section .data 
    msj1 db "Ingrese el primer número: "
    leng1 equ $ - msj1

    msj2 db "Ingrese el segundo número: "
    leng2 equ $ - msj2

    mensaje db "El resultado es: "
    leng equ $ - mensaje

section .bss
    n1 resb 1
    n2 resb 1
    suma resb 1   ;Directiva de datos, dos tipos
    
section .text
    global _start
_start:

    ;********Ingreso el primer numero***********
    mov eax, 4
    mov ebx, 1
    mov ecx, msj1
    mov edx, leng1
    int 80h

    mov eax, 3
    mov ebx, 2
    mov ecx, n1
    mov edx, 2
    int 80h

    ;********Ingreso el Segundo numero***********
    mov eax, 4
    mov ebx, 1
    mov ecx, msj2
    mov edx, leng2
    int 80h

    mov eax, 3
    mov ebx, 2
    mov ecx, n2
    mov edx, 2
    int 80h

    ;********Proceso de suma***********
    mov ax,[n1]
    mov bx,[n2]
    sub ax, '0'
    sub bx, '0'
    add ax, bx
    add ax, '0'
    mov [suma], eax 

    ;********Imprime resultado**********
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