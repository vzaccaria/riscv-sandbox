# Setting up

Beware that the complete construction of the container might take a few hours (2
hours in my case). To setup the docker container:

```
docker build . -t riscv-latest
```

This will create the container riscv-latest and install a few commands, among
which the gcc toolchain.

# Compiling and running hello world

```
make helloWorld.exe    # build the elf riscv executable of helloWorld.c
make helloWorld.s      # produce the riscv assembly of helloWorld.c
make helloWorld.run    # run helloWorld.exe with the rv8 instruction set simulator
```

The docker commands in the makefile will mount the current directory in the
container.
