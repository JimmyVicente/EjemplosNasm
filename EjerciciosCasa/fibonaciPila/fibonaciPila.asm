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
    msjN db "Ingrese un numero: "
    lenM equ $-msjN
    espacio db '',10
section .bss
    n1 resb 2
    n2 resb 2
    numero resb 2
    entrada resb 2
section .text
    global _start

_start:


    escribir msjN, lenM
    leer entrada,2

    mov ax, 0
    mov cl, 10
    div cl
    add ax, '00'
    mov [n1], ax

    mov ax, 1
    div cl
    add ax, '00'
    mov [n2], ax


    escribir n1, 2
    escribir espacio,1
    escribir n2, 2
    escribir espacio,1

    mov ax, 0
    mov bx, 1

    mov cx, 2

 fibonaci:
    
    inc cx
    push cx

    push bx
    add ax, bx
    push ax
  

    mov cl, 10
    div cl 
    add ax, '00'
    mov [numero], ax


    escribir numero, 2
    escribir espacio, 1

    pop bx
    pop ax
    pop cx

    mov dl, [entrada]
    sub dl, '0'

    cmp cl, dl
    je salir
    jmp fibonaci
  

salir:
    mov eax, 1
    int 80h