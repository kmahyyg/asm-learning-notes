# 参考教材 附注 5： 除法溢出避免公式证明

## Preview

由于下面的分析涉及到 Matlab 的相关函数，请先阅读下列参考文献：

- [1. mod() 和 rem() 的区别](https://www.kmahyyg.xyz/2018/Matlab-remVSmod/index.html)
- [2. fix() 和 floor() 的区别](https://www.kmahyyg.xyz/2018/Matlab-fixVSfloor/)

## Question

Calculate `X/n` `(X < 2^32, n != 0)`

Please ensure that your calculation will not occur any overflow.

## Analysis

### 此处以 8086 系列处理器为例，不出现溢出，说明计算过程中除法运算的商要小于 2^16 (65536)。

  作出下列假设：

  - `X/n = (H*65536+L)/n = (H/n)*65536 + (L/n)`
  - `H = int(x/65536)`
  - `L = rem(x/65536)`
  
  Cuz `H < 65536 & L < 65536`, So 上述转化成立
  
### 将计算 `X/n` 分解为计算 `(H/n)*65536 + (L/n)` 之后

汇编语言中使用 `DIV` 指令计算除法，并得出商和余数，我们保留商，余数丢弃，且余数必然小于除数。

无论如何， `H/n = int(x/65536) / n` 的余数是绝对不能丢的，因为一旦丢弃，就等价于丢弃了 `余数 × 65536`.

那么如何处理余数？

`H = int(H/n)* n + rem(H/n)`

所以：

```
(H/n) * 65536 + (L/n)
= [int(H/n) * n + rem(H/n)] / n * 65536 + (L/n)
= int(H/n) * 65536 + rem(H/n) * 65536 / n + L / n
= int(H/n) * 65536 + [rem(H/n) * 65536 + L] / n
```

### 进一步转化

我们现在将起始的 `X / n` 问题转化成了 `int(H/n) * 65536 + [rem(H/n) * 65536 + L] / n` 的问题。

这里需要进行两次运算：

 1. `H/n`
 2. `[rem(H/n) * 65536 + L] / n`
 
因为： `H = int(x/65536)` 所以第一次运算不会产生除法溢出。

对第二次运算进行证明:

```
 - L <= 65535
 - rem(H/n) <= n-1
 - rem(H/n) * 65536 <= (n-1) * 65536
 - rem(H/n) * 65536 + L <= (n-1) * 65536 + 65535
 - [rem(H/n) * 65536 + L] / n <= [(n-1) * 65536 + 65535] / n
 - [rem(H/n) * 65536 + L] / n <= 65536 - (1/n)
```
 
证毕。
