section .data
    asterisco db '*'
    newLine db '',10
section .bss
    cont_bx resb 1
    cont_cx resb 1
section .text
    global _start
_start:

    mov ecx, 9
l1:
    push ecx
    push ecx
    call printNewLine
    pop ecx

l2:
    push ecx
    call printAsterisco
    pop ecx
    loop l2

    pop ecx

    loop l1

    jmp salir

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
    mov eax, 1
    int 80h