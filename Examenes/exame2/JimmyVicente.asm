
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
    
    espacio db ' '
    newLine db '',10
section .bss
    numero resb 2
    aux resb 2
    cont resb 2

    n1 resb 2
    n2 resb 2
    n3 resb 2
    n4 resb 2
    n5 resb 2
section .text
    global _start

_start:

    mov cl,0

entrada:
    add cl, '0'
    mov [cont], cl 


    escribir msjN,lenN
    leer numero, 2

    mov eax, [numero]
    sub eax, '0'
    push eax

    ;comparar
    mov cl, [cont]
    sub cl,'0'
    inc cl

    cmp cl,5
    je reiniciarAux
    jmp entrada

reiniciarAux:
    mov esi,0
    mov cl,0

    jmp comparar

verOrdenado:
    cmp esi,0
    je presentar
    jmp comparar


comparar:

    add cl, '0'
    mov [cont],cl

    pop eax
    pop ebx

    ;comparar
    mov cl, [cont]
    sub cl,'0'
    inc cl

    cmp cl,5
    je verOrdenado
    
    cmp eax,ebx
    jg ordenar
    jmp mantenter

mantenter:
    push eax
    push ebx
    jmp comparar


ordenar:
    push ebx
    push eax
    add eax, '0'
    add ebx, '0'
    mov [n1], ebx
    mov [n2], eax
    ;aumentar aux
    inc esi

    jmp comparar


presentar:
    jmp salir


salir:
    escribir newLine,1
    mov eax, 1
    int 80h