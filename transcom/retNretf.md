# 5.4 RET & RETF

## RET

RET 命令使用栈中的数据，修改 IP 的内容，从而实现近转移。

对应的操作： 

- (IP) = ((SS)*16 + SP)
- (SP) = (SP) + 2

等价于： `pop IP`

## RET N

`ref n` 作用是修改 SP 的值，将 SP 的当前值 加上 n，具体请参照 [此处](https://asm.kmahyyg.xyz/asmcommands/pushpop.html#%E5%A6%82%E4%BD%95%E7%A1%AE%E5%AE%9A%E6%A0%88%E9%A1%B6%E6%A0%87%E8%AE%B0) 。

`ref n` 用于修改栈顶指针。等价于：

```asm6502
pop ip
add sp,n
```

## RETF

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
