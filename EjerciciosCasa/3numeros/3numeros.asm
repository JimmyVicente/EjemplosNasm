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
    msjN1 db 'Ingrese el primer numero: '
    lenN1 equ $ -msjN1
    
    msjN2 db 'Ingrese el segundo numero: '
    lenN2 equ $ -msjN2

    msjN3 db 'Ingrese el tercer numero: '
    lenN3 equ $ -msjN3

    mjsIgual db 'Es igual',10
    lenIgual equ $ -mjsIgual

    mjsNoIgual db 'No igual',10
    lenNoIgual equ $ -mjsNoIgual

section .bss
    n1 resb 2
    n2 resb 2
    n3 resb 2

section .text
    global _start
_start:
    
    escribir msjN1, lenN1
    leer n1, 2

    escribir msjN2, lenN2
    leer n2, 2
    
    escribir msjN3, lenN3
    leer n3, 2

compararSC:
    mov ax, [n1]
    mov bx, [n2]
    sub ax, '0'
    sub bx, '0'
    add ax, bx

    mov bx, [n3]
    sub bx, '0'

    cmp al, bl
    je esIgual
    jmp compararSA

compararSA:
    mov ax, [n2]
    mov bx, [n3]
    sub ax, '0'
    sub bx, '0'
    add ax, bx

    mov bx, [n1]
    sub bx, '0'
    cmp al, bl
    je esIgual
    jmp compararSB


compararSB:
    mov ax, [n1]
    mov bx, [n3]
    sub ax, '0'
    sub bx, '0'
    add ax, bx

    mov bx, [n2]
    sub bx, '0'
    cmp al, bl
    je esIgual
    jmp noEsIgual


esIgual:
    escribir mjsIgual, lenIgual
    jmp salir

noEsIgual:
    escribir mjsNoIgual, lenNoIgual
    jmp salir


salir:
    mov eax, 1
    int 80h