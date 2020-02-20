%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro leer 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj db 'Ingrese un numero: ',
    len equ $-msj

    asterisco db '*',

    newLine db '',10

    espace db ' '

section .bss
    numero resb 2
section .text
    global _start
_start:

    mov ecx, 1


salir:
    escribir newLine,1
    mov eax, 1
    int 80h