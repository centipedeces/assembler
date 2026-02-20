section .data
    msg db "Hola desde el Salon", 10 ; El 10 es el salto de línea (\n)

section .text
    global _start

_start:
    ; --- Escribir el mensaje en pantalla ---
    mov rax, 1          ; Llamada al sistema (syscall) para 'write'
    mov rdi, 1          ; File descriptor 1 es 'stdout' (pantalla)
    mov rsi, msg        ; Dirección de memoria del mensaje
    mov rdx, 20         ; Longitud del mensaje (incluyendo el 10)
    syscall             ; Invocar al kernel

    ; --- Salir del programa ---
    mov rax, 60         ; Llamada al sistema para 'exit'
    xor rdi, rdi        ; Código de error 0 (xor rdi, rdi es más rápido que mov rdi, 0)
    syscall
