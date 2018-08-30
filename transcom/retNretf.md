# 5.4 RET & RETF

## RET

RET 命令使用栈中的数据，修改 IP 的内容，从而实现近转移。

对应的操作： 

- (IP) = ((SS)*16 + SP)
- (SP) = (SP) + 2

等价于： `pop IP`

RETF 命令使用栈中的数据，修改 CS 和 IP 的内容，从而实现远转移。

对应的操作：

- (IP) = ((SS)* 16 + SP)
- (SP) = (SP) + 2
- (CS) = ((SS)* 16+ SP)
- (SP) = (SP) + 2

等价于： 

```
pop IP
pop CS
```

### QUIZ 

补全，实现从内存 1000:0000 处开始执行指令

```asm6502
assume cs:code

stack segment
    db 16 dup (0)
stack ends

code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,16
        mov ax, ;TODO
        push ax
        mov ax, ;TODO
        push ax
        retf
code ends

end start
```

答案：`0` 和 `1000h`
