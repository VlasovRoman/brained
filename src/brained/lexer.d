module brained.lexer;

import std.stdio;
import std.string;

class Lexer {

	public static bool 	analyze(string code) {
		int symbols = 0;

		foreach(i, symbol; code) {

			if(symbol == '[') {
				symbols++;
			}
			if(symbol == ']') {
				symbols--;
			}
			
			if(symbols < 0)
				return true;
		}

		return cast(bool)symbols;
	}
}