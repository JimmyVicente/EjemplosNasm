%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro
section .data
    pathNum1 db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/1examenRepaso/1.txt',0
    pathNum2 db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/1examenRepaso/2.txt',0
    pathMore db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/1examenRepaso/suma.txt',0

    mjsError db 'Error en el archivo',10
    lenError equ $-mjsError

    msjMore db ' + '
    msjEqual db ' = '
    
    newLine db '',10

section .bss
    num1 resb 1
    num2 resb 1

    idNum resb 1

    suma resb 2
    idFile resb 1
section .text
    global _start
_start:

readFileNum1:
    mov eax, 5 
    mov ebx, pathNum1
    mov ecx, 0
    mov edx, 0
    int 80h

    test eax, eax
    jz errorFile
    mov dword[idNum], eax
    
    mov eax, 3
    mov ebx, [idNum]
    mov ecx, num1
    mov edx, 1 ;len
    int 80h

    write num1,1
    ; close file 1
    mov eax, 6
    mov ebx, [idNum]
    mov ecx, 0
    mov edx, 0x1FF
    int 80h

    write msjMore,3

readFileNum2:
    mov eax, 5
    mov ebx, pathNum2
    mov ecx, 0
    mov edx, 0
    int 80h

    test eax, eax
    jz errorFile
    mov dword[idNum], eax
    mov eax, 3
    mov ebx, [idNum]
    mov ecx, num2
    mov edx, 1 ;len
    int 80h

    write num2,1
    ; close file 2
    mov eax, 6
    mov ebx, [idNum]
    mov ecx, 0
    mov edx, 0x1FF
    int 80h

        write msjEqual,3
sumaNumero:
    mov eax, [num1]
    mov ebx, [num2]
    sub eax, '0'
    sub ebx, '0'
    add eax, ebx
    add eax, '0'
    mov [suma], eax

    write suma, 1

    write newLine,1

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

    ;asigna el valor de la suma hacia el archivo
    mov eax,4
    mov ebx,[idFile]
    mov ecx,suma
    mov edx,1
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