# Summary

* [Introduction](README.md)

* [Chapter 1 - 环境搭建](envbuild/README.md)
  - [1.1 虚拟机搭建与安装](envbuild/vmsetup.md)
  - [1.2 安装编译器、调试器和连接器](envbuild/mountandinstall.md) 

* [Chapter 2 - 汇编基础：寄存器与内存](register/README.md)
  - [2.1 汇编基础：分类与适用](register/typeNchips.md)
  - [2.2 汇编基础：CPU 寻址](register/findaddr.md)
  - [2.3 汇编基础：段与段寄存器](register/segment.md)
  - [2.4 汇编基础：DS 寄存器与内存中的字](register/wordNds.md)

* [Chapter 3 - 汇编语言常见指令](asmcommands/README.md)
  - [3.1 MOV、ADD、SUB 指令](asmcommands/addsubmov.md)
  - [3.2 栈机制 与 PUSH、POP 指令](asmcommands/pushpop.md)
  - [3.3 第一个程序](asmcommands/helloworld.md)
  - [3.4 \[BX\] 和 LOOP 指令](asmcommands/bxloop.md)]
  - [3.5 包含多个段的程序](asmcommands/multisegment.md)
  - [3.6 DIV DD DUP 指令](asmcommands/divdddup.md)

* [Chapter 4 - 内存地址定位与数据处理](ramndata/README.md)
  - [4.1 AND OR 与 字符串](ramndata/andorstr.md)
  - [4.2 更加灵活的内存单元定位方法](ramndata/bxPidata.md)
  - [4.3 数据定位及位置表达](ramndata/regnsreg.md)
  - [4.4 数据处理数据的长度及综合应用](ramndata/lengthodata.md)

* [All Experiments](exps/README.md)
  - [实验一：DOS 中 ```DEBUG``` 的基本使用](exps/exp1-dosdbg.md)
  - [实验二：编程、编译、链接、跟踪 :star:](exps/exp2-firsttry.md)
  - [实验三：\[BX\] 和 LOOP 指令的使用](exps/exp3-bxloop.md)
  - [实验四：编写、调试具有多个端的程序](exps/exp4-multisegment.md)
  - [实验五：更加灵活的内存单元定位](exps/exp5-doubleloop.md)
