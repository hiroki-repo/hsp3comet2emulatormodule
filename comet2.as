//COMET II emulator module codename:mexicantexas
//This module is unlicensed so you can use it freely!
#module comet2moduleacc
#deffunc local comet2_init
vmmax=256
dim register,16,vmmax
ldim opcode,256
repeat 256:opcode(cnt)=*opcode_invalid:loop

opcode(0x00)=*opcode_00

opcode(0x10)=*opcode_10
opcode(0x11)=*opcode_11
opcode(0x12)=*opcode_12
opcode(0x14)=*opcode_14

opcode(0x20)=*opcode_20
opcode(0x21)=*opcode_21
opcode(0x22)=*opcode_22
opcode(0x23)=*opcode_23
opcode(0x24)=*opcode_24
opcode(0x25)=*opcode_25
opcode(0x26)=*opcode_26
opcode(0x27)=*opcode_27

opcode(0x30)=*opcode_30
opcode(0x31)=*opcode_31
opcode(0x32)=*opcode_32
opcode(0x34)=*opcode_34
opcode(0x35)=*opcode_35
opcode(0x36)=*opcode_36

opcode(0x40)=*opcode_40
opcode(0x41)=*opcode_41
opcode(0x44)=*opcode_44
opcode(0x45)=*opcode_45

opcode(0x50)=*opcode_50
opcode(0x51)=*opcode_51
opcode(0x52)=*opcode_52
opcode(0x53)=*opcode_53

opcode(0x61)=*opcode_61
opcode(0x62)=*opcode_62
opcode(0x63)=*opcode_63
opcode(0x64)=*opcode_64
opcode(0x65)=*opcode_65
opcode(0x66)=*opcode_66

opcode(0x70)=*opcode_70
opcode(0x71)=*opcode_71

opcode(0x80)=*opcode_80
opcode(0x81)=*opcode_81

opcode(0xf0)=*opcode_f0
ldim svcptr,0
return
*opcode_invalid
return

#deffunc comet2setsvchndler label prm_0
svcptr=prm_0
return

#defcfunc local comet2memread int prm_0_
#ifdef comet2memaccess
comet2memaccess (prm_0_&0xFFFF),0,1:statue=(((stat>>8)&0xFF)|((stat<<8)&0xFF00))
#else
statue=(((peek(memoryiex,((prm_0_&0xFFFF)*2)+1))&0xFF)|((peek(memoryiex,((prm_0_&0xFFFF)*2)+0)<<8)&0xFF00))
#endif
return statue
#deffunc local comet2memwrite int prm_0,int prm_1
#ifdef comet2memaccess
comet2memaccess (prm_0&0xFFFF),(((prm_1>>8)&0xFF)|((prm_1<<8)&0xFF00)),0
#else
wpoke memoryiex,((prm_0&0xFFFF)*2),(((prm_1>>8)&0xFF)|((prm_1<<8)&0xFF00))
#endif
return

#defcfunc local comet2getaddrx
register(9,vmidtmp)++:return (wpeek(register((peek(opcodetemp,0)>>0)&0xF,vmidtmp),0)*(((peek(opcodetemp,0)>>0)&0xF)!=0))+comet2memread(register(9,vmidtmp)-1)

#ifdef comet2memaccess
#deffunc comet2run var address,int vmid
#else
#deffunc comet2run var address,var memory,int vmid
dup memoryiex,memory
#endif
addressold=lpeek(address,0):vmidtmp=vmid:register(9,vmidtmp)=address:opcodetemp=comet2memread(register(9,vmidtmp)):register(9,vmidtmp)++
gosub opcode(peek(opcodetemp,1))
address=register(9,vmidtmp)
return address-addressold

*opcode_00
return

*opcode_10
lpoke register((peek(opcodetemp,0)>>4)&0xF),0,comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_11
comet2memwrite comet2getaddrx(),register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF
return
*opcode_12
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,comet2getaddrx()
return
*opcode_14
lpoke register((peek(opcodetemp,0)>>4)&0xF),0,register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return

