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
	lenN equ $-msjN

    msjR db "El factorial es: "
	lenR equ $-msjR

    nuevaLinea db "",10

section .bss
    numero resb 2
    aux resb 2
    respuesta resb 2

section .text
    global _start
_start:
    escribir msjN, lenN
    leer numero, 1

    mov ecx, [numero]
    sub ecx, '0'

    mov edx, 1
    mov [aux], edx

ciclo:
    push ecx
    mov eax, [aux]
    mul ecx

    mov [aux], eax


    ;convertir a 2 valores
    mov bl,10
    div bl
    add eax, '00'
    mov [respuesta], eax

    pop ecx
    loop ciclo

    escribir msjR, lenR
    escribir respuesta, 2
    escribir nuevaLinea, 1

salir:
    mov eax, 1
    int 80h