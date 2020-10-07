# Setting up

To setup the docker environment run

```
docker build . -t riscv-latest
```

# Compiling an hello world riscv program

```
make helloWorld.exe  # for the elf riscv executable
make helloWorld.s    # for the assembly
```
