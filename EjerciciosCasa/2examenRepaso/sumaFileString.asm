%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro
section .data

    pathMore db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/2examenRepaso/suma.txt',0

    mjsError db 'Error en el archivo',10
    lenError equ $-mjsError

    num1 db '1512'
    num2 db '2711'

    result db '    '
    lenResul equ $-result
    
    newLine db '',10
    espace db ' '
    more db '+'
    separar db '-----',10
    lenSeparar equ $ -separar

section .bss
    suma resb 2
    idFile resb 1
section .text
    global _start
_start:

readFileNum1:
    mov esi, 3 
    mov ecx, 4
    clc ;disable carry
addString:
    mov al, [num1+esi]
    ;mov ah, [num2+esi]
    ;adc al, ah

    adc al, [num2+esi]
    aaa ;work with al
    pushf
    or al, 30h ;aas
    popf
    mov [result+esi],al

    dec esi
    loop addString

    write espace,1
    write num1, 4
    write newLine, 1
    write more, 1
    write num2, 4
    write newLine, 1
    write separar, lenSeparar
    write espace, 1
    write result, 4
    write newLine, 1
    

writeFileMore:
     ;***access the file***
    mov eax, 8
    mov ebx, pathMore
    mov ecx, 2
    mov edx, 0x1FF
    int 80h

    test eax,eax
    jz errorFile

    mov dword [idFile], eax

    mov eax,4
    mov ebx,[idFile]
    mov ecx,result
    mov edx,lenResul
    int 80h
    
    ;****close file***
    mov eax,6
    mov ebx,[idFile]
    mov ecx,0
    mov edx,0x1FF
    int 80h

    jmp salir

errorFile:
    write mjsError, lenError

salir:
    mov eax, 1
    int 80h