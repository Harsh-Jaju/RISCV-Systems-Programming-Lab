.data
num : .word 6789
.text
.global main

main:
    lw a0, num
    li s0, 10
    li a1, 0
    jal ra, sum
    li a7, 93
    ecall

sum:
    addi sp, sp, -16

    sw a0, 0(sp)
    sw ra, 8(sp)
    addi t0, a0, -10
    bge t0, x0, call_sum
    add a1, a1, a0
    addi sp, sp, 16
    jalr x0, ra, 0

call_sum:
    rem t0, a0, s0
    add a1, a1, t0
    div a0, a0, s0
    jal ra, sum
   
    lw a0, 0(sp)
    lw ra, 8(sp)
    addi sp, sp, 16

    jalr x0, ra, 0
