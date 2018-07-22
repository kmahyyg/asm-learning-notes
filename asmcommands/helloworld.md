# 第一个程序

## 一个程序从写出代码到执行

1. 编写源代码
2. 对源代码进行编译，产生 OBJ 目标文件，编译后连接目标文件
3. 产生可执行文件并执行

可执行文件包括两个部分：程序（机器码）、数据、Metadata（程序的相关信息）

## 源代码说明

```assembly
assume cs:codesg    ;假设代码段 codesg 与寄存器 CS 关联

codesg segment      ;定义一个段，段标号 codesg，编译过程中指定一个段地址
		mov ax,0123h
		mov bx,0456h
		add ax,bx
		add ax,ax
		
		mov ax,4c00h   ;中断信号
		int 21h        ;发送 21 号返回中断
		
codesg ends         ;段定义结束

end                 ;汇编程序结束
```

## 实际操作过程
