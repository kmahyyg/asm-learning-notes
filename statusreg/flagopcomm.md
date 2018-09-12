# 6.2 标志位操作指令

## 标志位数据传送 LAHF / SAHF

指令格式：LAHF / SAHF

LAHF：将标志寄存器中最低8位数据传送到AH寄存器。
SAHF：将AH寄存器中数据传送到标志寄存器最低8位。

## 特定标志位操作指令 (CF)

指令格式： CLC / STC / CMC

指令功能：
- CLC：CF=0。
- STC：CF=0。
- CMC：CF取反。

说明：
- CLC：其他条件与控制标志位也有类似指令。
