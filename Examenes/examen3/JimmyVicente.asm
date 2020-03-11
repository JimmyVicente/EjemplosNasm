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

segment .data
	msj db "Escriba un numero: "
	len equ $-msj

    msjB db "El numero binario es: "
	lenB equ $-msjB

    newLine db '',10
    
    espace db ' '

segment .bss
    numero resb 2

segment .text
	global _start
_start:
    escribir msj, len
    leer numero, 2

    mov al, [numero]
    sub al, '0'

    cmp al, 1  ; si numero es igual 1 presenta 1
    je presentarUno 

    mov esi, 0 ;no se modifica el esi  y es el contador 

division:
    mov bl, 2
    div bl
    push eax
    escribir espace, 1
    pop ebx
    push ebx
    mov al, bl ; residuo 
    inc esi
    cmp al, 1
    je verFinal
    jmp division

verFinal:
    push eax
    escribir newLine,1
    escribir msjB, lenB
    pop eax
    add al, '0'
    mov [numero], al
    escribir numero, 1

    mov ecx, esi
    jmp presentar
presentar:
    pop eax
    push ecx
    add ah, '0'
    mov [numero], ah
    escribir numero, 1
    pop ecx
    loop presentar ;decrementa
    jmp salir

presentarUno:
    escribir newLine,1
    escribir msjB, lenB
    escribir numero, 1
    jmp salir

salir:
    escribir newLine,1
    escribir newLine,1
	mov eax, 1
	int 80h