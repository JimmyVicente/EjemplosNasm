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
    msjN db "Escribe un numero: ",
	lenN equ $-msjN
    espacio db '',10

section .bss
    numero resb 1

section .text
    global _start
_start:
    escribir msjN, lenN
    leer numero, 1
    jmp imprimir

principal:
    cmp cl, 0
    jz salir
    jmp imprimir

imprimir:
    mov eax, [numero]
    push eax
    escribir numero, 1 
    escribir espacio,1

    pop eax
    sub eax,'0'
    dec eax
    mov ecx, eax
    add eax, '0'
    mov [numero], eax

    cmp ecx, -1
    jz salir
    jmp imprimir

salir:
    mov eax, 1
    int 80h