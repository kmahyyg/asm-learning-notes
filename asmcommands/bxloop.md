# 3.4  [BX] 和 LOOP 指令 - 基础

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

## Reference

[1] https://stackoverflow.com/questions/23500782/assembly-parenthesis-explanation 

[2] https://www.jianshu.com/p/46efa9b8b0a8

[3] https://stackoverflow.com/questions/19012300/whats-the-difference-between-rdata-and-idata-segments

[4] https://stackoverflow.com/questions/36641131/why-are-mov-ds-bx-and-mov-ds-2345h-valid

[5] https://stackoverflow.com/questions/5364270/concept-of-mov-ax-cs-and-mov-ds-ax