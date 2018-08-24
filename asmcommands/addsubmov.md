# 3.1 MOV、ADD、SUB 指令

## MOV 指令

8086 CPU 共有十六根数据线，一次可以传送 16 位 的数据，可以一次传送一个字，我们只需要使用 MOV 指令 给出 16 位的寄存器，就能进行 16 位数据的传送了。

### 体验一

要求：将下列代码写入内存并保存执行

| Code | Explanation |
| :--: | :---------: |
| MOV AX,1000H | \ |
| MOV DS, AX | 将 DS 设为 1000H |
| MOV AX, [0] | 将 1000:0 处数据送入 AX，1000:1 存储高八位字送入 AH， 1000:0 存储低八位字送入 AL |
| MOV BX, [2] | 同上 |
| MOV CX, [1] | \ |
| MOV BX, [1] | \ |
| MOV CX, [2] | \ |

### MOV 指令的几种形式 （传送指令）

* MOV 寄存器，数据
* MOV 寄存器，寄存器
* MOV 寄存器，内存单元
* MOV 内存单元，寄存器
* MOV 段寄存器，寄存器
* MOV 寄存器，段寄存器
* MOV 内存单元， 段寄存器
* MOV 段寄存器，内存单元

## ADD、SUB 指令

### ADD、SUB指令的几种形式

- ADD 寄存器，数据
- ADD 寄存器，寄存器
- ADD 寄存器，内存单元
- ADD 内存单元，寄存器
- SUB 寄存器，数据
- SUB 寄存器，寄存器
- SUB 寄存器，内存单元
- SUB 内存单元，寄存器

### ADD、SUB指令无法对段寄存器进行操作

我们查阅到的资料大多显示是这是 CPU 工作在保护模式下的原因，也就是说这在很大程度上是为了保护系统安全，同时也与 Intel 对硬件架构的设计有关，这里，我们无法搞清楚这一问题与 CPU 在实模式下对于这个问题的应用机制，欢迎有想法的同学给我们查阅参考文献 [2] 之后给我们提交 PR。

## Reference

[1] https://stackoverflow.com/questions/125532/why-cant-i-change-the-value-of-a-segment-register-masm  根据 Intel IA-32 硬件架构工程师指导手册，ADD指令在某些特殊情况下可以对段寄存器进行操作。

[2] https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-manual-325462.html Intel® 64 and IA-32 Architectures Developer's Manual

[3] https://stackoverflow.com/questions/125532/why-cant-i-change-the-value-of-a-segment-register-masm