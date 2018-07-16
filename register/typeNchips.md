# 2.1 汇编基础：分类与适用

## 汇编语言

汇编语言（英语：assembly language）是一种用于电子计算机、微处理器、微控制器，或其他可编程器件的低级语言。在不同的设备中，汇编语言对应着不同的机器语言指令集。一种汇编语言专用于某种计算机系统结构，而不像许多高级语言，可以在不同系统平台之间移植。

使用汇编语言编写的源代码，然后通过相应的汇编程序将它们转换成可执行的机器代码。这一过程被称为汇编过程。

汇编语言使用助记符（Mnemonics）来代替和表示特定低级机器语言的操作。特定的汇编目标指令集可能会包括特定的操作数。许多汇编程序可以识别代表地址和常量的标签（Label）和符号（Symbols），这样就可以用字符来代表操作数而无需采取写死的方式。普遍地说，每一种特定的汇编语言和其特定的机器语言指令集是一一对应的。

许多汇编程序为程序开发、汇编控制、辅助调试提供了额外的支持机制。有的汇编语言编寫工具经常会提供巨集，它们也被称为宏汇编器。

## 汇编语言的分类

从汇编格式分，有 Intel 格式 ```add eax,[ebx]``` 和 AT&T 格式 ```addl (%ebx),%eax``` 的区别，前者由 Intel 提出，Windows 平台常见; 后者最早由贝尔实验室推出，用于 Unix 中，GNU 汇编器的缺省格式就是 AT&T 。不过 GNU 的编译器 ```gcc``` 和调试器 ```gdb``` 对这两种格式都支持，可以随意切换。```MASM``` 只支持Intel格式。Intel 格式和 AT&T 格式的区别只是符号系统的区别，这与 X86 和 ARM 的区别可不一样，后者是 CPU 体系的区别。

## 汇编语言使用到的编译器、链接器

常见的包括 ```MASM``` 和 GNU ASM （```GCC```），另外还有 。前者是微软的，只支持 x86，用在 DOS/Windows 平台中；后者是开源产品，主要用在Linux中，基本上支持大部分的CPU架构。这两者的区别在于伪指令的不同，伪指令是用来告诉编译器如何工作的，和编译器相关，和CPU无关。其实汇编的编译相当简单，这两套伪指令只是符号不相同，含义是大同小异，明白了一种，看另一种就很容易了。

### MASM [DEPRECATED]

闭源软件，在 Windows 7 及以下正常运作，目前在高版本系统中已被舍弃。

详情请参见此处：

- [English Wikipedia](https://en.wikipedia.org/wiki/Microsoft_Macro_Assembler)
- [Third-Party Archive](https://sourceforge.net/projects/masm611/)

### GCC (GNU ASM)

GCC 作为 *nix 平台上使用最广泛的开源编译器，早已广为人知。

详情请参见此处: 

- [English Wikipedia](https://en.wikipedia.org/wiki/GNU_Assembler)
- [GNU GCC Official Site](https://gcc.gnu.org/)

### NASM 

基于 BSD 开源授权，具有交叉编译能力，在过去被广泛使用。

详情请参见此处：

- [Official Site](https://www.nasm.us/)

