.section .text
.global main

main:
    li t3, 0x100
    csrs medeleg, t3

    la t3, mtrap_handler
    csrw mtvec, t3

    la t3, strap_handler
    csrw stvec, t3

    la t3, ucode
    csrw mepc, t3

    li t3, 0x1800
    csrc mstatus, t3

    mret



.align 4
mtrap_handler:
    csrr t6, mstatus

    mul a1, a1, a2
    li a0, 0

    la t3, strap_handler
    csrw mepc, t3

    li t3, 0x1800
    csrc mstatus, t3
    li t3, 0x0800
    csrs mstatus, t3

    mret



scode:
    la t3, ucode1
    csrw sepc, t3

    li t3, 0x100
    csrc sstatus, t3

    sret



.align 4
strap_handler:
    csrr t6, sstatus

    beqz a0, go_user

    ecall

go_user:
    j scode



ucode:
    li a1, 5
    li a2, 2

    li a0, 0
    ecall



ucode1:
    add a1, a1, a2
    li a0, 1

    ecall
