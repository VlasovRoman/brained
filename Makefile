brained: ./src/brained/*.d
	dmd ./src/brained/*.d -ofbrained

bdvm: ./src/bdvm/*.d
	dmd ./src/bdvm/*.d -ofbdvm


clean:
	rm -rf *.o