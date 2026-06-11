.data
array1 : .word 1, 0, 0, 0, 1, 0, 0, 0, 1
array2 : .word 1, 2, 3, 4, 5, 6, 7, 8, 9
array3 : .word 0, 0, 0, 0, 0, 0, 0, 0, 0
size : .word 3

.text
.global main

main:
    
    la t4, array1
    la t5, array2
    la t6, array3

    li t1, 0
    lw s0, size
    li s11, 4

loop1:
    
    beq t1, s0, end1
    li t2, 0

    loop2:
        beq t2, s0, end2
        li t3, 0
        li s1, 0
        li s2, 0
        li s3, 0
        li s4, 0
        
        loop3:
            beq t3, s0, end3 
            mul s3, t1, s0
            add s3, s3, t3
            mul s3, s3, s11

            mul s4, t3, s0
            add s4, s4, t2
            mul s4, s4, s11

            add t4, t4, s3
            add t5, t5, s4

            lw s5, 0(t4)
            lw s6, 0(t5)

            mul s5, s5, s6
            add s2, s2, s5

            la t4, array1
            la t5, array2 

            addi t3, t3, 1
            j loop3

        end3:
            li s3, 0
            mul s3, t1, s0
            add s3, s3, t2
            mul s3, s3, s11

            add t6, t6, s3
            sw s2, 0(t6)

            la t6, array3

            addi t2, t2, 1
            j loop2
    end2:
        addi t1, t1, 1
        j loop1

end1:

la t0, array3

li a7, 93
ecall
