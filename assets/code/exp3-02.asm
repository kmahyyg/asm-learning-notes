; the code here is tested now.
; please do not use this code to complete your homework.
; licensed under AGPL Ver3 by @kmahyyg 2018
 

assume cs:code

code segment
   
   mov ax,cs  ; any program beginning address is storaged in cs, very importatnt
   mov ds,ax  ; pass ax as segment base address
   mov ax,0020h
   mov es,ax
   mov bx,0
   mov cx,17h    ; the data bytes you should copy,after loop minus interupt program
   ; use offset <segment name> instead
   
s: mov al,[bx]     ; reuse the offset address
   mov es:[bx],al    ; pass the data in addr to ram
   inc bx          ; bx+=1
   
   loop s
   
   mov ax,4c00h
   int 21h
   
code ends

end
