MEMORY
{
    rom : ORIGIN = 0x20400000, LENGTH = 0x1000
    ram : ORIGIN = 0x80000000, LENGTH = 0x4000
}
SECTIONS
{
    .text : {
        *(.text*)
    } > rom

    .data : {
        *(.data*)
        *(.sdata*)
    } > ram AT > rom

    __sdata = ADDR(.data);
    __edata = __sdata + SIZEOF(.data);
    __data_load_addr = LOADADDR(.data);

    .rodata : {
        *(.rodata*)
    } > rom

    .bss : {
        *(.bss*)
    } > ram

    __sbss = ADDR(.bss);
    __ebss = __sbss + SIZEOF(.bss);
}