# 3.4  [BX] 和 LOOP 指令

## [BX]

一个内存单元的表示需要两种信息：内存单元地址和内存单元长度（类型），[BX] 表示一个内存单元，这个内存单元的偏移地址在 BX 中。

例一： ``` MOV AX,[BX]```  表示将一个内存单元的内容送入 AX 寄存器，这个内存单元的长度为 两个字节（即 AX 的大小），存放一个字，偏移地址在 BX 中，段地址在 DS 中。

例二： ``` MOV [BX],AX ``` 表示将 AX 中的数据送入 SA:EA 处， 其中 EA 由 BX 中存放的数据提供，作为偏移地址；SA 为段地址，默认由 DS 提供。

> 我们使用的参考书籍，在后续使用了 类似于 ```(ax)``` 这样自定义的例子来表示 寄存器 AX 中的内容，本笔记将不予使用任何非标准写法。 ```()``` 这样的用法在 AT&T 格式的汇编中才被允许使用。（参考文献 1）

> 书中还使用了 ```INC BX``` 指令，等价于 ``` ADD BX,1 ```

## LOOP

```
MOV CX,循环次数
S:
    代码段
    loop S
    
    MOV AX,4c00H
    INT 21H
```

代码解释：将循环次数置入 CX 中，S是一段代码的标号，标识着一个地址。当 CPU 执行 loop s的时候，将 CX -=1 直至判断到 CX 为 0，不为 0, 则跳转到 S 标号对应的地址处继续执行，为 0, 则跳转到下一条指令。

## idata & rdata

idata 和 rdata 都表示一个常量：

```
.text: Code 
.data: Initialized data
.bss: Uninitialized data
.rdata: Const/read-only (and initialized) data
.edata: Export descriptors
.idata: Import descriptors
.reloc: Relocation table (for code instructions with absolute addressing when the module could not be loaded at its preferred base address)
.rsrc: Resources (icon, bitmap, dialog, ...)
.tls: __declspec(thread) data (Fails with dynamically loaded DLLs -> hard to find bugs)
```

(请阅读参考文献2、3)

值得一提的是， ``` MOV DS,IDATA``` 为非法指令。（请阅读参考文献 4、5）

## 使用 DEBUG 追踪调试带有 LOOP 指令的程序

你可能会用到 [这里的源代码](../assets/code/bxloop.asm)

这里不作详细描述，在编写程序时，请注意一下几个问题：

- 汇编源代码中，数据不能以字母开头
- 运算结果不能出现进位丢失
- 提前确定好用于保存运算结果的寄存器

在这个自行完成的实验中，你可能会注意到：

-  ```LOOP S``` 在 ```DEBUG``` 中显示为 ```LOOP 0012（地址）```
-  使用```P``` 指令执行 ```INT 21H``` 中断
-  使用```G 0012``` 指令让程序自动执行前面的所有指令到```0012```处

## DEBUG 和 MASM 对指令的不同处理

源代码：

```x86asm
assume cs:code
code segment
   mov ax,2000h   ; directly input this to debug
   mov ds,ax      ; directly input this to debug
   mov al,[0]     ; directly input this to debug
   mov bl,[1]     ; directly input this to debug
   mov cl,[2]     ; directly input this to debug
   mov dl,[3]     ; directly input this to debug
   
   mov ax,4c00h
   int 21h
   
code ends
end
```

如果你将上诉标注了直接输入的代码输入到 ```DEBUG``` 中执行，你会看到： ```DEBUG``` 将其中的 ```[0][1][2][3]``` 直接解释为一个内存单元。使用 ```MASM``` 和 ```LINK``` 编译、连接之后得到 exe， 其中的  ```[0][1][2][3]``` 被解释为 ```idata``` 。

那么如何在源程序中实现将内存 2000:1、2000:2、2000:3、2000:4 单元的数据传入 AL、BL、CL、DL 中呢？

答案是借助 BX 寄存器：

```x86asm
mov ax,2000h
mov ds,ax
mov bx,偏移地址
mov al,[bx]    ; [ds:bx] 的数据送入 al
```

或者 ```mov al,ds:[0]``` 显式给出段基地址所在的寄存器。

## LOOP 和 [BX] 的联合应用

我们在本文的上半部分提到了运算时应当注意的一个问题：实现两个运算对象的类型匹配且结果不会超界。以我们目前的知识，解决方法只有选择一个 16 位寄存器暂存 8 位的初始数据并存储可能到达 16 位的运算结果，最终再写回目的存储器。

解决思路：

1. 初始化 DS=AX、Offset=BX
2. 初始化累加寄存器 DX，循环计数器 CX
3. 执行循环，将 **AL** 中的地址不断自增，实现连续运算、存储、跳转
4. 达到条件后使用 21 号中断退出程序。

## 段前缀

例如：```MOV AX,SS:[BX]``` 这样的访问内存单元的指令中，用于显式指明内存单元的段地址的 ```SS:``` 称为段前缀。

## 段前缀的使用

> 前情提要：
>
> 1. 一个段的寻址长度最大是 64 KB，相聚大于 64 KB 的目标单元需要多次设置 DS 寄存器。
> 2. 由 8086 地址转换规则知：  0:200 == 0020:0

应用举例：复制 ffff:0 ~ ffff:b 中的数据到 0:200 ~ 0:20b 中。

源代码：

```x86asm
assume cs:code

code segment

   mov ax,0ffffh   ; addr cannot start with letter,add 0&h
   mov ds,ax       ; remember the source addr
   mov ax,0020h
   mov es,ax       ; remember the target addr
   mov bx,0        ; addr offset
   
   mov cx,12       ; loop * 12
   
s: mov dl,[bx]     ; dl=ds<<4+bx
   mov es:[bx],dl  ; send data in dl to 0020:bx
   inc bx

   loop s
   
   mov ax,4c00h
   int 21h
   
code ends
end
```

## 寻找一段安全的空间执行你的指令

我们之前在说到栈顶超界问题时提到过这一问题，也就是你的代码和数据不应当覆盖任何存有系统关键信息和关键指令或者存有其他程序可能使用的信息的区域。

在我们实验的 DOS 环境下，由于 CPU 工作在实模式，没有能力对硬件系统进行全面、严格的管理。在现在操作系统中，CPU 工作在保护模式下，你是无法直接操作这类硬件资源的。

本书所使用的参考书籍建议我们使用 0:200~0:2FF 这段空间，因为一般情况下这段空间不会被其他使用。

## 请完成实验三

## Reference

[1] https://stackoverflow.com/questions/23500782/assembly-parenthesis-explanation 

[2] https://www.jianshu.com/p/46efa9b8b0a8

[3] https://stackoverflow.com/questions/19012300/whats-the-difference-between-rdata-and-idata-segments

[4] https://stackoverflow.com/questions/36641131/why-are-mov-ds-bx-and-mov-ds-2345h-valid

[5] https://stackoverflow.com/questions/5364270/concept-of-mov-ax-cs-and-mov-ds-ax

[6] （写的不是太好，建议不要看） https://chrislinn.github.io/2017/06/23/assembly-shuangw/
