section .data
    pregunta db "Escribe algo (o 'q' para salir): ", 10
    largo_p  equ $ - pregunta

section .bss
    buffer   resb 64
    contador resq 1

section .text
    global _start

_start:
    mov qword [contador], 0

bucle_lectura:
    ; --- 1. Preguntar ---
    mov rax, 1
    mov rdi, 1
    mov rsi, pregunta
    mov rdx, largo_p
    syscall

    ; --- 2. Leer del teclado ---
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 64
    syscall

    ; --- 3. Incrementar contador de intentos ---
    mov rax, [contador]
    inc rax
    mov [contador], rax

    ; --- 4. LA CLAVE: ¿Escribió 'q'? ---
    ; Usamos registros más pequeños para un solo carácter (AL es la parte baja de RAX)
    mov al, [buffer]    ; Movemos el PRIMER byte del buffer al registro AL
    cmp al, 'q'         ; Comparamos ese byte con el carácter 'q'
    je salir            ; JE (Jump if Equal): Si es 'q', saltamos a la etiqueta 'salir'

    ; --- 5. Si no fue 'q', repetimos ---
    jmp bucle_lectura   ; Salto incondicional: vuelve arriba siempre

salir:
    mov rdi, [contador] ; Devolvemos cuántas veces escribió antes de salir
    mov rax, 60
    syscall
