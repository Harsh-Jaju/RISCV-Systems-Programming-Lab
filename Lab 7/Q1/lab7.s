.section .text.init
.global _start
_start:
# 1. Initialize Stack Pointer (sp)
# 2. Setup Trap Vectors (mtvec)
# 3. Prepare transition to User Mode (mstatus and mepc)
# 4. Execute mret to jump to ucode

    la sp, _stack_top

    la t5, mtrap_handler
    csrw mtvec, t5
    la t5, ucode
    csrw mepc, t5

    li t5, 2048
    csrc mstatus, t5
    li t5, 4096
    csrc mstatus, s0
    
    li t5, 128
    csrw mstatus, t5

    mret


.section .text
.align 4
mtrap_handler:
# --- Context Saving ---
# Save registers used in ucode. In the ideal case should save all registers.
# --- Decode mcause ---
# Implement logic to handle causes 2, 3, 4, 5, 8

# --- Context Restoration ---

addi sp, sp, -72
sw ra, 0(sp)
sw t0, 8(sp)
sw t0, 16(sp)
sw t0, 24(sp)
sw t0, 32(sp)
sw t0, 40(sp)
sw t0, 48(sp)
sw t0, 56(sp)
sw a0, 64(sp)


csrr t5, mcause
li t0, 2
li t1, 3
li t2, 4
li t3, 5
li t4, 8

beq t5, t0, illegal
beq t5, t1, break
beq t5, t2, Mis
beq t5, t3, Access
beq t5, t4, ecalled

ecalled:
    csrr t6, mepc
    addi t6, t6, 4
    csrw mepc, t6
    li a0, 0xfeed
    j endfull

break:
    csrr t6, mepc
    addi t6, t6, 2
    csrw mepc, t6
    li a0, 0xbeef
    j endfull

illegal:
    csrr s9, mtval
    csrr t6, mepc
    addi t6, t6, 4
    csrw mepc, t6
    j endfull

Mis:
    csrr s10, mtval
    csrr t6, mepc
    addi t6, t6, 4
    csrw mepc, t6
    j endfull

Access:
    csrr s11, mtval
    csrr t6, mepc
    addi t6, t6, 4
    csrw mepc, t6
    j endfull


endfull:

lw ra, 0(sp)
lw t0, 8(sp)
lw t0, 16(sp)
lw t0, 24(sp)
lw t0, 32(sp)
lw t0, 40(sp)
lw t0, 48(sp)
lw t0, 56(sp)
lw a0, 64(sp)
addi sp, sp, 72

mret

ucode:
    # --- Sequence of Exception Tests ---
    # Trigger exceptions one after another to test your handler logic

    .word 0x00000000

    ebreak

    la t0, ucode; ld t0, 0(t0)

    li t0, 0x0; ld t1, 0(t0)

    ecall

    j .



.section .bss
.align 16
_stack_low:
.space 4096
_stack_top:
