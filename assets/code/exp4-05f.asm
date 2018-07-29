assume cs:code 

dataa segment
  dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fx,0ffh
dataa ends

stackb segment
  dw 0,0,0,0,0,0,0,0
stackb ends

code segment

start: mov ax,stackb  ; set stack segment base addr
       mov ss,ax     ; set stack segment base addr
       mov sp,16     ; set the top flag of stack, stack max saved 16 bytes
       
       mov ax,dataa  ; set data segment base addr
       mov ds,ax     ; set data segment base addr
       
       mov bx,0      ; set offset addr
       mov cx,8      ; set loop times * 8
       
    s: push ds:[bx]  ; push data into stack
       add bx,2      ; add offset 2
       
       mov ax,4c00h
       int 21h
  
code ends

end start
