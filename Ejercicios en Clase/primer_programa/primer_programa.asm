section .data
    mensaje db "hola emsamblador"
    tamano equ $-mensaje
section .text
    global _start
_start:
    mov eax, 4  ;entrada de escritura, movimiente en el registro eax el valor 4
    mov ebx, 1  ;salida, movimiente en el registro ebx el valor 1
    mov ecx, mensaje ;movimiente en el registro ecx del mensaje
    mov edx, tamano ;movimiente en el registro edx del tamaño 
    int 80h ;envia una aseñal al Sistema Operativo (S.O) para ejecutar una subrutina (operación especifica en el S.O)... 
            ; eax => Ejecuta la subrutina dependiendo del movimeinto del eax 
            ; ebx => Determina el estandar 
            ; ecx => lo que desea imprimir 
            ; edx => el número de caracteres de la variable mensaje 

    mov eax, 1
    int 80h