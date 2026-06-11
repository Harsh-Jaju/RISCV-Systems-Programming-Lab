
.section .text
.global main



main:
    # Prepare jump to super mode
    li t1, 1
    slli t1, t1, 11   #mpp_mask
    csrs mstatus, t1
    
    la t4, supervisor       #load address of user-space code
    csrrw zero, mepc, t4    #set mepc to user code
    
    la t5, page_fault_handler
    csrw mtvec, t5
   
    mret

supervisor:
################## Setting up page tables ##############
    # Set value in PTE2 (Initial Mapping)
    li a0,0x81000000
    li a1, 0x82000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 16(a0)

    # To set V.A 0x0 -> P.A 0x0
    li a1, 0x82001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE1 (Initial Mapping)
    li a0,0x82000000
    li a1, 0x83000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set Frame number in PTE0 (Initial Mapping)
    li a0,0x83000000
    li a1, 0x80000
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 0(a0)

    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 8(a0)

    # Set value in PTE1 (Code Mapping)
    li a0,0x82001000
    li a1, 0x83001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE0 (Code Mapping)
    li a0,0x83001000
    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xfb # D | A | G | U | X | - | R |V
    sd a1, 0(a0)

    # Data Mapping
    li a1, 0x80002
    slli a1, a1, 0xa
    ori a1, a1, 0xf7 # D | A | G | U | - | W | R |V
    sd a1, 8(a0)
    

####################################################################

    # Prepare jump to user mode
    li t1, 0
    slli t1, t1, 8   #spp_mask
    csrs sstatus, t1

    # Configure satp
    la t1, satp_config 
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0       # load VA address of user-space code
    csrrw zero, sepc, t4    # set sepc to user code
    
    sret



###################################################################
##################### ADD CODE ONLY HERE  #########################
###################################################################
.align 4
page_fault_handler:
    
    csrr s0, mcause
    li s1, 12
    beq s0, s1, instruction_page_fault
    li s1, 13
    beq s0, s1, data_page_fault
    j end

instruction_page_fault:
    #New Page
    la s0, page
    ld s1, 0(s0) 
    li s2, 0x1000
    add s2, s2, s1
    sd s2, 0(s0)

    #Copying Page
    li s0, 0x80001000 
    li s2, 0
loop:
    li s3, 0x1000
    beq s2, s3, table_setup
    add s3, s0, s2
    ld s3, 0(s3)
    add s4, s1, s2
    sd s3, 0(s4)
    addi s2, s2, 8
    j loop

    #Setting up new page into page table
table_setup:
    csrr s0, mtval
    srli s0, s0, 21
    li s2, 0x1FF
    and s0, s0, s2

    #Level-1 Page table
    li s2, 0x82001000
    slli s0, s0, 3
    add s0, s0, s2
    ld s2, 0(s0)

    andi s3, s2, 1
    bnez s3, l1_valid_inst

    #Fixing Page Table Page Fault
    la s3, page_table
    ld s4, 0(s3) 
    li s5, 0x1000
    add s5, s5, s4
    sd s5, 0(s3)

    srli s4, s4, 2
    ori s4, s4, 1
    sd s4, 0(s0)
    mv s2, s4

    #Level-0 Page Table
l1_valid_inst:
    csrr s0, mtval
    srli s0, s0, 12            
    li s3, 0x1FF
    and s0, s0, s3  
    slli s0, s0, 3
    srli s2, s2, 10
    slli s2, s2, 12
    add s2, s2, s0

    srli s1, s1, 2
    li s0, 0xDB
    or s1, s1, s0
    sd s1, 0(s2)
    j end

data_page_fault:
    csrr s0, mtval
    srli s0, s0, 21
    li s2, 0x1FF
    and s0, s0, s2

    #Level-1 Page table
    li s2, 0x82001000
    slli s0, s0, 3
    add s0, s0, s2
    ld s2, 0(s0)

    andi s3, s2, 1
    bnez s3, l1_valid_data

    #Fixing Page Table Page Fault
    la s3, page_table
    ld s4, 0(s3) 
    li s5, 0x1000
    add s5, s5, s4
    sd s5, 0(s3)

    srli s4, s4, 2
    ori s4, s4, 1
    sd s4, 0(s0)
    mv s2, s4

    #Directing page table into data section
l1_valid_data:
    csrr s0, mtval
    srli s0, s0, 12            
    li s3, 0x1FF
    and s0, s0, s3  
    slli s0, s0, 3
    srli s2, s2, 10
    slli s2, s2, 12
    add s2, s2, s0

    li s1, 0x80002000
    srli s1, s1, 2
    li s0, 0xD7
    or s1, s1, s0
    sd s1, 0(s2)
    j end

end:
    mret


###################################################################
###################################################################


.align 12
user_code:
    la t1,var_count
    lw t2, 0(t1) 
    addi t2, t2, 1
    sw t2, 0(t1)

    la t5, code_jump_position
    lw t3, 0(t5)
    li t4, 0x2000
    add t3, t3, t4
    sw t3, 0(t5)
    
    jalr x0, t3


.data
.align 12
var_count:  .word  0
code_jump_position: .word 0x0000


.align 8
# Value to set in satp
satp_config: .dword 0x8000000000081000

.align 3
page: .dword 0x80003000

.align 3
page_table: .dword 0x83002000
