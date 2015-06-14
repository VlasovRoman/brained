module brained.opcode;

class Opcode {
public:

	Type 	type;
	int 	arg = 1;

	enum Type {
		ADD,
		SHIFT,
		ZERO,
		OUT,
		IN,
		WHILE,
		END
	}

	this(Type type, int arg) {
		this.type = type;
		this.arg = arg;
	}

	this(Type type) {
		this.type = type;
	}

	Opcode	clone() {
		Opcode opcode = new Opcode(type, arg);

		return opcode;
	}
}