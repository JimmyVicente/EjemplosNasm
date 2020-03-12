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
    pathDes db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/3exameRepaso/arrayDes.txt',0
    pathOr db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/3exameRepaso/arrayOr.txt',0
    newLine db '',10

    ;Dfenir arreglo 
    array db 0,0,0,0,0,0
    lenArray equ $ -array

section .bss
    idArray resb 1
    aux resb 1
    idFile resb 1
section .text
    global _start
_start:

readFileNum1:
    mov eax, 5 
    mov ebx, pathDes
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

    write array,lenArray
    write newLine,1
    ; close file 1
    mov eax, 6
    mov ebx, [idArray]
    mov ecx, 0
    mov edx, 0x1FF
    int 80h

initOrder:
    ;asignacion en las posiciones efectivas
    mov esi, array
    mov edi, 0
    
    mov al, [esi]
    mov [aux], al

    mov cl, 0
order:
    add esi, 1
    add edi, 1
    mov al, [aux]
    mov bl, [esi]

    cmp bl, al
    jb changePosition
    jmp chageAux

changePosition:
    sub esi, 1
    sub edi, 1
    mov [esi], bl
    add esi, 1
    add edi, 1
    mov [esi], al
    inc cl
    jmp sizeArray
chageAux:
    mov [aux], bl
sizeArray:
    ;sub edi, 1
    cmp edi, lenArray
    jb order

    mov al, [esi]
    sub esi, 1
    sub edi, 1
    mov [esi], al


    cmp cl,0
    jg initOrder

    mov esi, array
    mov edi, 0

printResult:
    mov al, [esi]
    ;add al,'0'
    mov [aux], al
    write aux, 1
    add esi, 1
    add edi, 1
    cmp edi, lenArray
    jb printResult

writeResultFile:
    ;***access the file***
    mov eax, 8
    mov ebx, pathOr
    mov edx, 0x1FF
    int 80h

    test eax,eax
    jz salir

    mov dword [idFile], eax

    ;asigna el valor de la suma hacia el archivo
    mov eax,4
    mov ebx,[idFile]
    mov ecx,array
    mov edx,lenArray
    int 80h
    
    ;****close file***
    mov eax,6
    mov ebx,[idFile]
    mov ecx,0
    mov edx,0x1FF
    int 80h

salir:
    mov eax, 1
    int 80h