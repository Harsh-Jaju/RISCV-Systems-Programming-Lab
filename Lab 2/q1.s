.data
array : .word 5, 2, 9, 1, 3, 6
size : .word 6

.text
.global main

main:
    
    lw t1, size
    addi t1, t1, -1
    li t3, 0

loopout:
    
    beq t3, t1, end

    la t0, array
    li t2, 0

    sub t4, t1, t3

    loop:
        beq t2, t4, end1

        lw t5, 0(t0)
        lw t6, 4(t0)

        ble t5, t6, label2

        label1:
            sw t5, 4(t0)
            sw t6, 0(t0)

        label2:
        addi t2, t2, 1
        addi t0, t0, 4
        j loop

    end1:
        addi t3, t3, 1
        j loopout
     
end:

la t0, array

li a7, 93
ecall
