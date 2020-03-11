%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro
section .data

    archivo db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosClase/files/codigo.txt',0

    mjsError db 'Error en el archivo'
    lenError equ $-mjsError

section .bss
    texto resb 35
    idArchivo resb 1
section .text
    global _start
_start:

    mov eax, 5 ;Se convoca una subrutina al SO
    mov ebx, archivo 
    mov ecx, 0  ;modos de acceso  R-only=0 W-only=1 RDWR=2
    mov edx, 0
    int 80h

    test eax,eax
    jz noFile
    mov dword[idArchivo],eax
    mov eax,3
    mov ebx,[idArchivo]
    mov ecx,texto
    mov edx,35
    int 80h

    write texto, 35

    ;****close file***
    mov eax,6
    mov ebx,[idArchivo]
    mov ecx,0
    mov edx,0x1FF
    int 80h

    jmp salir
    
noFile:
    write mjsError, lenError

salir:
    mov eax, 1
    int 80h
