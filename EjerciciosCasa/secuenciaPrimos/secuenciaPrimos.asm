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
    msj db 'Ingrese un numero: ',
    len equ $-msj

    msjP db ' no es primo',
    lenP equ $-msjP
section .bss
    numero resb 1
    primo resb 1
section .text
    global _start
_start:
    escribir msj, len
    leer numero, 1

    mov al, 2  ;contador n veces
    mov bl, 2  ;contador divisor
    mov ecx, [numero]
    sub ecx, '0'

bucleNumero:
    push ecx ;loop
    call comparar
    pop ecx ;loop
    loop bucleNumero
    jmp salir

comparar:
    cmp bl, al
    je imprimir
    jmp bucle
bucle:
    push eax
    mov ah, 0
    div bl
    inc bl 
    cmp ah, 0
    je noPrimo
    jmp esPrimo
    
noPrimo:
    pop eax
    inc al
    jmp comparar
esPrimo:
    pop eax
    jmp comparar

imprimir:
    push eax 
    add eax, '0'
    mov [primo], eax
    escribir primo,1
    pop eax
    inc al
    mov bl, 2
    ret



salir:
    mov eax, 1
    int 80h