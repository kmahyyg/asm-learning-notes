assume cs:codesg

datasg segment

    db '1975','1976','1977','1978','1995'    ;years
    dd 16,22,382,1456,5937000    ; total salary
    dw 3,7,9,13,17800   ;employees
    
datasg ends

codesg segment

    start:  ;todo
    
codesg ends

table segment

    db 5 dup ('year total employees average ')
    
table ends
