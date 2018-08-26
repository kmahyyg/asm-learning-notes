# 参考教材 附注 3： MASM 编译器对 JMP 的相关处理

## 向前转移

编译器中有一个地址寄存器 (AC)，编译器在编译过程中，每读到一个字节，AC 就自增 1. 当编译器遇到一些伪操作时，也会根据具体情况使 AC 增加。

向前转移时，编译器可以在读到标号 s 后记下 AC 的值 as，在读到 `jmp .... s` 后记下 AC 的值 aj，编译器使用 as - aj 算出位移量 disp.

`jmp short s` 对应的机器码 `EB disp` 中 disp 用 Hex 表示，共计 1 个字节。
`jmp near ptr s` 对应的机器码 `E9 disp` 中 disp 用 Hex 表示，共计 2 个字节。
`jmp far ptr s` 对应的机器码 `EA OFFSET STACK_BASE` ， 偏移地址 2 个字节，段地址 2 个字节，共计 4 个字节。

|按disp分类|按指令格式分类|处理措施|
|:-------:|:---------:|:------:|
| -128~127 | jmp s | 转换为 `EB disp` |
| -128~127 | jmp short s | 转换为 `EB disp` |
| -128~127 | jmp near ptr s | 转换为 `EB disp` |
| -128~127 | jmp far ptr s | 转换为 `EB disp` |
| -32768~32767 | jmp short s | 编译错误 |
| -32768~32767 | jmp s | 转换为 `E9 disp` |
| -32768~32767 | jmp near ptr s | 转换为 `E9 disp` |
| -32768~32767 | jmp far ptr s | 转换为 `EA OFFSET STACK_BASE` |

## 向后转移

编译器先读到 `jmp ...... s` 指令，由于此时尚未读到标号 s，所以编译器此时还不能确定标号 s 处 AC 值，也就是说，编译器不能确定位移量 disp 的大小。
此时编译器将 `jmp ...... s` 指令全部当作 `jmp short s` 来读取，记下 `jmp ...... s` 指令的位置和 AC 的值 aj. 并进行如下处理：

 - jmp short s
 
 生成`EB 90` (`jmp short s + nop`) ，预留 1 字节，存放 8 位 disp.
 
 - jmp s & jmp near ptr s
 
 生成`EB 90 90` (`jmp short s + nop + nop `) ，预留 2 字节，存放 16 位 disp.
 
 - jmp far ptr s
 
 生成`EB 90 90 90 90` (`jmp short s + nop + nop + nop + nop`) ，预留 4 字节，存放 32 位 disp，此时 disp 是 段地址和偏移地址.
 
接下来编译器继续工作，当向后读到标号 s 时，记下 AC 的值 as, 并计算出转移的位移量 disp = as - aj.

|按disp分类|按指令格式分类|处理措施|
|:-------:|:---------:|:------:|
| -128~127 | jmp s | 在之前预留的位置填上 `EB disp` |
| -128~127 | jmp short s | 在之前预留的位置填上 `EB disp` |
| -128~127 | jmp near ptr s | 在之前预留的位置填上 `EB disp` |
| -128~127 | jmp far ptr s | 在之前预留的位置填上 `EB disp` |
| -32768~32767 | jmp short s | 编译错误 |
| -32768~32767 | jmp s | 在之前预留的位置填上 `E9 disp` |
| -32768~32767 | jmp near ptr s | 在之前预留的位置填上 `E9 disp` |
| -32768~32767 | jmp far ptr s | 在之前预留的位置填上 `EA OFFSET STACK_BASE` |

