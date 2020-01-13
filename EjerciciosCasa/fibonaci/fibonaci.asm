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
    espacio db '',10
section .bss
    n1 resb 1
    n2 resb 1
    numero resb 1
section .text
    global _start

_start:

    mov esi, 2
    mov al, 0
    mov bl, 1
    add al, '0'
    add bl, '0'
    mov [n1], al
    mov [n2], bl

    escribir n1, 1
    escribir espacio,1
    escribir n2, 1
    escribir espacio,1

    mov al, 0
    mov bl, 1
    mov [n1], al
    mov [n2], bl

 fibonaci:
    
    inc esi

    mov al, [n1]
    mov bl, [n2]
    mov [n1], bl
    add al, bl
    mov [n2], al
  

    ;mov cl, 10
    ;div cl 
    add ax, '0'
    mov [numero], ax


    escribir numero, 2
    escribir espacio, 2



    cmp esi, 12
    je salir
    jmp fibonaci
  

salir:
    mov eax, 1
    int 80h