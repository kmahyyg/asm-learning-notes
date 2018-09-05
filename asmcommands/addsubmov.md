# 3.1 MOV、ADD、SUB 指令

## MOV 指令

8086 CPU 共有十六根数据线，一次可以传送 16 位 的数据，可以一次传送一个字，我们只需要使用 MOV 指令 给出 16 位的寄存器，就能进行 16 位数据的传送了。

`mov dest,src`，要求操作数位数相同，无法确定传送位数，则使用 `ptr` 说明。

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

#### MOV 指令的几种形式 （传送指令）

* MOV 寄存器，数据
* MOV 寄存器，寄存器
* MOV 寄存器，内存单元
* MOV 内存单元，寄存器
* MOV 段寄存器，寄存器
* MOV 寄存器，段寄存器
* MOV 内存单元， 段寄存器
* MOV 段寄存器，内存单元

### MOVZX/MOVSX 数据扩展传送

`movzx/movsx dest,src` 对 SRC 进行 Z/S 拓展之后赋值给目的操作数，IA-32+ Only.

SRC 为 8 / 16 Bits，DESC 为 16 / 32 Bits.

#### S 拓展 (Signed int)

操作数高位补符号位做 Signal 拓展。

0x1a2b -> 0x00001a2b ：16 位拓展为 32 位
0xa1b2 -> 0xffffa1b2 : 16 位拓展为 32 位

#### Z 拓展 (Unsigned int)

操作数高位补 0做 Zero 拓展。

0x1a2b -> 0x00001a2b ：16 位拓展为 32 位

## ADD、SUB 指令

`ADD/SUB 寄存器，数据` 意义： 对 寄存器 中 原有数据 和 指令中的数据 进行 相应操作之后将结果回写到寄存器中，均为 半操作 (Half-add / Half-sub)。

### ADD、SUB 命令可能存在的理解错误问题

1. 将 `ADD/SUB` 的运算数据理解为无符号二进制整数，将运算后 CF 标志位取值作为运算结果最高位的取值，结果正确。
2. 将 `ADD/SUB` 的运算数据理解为带符号二进制整数，则运算后 OF 标志位 == 0，结果正确； OF 标志位 == 1，结果不正确；

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

### ADD/SUB 的变种：ADC/SBB

`adc dest,src` 做全加运算， **两个操作数不能同时为内存操作数，dest 不能为 idata!**

被加数 `dest`，加数 `src`, 等价于 `dest = dest + src + cf (进位标志)`.

`sbb dest,src` 做全减运算， **两个操作数不能同时为内存操作数，dest 不能为 idata!**

被减数 `dest`，减数 `src`, 等价于 `dest = dest - src - cf (进位标志)`.

其余同上。

## 数据交换指令 XCHG

`xchg dest,src` SRC 与 DESC 互换，且只能在寄存器与内存操作数或者寄存器与寄存器之间进行， **不能直接交换两个内存或者段寄存器！**

## 相加并交换指令 XADD

`xadd dest,src` 被加数 `dest` 与 加数 `src` 交换之后做半加运算，`dest=dest+src`。

**两个操作数不能同时为内存操作数，dest 不能为 idata!**

## 

## Reference

[1] https://stackoverflow.com/questions/125532/why-cant-i-change-the-value-of-a-segment-register-masm  根据 Intel IA-32 硬件架构工程师指导手册，ADD指令在某些特殊情况下可以对段寄存器进行操作。

[2] https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-manual-325462.html Intel® 64 and IA-32 Architectures Developer's Manual

[3] https://stackoverflow.com/questions/125532/why-cant-i-change-the-value-of-a-segment-register-masm
