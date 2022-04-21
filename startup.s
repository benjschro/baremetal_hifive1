.align 2
.section .text
.globl _start
_start:
        la    sp, 0x80001000           # setup stack pointer

_load_data:
        la    t0, __sdata              # t0 = ram start address of .data
        la    t1, __edata              # t1 = ram end address of .data
        la    t2, __data_load_addr     # t2 = rom start address of .data

1:      beq   t0, t1, 2f               # .data load to ram is complete when t0 = t1
        lb    t4, (t2)                 # t4 = *t2
        sb    t4, (t0)                 # *t0 = t4

        addi  t2, t2, 1                # t2 += 1
        addi  t0, t0, 1                # t0 += 1

        j 1b
2:

_zero_bss:
        la    t0, __sbss               # t0 = ram start address of .bss
        la    t1, __ebss               # t1 = ram end address of .bss

1:      beq   t0, t1, 2f               # .data load to ram is complete when t0 = t1
        sb    zero, (t0)               # *t0 = 0

        addi  t0, t0, 1                # t0 += 1

        j 1b
2:

_init_complete:
        j main
