;code untested
;donnot use
;by kmahyyg
;licensed under agplV3

assume cs:codesg

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
            mov ss,ax    ; set datasg segmeng as stack
            mov bp,0   ; stack base pointer(bp): point at the base of the stack
            
            mov ax,table 
            mov ds,ax
            
            ; stack pointer(sp): point at the top of stack
            
            mov si,0   ; source index register
            mov bx,0   ; base register: locate data in DS 
            mov cx,5   ; loop times: 5 groups of data
            
     inpt:  mov ax,[bp]
            mov [bx],ax
            ; years in table
            
            ; remember data structure 
            mov ax,[bp+20]     ; jump to the start of salary
            mov [bx+5],ax      ; offset for write data
            mov ax,[bx+22]     ; choose the salary data
            mov [bx+7],ax      ; write salary
            
            mov ax,ss:[si+38]
            mov [bx+10],ax     ; offset 10 for employees
            
            mov ax,[bx+5]
            mov dx,[bx+7]
            div word ptr [bx+10]
            mov [bx+13],ax
            
            add bx,16
            add bp,4
            add si,2
            
            loop inpt
            
            mov ax,4c00h
            int 21h
            
codesg ends

end start