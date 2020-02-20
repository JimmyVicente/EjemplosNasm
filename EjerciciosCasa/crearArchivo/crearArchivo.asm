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

segment .data
	msg2 db "Escribe en un archivo :",0xA
	len2 equ $-msg2

  msjPath db 'Ingrese el directorio donde quiere guardar : '
  lenPath equ $ -msjPath

  msjArchivo db 'Ingrese el directorio donde quiere guardar : '
  lenArchivo equ $ -msjArchivo


segment .bss
    path resb 1
    archivo resb 1

segment .text
	global _start
_start:

    ;escribir msjPath, lenPath
    ;leer path, 50

    ;mov eax, 39      ;servicio para crear un directorio
    ;mov ebx, path    ;Define la ruta del servicio
    ;mov ecx, 0x1FF   ;Definir el permiso 777
    ;int 80h

    escribir msjArchivo, lenArchivo
    leer archivo, 50

    mov eax, 8		
    mov ebx, archivo	
    mov ecx, 0x1FF	
    int 80h


salir:
	mov eax, 1
	int 80h