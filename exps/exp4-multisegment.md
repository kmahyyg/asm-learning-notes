# 实验四：编写、调试具有多个段的程序

## 写在实验之前

部分实验代码涉及下列定义性描述，请阅读后继续实验。

| Directive | Purpose | Storage Space |
| :-------: | :------: | :----------: |
| DB | Define Byte | Allocates 1 Byte |
| DW | Define Word | Allocates 2 Bytes |
| DD | Define DoubleWord | Allocates 4 Bytes |
| DQ | Define QuadWord | Allocates 8 Bytes |
| DT | Define Ten Bytes | Allocates 10 Bytes |

## 实验目的

了解程序中有多个段的情况及其源代码写法。

## 实验题目 1：分析

根据 [3.5 包含多个段的程序](../asmcommands/multisegment.md) 学习的内容，使用 ```MASM``` 编译、连接下列每个源代码之后，用 ```DEBUGX``` 追踪运行，回答下列问题：

1. CPU 执行程序，程序返回前， data 段中的数据为多少？
2. CPU 执行程序，程序返回前，```R``` 指令读取到的各寄存器中的值为？
3. 设程序加载之后， ```code``` 段的地址为 X，请问 data 段和 stack 段的地址为？
4. 对于程序中定义的各个段，若段中的数据占 N 个字节，请问程序加载之后，该段实际占用的空间为？
5. 如果 ``` end start ``` 变成 ``` end``` ，实际执行从哪个地址开始执行？

[源代码 1](/assets/code/exp4-01.asm)     [源代码 2](/assets/code/exp4-03.asm)     [源代码 3](/assets/code/exp4-03.asm)

## 实验题目 2： 编程

1. 补全 ```code``` 段中的代码，将 a、b 段中的数据一次相加，将结果保存在 c 段中。 [源代码 4](/assets/code/exp4-04.asm)
2. 补全 ```code``` 段中的代码，用 ```push``` 将 a 段中前 8 个字型数据逆序存储在 b 段中。 [源代码 5](/assets/code/exp4-05.asm)

## 我的实验解决方案

问答题请自行调试解决。

编程题：（仅供参考） [源代码 4](/assets/code/exp4-04f.asm)   [源代码 5](/assets/code/exp4-05f.asm)

## 实验反思

> Q4. 对于程序中定义的各个段，若段中的数据占 N 个字节，请问程序加载之后，该段实际占用的空间为？
>
> 这个问题我们在之前提到过，每个段最大长度为 64 KiB，与 16 的倍数对齐。
>
> 我们分两类情况来讨论：
>
> 1.  N % 16 == 0，那么占用大小就是 (N / 16) \* 16
> 2.  N % 16 != 0，那么占用大小就是 (N ```floor``` 16 + 1) \* 16
>
> 总结起来就是 ((N+15)/16) * 16 。


- 通过上述实验题目，请你对汇编语言中的现已学过的指令进行总结，并在评论区提出你的想法与大家交流探讨。

## Reference

[1] http://www.cnblogs.com/tsembrace/        发现的一个不错的博客，推荐一下
