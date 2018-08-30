# 5.6 CALL 与 RET 的结合使用

## 分析示例程序

```asm6502
assume cs:code
code segment
        start:  mov ax,1
                    mov cx,3
                    call s
                    mov bx,ax
                    mov ax,4c00h
                    int 21h
                s: add ax,ax
                    loop s
                    ret
code ends
end start
```

### 执行过程

- CPU 将 `call s` 指令的机器码读入，IP 指向 `mov bx,ax` ，接下来 执行 call 指令，将当前 IP 的值压入栈中，改变 IP 使跳转到 S 标号处。
- 从 S 处开始执行命令，循环三次，1+1=2, 2+2=4, 4+4=8，最终结果为 8。
- 将 ret 处指令读入，IP 指向 ret 之后的内存单元，将之前保存的值出栈，送入 IP 中，继续执行。
- 将 AX 最终的值 8 传入 BX，退出。

## 实现一个子程序的示例

### TODO