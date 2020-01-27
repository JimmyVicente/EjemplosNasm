%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj db '*',10
section .text
    global _start
_start:
    mov ecx, 9
    jmp principal

principal:
    cmp ecx, 0
    je salir
    jmp imprimir

imprimir:
    dec ecx
    push ecx
    escribir msj, 2
    pop ecx
    jmp principal


salir:
    mov eax, 1
    int 80h