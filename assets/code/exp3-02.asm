; the code here is not tested now.
; please do not use this code to complete your homework.
; licensed under AGPL Ver3 by @kmahyyg 2018
 

assume cs:code

code segment
   
   mov ax,0
   mov ds,ax
   mov ax,0020h
   mov es,ax
   mov bx,0
   mov cx,3
   
s: mov al,[bx]
   mov es:[bx],al
   inc bx
   
   loop s
   
   mov ax,4c00h
   int 21h
   
code ends

end
