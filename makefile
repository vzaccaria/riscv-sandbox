
CC=docker run -v $(PWD):/root/local -w /root/local --rm --entrypoint "/opt/riscv/toolchain/bin/riscv64-unknown-elf-gcc" riscv-latest -g
OBJDUMP=docker run -v $(PWD):/root/local -w /root/local --rm --entrypoint "/opt/riscv/toolchain/bin/riscv64-unknown-elf-objdump" riscv-latest
NM=docker run -v $(PWD):/root/local -w /root/local --rm --entrypoint "/opt/riscv/toolchain/bin/riscv64-unknown-elf-nm" riscv-latest
RUN=docker run -v $(PWD):/root/local -w /root/local --rm --entrypoint '/usr/local/bin/rv-sim' riscv-latest 
GDB=docker run -ti -v $(PWD):/root/local -w /root/local --rm --entrypoint '/opt/riscv/toolchain/bin/riscv64-unknown-elf-gdb' riscv-latest 

all: helloWorld.exe helloWorld.s

%.s: %.c
	$(CC) -march=rv64g  -S $<

%.exe: %.s
	$(CC) -march=rv64g $< -o $@

%.run: %.exe
	$(RUN) $<

%.o: %.c
	$(CC) -c -march=rv64g $< -o $@

%.dump: %.exe
	$(OBJDUMP) --disassemble=main $<

%.dumpall: %.exe
	$(OBJDUMP) -D $<

%.odump: %.o
	$(NM) --format sysv $<
	$(OBJDUMP) -t -r --disassemble=main $<

# Remember to 'load' the program in the gdb
%.gdb: %.exe
	$(GDB) helloWorld.exe

clean:
	rm -f *.s *.o a.out *.exe
