# 4.2 更加灵活的内存单元定位方法

## [BX+IDATA]

这里我们介绍一种新的更为灵活的方式来指明内存单元 `[bx+idata]` ，它的偏移地址为 `(bx中的数值)+idata` 。其中 `idata` 可以直接用数值指定。

## [BX+IDATA] 进行数组处理

废话不多说。直接上代码。

我们首先定义一个数据段：

```asm6502
assmue cs:codesg,ds:datasg

datasg segment

    db 'BaSiC'
    db 'MinIX'
    
datasg ends

codesg segment:

    start: ;TODO
           ;TODO
           
codesg ends

end start
```

我们之前使用的定位字符串中字符的办法，是使用 `AND` `OR` 指令。现在开始，我们可以使用这样的一种新方法实现定位。

我们知道这样定义的数据段，数据保存在 DS 寄存器的前几个单元，我们又知道字符串的长度是 5, 所以使用 `[0+BX]` 和 `[5+BX]` 的形式来提供字符串中的字符。不言而喻，在这里， BX仅提供了偏移地址。

`0[BX]` 和 `5[BX]` 同样也和上述描述等价。如果你熟悉 C 语言，你会发现，其实和 C 语言中数组操作基本在写法上一致。

`[BX+IDATA]` 的方式为高级语言实现数组提供了便利机制。

## SI 和 DI

SI 源变址寄存器，DI 目的变址寄存器，SI 和 DI 不能分成两个 8 位的寄存器来使用。在串处理指令中，SI 一般用作隐含的源串地址，默认在 DS 中；DI 用做隐含的目的串地址，默认在 ES 中，二者都与 BX 寄存器的功能有关。

### 尝试复制字符串




## Reference

[1] https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture
