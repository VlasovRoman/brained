import std.stdio;

import brained.lexer;
import brained.tokenizer;
import brained.optimizer;
import brained.generator;
import brained.opcode;

int main(string[] args) {
	if(args.length < 3) {
		writeln("Use 'brained file.b* filename' for compiling");

		return 1;
	}

	string code = "";
	char[] buffer;
	//string[] toGenerator;

	auto file = File(args[1], "r");

	while(!file.eof()) {
		file.readln(buffer);
		code ~= buffer;
	}

	if(Lexer.analyze(code)) {
		writeln("Error!");

		return 2;
	}

	Opcode[]  commands = Tokenizer.tokenize(code);

	commands = Optimizer.optimize(commands);

	Generator generator = new Generator();
	generator.generate(commands, args[2]);

	return 0;
}