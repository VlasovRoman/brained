module bdvm.translator;

import std.stdio;
import std.bitmanip;
import std.encoding;

class VirtualMachine {
public:
	this() {
		i = 15000;
	}

	bool 		openProgram(string filename) {
		byte[1] buffer; 

		auto file = File(filename, "rb");

		while(!file.eof()) {
			file.rawRead(buffer);

			bytecode ~= buffer;
		}

		bytecode.length -= 1;

		return true;
	}

	bool		getNextCommand(ref ubyte opByte, ref int arg) {
		if(byteId == bytecode.length)
			return true;

		ubyte[4] 	byteArg;
		opByte = bytecode[byteId];
		byteId++;

		byteArg = bytecode[byteId..byteId + 4];
		byteId += 4;

		arg = littleEndianToNative!int(byteArg);

		return false;
	}

	void 		execute() {
		ubyte 	opByte;
		int 	arg;;

		while (!getNextCommand(opByte, arg)) {

			switch(opByte) {
				case 0x1: memory[i] += arg; break;
				case 0x2: i += arg; break;
				case 0x3:
					while(arg) {
						write(cast(dchar) memory[i]);
						arg--;
					}
				break;
				//case 0x4:
				//	read
				case 0x5: memory[i] = 0; break;
				case 0x6:
					stack ~= byteId;

				break;
				case 0x7 :
					if(memory[i] != 0){
						byteId = stack[$ - 1];
					}
					else continue;
				break;
				default: break;
			}

		}
	}
private:
	int[30000] 	memory;
	ubyte[]		bytecode;

	int 		byteId;
	int 		i;
	int[] 		stack;
}