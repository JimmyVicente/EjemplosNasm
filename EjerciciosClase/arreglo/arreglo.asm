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
    msj db 'Ingrese numero: '
    len equ $ -msj

    mjsMayor db 'El número mayor es: '
    lenMayor equ $-mjsMayor

    mjsMenor db 'El número menor es: '
    lenMenor equ $-mjsMenor

    newLine db '',10

    ;Dfenir arreglo 
    arreglo db 0,0,0,0,0,0
    lenArreglo equ $ -arreglo

section .bss
    numero resb 1
    menor resb 1
    mayor resb 1
    aux resb 1
section .text
    global _start
_start:
    
    ;asignacion en las posiciones efectivas
    mov esi, arreglo
    mov edi, 0

leerNumero:
    escribir msj, len
    leer numero, 2

    ;asignacion de un numero en el arreglo
    mov eax, [numero]
    sub eax, '0'
    mov [esi], eax

    ;incrementar una posicion en e arreglo
    add esi, 1
    add edi, 1
    
    ;comparar para ahcer el salto
    cmp edi, lenArreglo
    jb leerNumero

    mov esi, arreglo
    mov edi, 0

    mov al, [esi]
    mov [menor], al

;Ver el numeor menor
verMenor:
    mov bl, [esi]
    add esi, 1
    add edi, 1

    mov al, [menor]

    cmp bl, al
    jb  numeroMenor
    jmp compararMenor

numeroMenor:
    mov [menor],bl

compararMenor:
    cmp edi, lenArreglo
    jb verMenor

    mov esi, arreglo
    mov edi, 0
    mov al, [esi]
    mov [mayor], al

;Ver el numeor mayor

verMayor:
    mov bl, [esi]
    add esi, 1
    add edi, 1

    mov al, [mayor]

    cmp bl, al
    jg  numeroMayor
    jmp compararMayor
numeroMayor:
    mov [mayor],bl
compararMayor:
    cmp edi, lenArreglo
    jb verMayor

; Presentar los numeros
presentar:
    escribir mjsMenor, lenMenor
    mov eax, [menor]
    add eax, '0'
    mov [menor], eax
    escribir menor, 1

    escribir newLine,1

    escribir mjsMayor, lenMayor
    mov eax, [mayor]
    add eax, '0'
    mov [mayor], eax
    escribir mayor, 1

    escribir newLine,1


salir:
    mov eax, 1
    int 80h