;code untested
;donnot use
;by kmahyyg
;licensed under agplV3

assume cs:codesg,ds:datasg,ss:table

datasg segment   ; seen as stack

    db '1975','1976','1977','1978','1995'    ;years
    dd 16,22,382,1456,5937000    ; total salary
    dw 3,7,9,13,17800   ;employees
    
datasg ends

table segment

    db 5 dup ('year total employees average ')
    
table ends

codesg segment

    start:  mov ax,datasg 
            mov ss,ax    ; ss point to datasg segment
            mov di,0   
            
            mov ax,table 
            mov es,ax   ; es point to table segment
            
            mov si,0   
            mov bx,0   ; base register: locate data in DS 
            mov cx,5   ; loop times: 5 groups of data
            
     inpt:  mov al,[di]
            mov es:[bx],ax
            mov al,[di+1]
            mov es:[bx],ax
            mov al,[di+2]
            mov es:[bx],ax
            mov al,[di+3]
            mov es:[bx],ax
            ; years in table 4bytes
            
            ; remember data structure 
            mov ax,14h[di]     ; jump to the start of salary, 20 bytes offset
            mov dx,16h[di]      ; offset for write data
            mov es:5h[bx],ax     ; choose the salary data
            mov es:7h[bx],dx      ; write salary
            
            mov ax,ss:[si+38]
            mov [bx+10],ax     ; offset 10 for employees
            
            mov ax,[bx+5]
            mov dx,[bx+7]
            div word ptr [bx+10]
            mov [bx+13],ax
            
            add bx,16
            add di,4
            add si,2
            
            loop inpt
            
            mov ax,4c00h
            int 21h
            
codesg ends

end start
