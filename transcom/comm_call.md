# 5.5 CALL 指令

## 指令规定

CALL 指令执行两步操作：

- 将当前的 CS 和 IP 压入栈中。
- 转移

指令格式： `call 转移目的地`

call 指令不能进行短转移，其余同 jmp 指令的原理相同。接下来，我们讲解 call 指令的主要应用格式。

## 依据位移进行转移

格式： `call 标号`

这类指令等价于：

```asm6502
push IP
jmp near ptr 标号
```

执行的操作是：

- (SP) = (SP) - 2
- ((SS) * 16 + (SP)) = (IP)
- (IP) = (IP) + 16 Bits 位移

### 16 Bits 位移的计算

位移 = 标号地址 - call 指令后第一字节的地址。

范围: -32768 ~ 32767，补码表示。

计算：在编译器编译时算出。

## 转移目的地址在指令中

格式： `call far ptr 标号` 实现段间转移

这类指令等价于：

```asm6502
push CS
push IP
jmp near ptr 标号
```

执行的操作是：

- (SP) = (SP) - 2
- ((SS) * 16 + (SP)) = (CS)
- (SP) = (SP) - 2
- ((SS) * 16 + (SP)) = (IP)
- (CS) = 标号所在段的段地址
- (IP) = 标号在段中的偏移地址

## 转移地址在寄存器中

格式： `call REG` 

REG 为 16 位寄存器的编号

这类指令等价于：

```asm6502
push IP
jmp REG
```

执行的操作是：

- (SP) = (SP) - 2
- ((SS) * 16 + (SP)) = (IP)
- (IP) = (16 Bits 寄存器)

## 转移地址在内存中

### call word ptr RAM

格式即标题。

这类指令等价于：

```asm6502
push IP
jmp word ptr RAM
```

执行的操作是：

- 修改 IP 为对应的 RAM 单元中的内容
- (SP) = (SP) - 2

### call dword ptr RAM

格式即标题。

这类指令等价于：

```asm6502
push CS
push IP
jmp dword ptr RAM
```

执行的操作是：

- 修改 CS 和 IP 为对应的 RAM 单元中的 dword 的内容，其中 CS 对应为 dword 的高位地址的内容，IP 对应为 dword 的低位地址的内容
- (SP) = (SP) - 4
