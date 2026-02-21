section .data
    msg1 db "Primer numero (0-4): ", 10
    l1	 equ $ - msg1
    msg2 db "Segundo numero (0-4): ", 10
    l2   equ $ - msg2
    msg_res db "Suma: "
    l_res   equ $ - msg_res

section .bss
    buffer resb 8

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, l1
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 8
    syscall

    movzx r8, byte [buffer] ; antes: mov r8b, [buffer]
    sub r8, 48

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, l2
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 8
    syscall

    movzx rax, byte [buffer] ; antes mov al, [buffer]
    sub rax, 48

    add rax, r8

    add rax, 48
    mov [buffer], al
    mov byte [buffer+1], 10

    mov rax, 1
    mov rdi, 1
    mov rsi, msg_res
    mov rdx, l_res
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 2
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
 
