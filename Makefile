all:
	riscv64-unknown-elf-gcc -c -g startup.s -g -march=rv32imac -mabi=ilp32 -o startup.o -ffreestanding
	riscv64-unknown-elf-gcc -c -g main.c -g -march=rv32imac -mabi=ilp32 -o main.o -ffreestanding
	riscv64-unknown-elf-gcc startup.o main.o -g -march=rv32imac -mabi=ilp32 -T sifive_e.ld -o program.elf -nostartfiles -nostdlib
run:
	qemu-system-riscv32 -machine sifive_e -kernel program.elf -gdb tcp::1234 -S -nographic &
	riscv64-unknown-elf-gdb program.elf -tui