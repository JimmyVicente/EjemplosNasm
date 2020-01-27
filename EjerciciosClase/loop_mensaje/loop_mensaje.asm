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
    msjN db "Ingrese un numero: ",10
	lenN equ $-msjN

    msj db " Saludos",10
	len equ $-msj

    msj1 db 10,"Mensaje "
	len1 equ $-msj1

    asterisco db "*"
    espacio db '',10

section .bss
    aux resb 2
    n resb 2

section .text
    global _start
_start:
    mov ecx,30
ciclo:
    push ecx
    mov al, cl
    mov cl, 10
    div cl
    add ax, "00"
    mov [aux], eax
    escribir msj1, len1
    escribir aux, 2
    escribir msj,len
    pop ecx
    loop ciclo

salir:
    mov eax, 1
    int 80h