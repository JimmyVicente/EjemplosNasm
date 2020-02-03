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
    lenM equ $-msjN
    newLine db '',10
    mjsMul db ' * '
    lenMul equ $-mjsMul
    msjIgual db ' = '
section .bss
    n resb 2
    dlIn resb 2
    r resb 2
section .text
    global _start
_start:
    escribir msjN, lenM
    leer n,2
    mov al, [n]
    sub al, '0'
    mov dl,0

multiplicar:
    inc dl
    push eax
    push edx
    mul dl

    ;convertir a 2 valores
    mov bl,10
    div bl
    add eax, '00'
    mov [r], eax

    ;Obtener el valor del incremento
    mov ax,dx
    div bl
    add ax, '00'
    mov [dlIn], ax

    escribir n,1
    escribir mjsMul,lenMul
    escribir dlIn,2
    escribir msjIgual,3
    escribir r, 2
    escribir newLine,1

    pop edx
    pop eax
    cmp dl,12
    je salir
    jmp multiplicar
    
salir:
 mov eax, 1
 int 80h
