OUTPUT_ARCH( "riscv" )
ENTRY( _start )

SECTIONS
{
  . = 0x80000000;

  .text : {
    *(.text)           /* Take all .text sections from all files and put them here */
  }

  .data : {
    *(.data)
  }

  .bss : {
    *(.bss)
  }

  /* Align stack to 16 bytes for RISC-V ABI compliance */
  . = ALIGN(16);
  . += 0x1000;
  _stack_top = .;

  . = ALIGN(16);
  . += 0x1000;
  _stack_machine = .;
}

