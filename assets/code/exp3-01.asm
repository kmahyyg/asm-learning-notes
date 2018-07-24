; the code here is not tested now.
; please do not copy it to complete your homework.
; licensed under AGPL Ver3 by @kmahyyg 2018

assume cs:codesg

codesg segment
   
   mov ax,0020h
   mov ds,ax
   mov bx,0
   mov cx,64
   
s: mov [al],bx
   inc bx
   
   loop s
   
   mov ax,4c00h
   int 21h

codesg ends

end
