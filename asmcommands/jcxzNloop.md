# 3.9 转移指令(3): JCXZ & LOOP

## JCXZ 有条件转移指令

`jcxz <标号>` 为有条件转移指令，所有的有条件转移指令都为短转移，对应机器码使用转移位移表示，修改 IP，范围：-128~127。

转移条件： **(CX)==0**

操作：

(1) (CX)==0，(IP)=(IP)+<8 位位移>
(2) 8 位位移 = 标号地址 - `jcxz` 指令后第一个字节的地址, 其余同 `jmp short <标号>`。

### Quiz 1: Fill in the blank

补全代码，使用 `jcxz` 在 2000H 段查找第一个值为 0 的字节，找到后将它的偏移地址存储在 DX 中。

```asm6502
assume cs:codesg
codesg segment
    start:  mov ax,2000h
            mov ds,ax
            mov bx,0
        s:  ;(TODO)
            ;(TODO)
            ;(TODO)
            ;(TODO)
            jmp short s
       ok:  mov dx,bx
            mov ax,4c00h
            int 21h
codesg ends
end start
```

>答案：
> mov ch,0
> mov cl,[bx]
> jcxz ok
> inc bx

## LOOP 循环 - 短转移

`loop <标号>`，所有的循环指令都是短转移，对应机器码使用转移位移表示，修改 IP，范围：-128~127。

转移条件： **(CX) = (CX) - 1, (CX) != 0** 时转移到标号处执行。

其余同 `jcxz` 指令。
