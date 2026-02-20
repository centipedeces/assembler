section .data
    pregunta db "Escribe algo (o 'q' para salir): ", 10
    largo_p  equ $ - pregunta

section .bss
    buffer   resb 64

section .text
    global _start

_start:
    ; --- 1. PROCESO DE LIMPIEZA DEL BUFFER ---
limpiar_buffer:
    mov al, 0           ; Queremos llenar con ceros
    mov rdi, buffer     ; Destino de la limpieza
    mov rcx, 64         ; ¿Cuántas veces? (Contador para REP)
    rep stosb           ; ¡REPite STOSB hasta que RCX sea cero!

    ; --- 2. Mostrar pregunta ---
    mov rax, 1
    mov rdi, 1
    mov rsi, pregunta
    mov rdx, largo_p
    syscall

    ; --- 3. Leer del teclado ---
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 64
    syscall

    ; --- 4. Lógica de salida ---
    cmp rax, 2          ; ¿'q' + Enter?
    jne continuar  ; Si no es 'q', limpiamos y pedimos de nuevo
    
    mov al, [buffer]
    cmp al, 'q'
    jne continuar

    ; --- 5. Salir ---
    mov rax, 60
    xor rdi, rdi        ; Salir con código 0
    syscall

continuar:
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 64
    syscall

    jmp limpiar_buffer