*opcode_20
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)+comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_21
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)-comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_22
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)+comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_23
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)-comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_24
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)+register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_25
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)-register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_26
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)+register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_27
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)-register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&2)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return

*opcode_30
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_31
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)|comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_32
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)^comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return

*opcode_34
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_35
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)|register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_36
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)^register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return

*opcode_40
calctempx=comet2memread(comet2getaddrx())
calctemp=((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)|(0xFFFF0000*((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)>=0x8000)))-((calctempx&0xFFFF)|(0xFFFF0000*((calctempx&0xFFFF)>=0x8000)))
wpoke register(10,vmidtmp),0,((calctemp>>14)&6)|(((calctemp&0xFFFF)=0)&1)
return
*opcode_41
calctemp=register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)-comet2memread(comet2getaddrx())
wpoke register(10,vmidtmp),0,((calctemp>>14)&6)|(((calctemp&0xFFFF)=0)&1)
return

*opcode_44
calctemp=((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)|(0xFFFF0000*((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)>=0x8000)))-((register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)&0xFFFF)|(0xFFFF0000*((register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)&0xFFFF)>=0x8000)))
wpoke register(10,vmidtmp),0,((calctemp>>14)&6)|(((calctemp&0xFFFF)=0)&1)
return
*opcode_45
calctemp=register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)-register((peek(opcodetemp,0)>>0)&0xF,vmidtmp)
wpoke register(10,vmidtmp),0,((calctemp>>14)&6)|(((calctemp&0xFFFF)=0)&1)
return

*opcode_50
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)<<comet2getaddrx())&0x7FFF)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_51
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>comet2getaddrx())&0x7FFF)|(register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0x8000)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_52
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)<<comet2getaddrx())&0xFFFF)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return
*opcode_53
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>comet2getaddrx())&0xFFFF)
wpoke register(10,vmidtmp),0,((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)>>14)&6)|(((register((peek(opcodetemp,0)>>4)&0xF,vmidtmp)&0xFFFF)=0)&1)
return

*opcode_61
addresstemp=comet2getaddrx()
if (register(10,vmidtmp)&2){lpoke register(9,vmidtmp),0,addresstemp}
return
*opcode_62
addresstemp=comet2getaddrx()
if (register(10,vmidtmp)&1)=0{lpoke register(9,vmidtmp),0,addresstemp}
return
*opcode_63
addresstemp=comet2getaddrx()
if (register(10,vmidtmp)&1){lpoke register(9,vmidtmp),0,addresstemp}
return
*opcode_64
addresstemp=comet2getaddrx()
lpoke register(9,vmidtmp),0,addresstemp
return
*opcode_65
addresstemp=comet2getaddrx()
if (register(10,vmidtmp)&3)=0{lpoke register(9,vmidtmp),0,addresstemp}
return
*opcode_66
addresstemp=comet2getaddrx()
if (register(10,vmidtmp)&4){lpoke register(9,vmidtmp),0,addresstemp}
return

*opcode_70
register(8,vmidtmp)=(register(8,vmidtmp)-1)&0xFFFF
comet2memwrite register(8,vmidtmp),comet2getaddrx()
return
*opcode_71
lpoke register((peek(opcodetemp,0)>>4)&0xF,vmidtmp),0,comet2memread(register(8,vmidtmp))
register(8,vmidtmp)=(register(8,vmidtmp)+1)&0xFFFF
return

*opcode_80
addresstemp=comet2getaddrx()
register(8,vmidtmp)=(register(8,vmidtmp)-1)&0xFFFF
comet2memwrite register(8,vmidtmp),register(9,vmidtmp)
lpoke register(9,vmidtmp),0,addresstemp
return
*opcode_81
lpoke register(9,vmidtmp),0,comet2memread(register(8,vmidtmp))
register(8,vmidtmp)=(register(8,vmidtmp)+1)&0xFFFF
return

*opcode_f0
addresstemp=comet2getaddrx():mref stat4svcid,64:lpoke stat4svcid,0,addresstemp
if lpeek(svcptr,0)!=0{gosub svcptr}
return

#global
comet2_init@comet2moduleacc
