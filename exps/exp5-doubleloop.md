# 实验五：二重循环

## 实验目的

学会灵活运用 BX、IDATA、SI、DI 灵活的定位内存单元。

## 实验题目

> 参考教材 7.10 小节的内容

### 基础要求

补全代码段，使用程序将下列数据段中的单词的某些字母大写。

```asm6502
assume cs:codesg,ds:datasg

datasg segment

    db  'the words or sentences you love here'
        
datasg ends

codesg segment

    start:  ;todo

codesg ends

end start
```

**本质：二维数组的字符串操作**

### 第一次尝试：首字母大写

我们先来尝试一下使用循环方式变更单词的首字母。

```asm6502
assume cs:codesg,ds:datasg

datasg segment

     db '1. file        '
     db '2. edit        '
     db '3. test        '
     
datasg ends

codesg segment

    start:  mov ax,datasg
            mov ds,ax
            mov bx,0
            
            mov cx,6
            
        s:  mov al,[bx+3]        ; index==3,column==4,find char
            and al,11011111b     ; upper char
            mov [bx+3],al        ; result write back
            add bx,16
            loop s
            
codesg ends

end start
```

### 第二次尝试：所有字母大写 （二重循环）

#### 实验数据

```asm6502
assume cs:codesg,ds:datasg

datasg segment

    db 'ibm     '
    db 'dec     '
    db 'dos     '
    db 'vax     '
    db 'las     '
    
datasg ends

codesg segment

    start:  ;TODO
            
codesg ends

end start
```

#### 实验题目分析

两次循环实现定义的数据段中所有字母均大写的转换。第一次循环，要循环一个字符串内的所有字符；第二次循环，要依次循环所有的字符串。
但是， **`loop` 指令用于保存循环次数的寄存器只有 CX 一个** ，如何保证两次循环中 CX 的值与循环对应？

#### 解决方案一：使用 DX 寄存器暂时存储 CX 中的数据

```asm6502
assume cs:codesg,ds:datasg

datasg segment

    db 'ibm     '
    db 'dec     '
    db 'dos     '
    db 'vax     '
    db 'las     '
    
datasg ends

codesg segment

    start:  mov ax,datasg
            mov ds,ax
            mov bx,0
            
            mov cx,5
            
       s0:  mov dx,cx   ; outside loop cx value saved in dx
            mov si,0    ; source index reset to 0
            mov cx,3    ; inside loop cx set to 3
            
        s:  mov al,[bx+si]    ; offset= word offset + char offset
            and al,11011111b  ; upper case
            mov [bx+si],al    ; result write back
            inc si
            loop s
            
            add bx,8     ; offset 1 word
            mov cx,dx    ; restore the saved situation
            
            loop s0
            
            mov ax,4c00h
            int 21h
            
codesg ends

end start
```

#### 解决方案二： 使用一段内存空间暂存 CX 中的数据

```asm6502
assume cs:codesg,ds:datasg

datasg segment

    db 'ibm     '
    db 'dec     '
    db 'dos     '
    db 'vax     '
    db 'las     '
    
datasg ends

codesg segment

    start:  mov ax,datasg
            mov ds,ax
            mov bx,0
            
            mov cx,5
            
       s0:  mov ds:[40H],cx
            mov si,0
            mov cx,3
            
        s:  mov al,[bx+si]
            and al,11011111b
            mov [bx+si],al
            
            inc si
            loop s
            
            add bx,8
            mov cx,ds:[40H]
            
            loop s0
            
            mov ax,4c00h
            int 21h
            
codesg ends

end start
```

#### 解决方案三： 使用堆栈

```asm6502
assume cs:codesg,ds:datasg,ss:stacksg

stacksg segment
    dw 0,0,0,0,0,0,0,0     ; stack length 16bytes
stacksg ends

datasg segment

    db 'ibm     '
    db 'dec     '
    db 'dos     '
    db 'vax     '
    db 'las     '
    
datasg ends

codesg segment

    start:  mov ax,stacksg
            mov ss,ax
            mov sp,16
            
            mov ax,datasg
            mov ds,ax
            mov bx,0
            
            mov cx,5
            
       s0:  push cx
            mov si,0
            mov cx,3
            
        s:  mov al,[bx+si]
            and al,11011111b
            mov [bx+si],al
            
            inc si
            loop s
            
            add bx,8
            pop cx
            loop s0
            
            mov ax,4c00h
            int 21h
            
codesg ends

end start
```

## 实验反思

通过这次实验，你学习到了什么？在实验过程中有哪些可能存在疑问的地方？欢迎你在下方留言区与我们讨论。
