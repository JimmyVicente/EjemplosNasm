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
    pathDes db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/EjerciciosCasa/5examenRepaso/array.txt',0
    newLine db '',10

    mjsDes db 'Desordenado: '
    lenDes equ $ -mjsDes

    mjsOr db 'Ordenado:    '
    lenOr equ $ -mjsOr

    mjsMedian db 'La mediana es: '
    lenMedian equ $ -mjsMedian 
    
    mjsResidue db '.5'
    lenResidue equ $- mjsResidue

    ;Dfenir arreglo 
    array db 0,0,0,0,0,0,0,0,0
    lenArray equ $ -array

section .bss
    idArray resb 1
    aux resb 1
    idFile resb 1
    ; median 
    median resb 1
section .text
    global _start
_start:

readFileNum:
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

    write mjsDes, lenDes
    write array,lenArray
    write newLine,1
    ; close file 1
    mov eax, 6
    mov ebx, [idArray]
    mov ecx, 0
    mov edx, 0x1FF
    int 80h

; iniciar ordenamiento
    mov esi, array
    mov edi, 0
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
    cmp edi, lenArray
    jb order

    mov al, [esi]
    sub esi, 1
    sub edi, 1
    mov [esi], al


    cmp cl,0
    jg initOrder
    ;

printResultOrder:
    write mjsOr, lenOr
    write array, lenArray
    write newLine, 1

; Find median in array
initMedian:
    mov esi, array
    mov edi, 0

    mov al, lenArray
    mov cl, 2
    div cl

    cmp ah, 0
    je medianPair
    jmp medianOdd

medianPair:
    call seePosition
    mov al, [esi]
    inc esi
    inc edi
    mov bl, [esi]
    ;
    add al, bl
    ;
    mov cl, 2
    div cl
    mov [median], al
    add ah, '0'
    write mjsMedian, lenMedian
    write median, 1
    write mjsResidue, lenResidue
    write newLine, 1
    jmp salir

medianOdd:
    call seePosition
    inc esi
    inc edi
    mov al, [esi]
    mov [median], al
    write mjsMedian, lenMedian
    write median, 1
    write newLine, 1
    jmp salir

seePosition:
    inc esi
    inc edi
    dec al
    cmp al, 1
    jg seePosition
    ret
    
salir:
    mov eax, 1
    int 80h