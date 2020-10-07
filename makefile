
CC=docker run -v $(PWD):/root/local -w /root/local --rm --entrypoint "/opt/riscv/toolchain/bin/riscv64-unknown-elf-gcc" riscv-latest
OBJDUMP=docker run -v $(PWD):/root/local -w /root/local --rm --entrypoint "/opt/riscv/toolchain/bin/riscv64-unknown-elf-objdump" riscv-latest
NM=docker run -v $(PWD):/root/local -w /root/local --rm --entrypoint "/opt/riscv/toolchain/bin/riscv64-unknown-elf-nm" riscv-latest

all: helloWorld.exe

%.s: %.c
	$(CC) -march=rv64g  -S $<

%.exe: %.s
	$(CC) -march=rv64g $< -o $@

%.o: %.c
	$(CC) -c -march=rv64g $< -o $@

%.dump: %.exe
	$(OBJDUMP) --disassemble=main $<

%.dumpall: %.exe
	$(OBJDUMP) -D $<

%.odump: %.o
	$(NM) --format sysv $<
	$(OBJDUMP) -t -r --disassemble=main $<

clean:
	rm -f *.s *.o a.out *.exe
