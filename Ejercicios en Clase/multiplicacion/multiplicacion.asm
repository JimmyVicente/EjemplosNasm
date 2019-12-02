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
    m1 resb 1
    m2 resb 1
    multiplicacion resb 1   ;Directiva de datos, dos tipos
    
section .text
    global _start
_start:

    ;********Ingreso el primer numero***********
    escribir msj1, leng1
    leer m1, 2

    ;********Ingreso el Segundo numero***********
    escribir msj2, leng2
    leer m2, 2

    ;********Proceso de division***********
    mov al,[m1]
    mov bl,[m2]
    sub al, '0'
    sub bl, '0'
    mul bl
    add al, '0'
    mov [multiplicacion], al

    ;********Imprime resultado**********
    escribir mensaje,leng
    escribir multiplicacion, 1

    mov eax, 1
    int 80h