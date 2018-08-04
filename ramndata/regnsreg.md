# 4.3 汇编语言中数据定位及位置表达

## 定义的描述性符号

普通的数据寄存器的集合包括： AX、BX、CX、DX、AH、AL、BH、BL、CH、CL、DH、DL、SP、BP、SI、DI。

段寄存器的集合包括： DS、SS、CS、ES。

## BX、SI、DI、BP 

 1. 这四个寄存器都可以在汇编语言中使用 `[]` 来进行内存单元的寻址。
 2. 这四个寄存器在 `[]` 中，只能以 `(idata) + bx + (si/di) ` 或者 `(idata) + bp + (si/di)` 形式进行寻址。
 3. `[bp]` 可以默认不显式给出段基地址，默认保存在 SS 中。

## 机器指令处理的数据

机器指令并不关心数据的值，也不关心汇编语言的表示，只关心需要执行的指令涵义和指令所需数据执行前的位置。

| 机器码 | 汇编语言 | 执行指令前的数据位置 |
| :---: | :-----: | :--------------: |
| 8E1E0000 | mov bx,[0] | RAM, ds:0 |
| 89C3 | mov bx,ax | Inside CPU, AX |
| BB0100 | mov bx,1 | Inside CPU, IR |

## 汇编语言中数据位置的表达

下列参数均可写入到汇编语句，用于表示数据位置：

 - 立即数 (idata)
 - 寄存器
 - 段地址和偏移地址 (段寄存器)
 
## 寻址方式小结

SA = 段基地址
EA = 偏移地址 （形式上的有效地址）

| 寻址方式 | 含义 | 名称 | 举例 |
| :-----: | :----: | :----: | :----:|
| [idata] | EA=idata,SA=(ds) | 直接寻址 | [idata] |
| [bx] | EA=(bx),SA=(ds) | 寄存器间接寻址 | [bx] |
| [si] | EA=(si),SA=(ds) | 寄存器间接寻址 | [si] |
| [di] | EA=(di),SA=(ds) | 寄存器间接寻址 | [di] |
| [bp] | EA=(bp),SA=(ss) | 寄存器间接寻址 | [bp] |
| [bx+idata] | EA=(bx)+idata,SA=(ds) | 寄存器相对寻址 | 结构体：[bx].idata |
| [si+idata] | EA=(si)+idata,SA=(ds) | 寄存器相对寻址 | 数组：idata[si],idata[di] |
| [di+idata] | EA=(di)+idata,SA=(ds) | 寄存器相对寻址 | 二维数组：[bx]\[idata\] |
| [bp+idata] | EA=(bp)+idata,SA=(ds) | 寄存器相对寻址 | / |
| [bx+si] | EA=(bx)+(si),SA=(ds) | 基址变址寻址 | / |
| [bx+di] | EA=(bx)+(di),SA=(ds) | 基址变址寻址 | / |
| [bp+si] | EA=(bp)+(si),SA=(ss) | 基址变址寻址 | 用于二维数组：[bx]\[si\] |
| [bp+di] | EA=(bp)+(di),SA=(ss) | 基址变址寻址 | / |
| [bx+si+idata] | EA=(bx)+(si)+idata,SA=(ds) | 相对基址变址寻址 | / |
| [bx+di+idata] | EA=(bx)+(di)+idata,SA=(ds) | 相对基址变址寻址 | 用于结构中的数组项： [bx].idata[si] |
| [bp+si+idata] | EA=(bp)+(si)+idata,SA=(ss) | 相对基址变址寻址 | 用于二维数组： idata[bx]\[si\] |
| [bp+di+idata] | EA=(bp)+(di)+idata,SA=(ss) | 相对基址变址寻址 | / |

