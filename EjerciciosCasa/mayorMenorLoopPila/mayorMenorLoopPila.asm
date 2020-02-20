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

    msjMenor db 'El numero menor es: ',
    lenMenor equ $-msjMenor

    msjMayor db 'El numero mayor es: ',
    lenMayor equ $-msjMayor

    msjSuma db 'La sumatoria es: ',
    lenSuma equ $-msjSuma

    msjProm db 'El promedio: ',
    lenProm equ $-msjProm

    newLine db '',10

    espace db ' '

section .bss
    cont resb 2
    numero resb 2
    menor resb 2
    mayor resb 2
    suma resb 2
    promedio resb 2
section .text
    global _start
_start:
    mov ecx, 5
pedirNumero:
    push ecx
    escribir msj, len
    leer numero, 2
    pop ecx

    mov eax, [numero]
    sub eax, '0'
    push eax

    loop pedirNumero

    mov ecx, 4
    
    pop eax
    mov [menor], eax
    mov [mayor], eax
    mov [suma], eax

bucle:
    pop eax
    call compararMenor
    call compararMayor
    call sumarVal
    loop bucle
    jmp  presentar

sumarVal:
    mov ebx, [suma]
    add eax, ebx
    mov [suma], eax
    ret

compararMenor:
    mov bl, [menor]
    cmp al, bl
    jb esMenor
    ret

esMenor:
    mov [menor], al
    ret

compararMayor:
    mov bl, [mayor]
    cmp al, bl
    jg esMayor
    ret

esMayor:
    mov [mayor], al
    ret

presentar:
    escribir newLine,1

    escribir msjMenor, lenMenor
    mov eax, [menor]
    add eax, '0'
    mov [menor], eax
    escribir menor, 1

    escribir newLine,1

    escribir msjMayor, lenMayor
    mov eax, [mayor]
    add eax, '0'
    mov [mayor], eax
    escribir mayor, 1

    escribir newLine,1

    escribir msjSuma, lenSuma

    mov al, [suma]
    mov cl, 10
    div cl
    add eax, '00'
    mov [suma], eax
    escribir suma, 2


    escribir newLine,1
    escribir newLine,1
salir:
    mov eax, 1
    int 80h