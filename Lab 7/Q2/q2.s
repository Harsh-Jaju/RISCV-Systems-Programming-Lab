.section .data
.global ans # need to declare as a global variable
ans: .space 40

.section .text
.global decrypt # need to declare as a global variable


decrypt:
    # perform decryption over the string cipher_text 

    
    
    la a2, ans
    la a3, ans
    li t0, 0

    loop1:
        lb t4, 0(a0)
        beq t4, x0, exit

        li t1, 0
        la a1, substitution

        loop2:
            lb t4, 0(a0)
            lb t5, 0(a1)
            beq t4, t5, check
            addi t1, t1, 1
            addi a1, a1, 1
            j loop2

        check:
            addi t1, t1, 97
            sb t1, 0(a2)
            addi a2, a2, 1
            addi a0, a0, 1
            j loop1
    exit:

        sb x0, 0(a2) 
        la a0, ans
        ret
