section .data
    msg1 db "Primer numero (0-4): ", 10
    l1   equ $ - msg1
    msg2 db "Segundo numero (0-4): ", 10
    l2   equ $ - msg2

section .bss
    buffer resb 8

section .text
    global _start

_start:
    ; --- 1. Pedir primer número ---
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

    ; Convertir y guardar en R8
    mov al, [buffer]
    sub al, 48
    movzx r8, al       ; R8 ahora tiene el primer número real

    ; --- 2. Pedir segundo número ---
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

    ; Convertir el segundo
    mov al, [buffer]
    sub al, 48         ; AL ahora tiene el segundo número real

    ; --- 3. La Suma Final ---
    add rax, r8        ; Sumamos R8 al valor de RAX
    
    ; --- 4. Salida ---
    mov rdi, rax       ; Pasamos el resultado total a RDI para el exit
    mov rax, 60
    syscall
