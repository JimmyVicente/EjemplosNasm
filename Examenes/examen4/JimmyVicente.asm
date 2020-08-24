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
    path db '/home/jimmy/Documentos/ENSAMBLADOR/EjemplosNasm/Examenes/examen4/Jimmy_Vicente.txt',0
    newLine db '',10

    mjsNum db 'El numero '
    lenNum equ $ -mjsNum

    mjsCont db ' se repite '
    lenCont equ $ -mjsCont

    mjsSomething db ' veces',10
    lenSomething equ $ -mjsSomething

    mjsSum db 'La suma de los numeros es: '
    lenSum equ $ -mjsSum


    ;Dfenir arreglo 
    array db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    lenArray equ $ -array

    ;sum db '  '

section .bss
    idArray resb 1
    ; variable fot repeat
    value resb 1
    aux resb 1
    cont resb 1
    ; variable for sum of numbers
    sum resb 2
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

    write array,lenArray
    write newLine,1

    ; close file 1
    mov eax, 6
    mov ebx, [idArray]
    mov ecx, 0
    mov edx, 0x1FF
    int 80h


initNumRepeat:
    mov esi, array
    mov edi, 0

    mov eax, [esi]
    mov [value], eax

    mov bl, 0
    mov [cont], bl
    
    mov cl, 0

    mov dl, 0

findRepeat:
    mov al, [value]
    mov bl, [esi]

    call compareRepeat
    
    inc esi
    inc edi
    cmp edi, lenArray
    jb findRepeat
    jmp compareEndArray
    
compareRepeat:
    cmp al, bl
    je incrementCont
    ret
incrementCont:
    inc cl
    ret
compareEndArray:
    inc dl
    ;see position
    mov esi, array
    mov edi, 0
    mov al, dl
    call seePosition
    mov al, [esi]
    mov [aux], al
    ; see num repeat
    mov esi, array
    mov edi, 0
    mov al, 0
    mov bl, 0
    push edx
    call seeNumRepeat
    ;push ebx
    ;add ebx, '0'
    ;mov [sum], ebx
    ;write sum, 1
    ;pop ebx
    call decideResult

    pop edx
    
   
    ;see position
    mov esi, array
    mov edi, 0
    mov al, dl
    call seePosition
    mov al, [esi]
    mov [value], al
    

    ;restar all
    mov esi, array
    mov edi, 0
    mov cl, 0

    cmp dl, lenArray
    jb findRepeat
    jmp initSumOfNumbers
decideResult:
    cmp bl, 0
    je printResultRepeat
    ret
seePosition:
    inc esi
    inc edi
    dec al
    cmp al, 0
    jg seePosition
    ret
seeNumRepeat:
    push eax
    call repeatMethod
    pop eax
    inc al
    cmp al, dl
    jb seeNumRepeat
    ret
repeatMethod:
    mov al, [esi]
    inc esi
    cmp al, [aux]
    je incrementRepeat
    ret
incrementRepeat:
    inc bl
    ret

printResultRepeat:
    add cl, '0'
    mov [cont], cl

    write mjsNum, lenNum
    write value, 1
    write mjsCont, lenCont
    write cont, 1
    write mjsSomething, lenSomething
    ret


;init sum of numbers 
initSumOfNumbers:
    mov esi, 0
    mov ecx, lenArray
    mov bl, 0
    clc  ;disable carry
sumOfNumbers:
    mov al, [array+esi]
    sub al, '0'
    add bl, al
    inc esi
    loop sumOfNumbers
    mov al, bl
    mov bl, 10
    div bl
    add ax,'00'
    mov [sum], ax
printResultSum:
    write newLine, 1
    write mjsSum, lenSum
    write sum, 3
    write newLine, 1
salir:
    mov eax, 1
    int 80h