# DEBUG(DOS) 参考文档

DEBUG syntax:

```
DEBUG [/F] [[drive:][path]filename [arglist]]

  /F        enable page flipping
  filename  file to debug or examine
  arglist   parameters given to program
```
  
DEBUG commands:

```
assemble        A [address]                                     standard
compare         C range address                                 standard
dump            D[B|W|D] [range]                                standard
dump interrupt  DI interrupt [count]                            DEBUGX
dump LDT        DL selector [count]                             DEBUGX
dump MCB chain  DM                                              standard
dump ext memory DX [physical_address]                           DEBUGX   (define DXSUPP=1)
enter           E address [list]                                standard
fill            F range list                                    standard
go              G [=address] [breakpoints]                      standard
hex add/sub     H value1 value2                                 standard
input           I[W|D] port                                     standard
load file       L [address]                                     standard
load sectors    L address drive sector count                    standard
move            M range address                                 standard
set CPU mode    M [x|N|T] (x=0..6, N=no FPU, T=386 with 287)    DEBUGX   (define MODESETCMD=1)
name            N [[drive:][path]filename [arglist]]            standard
output          O[W|D] port value                               standard
proceed         P [=address] [count]                            standard
proceed return  PR                                              standard
quit            Q                                               standard
register        R [register [value]]                            standard
MMX register    RM                                              DEBUGX   (define MMXSUPP=1)
FPU register    RN                                              standard (enhanced in DEBUGX with define FPTOSTR=1)
toggle 386 regs RX                                              standard
search          S range list                                    standard
trace           T [=address] [count]                            standard
trace mode      TM [0|1]                                        standard
unassemble      U [range]                                       standard
view flip       V                                               standard
write file      W [address]                                     standard
write sectors   W address drive sector count                    standard
EMS allocate    XA count                                        special  (define EMSCMD=1)
EMS deallocate  XD handle                                       special  (define EMSCMD=1)
EMS map memory  XM logical_page physical_page handle            special  (define EMSCMD=1)
EMS reallocate  XR handle count                                 special  (define EMSCMD=1)
EMS show status XS                                              special  (define EMSCMD=1)
```

From https://sites.google.com/site/pcdosretro/enhdebug

关于 DOS int21h 中断和相关的其他中断的具体使用及功能，可参考： http://stanislavs.org/helppc/
