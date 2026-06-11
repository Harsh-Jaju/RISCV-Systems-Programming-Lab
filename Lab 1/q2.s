.data
array : .word 2, 3, 4, 5, 6
size : .word 5

.text
.global main

main:
la t0, array
lw t1, size

li t2, 0

loop:
beq t2, t1, end

mv t5, t2
li t6, 1

and t5, t5, t6

beq t5, zero, label1

lw t6, 0(t0)
addi t6, t6, -1
sw t6, 0(t0)
j label2

label1: 
lw t6, 0(t0)
addi t6, t6, 1
sw t6, 0(t0)

label2:
addi t0, t0, 4
addi t2, t2, 1
j loop

end:

li a7, 93
ecall