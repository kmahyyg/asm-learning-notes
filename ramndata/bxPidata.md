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

    start:  ;TODO
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

首先，定义数据段：

```asm6502
assume cs:codesg,ds:datasg

datasg segment
    db 'welcome to asm!'
    db '...............'    ; 15-byte long data
datasg ends
```

接下来，我们尝试使用 SI、DI 两个寄存器来对两个字符串的位置进行复制后替换。

```asm6502
codesg segment
    start:  mov ax,datasg
            mov ds,ax
            mov si,0     ; source addr offset
            mov di,15    ; dest addr offset
            
            mov cx,8     ; loop times 8
            
        s:  mov ax,[si]  ; ds:si point at source str
            mov [di],ax  ; ds:di point at dest str
            ; finish copy process
            add si,2
            add di,2     ; exchange 2 bytes once
            
            loop s
            
            mov ax,4c00h
            int 21h
codesg ends

end start
```

#### 进一步优化复制过程

我们可以跳过 DI 寄存器，只是用 SI 寄存器指明初始地址，之后使用 `[BX(/SI/DI) + IDATA]` 的方式，来使程序更加简洁。

批注（以下仅为个人意见）： 个人十分反对下列直接 hard-code 字符串长度的代码，为了程序的后续优化，不建议大家这样编写程序。此处展示的示例只为了尽可能减少代码长度。

```asm6502
codesg segment
    start:  mov ax,datasg
            mov ds,ax
            mov si,0  ; set the source addr offset
            
            mov cx,8  ; set loop times
            
        s:  mov ax,0[si]   ; copy source
            mov 16[si],ax  ; paste at dest
            add si,2
            
            loop s
            
            mov ax,4c00h
            int 21h
            
codesg segment

end start
```

## 其他的利用 BX、SI、DI、IDATA 实现的更加灵活的定位方法



## Reference

[1] https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture
