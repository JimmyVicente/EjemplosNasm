%macro  escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro  leer 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj1 db "Operación  de división de 8 bits", 10
    len1 equ $-msj1

    msj2 db "Ingrese el primer número: "
    len2 equ $ - msj2

    msj3 db "Ingrese el segundo número: "
    len3 equ $ - msj3

    msj4 db "El cociente es: "
    len4 equ $-msj4

    msj5 db "El residuo es: "
    len5 equ $-msj5

    espacio db "",10

section .bss
    d1 resb 1
    d2 resb 1
    residuo resb 1
    cociente resb 1

section .text
    global _start
_start:

    escribir msj1, len1
    escribir msj2, len2
    leer d1, 2
    escribir msj3, len3
    leer d2, 2
    
    mov al, [d1]
    mov bl, [d2]
    sub ax, '0'
    sub bl, '0'
    div bl
    add al, '0'
    mov [cociente], al
    add ah, '0'
    mov [residuo], ah
    ;*************cociente************
    escribir msj4, len4
    escribir cociente, 1
    ;*************residuo************
    escribir espacio, 1
    escribir msj5, len5
    escribir residuo, 1
    escribir espacio, 1
    ;*************final************
    mov eax, 1
    int 80h