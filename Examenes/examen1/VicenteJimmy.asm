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
    mjsGetNumero db 'Ingrese un numero: '
    lenGetNumero equ $-mjsGetNumero

    mjsNumero db 'El numero '
    lenNumero equ $-mjsNumero


    mjsPrimo db ' es primo',10
    lenPrimo equ $-mjsPrimo

    mjsNoPrimo db ' no es primo',10
    lenNoPrimo equ $-mjsNoPrimo

section .bss
    numero resb 1
section .text
    global _start
_start:

    ;**************Pedir numero***********************
    escribir mjsGetNumero, lenGetNumero   
    leer numero, 1

    mov cl,2 ;Inicializar contador en 2
    
    mov al,[numero]
    sub al, '0'

    cmp al, 1
    je NoPrimo
    jmp comparar

comparar:
    ;Comparar si el numero ingresado es igual al contador
    cmp al,cl
    je EsPrimo
    jmp bucle


bucle:
    ;Divir el numero ingresado para el contador
    mov ah, 0
    mov al, [numero]
    sub al, '0'
    div cl
    
    inc cl ;Incrementar el contador

    ;Comparar si en residuo es 0
    cmp ah, 0
    je NoPrimo
    jmp comparar

NoPrimo:
    escribir mjsNumero, lenNumero
    escribir numero, 1
    escribir mjsNoPrimo, lenNoPrimo
    jmp salir

EsPrimo:
    escribir mjsNumero, lenNumero
    escribir numero, 1
    escribir mjsPrimo, lenPrimo
    jmp salir


salir:
    mov eax, 1
    int 80h