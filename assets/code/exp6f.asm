; asm-learning-notes
; Copyright (C) 2018  kmahyyg
; 
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU Affero General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU Affero General Public License for more details.
; 
; You should have received a copy of the GNU Affero General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.

assume cs:codesg,ds:datasg,es:table

datasg segment   ; seen as data segment

    db '1975','1976','1977','1978','1995'    ;years
    dd 10h,16h,17eh,5b0h,5a9768h    ; total salary
    dw 3h,7h,9h,0dh,4588h   ;employees
    
datasg ends

table segment    ; seen as extra data segment

    db 5 dup ('year toal empl ag ')
    
table ends

codesg segment

    start:  mov ax,datasg 
            mov ds,ax    ; ss point to datasg segment
            mov di,0   
            
            mov ax,table 
            mov es,ax   ; es point to table segment
            
            mov si,0   
            mov bx,0   ; base register: locate data in DS 
            mov cx,5   ; loop times: 5 groups of data
            
       s1:  mov al,[di]
            mov es:[bx],ax
            mov al,[di+1]
            mov es:[bx+1],ax
            mov al,[di+2]
            mov es:[bx+2],ax
            mov al,[di+3]
            mov es:[bx+3],ax
            ; years in table 4 bytes (32 bits)
            
            ; remember data structure 
            mov ax,18h[di]     ; jump to the start of salary, 20 bytes offset
            mov es:5h[bx],ax     ; choose the salary data
            
            mov ax,28h[si]      ; 40 bytes in datasg segment offset (4 bytes == 32 bits)
            mov es:0ah[bx],ax   ; employees' numbers into table segment  
            
            mov ax,20h[di]      ; save num to be divided (2 bytes == 16 bits)
            mov dx,22h[di]      ; which is salary
            div word ptr 28h[si]   ; divided by 28h[si]
            mov es:0dh[bx],ax   ; quotient saved to table segment
            
            add bx,16  ; next line
            add di,4   ; 4 bytes offset (other datas)
            add si,2   ; 2 bytes offset (employees)
            
        loop s1  ; loop code
                
        mov ax,4c00h
        int 21h      ; back to normal
            
codesg ends

end start
