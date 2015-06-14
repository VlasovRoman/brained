module brained.tokenizer;

import brained.opcode;

import std.stdio;

class Tokenizer {

	static Opcode[] 	tokenize(string code) {
		Opcode[] retValue;

		foreach(ref i, symbol; code) {

			switch(symbol) {
				case '+': retValue ~= new Opcode(Opcode.Type.ADD, +1); break;
				case '-': retValue ~= new Opcode(Opcode.Type.ADD, -1); break;
				case '>': retValue ~= new Opcode(Opcode.Type.SHIFT, +1); break;
				case '<': retValue ~= new Opcode(Opcode.Type.SHIFT, -1); break;
				case '.': retValue ~= new Opcode(Opcode.Type.OUT); break;
				case ',': retValue ~= new Opcode(Opcode.Type.IN); break;

				case '[': 
					char next = code[i + 1];

					if((next == '-' || next == '+') && (code[i+2] == ']')) {
						retValue ~= new Opcode(Opcode.Type.ZERO);
						i += 2;
					}
					else
						retValue ~= new Opcode(Opcode.Type.WHILE);
				break;

				case ']': retValue ~= new Opcode(Opcode.Type.END); break;
				default: break;
			}
		}

		return retValue;
	}
}