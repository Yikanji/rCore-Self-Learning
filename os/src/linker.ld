OUTPUT_ARCH(riscv)                  /* object platform riscv */
ENTRY(_start)                       /* start point as _start, the global sign from entry.asm */
BASE_ADDRESS = 0x80200000;          /* the start address constant */

SECTIONS                            /* merge the segment */
{
    . = BASE_ADDRESS;

    skernel = .;

    stext = .;                      /* the start of the segment .text */
    .text : {
        *(.text.entry)              /* the first instruction of kernel */
        *(.text .text.*)
    }

    . = ALIGN(4K);
    etext = .;                      /* the end of the segment .text */

    srodata = .;
    .rodata : {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    }

    . = ALIGN(4K);
    erodata = .;

    sdata = .;
    .data : {
        *(.data .data.*)
        *(.sdata .sdata.*)
    }

    . = ALIGN(4K);
    edata = .;

    .bss : {
        *(.bss.stack)
        sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    }
    
    . = ALIGN(4K);
    ebss = .;

    ekernel = .;

    /DISCARD/ : {
        *(.en_frame)
    }
}
