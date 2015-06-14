import std.stdio;

//import brained.lexer;
//import brained.tokenizer;
//import brained.optimizer;
//import brained.generator;
//import brained.opcode;
import bdvm.translator;

void main(string[] args) {
	//TODO: checking on 1 arg

	string filename = args[1];
	//string code = "";

	//char[] buffer;
	//auto file = File(filename, "r");

	//while(!file.eof()) {
	//	file.readln(buffer);
	//	code ~= buffer;
	//}

	int[30_000]  memory;

	VirtualMachine virtualMachine = new VirtualMachine();
	virtualMachine.openProgram(filename);

	virtualMachine.execute();
}