# 5.3 转移指令(3): JCXZ & LOOP

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

### Quiz 2: Fill in the blank

补全下列程序，利用 `loop` 在 2000H 段查找第一个值为 0 的字节，找到后将它的偏移地址存储在 DX 中。

```asm6502
assume cs:codesg
codesg segment
    start:  mov ax,2000h
            mov ds,ax
            mov bx,0
        s:  mov cl,[bx]
            mov ch,0
            ;(TODO)
            inc bx
            loop s
       ok:  dec bx    ; dec = -1
            mov dx,bx
            mov ax,4c00h
            int 21h
codesg ends
end start
```

> 答案： inc cx
> 原因： [CX] == 1 时再减一得0，跳出循环，并未找到我们需要的数据。 当减一得到-1的时候，才是我们需要的 0 数据。

## 一些注意事项

### 根据位移进行转移的意义

这样设计是为了方便程序段在内存中的浮动装配。

我们前面提到，程序所需要使用的空间由计算机在运行程序时预先固定分配一块空闲可用的空间，这段空间的地址并不固定。这样设计可以保证无论如何程序都可以正常运行，因为转移指令的相对位置永远不变。

### 编译器对转移位移超界的检测

注意每条指令允许的最大转移范围，转移范围超界会引发编译器报错。形如 `jmp 2000:0100` 只能在 `debug` 中使用，不能用于编译器编译的源码中。
