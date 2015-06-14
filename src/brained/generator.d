module brained.generator;

import brained.opcode;

import std.stdio;
import std.bitmanip;
import std.array;
import std.process;
import std.conv;

ubyte[Opcode.Type] Bytecode;

class Generator {
	this() {
		Bytecode[Opcode.Type.ADD] = 0x1;
		Bytecode[Opcode.Type.SHIFT] = 0x2;
		Bytecode[Opcode.Type.OUT] = 0x3;
		Bytecode[Opcode.Type.IN] = 0x4;
		Bytecode[Opcode.Type.ZERO] = 0x5;
		Bytecode[Opcode.Type.WHILE] = 0x6;
		Bytecode[Opcode.Type.END] = 0x7;
	}

	void 	writeLineOfCode(File* file, int tabs, string code) {
		tabs += 1;
		foreach(i; 0..tabs) {
			file.write(" ");
		}
		file.writeln(code);
	} 

	void 	generate(Opcode[] code, string filename) {
		auto file = new File(filename ~ ".asm", "w");

		generateHeader(file);

		string 	cycles[];
		int 	cycle;
		//ubyte[] bytecode;

		foreach(opcode; code) { 
			switch(opcode.type) {
			case Opcode.Type.ADD:  
				file.writeln("	add [edi], byte ", +opcode.arg);
				//writeLineOfCode(file, cycles.length, "add [edi], byte " ~ to!(string)(opcode.arg));
			break;
			case Opcode.Type.OUT:
				foreach(i; 0..opcode.arg) {
					file.writeln("	PUTCHAR [edi] ");
					//writeLineOfCode(file, cycles.length, "PUTCHAR [edi] " ~ to!(string)(opcode.arg));
				}
			break;
			case Opcode.Type.SHIFT:
				file.writeln("	add edi, byte ", +opcode.arg);
				//writeLineOfCode(file, cycles.length, "add edi, byte " ~ to!(string)(opcode.arg));
			break;
			case Opcode.Type.ZERO:
				file.writeln("	mov [edi], byte 0");
			break;
			case Opcode.Type.WHILE:
				cycles ~= "L" ~ to!(string)(cycle);
				cycle++;
				file.writeln(cycles[$-1], ":");
				//file.writeln("	mov [edi]");
			break;
			case Opcode.Type.END :
				//file.writeln("	cmp [edi], byte 0");
				file.writeln("	jnz ", cycles[$-1]);
				cycles.length -= 1;
			break;
			//default: break;
			}
			//ubyte[4] buffer = [0, 0, 0, 0];
			//bytecode ~= Bytecode[opcode.type];

			//buffer = nativeToLittleEndian!int(opcode.arg);
			//bytecode ~= buffer;
		}



		file.writeln("FINISH");

		//file.rawWrite(bytecode); 
		//file.close();
		file.close();

		executeShell("nasm -f elf " ~ filename ~".asm");
		executeShell("ld -m elf_i386 " ~ filename ~ ".o -o " ~ filename);
		//executeShell("rm " ~ filename ~ ".asm");		
	}

	void 	generateHeader(File* file) {
		file.writeln("%include \"stdio.inc\"");

		file.writeln("section .bss");

		file.writeln("array resb 30000");
		file.writeln(" ");
		file.writeln("global _start");

		file.writeln(" ");
		file.writeln("section .text");
		file.writeln("_start: ");
		file.writeln("	mov ecx, 30000");
		file.writeln("	mov edi, array");

		file.writeln(" ");
		file.writeln("	mov eax, 0");
		file.writeln("	initMemory:");
		file.writeln("		mov [edi], byte 0");
		file.writeln("		inc edi");
		file.writeln("		inc eax");
		file.writeln("		cmp eax, ecx");
		file.writeln("		jl	initMemory");

		file.writeln(" ");
		file.writeln("	mov edi, array + 15000");
	}

}