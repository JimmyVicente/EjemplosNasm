%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro
section .data

    folder db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosClase/files/newFolder',0

    file db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosClase/files/newFolder/newFile.txt',0

    mjsError db 'Error en el archivo',10
    lenError equ $-mjsError

section .bss
    texto resb 35
    idFile resb 1
section .text
    global _start
_start:

    ;***create folder***
    mov eax, 39      
    mov ebx, folder    
    mov ecx, 0x1FF   
    int 80h

    read texto, 35

    ;***access the file***
    mov eax, 8
    mov ebx, file
    mov ecx, 2
    mov edx, 0x1FF
    int 80h

    test eax,eax
    jz noFile

    mov dword [idFile], eax

    mov eax,4
    mov ebx,[idFile]
    mov ecx,texto
    mov edx,35
    int 80h
    
    ;****close file***
    mov eax,6
    mov ebx,[idFile]
    mov ecx,0
    mov edx,0x1FF
    int 80h

    jmp salir

noFile:
    write mjsError, lenError

salir:
    mov eax, 1
    int 80h
