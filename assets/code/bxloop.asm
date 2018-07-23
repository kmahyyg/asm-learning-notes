assume cs:code

code segment

   mov ax,0ffffh
   mov ds,ax
   mov bx,8     ; ds:dx=ffff:6

   mov al,[bx]
   mov ah,0     ; (al)=((ds*16)+(bx)),(ah)=0
   mov dx,0     ; init empty dx to save data

   mov cx,123   ; define loop times

s: add dx,ax    ; loop program
   loop s

   mov ax,4c00h   ; interupt to get back
   int 21h

code ends

end
