%macro escribir 2
  mov eax, 4
  mov ebx, 1
  mov ecx, %1
  mov edx, %2
  int 80h
%endmacro

section .data
    num1 db '3277'
    num2 db '2566'

    result db '    '

section .text
    global _start
_start:
    mov esi, 3 
    mov ecx, 4
    clc ;disable carry
addString:
    mov al, [num1+esi]
    sbb al, [num2+esi]
    aas ;work with al
    pushf
    or al, 30h ;aas
    popf
    mov [result+esi],al

    dec esi
    loop addString

    escribir result,4

salir:
    mov eax, 1
    int 80h