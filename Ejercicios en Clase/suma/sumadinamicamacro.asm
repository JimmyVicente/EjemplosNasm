%macro  escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro  leer 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

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
    escribir msj1, leng1
    leer n1, 2

    ;********Ingreso el Segundo numero***********
    escribir msj2, leng2
    leer n2, 2

    ;********Proceso de suma***********
    mov ax,[n1]
    mov bx,[n2]
    sub ax, '0'
    sub bx, '0'
    add ax, bx
    add ax, '0'
    mov [suma], ax 

    ;********Imprime resultado**********
    escribir mensaje,leng
    escribir suma, 1

    mov eax, 1
    int 80h