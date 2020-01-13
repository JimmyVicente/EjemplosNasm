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
  mjs db 10, 'Carperta o directorio creado', 10
  lenMsj equ $ -mjs
  
  msjPath db 'Ingrese el directorio donde quiere guardar : '
  lenPath equ $ -msjPath

  
section .bss
  
  path resb 1

section .text
  global _start 

_start:

  escribir msjPath, lenPath
  leer path, 50

  mov eax, 39      ;servicio para crear un directorio
  mov ebx, path  ;Define la ruta del servicio
  mov ecx, 0x1FF   ;Definir el permiso 777
  int 80h
  
  escribir mjs, lenMsj
  
  
  jmp salir


salir:
  mov eax, 1
  int 80h