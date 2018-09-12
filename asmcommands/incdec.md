# 3.8 自增、自减与比较指令

## INC 自增 1 & DEC 自减 1

指令格式： `inc/dec dest`

功能： 对目的操作数 `dest` +- 1

注意：

 - `INC WORD PTR [BX]`
 - 常用于修改循环程序中的循环次数

## NEG 求相反数

指令格式： `neg dest`

指令实现： `dest = 0 - dest`

**指令注意事项**：

 - `dest` 为内存操作数，使用 `ptr` 说明操作数类型为 `byte / word / dword`
 - 指令执行时影响标志位：`OF PF SF ZF AF`
 - `neg` 指令的目的操作数应当理解为 **补码表示的带符号操作数**

## CMP 比较

比较方法：半减作差

指令格式：`cmp dest,src`

指令原理： 比较 src 和 dest 大小，使用作差法并设置条件标志位

指令执行结果：

- 如果 `zf=1`，则 `dest=src`
- 如果 `of=0 && sf=0`，则 `dest>=src`
- 如果 `of=0 && sf=1`，则 `dest<src`

Quiz Time：如何判断 dest 是一个正数还是一个负数？

## CMPXCHG 比较并交换指令

指令使用范围限制： 486+ CPU

指令格式： `cmpxchg dest,src`

指令原理：比较是否相等，借用中转寄存器进行交换。

指令注意：**dest 可以为寄存器或内存操作数，src 只能是寄存器操作数**

指令原理： 

- 累加器 (AC/AL/AX/EAX 寄存器) 与 DEST 比较
- AC = DEST : ZF<-1 , DEST<-SRC
- AC != DEST : ZF<-0, AC<-DEST

## CMPXCHG8B 比较并交换 8 字节指令

指令格式： `cmpxchg8b dest`

指令使用范围： 486+ CPU

指令注意：**len(dest) = 64 bits in RAM**

指令功能：

1. 比较 64 位隐含操作数(EDX,EAX) 与 DEST 比较
2. (EDX,EAX) = DEST : ZF <- 1, DEST <- (EDX,EAX)
3. (EDX,EAC) != DEST : ZF <- 0, (EDX,EAX) <- (DEST)

