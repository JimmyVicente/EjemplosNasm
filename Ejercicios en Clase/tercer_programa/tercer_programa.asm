section .data
    entada db "Ingrese su nombre: ",10
    sizeEntrada equ $-entada
    mensaje db "Su nombre es: "
    sizeMensaje equ $-mensaje

section .bss
    nombre resb 5 ;la capacidad 

section .text 
    global _start 
_start:
    ;*******imprimir mensaje 1*********
    mov eax, 4
    mov ebx, 1
    mov ecx, entada
    mov edx, sizeEntrada
    int 80h
    ;*******Lectura del nombre*********
    mov eax, 3  
    mov ebx, 2 
    mov ecx, nombre 
    mov edx, 5  
    int 80h 
    ;*******Imprimir mensaje 2 *********
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, sizeMensaje
    int 80h
    ;*******Imprimir nombre *********
    mov eax, 4
    mov ebx, 1
    mov ecx, nombre
    mov edx, 5
    int 80h
    
    mov eax, 1
    int 80h