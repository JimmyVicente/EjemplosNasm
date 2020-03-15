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
    path db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/6examenRepaso/array.txt',0
    newLine db '',10
    espace db ' '
  
    array db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    lenArray equ $ -array
    
section .bss
    idArray resb 1
    aux resb 1
section .text
    global _start
_start:
readFileNum:
    mov eax, 5 
    mov ebx, path
    mov ecx, 0
    mov edx, 0
    int 80h

    test eax, eax
    jz salir
    mov dword[idArray], eax
    
    mov eax, 3
    mov ebx, [idArray]
    mov ecx, array
    mov edx, lenArray ;len
    int 80h

    ; close file 1
    mov eax, 6
    mov ebx, [idArray]
    mov ecx, 0
    mov edx, 0x1FF
    int 80h

    mov esi,array
    mov edi, 0
bucle:
    mov eax, [esi]
    sub eax, '0'
    mov [aux], eax
    write aux,1
    write espace, 1
    inc esi
    inc edi
    cmp edi, lenArray
    jb bucle
    write newLine, 1
salir:
    mov eax, 1
    int 80h