# RISCV Systems Programming Lab

This repository contains my solutions and implementations for the **RISC-V Systems Programming Lab** at **IIT Madras**. The course explores various aspects of systems programming through the RISC-V architecture, including assembly programming, privilege modes, interrupt handling, virtual memory, page-fault management, and digital system design using Logisim.

## Key Highlights

- Implemented privilege transitions between Machine Mode (M-Mode) and Supervisor Mode (S-Mode).
- Developed custom trap and exception handlers using RISC-V CSRs.
- Configured timer interrupts and implemented cooperative multitasking through context switching.
- Built a bare-metal Sv39 virtual memory subsystem.
- Implemented multi-level page tables, virtual-to-physical address translation, and page-fault handling.
- Designed and verified digital systems using Logisim.
- Developed RISC-V assembly programs involving recursion, sorting, matrix multiplication, and memory management.

---

## Labs Overview

| Lab | Topic |
|------|--------|
| 0 | Introduction |
| 1 | Basic Assembly Programming |
| 2 | Arrays and Matrix Operations |
| 3 | Recursion in Assembly |
| 4 | Digital Logic Design using Logisim |
| 5 | Program Loading and Execution |
| 6 | Privilege Modes and Trap Handling |
| 7 | Timer Interrupts and Cooperative Multitasking |
| 8 | Sv39 Virtual Memory |
| 9 | Page Fault Handling |
| 10 | Logisim-Based System Design |
| 11 | Advanced Logisim Design |
| 12 | Final Laboratory Assignment |
| Endsem | Stack Analysis and Superpage Implementation |

---

## Lab 0 – Introduction

Introduction to the RISC-V ISA, toolchain, simulator environment, and laboratory workflow.

**Topics Covered**
- RISC-V instruction set basics
- Assembly programming workflow
- Toolchain setup and execution environment

---

## Lab 1 – Basic Assembly Programming

Implemented elementary RISC-V assembly programs involving arithmetic, logical operations, and array manipulation.

**Tasks**
- Arithmetic operations
- Bitwise operations
- Conditional execution
- Array processing

**Files**
- `q1.s`
- `q2.s`

---

## Lab 2 – Arrays and Matrix Operations

Implemented algorithms involving loops, memory addressing, and multi-dimensional data structures.

**Tasks**
- Bubble Sort
- Matrix Multiplication
- Array Traversal

**Files**
- `q1.s`
- `q2.s`
- `q2b.s`

---

## Lab 3 – Recursion in Assembly

Implemented recursive algorithms while understanding stack frames and procedure calls in RISC-V.

**Tasks**
- Recursive Digit Sum
- Recursive Function Implementation

**Files**
- `q1.s`
- `q1bonus.s`

---

## Lab 4 – Digital Logic Design using Logisim

Designed and simulated digital circuits using Logisim.

**Topics Covered**
- Combinational Logic
- Sequential Logic
- Circuit Verification
- Simulation and Testing

**Files**
- `Task1.circ`
- `Task2.circ`
- `Task3.circ`
- `Task4.circ`

---

## Lab 5 – Program Loading and Execution

Worked with programs executing on a custom RISC-V platform.

**Tasks**
- Hello World Implementation
- Snake Game Implementation
- Memory Initialization File Generation
- Program Loading and Execution

**Contents**
- Assembly source files
- HEX memory images
- Supporting build files

---

## Lab 6 – Privilege Modes and Trap Handling

Implemented privilege mode transitions and trap handling mechanisms in RISC-V.

**Topics Covered**
- Machine Mode (M-Mode)
- Supervisor Mode (S-Mode)
- CSR Programming
- Trap and Exception Handling
- Exception Delegation
- Custom Trap Handlers

**Learning Outcomes**
- Understanding RISC-V privilege architecture
- Handling exceptions and interrupts
- Managing execution across privilege levels

---

## Lab 7 – Timer Interrupts and Cooperative Multitasking

Implemented timer-driven execution and context switching mechanisms.

**Topics Covered**
- Timer Interrupt Configuration
- Machine Timer Registers
- Context Saving and Restoration
- Cooperative Multitasking
- Task Scheduling

**Learning Outcomes**
- Interrupt-driven execution
- Context switching between multiple tasks
- Building a basic multitasking environment

---

## Lab 8 – Sv39 Virtual Memory

Implemented a bare-metal virtual memory subsystem using the Sv39 paging scheme.

**Topics Covered**
- Sv39 Address Translation
- Multi-Level Page Tables
- SATP Configuration
- Supervisor Mode Execution
- Virtual-to-Physical Address Mapping

**Learning Outcomes**
- Understanding virtual memory systems
- Constructing page tables
- Managing address translation in RISC-V

---

## Lab 9 – Page Fault Handling

Implemented dynamic page mapping and software-managed page-fault resolution.

**Topics Covered**
- Instruction Page Faults
- Load/Store Page Faults
- Dynamic Page Allocation
- Page Table Updates
- Trap-Based Memory Management

**Learning Outcomes**
- Resolving page faults through software
- Dynamic memory mapping
- Integration of paging and trap handling mechanisms

---

## Lab 10 – Logisim-Based System Design

Designed and simulated digital systems using Logisim.

**Topics Covered**
- Digital Circuit Design
- Hardware Simulation
- Functional Verification
- System Integration

**Tools**
- Logisim

---

## Lab 11 – Advanced Logisim Design

Implemented and verified larger digital systems using Logisim.

**Topics Covered**
- Circuit Integration
- Hardware Validation
- System-Level Verification
- Simulation-Based Testing

**Files**
- `Lab11.circ`

---

## Lab 12 – Final Laboratory Assignment

Final laboratory assignment integrating concepts learned throughout the course.

**Topics Covered**
- Systems Programming Concepts
- RISC-V Architecture
- Hardware-Software Interaction

---

## End Semester Evaluation

### Question 1 – Stack Analysis

Implemented stack-related analysis and management mechanisms in RISC-V.

**Topics Covered**
- Stack Frame Construction
- Function Call Management
- Register Preservation
- Stack Traversal and Analysis
- Procedure Execution Tracking

### Question 2 – Superpage Implementation

Implemented virtual memory optimizations using superpages.

**Topics Covered**
- Multi-Level Page Tables
- Superpage Mapping
- Large-Page Address Translation
- Reduced Page Table Overhead
- Efficient Virtual Memory Management

**Learning Outcomes**
- Understanding hierarchical page-table structures
- Implementing large-page mappings
- Optimizing address translation performance

---

## Topics Covered Throughout the Course

- RISC-V Assembly Programming
- Stack Management and Recursion
- Sorting Algorithms
- Matrix Multiplication
- Privilege Modes
- CSR Programming
- Trap and Exception Handling
- Timer Interrupts
- Cooperative Multitasking
- Context Switching
- Virtual Memory
- Sv39 Paging
- Page Tables
- Page Fault Handling
- Linking and Memory Layout
- C and Assembly Interfacing
- Digital Logic Design
- Logisim Circuit Design
- Hardware Verification

---

## Tools Used

- RISC-V Toolchain
- Spike Simulator
- GCC
- Linker Scripts
- Logisim

---

## Author

**Harsh Jaju**  
B.Tech, Computer Science and Engineering  
**Indian Institute of Technology Madras**
