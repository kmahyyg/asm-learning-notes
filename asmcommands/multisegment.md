# 3.5 包含多个段的程序

## 前言

我们前面所编写的程序都只有一个代码段，那如果程序需要存储其他数据怎么办呢？很多同学会问。那就要使用一个没有被其他程序占用但又可被本程序安全占用的空间，我们前面提到的 0:200~0:2FF 就是相对安全的。但这段空间只有 256 个字节，超过 256 个字节怎么办呢？

在操作系统的环境中，程序合法地通过操作系统取得的任意长度的空间都是可以安全操作的。程序申请操作系统分配空间的办法有两种：1. 加载程序的时候为程序固定分配的空间，2. 在程序执行的过程中向操作系统动态申请分配空间。

本章我们将仅讨论第一种情况。

从程序编写的角度来说，我们便要定义多个不同类型的段（例如：数据段、栈段）来存放这些不同类型的数据，为了程序设计上的清晰和方便，我们一般也定义不同的段来存放他们。

针对这些程序，我们本章依照这样的顺序讨论以下两个问题：

1. 在一个段中存放数据、代码、栈。
2. 将代码、数据、栈放入不同段中。

## 在代码段中使用数据

有请 “dw” 关键字出场。

> "dw", which means "double words" instead of  "define word", defined a word with double space. It means that, if a single word is considered 8-byte long, it means the size of the target operand is 16 bits.

示例：

```x86asm
assume cs:code
code segment
   dw 0123h,0456h,0789h,0abch
   mov bx,0
   mov ax,0
   
   mov cx,8
s: add ax,cs:[bx]
   add bx,2
   loop s
   
   mov ax,4c00h
   int 21h
   
code ends
end
```



## Reference

[1] http://www.cs.virginia.edu/~evans/cs216/guides/x86.html