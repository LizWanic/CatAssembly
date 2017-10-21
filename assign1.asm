; Elizabeth Wanic
; 12 January 2017
; CS 3140 - Assignment 1
; Command line for assembly : 
;    nasm -f elf32 assign1.asm
; Command line for linker :
;    ld -o assign1 -m elf_i386 assign1.o
; User must enter ./assign1 to run the program
; User must enter input through command line and hit enter to see it in stdout
; User must enter control d when finished to exit

bits 32                 ; indicates 32 bit program
global _start           ; make _start symbol visible for linker

_start:                 ; program entry point
    mov eax, 0x03       ; 3 is sys call for read
    mov ebx, 0x00       ; fd for stdin is 0
    mov ecx, esp        ; stack pointer to memory location
    mov edx, 0x01       ; read one byte at a time
    int 0x80            ; execute read sys call
    cmp eax, 0x01       ; check if there is something to read
    jne _myexit         ; jump to exit when finished reading
    mov eax, 0x04       ; 4 sys call for write
    mov ebx, 0x01       ; fd for stdout is 1
    mov ecx, esp        ; stack pointer to memory location
    mov edx, 0x01       ; write one byte at a time
    int 0x80            ; execute write sys call
    jmp _start          ; jump to start to keep reading

_myexit:
    mov eax, 0x01       ; 1 is sys call for exit
    int 0x80            ; execute exit sys call
