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

    msjR db "Respuesta: "
	lenR equ $-msjR

    nuevaLinea db "",10

section .bss
    cantidad resb 2
    numero resb 2
    aux resb 2
    respuesta resb 2

section .text
    global _start
_start:


    mov ecx, 2

    mov edx, 0
    mov [aux], edx

ciclo:
    push ecx

    escribir msjN, lenN
    leer numero, 2

    mov eax, [numero]
    sub eax, '0'
    mov ecx, eax
    mul ecx

    mov ecx, [aux]
    add eax, ecx

    mov [aux], eax
    
    pop ecx
    loop ciclo

    ;convertir a 2 valores
    add eax, '0'
    mov [respuesta], eax

    
    escribir respuesta, 1
    escribir nuevaLinea, 1


salir:
    mov eax, 1
    int 80h