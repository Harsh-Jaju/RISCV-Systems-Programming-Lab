.data
sqaure_vtable: .dword 0, 0
triangle_vtable: .dword 0, 0

side: .word 5
base: .word 4
height: .word 6

.text
.global main

main:
    la t4, sqaure_vtable
    la t5, triangle_vtable
    la t6, square_area
    la s0, triangle_area

    sw t6, 0(t4)
    sw s0, 0(t5)

    la t6, square_perimeter
    la s0, triangle_perimeter

    sw t6, 8(t4)
    sw s0, 8(t5)

    li t0, 0
    addi sp, sp, -16
    li s1, 5
    li s2, 0
    la s3, sqaure_vtable
    sd s3, 0(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    jal ra, dispatch
    mv t1, a0

    li t0, 1
    jal ra, dispatch
    mv t2, a0

    addi sp, sp, 16


    li t0, 0
    addi sp, sp, -16
    li s1, 4
    li s2, 6
    la s3, triangle_vtable
    sd s3, 0(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    jal ra, dispatch
    mv t3, a0

    li t0, 1
    jal ra, dispatch
    mv t4, a0

    addi sp, sp, 16

    li a7, 93
    ecall


dispatch:
    mv a0, sp
    lw t5, 0(sp)
    
    li s0, 8
    mul s0, s0, t0
    add t5, t5, s0
    lw t5, 0(t5)

    addi s6, ra, 0

    jalr ra, t5, 0

    addi ra, s6, 0

    ret 


square_area: 
    lw s0, 8(a0)
    mul a0, s0, s0
    ret
    
square_perimeter:
    li s0, 4
    lw s1, 8(a0)
    mul a0, s0, s1
    ret

triangle_area:
    lw s0, 8(a0)
    lw s1, 12(a0)
    mul a0, s0, s1
    li s0, 2
    div a0, a0, s0
    ret

triangle_perimeter:
    li s0, 3
    lw s1, 8(a0)
    mul a0, s0, s1
    ret

