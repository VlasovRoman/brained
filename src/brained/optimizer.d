module brained.optimizer;

import brained.opcode;

import std.stdio;
import std.string;

class Optimizer {

	public static Opcode[] 	optimize(Opcode[] code) {
		Opcode[] optimalCode;

		foreach(ref i, opcode; code) {
			if(optimalCode.length == 0)  {
				optimalCode ~= opcode.clone();
				continue;
			}

			switch(opcode.type) {
				case Opcode.Type.ADD:
				case Opcode.Type.SHIFT:
				case Opcode.Type.ZERO:
				case Opcode.Type.OUT:
				case Opcode.Type.IN:

					if(optimalCode[$ - 1].type != opcode.type) {
						if(optimalCode[$ - 1].arg == 0) {
							optimalCode.length -= 1;
							i--;
						}

						if(optimalCode[$ - 1].type == Opcode.Type.ZERO)
							optimalCode[$ - 1].arg = 1;

						optimalCode ~= opcode.clone();

						continue;
					}

					optimalCode[$ - 1].arg += opcode.arg;
				break;

				case Opcode.Type.WHILE:
				case Opcode.Type.END:
					optimalCode ~= opcode.clone();
				break;
			}
		}

		return optimalCode;
	}
}