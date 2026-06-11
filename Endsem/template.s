.section .text
.global main

main:
	# Write code here to jump to supervisor mode 
	li t0, 0x0800
	csrs mstatus, t0

	la t0, supervisor
	csrw mepc, t0

	mret

supervisor: 
################ Initialize your page tables here ################
	
	la t0, L1_PT
	la t1, L0_PT_User
	srli t1, t1, 2
	ori t1, t1, 0x01
	sd t1, 0(t0)

	la t0, L1_PT
	la t1, L0_PT_Id
	srli t1, t1, 2
	ori t1, t1, 0x01
	sd t1, 16(t0)

	la t0, L0_PT_User
	la t1, user_code
	srli t1, t1, 2
	ori t1, t1, 0xDF    # V=1, R=1, W=1, X=1, U=1, A=1, D=1 (User-accessible)
	sd t1, 0(t0)

	# User data
	la t0, L0_PT_User
	la t1, data_start
	srli t1, t1, 2
	ori t1, t1, 0xDF    # V=1, R=1, W=1, X=1, U=1, A=1, D=1 (User-accessible)
	sd t1, 8(t0)

	# supervisor code identity
	la t0, L0_PT_Id
	la t1, main
	srli t1, t1, 2
	ori t1, t1, 0xCF    # V=1, R=1, W=1, X=1, U=0, A=1, D=1 (Supervisor only)
	sd t1, 0(t0)


	# satp value for Sv39
	la t0, L1_PT
	srli t0, t0, 12                 # PPN of Root Page Table
	li t1, 0x8000000000000000       # Mode 8 for Sv39
	or t0, t0, t1
	la t1, satp_config
	sd t0, 0(t1)

####################################################################

	# Prepare a jump to user mode
	li t0, 0x100
	csrc sstatus, t0

################ DO NOT MODIFY THESE INSTRUCTIONS ################
	la t1, satp_config # load satp val
	ld t2, 0(t1)
	sfence.vma zero, zero
	csrrw zero, satp, t2
	sfence.vma zero, zero

	li t4, 0
	csrrw zero, sepc, t4
	sret
#################################################################### 
.align 21
user_code:
# Write user code here that does the following:
    # 1. Initialize four variables var1 , var2 , var3 , var4 in the data section with values 1 , 2 , 3 , 4.
    # 2. The user_code must load these variables into t1 , t2 , t3 , t4 registers (for reading during debug mode) and then loop back to itself.
# Don't forget to align the data section and user_code propely. For assembly directive usage, use the last reference given.

    li t0, 0x200000
	ld t1, 0(t0)
	ld t2, 8(t0)
	ld t3, 16(t0)
	ld t4, 24(t0)

user_loop:
	j user_loop

.section .data 
.align 21
data_start:
var1: .dword 1
var2: .dword 2
var3: .dword 3
var4: .dword 4

satp_config: .dword  
# Set appropriate value for satp here.

.align 12
L1_PT: .zero 4096
L0_PT_User: .zero 4096
L0_PT_Id: .zero 4096


