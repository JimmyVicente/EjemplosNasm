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
    msjC db "Ingrese numero de columnas: "
    lenC equ $-msjC

    msjF db "Ingrese numero de filas: "
    lenF equ $-msjF
    
    espacio db ' '
    newLine db '',10
section .bss
    c resb 2
    f resb 2
    numero resb 2
section .text
    global _start

_start:
    escribir msjC,lenC
    leer c, 2

    escribir msjF,lenF
    leer f, 2

    escribir newLine,1

    mov eax, [f]
    mov ebx, [c]
    sub eax, '0'
    sub ebx, '0'

    mov ecx,1 ;numero
    mov edx,0  ;contador

columnas:
    push eax  ;filas
    push ebx  ;columnas
    push ecx  ;numero
    push edx  ;contador

    mov eax, ecx
    mov cl,10
    div cl
    add eax, '00'
    mov [numero], eax

    escribir numero, 2
    escribir espacio,1

    pop edx  ;contador
    pop ecx  ;numero
    pop ebx  ;columnas
    pop eax  ;filas

    inc dl  ;incremento contador
    inc cl  ;incremento numero

    cmp bl, dl
    je filas
    jmp columnas

filas:
    push eax  ;filas
    push ebx  ;columnas
    push ecx  ;numero
    push edx  ;contador
    escribir newLine,1
    pop edx  ;contador
    pop ecx  ;numero
    pop ebx  ;columnas
    pop eax  ;filas

    dec eax   ;decremento filas
    mov edx,0 ;regreso el contador a 0

    cmp al,0
    je salir
    jmp columnas




salir:
    escribir newLine,1
    mov eax, 1
    int 80h