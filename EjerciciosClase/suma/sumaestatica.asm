section .data 
    mensaje db "El resultado es: ", 10
    leng equ $-mensaje
section .bss
    suma resb 1   ;Directiva de datos, dos tipos
    
section .text
    global _start
_start:
    mov eax, 4
    mov ebx, 3
    add eax, ebx
    add eax, '0' ;tranformar de numero a cadena

    mov [suma], eax 


    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, leng
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, suma
    mov edx, 1
    int 80h

    mov eax, 1
    int 80h

