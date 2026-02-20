section .data
    pregunta db "Escribe un numero del 0 al 9: ", 10
    largo_p equ $ - pregunta

section .bss
    buffer resb 8

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, pregunta
    mov rdx, largo_p
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 8
    syscall

    mov al, [buffer]
    sub al, 48
    add al, 5

    movzx rdi, al
    mov rax, 60
    syscall

