section .data
    num1 db "Ingresa el primer sumando:", 10
    l_num1 equ $ - num1
    num2 db "Ingresa el segundo sumando:", 10
    l_num2 equ $ - num2
    salida db "la suma es:"
    l_salida equ $ - salida
    msg_lucky db "suerte!", 10
    l_lucky equ $ - msg_lucky

section .bss
    buffer resb 8

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, num1
    mov rdx, l_num1
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 8
    syscall

    movzx r8, byte [buffer]
    sub r8, 48

    mov rax, 1
    mov rdi, 1
    mov rsi, num2
    mov rdx, l_num2
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 8
    syscall

    movzx rax, byte [buffer]
    sub rax, 48

    add rax, r8
    add rax, 48

    mov [buffer], al
    mov byte [buffer+1], 10

    movzx rax, byte [buffer]
    sub rax, 48
    cmp rax, 7
    jne continuar
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_lucky
    mov rdx, l_lucky
    syscall

continuar:
    mov rax, 1
    mov rdi, 1
    mov rsi, salida
    mov rdx, l_salida
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 2
    syscall
 
    mov rax, 60
    xor rdi, rdi
    syscall
