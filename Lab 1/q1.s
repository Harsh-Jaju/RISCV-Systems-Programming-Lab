.data
num1: .word 7
num2: .word 3
array: .word 0, 0, 0, 0, 0
.text
.global main

main: 
    la t0, array
    la t1, num1
    la t2, num2
    
    lw t3, 0(t1)
    lw t4, 0(t2)

    add t5, t3, t4
    sw t5, 0(t0)

    addi t0, t0, 4

    sub t5, t3, t4
    sw t5, 0(t0)

    addi t0, t0, 4

    and t5, t3, t4
    sw t5, 0(t0)

    addi t0, t0, 4

    or t5, t3, t4
    sw t5, 0(t0)

    addi t0, t0, 4

    sub t3, zero, t3
    addi t3, t3, -1
    xor t5, t3, t4
    sw t5, 0(t0)

end: 
    li a7, 93
    ecall
