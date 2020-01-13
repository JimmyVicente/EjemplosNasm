%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro
%macro leer 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro
section .data
    mjsNumero db 'Ingrese un numero: '
    lenNumero equ $-mjsNumero

    mjsPrimo db 'Es primo',10
    lenPrimo equ $-mjsPrimo

    mjsNoPrimo db 'No es primo',10
    lenNoPrimo equ $-mjsNoPrimo

section .bss
    numero resb 1
section .text
    global _start
_start:

    escribir mjsNumero, lenNumero
    leer numero, 1

    mov cl,2

comparar:
    mov al,[numero]
    sub al, '0'
    cmp al,cl
    je EsPrimo
    jmp divir


divir:
    ;dividir 
    mov ah, 0
    mov al, [numero]
    sub al, '0'
    div cl
    
    inc cl

    cmp ah, 0
    je NoPrimo
    jmp comparar
    

NoPrimo:
    escribir mjsNoPrimo, lenNoPrimo
    jmp salir

EsPrimo:
    escribir mjsPrimo, lenPrimo
    jmp salir


salir:
    mov eax, 1
    int 80h