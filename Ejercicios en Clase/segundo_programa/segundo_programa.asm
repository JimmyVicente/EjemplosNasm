section .data
    nombre1 db "Jimmy "
    tamano1 equ $-nombre1
    nombre2 db "Leonel "
    tamano2 equ $-nombre2
    apellido1 db "Vicente "
    tamano3 equ $-apellido1
    apellido2 db "Guayanay"
    tamano4 equ $-apellido2
section .text
    global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, nombre1
    mov edx, tamano1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nombre2
    mov edx, tamano2
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, apellido1
    mov edx, tamano3
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, apellido2
    mov edx, tamano4
    int 80h

    mov eax, 1
    int 80h
