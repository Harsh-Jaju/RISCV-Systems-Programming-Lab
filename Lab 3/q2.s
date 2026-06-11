.data
.align
num : .word 4
.align
buffer: .space 200
.align
newline: .byte '\n'
.text
.global main

main:
    lw a0, num
    lw a1, num
    li a2, 0
    li s4, 4

    jal ra, par

    li a7, 93
    ecall

par:
    addi sp, sp, -32
    sw a0, 0(sp)
    sw a1, 8(sp)
    sw a2, 16(sp)
    sw ra, 24(sp)
    
    or t0, a0, a1
    bne t0, x0, call_par

    la t0, buffer
    
    add t0, t0, a2
    sb zero, 0(t0)

    addi s8, a0, 0
    addi s9, a1, 0
    addi s10, a2, 0

    li a0, 1
    la a1, buffer
    mv a2, a2
    li a7, 64
    ecall

    li a0, 1
    la a1, newline
    li a2, 1
    li a7, 64
    ecall

    addi a0, s8, 0
    addi a1, s9, 0
    addi a2, s10, 0
    addi sp, sp, 32

    jalr x0, ra, 0


call_par:

    ble a0, x0, call1

    la t0, buffer
    add t0, t0, a2
    li s11, '('
    sb s11, 0(t0)


    addi a0, a0, -1
    addi a2, a2, 1

    jal ra, par

    addi a0, a0, 1
    addi a2, a2, -1

    call1:

    sub s11, a1, a0
    ble s11, x0, call2

    la t0, buffer
    add t0, t0, a2
    li s11, ')'
    sb s11, 0(t0)


    addi a1, a1, -1
    addi a2, a2, 1

    jal ra, par

    addi a1, a1, 1
    addi a2, a2, -1

    call2:

    lw a0, 0(sp)
    lw a1, 8(sp)
    lw a2, 16(sp)
    lw ra, 24(sp)
    
    addi sp, sp, 32

    jalr x0, ra, 0

