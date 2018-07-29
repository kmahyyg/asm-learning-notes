assume cs:code

dataa segment
  db 1,2,3,4,5,6,7,8
dataa ends

datab segment
  db 1,2,3,4,5,6,7,8
datab ends

datac segment 
  db 0,0,0,0,0,0,0,0
datac ends

code segment

start: mov bx,0    ; offset addr
       mov dx,0    ; save sum data to be passed
       mov cx,8    ; loop times
       
    s: mov dx,0    ; clear temp storage
       
       mov ax,dataa
       mov ds,ax
       add dl,[bx]
       
       mov ax,datab
       mov ds,ax
       add dl,[bx]
       
       mov ax,datac
       mov ds,ax
       mov [bx],dl
       
       inc bx
       
       loop s
       
       mov ax,4c00h
       int 21h
       
code ends

end start
