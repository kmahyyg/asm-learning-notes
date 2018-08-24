assume cs:codesg,ds:datasg

datasg segment 

    dw 0257h,0265h,026ch,0263h,026fh,026dh,0265h,0220h
    dw 0774h,076fh,0720h
    dw 7462h,7469h,746ch,7469h,7462h,7469h,746ch,7469h,7421h
    
datasg ends

codesg segment

    start:  mov ax,0b872h
            mov es,ax
            mov ax,datasg
            mov ds,ax
            
            mov bx,0
            
            mov cx,40
            
      lys:  mov al,ds:[bx]
            mov es:[bx],al
            inc bx
            
            loop lys
            
            mov ax,4c00h
            int 21h
            
codesg ends
end start

