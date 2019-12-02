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
    mensaje db "Operaciones Arimeticas", 10
    leng equ $-mensaje
    msjnum1 db "Ingrese el primer número: "
    lengnum1 equ $ - msjnum1

    msjnum2 db "Ingrese el segundo número: "
    lengnum2 equ $ - msjnum2

    mjsSuma db "La suma es: "
    lengSuma equ $ - mjsSuma

    mjsResta db "La resta es: "
    lengResta equ $ - mjsResta

    mjsMul db "La multiplicación es: "
    lengMul equ $ - mjsMul

    mjsDiv db "DIVISIÓN",10
    lengDiv equ $ - mjsDiv

    msjDiv1 db "El cociente es: "
    lengDiv1 equ $-msjDiv1

    msjDiv2 db "El residuo es: "
    lengDiv2 equ $-msjDiv2

    espacio db "",10

section .bss
    n1 resb 1
    n2 resb 1

    resultado resb 1
    residuo resb 1

section .text
    global _start
_start:

    escribir mensaje, leng
    ;*****pedir primer numero******
    escribir msjnum1, lengnum1
    leer n1, 2

    ;*****pedir primer numero******
    escribir msjnum2, lengnum2
    leer n2, 2


    ;******SUMA********
    mov ax,[n1]
    mov bx,[n2]
    sub ax, '0'
    sub bx, '0'
    add ax, bx
    add ax, '0'
    mov [resultado], ax 
    ;*****Escribir Suma*****
    escribir mjsSuma, lengSuma
    escribir resultado, 1
    escribir espacio, 1



    ;******RESTA********
    mov ax,[n1]
    mov bx,[n2]
    sub ax, '0'
    sub bx, '0'
    sub ax, bx
    add ax, '0'
    mov [resultado], ax 
    ;*****Escribir Resta*****
    escribir mjsResta, lengResta
    escribir resultado, 1
    escribir espacio, 1


    ;******MULTIPLICACION********
    mov al,[n1]
    mov bl,[n2]
    sub al, '0'
    sub bl, '0'
    mul bl
    add al, '0'
    mov [resultado], al 
    ;*****Escribir MULTIPLICACION*****
    escribir mjsMul, lengMul
    escribir resultado, 1
    escribir espacio, 1



    ;******DIVISION********
    mov al, [n1]
    mov bl, [n2]
    sub al, '0'
    sub bl, '0'
    div bl
    add al, '0'
    mov [resultado], al
    add ah, '0'
    mov [residuo], ah
    ;*****Escribir DIVISION*****
    escribir mjsDiv, lengDiv
    ;escribir cociente
    escribir msjDiv1, lengDiv1
    escribir resultado, 1
    escribir espacio, 1
    ;escribir residuo
    escribir msjDiv2, lengDiv2
    escribir residuo, 1
    escribir espacio, 1

    
    mov eax, 1
    int 80h
