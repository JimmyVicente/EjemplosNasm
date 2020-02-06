section .data
    asterisco db '*'
    newLine db '',10
    espace db ' '
section .bss
    cont_aux resb 1
section .text
    global _start
_start:

    mov ecx, 9
l1:
    push ecx
    push ecx
    call printNewLine
    pop ecx
    mov eax, 10
    sub eax, ecx

l2:
    push ecx
    push eax
    call printEspace
    pop eax
    dec al
    pop ecx
    cmp al, 0
    je l3
    jmp l2
    

l3: 
    push ecx
    call printAsterisco
    pop ecx
    loop l3

    pop ecx

    loop l1

    jmp salir

printEspace:
    mov eax, 4
    mov ebx, 1
    mov ecx, espace
    mov edx, 1
    int 80h
    ret 

printNewLine:
    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, 1
    int 80h
    ret 

printAsterisco:
    mov eax, 4
    mov ebx, 1
    mov ecx, asterisco
    mov edx, 1
    int 80h
    ret 


salir:
    call printNewLine
    mov eax, 1
    int 80h