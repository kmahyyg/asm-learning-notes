# 3.7 MUL 乘法指令

## Before we start

请复习 [寻址方式小结](https://asm.kmahyyg.xyz/ramndata/regnsreg.html#%E6%B1%87%E7%BC%96%E8%AF%AD%E8%A8%80%E4%B8%AD%E6%95%B0%E6%8D%AE%E4%BD%8D%E7%BD%AE%E7%9A%84%E8%A1%A8%E8%BE%BE)

## 格式

```asm6502
mul REG 
mul RAM 
```

RAM 作为内存单元，可以用不同的方式给出，请查看上述寻址方式小结，这里不作赘述。
可以是： `byte ptr ds:[0]` 或者 `word ptr [bx+si+8]`。

## 注意事项

### 乘数的长度要求 & 结果的存储

乘数必须同为 8 位或同为 16 位。

| 乘数 | 存放位置 | 结果 |
|:----:|:------:|:-----:|
| 8 Bits | AL + 8 Bits (REG/RAM) | AX |
| 16 Bits | AX + 16 Bits (REG/RAM) | DX + AX |

## 示例代码

(1) 8 Bits

```asm6502
mov al,100
mov bl,10
mul bl
```

Answer = (AX) = 100 * 10 = 1000 (03E8H)

(2) 16 Bits

```asm6502
mov ax,100
mov bx,10000
mul bx
```

Answer = 100 * 10000 = 1000000 

(AX) = 4240H (DX) = 000FH

(F4240H) = (1000000)
