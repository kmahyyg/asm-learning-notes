# 5.1 转移指令(1): 操作符 OFFSET

## 转移指令

转移指令：可以修改 CS （或/和） IP 的指令统称为转移指令，概括的说，转移指令就是可以控制 CPU 执行内存中某处代码的指令。

### 转移指令的分类

| 指令操作 | 名称 | 示例 |
|:-------:|:-----:|:-----:|
| 只修改 IP | 段内转移 | jmp ax |
| 同时修改 CS 和 IP | 段间转移 | jmp 1000:0 |

段内转移又分为：

|名称|修改IP的范围|
|:----:|:-----:|
| 短转移 | -128～127 |
| 近转移 | -32768～32767 |

转移指令分为以下几个大类：

 - 无条件转移（例如：jmp）
 - 条件转移
 - 循环（例如：loop）
 - 过程
 - 中断
 
## 操作符 OFFSET

`OFFSET` 的功能是取得标号的偏移地址，属于由编译器处理的一段符号。对于下面的一段代码：

```asm6502
assume cs:codesg
codesg segment
    start: mov ax,offset start
    s: mov ax, offset s
codesg ends
end start
```
实际上，第一条指令等价于 `mov ax,0` ，第二条指令等价于 `mov ax,3`。
第一条指令的机器码长度是三个字节。

## Quiz 1： 将 s 处每一条指令复制到 s0 处

```asm6502
assume cs:codesg
codesg segment
    s:  mov ax,bx
        mov si, offset s
        mov di, offset s0
        ;(TODO)
        ;(TODO)
   s0:  nop
        nop  ; the machine code of nop cost 1 byte
codesg ends
end s
```

小提示，明确下列几个问题：

1. s 和 s0 处所在的内存单元的地址是多少？ cs: offset s & cs: offset s0。
2. s 复制到 s0 处的实质是从什么到什么的数据传送？ cs: offset s 到 cs: offset s0。
3. 偏移地址是多少？分别对应存到哪一个寄存器中？ offset s -> si, offset s0 -> di。
4. 要复制的指令有多长？需要预先占位吗？ mov ax,bx 长度 2 字节，即 1 个字。 需要一个 占用 2 Bytes 的 Placeholder。

答案：

```asm6502
mov ax,cs:[si]
mov ax,cs:[di]
```

