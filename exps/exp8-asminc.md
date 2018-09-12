# 实验八：VS 内联汇编

## 实验要求

分析下列汇编语句，并在 VS 中使用 C 语言内联汇编编译调试执行。

## 实验代码

### Quiz 1

```c
#include  <stdio.h>
int  main(  )
{
    unsigned  char  flag1, flag2, flag3;
     //嵌入汇编
    _asm  {
        .. .. ..
    }
    printf("flag1=%02XH\n", flag1);
    printf("flag2=%02XH\n", flag2);
    printf("flag3=%02XH\n", flag3);
    return  0;
}
```

```asm6502
_asm  {
        MOV   AH, 0
        SAHF               //SF=0，ZF=0，PF=0，AF=0，CF=0
        LAHF               //把标志寄存器低8位(02H)又回送到AH
        MOV   flag1, AH    //把AH的值保存到变量flag1
        ;
        MOV   DX, 7799H    //DX=7799H
        ADD   DL, DH       //DX=7710H，AF=1，CF=1
        LAHF               //把标志寄存器低8位(13H)送到AH寄存器
        MOV   flag2, AH    //把AH的值保存到变量flag2
        ;
        SUB   DH, 84H      //DH=F310H，SF=1，CF=1
        CLC                //CF=0
        LAHF               //把标志寄存器低8位(86H)送到AH
        MOV   flag3, AH    //把AH的值保存到变量flag3
    }
```

### Quiz 2

```c
#include  <stdio.h>
int  main( )
{
    unsigned  char vch1=188,vch2=172,vch3=233;
    unsigned  int   sum=0;
    //嵌入汇编
    _asm  {
     .. .. ..
    }
    printf("sum=%u\n", sum);
    return  0;
}
```

```asm6502
_asm  {
    SUB   EDX, EDX          //使EDX为0，用DX存放累加和
    ADD   DL, vch1          //加第1个字节
    ADC   DH, 0             //高8位相加（保持形式一致）
    ADD   DL, vch2          //加第2个字节
    ADC   DH, 0             //高8位相加（考虑可能出现的进位）
    ADD   DL, vch3          //加第3个字节
    ADC   DH, 0             //高8位相加（考虑可能出现的进位）
    MOV   sum, EDX          //把结果送到变量sum
    }
```

## 实验结果及反思

你分析的结果与代码注释一致吗？分析过程对你有什么启发？ 欢迎在评论区分享。