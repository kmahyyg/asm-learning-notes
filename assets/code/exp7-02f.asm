assume cs:codesg,ds:datasg

datasg segment 

    dw 5702h,6502h,6c02h,6302h,6f02h,6d02h,6502h,2002h
    dw 7407h,6f07h,2007h
    dw 6274h,6974h,6c74h,6974h,6274h,6974h,6c74h,6974h,2174h
    
datasg ends

codesg segment

    start:  mov ax,datasg
            mov ds,ax
            mov es,b8000h
            mov ax,start
            mov bx,0
            
            mov cx,40
            
      lys:  mov al,[bx]
            mov dx,ds:[bx]
            mov es:[bx],dx
            inc bx
            
            loop lys
            
            mov ax,4c00h
            int 21h
            
codesg ends
end start

