section .data
    pregunta db "Escribe algo para el Salon: ", 10
    largo_p equ $ - pregunta
    respuesta db "Escribiste: "
    largo_r equ $ - respuesta

section .bss                ; Block Started by Symbol
    buffer resb 64          ; Reservamos 64 bytes de espacio vacío

section .text
    global _start

_start:
    ; 1. Imprimir la pregunta
    mov rax, 1
    mov rdi, 1
    mov rsi, pregunta
    mov rdx, largo_p
    syscall

    ; 2. Leer desde el teclado (sys_read)
    mov rax, 0              ; syscall 0 es 'read'
    mov rdi, 0              ; file descriptor 0 es 'teclado' (stdin)
    mov rsi, buffer         ; Donde guardaremos lo que el usuario escriba
    mov rdx, 64             ; Límite de bytes a leer
    syscall

    ; 3. Imprimir el texto "Escribiste: "
    mov rax, 1
    mov rdi, 1
    mov rsi, respuesta
    mov rdx, largo_r
    syscall

    ; 4. Imprimir lo que guardamos en el buffer
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer         ; Ahora RSI apunta al espacio que antes estaba vacío
    mov rdx, 64             ; Imprimimos los 64 bytes del espacio
    syscall

    ; 5. Salir (sys_exit)
    mov rax, 60
    xor rdi, rdi
    syscall
