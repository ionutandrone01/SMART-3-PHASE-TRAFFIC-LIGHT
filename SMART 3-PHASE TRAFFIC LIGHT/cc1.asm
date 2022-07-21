
;CodeVisionAVR C Compiler V3.48b 
;(C) Copyright 1998-2022 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Release
;Chip type              : ATmega164A
;Program type           : Application
;Clock frequency        : 20.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : No
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 1
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega164A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPMCSR=0x37
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.EQU __FLASH_PAGE_SIZE=0x40
	.EQU __EEPROM_PAGE_SIZE=0x04

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _rx_wr_index0=R3
	.DEF _rx_rd_index0=R2
	.DEF _rx_counter0=R5
	.DEF _tx_wr_index0=R4
	.DEF _tx_rd_index0=R7
	.DEF _tx_counter0=R6

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  _usart0_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0xD6:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x01

	.DSEG
	.ORG 0x200

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;interrupt [21] void usart0_rx_isr(void)
; 0000 0049 {

	.CSEG
_usart0_rx_isr:
; .FSTART _usart0_rx_isr
	RCALL SUBOPT_0x0
; 0000 004A char status,data;
; 0000 004B status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,192
; 0000 004C data=UDR0;
	LDS  R16,198
; 0000 004D if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 004E {
; 0000 004F rx_buffer0[rx_wr_index0++]=data;
	MOV  R30,R3
	INC  R3
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0000 0050 #if RX_BUFFER_SIZE0 == 256
; 0000 0051 // special case for receiver buffer size=256
; 0000 0052 if (++rx_counter0 == 0) rx_buffer_overflow0=1;
; 0000 0053 #else
; 0000 0054 if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R3
	BRNE _0x4
	CLR  R3
; 0000 0055 if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x4:
	INC  R5
	LDI  R30,LOW(8)
	CP   R30,R5
	BRNE _0x5
; 0000 0056 {
; 0000 0057 rx_counter0=0;
	CLR  R5
; 0000 0058 rx_buffer_overflow0=1;
	SBI  0x1E,0
; 0000 0059 }
; 0000 005A #endif
; 0000 005B }
_0x5:
; 0000 005C }
_0x3:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0xFB
; .FEND
;char getchar(void)
; 0000 0063 {
_getchar:
; .FSTART _getchar
; 0000 0064 char data;
; 0000 0065 while (rx_counter0==0);
	ST   -Y,R17
;	data -> R17
_0x8:
	TST  R5
	BREQ _0x8
; 0000 0066 data=rx_buffer0[rx_rd_index0++];
	MOV  R30,R2
	INC  R2
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	LD   R17,Z
; 0000 0067 #if RX_BUFFER_SIZE0 != 256
; 0000 0068 if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R2
	BRNE _0xB
	CLR  R2
; 0000 0069 #endif
; 0000 006A #asm("cli")
_0xB:
	CLI
; 0000 006B --rx_counter0;
	DEC  R5
; 0000 006C #asm("sei")
	SEI
; 0000 006D return data;
	MOV  R30,R17
	LD   R17,Y+
	RET
; 0000 006E }
; .FEND
;interrupt [23] void usart0_tx_isr(void)
; 0000 007E {
_usart0_tx_isr:
; .FSTART _usart0_tx_isr
	RCALL SUBOPT_0x0
; 0000 007F if (tx_counter0)
	TST  R6
	BREQ _0xC
; 0000 0080 {
; 0000 0081 --tx_counter0;
	DEC  R6
; 0000 0082 UDR0=tx_buffer0[tx_rd_index0++];
	MOV  R30,R7
	INC  R7
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R30,Z
	STS  198,R30
; 0000 0083 #if TX_BUFFER_SIZE0 != 256
; 0000 0084 if (tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R7
	BRNE _0xD
	CLR  R7
; 0000 0085 #endif
; 0000 0086 }
_0xD:
; 0000 0087 }
_0xC:
_0xFB:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;void putchar(char c)
; 0000 008E {
; 0000 008F while (tx_counter0 == TX_BUFFER_SIZE0);
;	c -> Y+0
; 0000 0090 #asm("cli")
; 0000 0091 if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
; 0000 0092 {
; 0000 0093 tx_buffer0[tx_wr_index0++]=c;
; 0000 0094 #if TX_BUFFER_SIZE0 != 256
; 0000 0095 if (tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
; 0000 0096 #endif
; 0000 0097 ++tx_counter0;
; 0000 0098 }
; 0000 0099 else
; 0000 009A UDR0=c;
; 0000 009B #asm("sei")
; 0000 009C }
;interrupt [14] void timer1_compa_isr(void)
; 0000 00A9 {
_timer1_compa_isr:
; .FSTART _timer1_compa_isr
; 0000 00AA LED1 = ~LED1; // invert LED
	SBIS 0xB,6
	RJMP _0x16
	CBI  0xB,6
	RJMP _0x17
_0x16:
	SBI  0xB,6
_0x17:
; 0000 00AB }
	RETI
; .FEND
;void etapa1()
; 0000 00AE {                      //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
_etapa1:
; .FSTART _etapa1
; 0000 00AF LMS2A_V = LOW;
	CBI  0x5,6
; 0000 00B0 LMS2A_R = HIGH;
	SBI  0x8,0
; 0000 00B1 
; 0000 00B2 delay_ms(1500);  //LA TERMINAREA CICLULUI MAI INTAI SE FACE ROSU PE STRADA 2A IAR CULORILE CELORLALTE SEMAFOARE COMUTA DUPA O INTARZIERE DE 2 SECUNDE
	RCALL SUBOPT_0x1
; 0000 00B3 //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSIE
; 0000 00B4 LPS1_V = LOW;
; 0000 00B5 LPS1_R = HIGH;
; 0000 00B6 //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSIE
; 0000 00B7 LPS2_V = LOW;
	RCALL SUBOPT_0x2
; 0000 00B8 LPS2_R = HIGH;
; 0000 00B9 //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
; 0000 00BA LMS2B_V = LOW;
; 0000 00BB LMS2B_R = HIGH;
; 0000 00BC //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
; 0000 00BD LMS1_V = HIGH;
; 0000 00BE LMS1_R = LOW;
	CBI  0x5,5
; 0000 00BF }
	RET
; .FEND
;void etapa2()
; 0000 00C2 {                      //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
_etapa2:
; .FSTART _etapa2
; 0000 00C3 LMS2A_V = LOW;
	CBI  0x5,6
; 0000 00C4 LMS2A_R = HIGH;
	SBI  0x8,0
; 0000 00C5 //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSIE
; 0000 00C6 LPS1_V = LOW;
	CBI  0x5,0
; 0000 00C7 LPS1_R = HIGH;
	SBI  0x5,1
; 0000 00C8 //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSIE
; 0000 00C9 LPS2_V = LOW;
	RCALL SUBOPT_0x2
; 0000 00CA LPS2_R = HIGH;
; 0000 00CB //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
; 0000 00CC LMS2B_V = LOW;
; 0000 00CD LMS2B_R = HIGH;
; 0000 00CE //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA GABLBEN
; 0000 00CF LMS1_V = HIGH;
; 0000 00D0 LMS1_R = HIGH;
	SBI  0x5,5
; 0000 00D1 }
	RET
; .FEND
;void etapa3()
; 0000 00D4 {                       //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
_etapa3:
; .FSTART _etapa3
; 0000 00D5 LMS1_V = LOW;
	CBI  0x5,4
; 0000 00D6 LMS1_R = HIGH;
	SBI  0x5,5
; 0000 00D7 
; 0000 00D8 delay_ms(1500);  //DUPA CE SE FACE ROSU PE STRADA 1, CULORILE CELORLALTE SEMAFOARE COMUTA DUPA 2 SECUNDE
	LDI  R26,LOW(1500)
	LDI  R27,HIGH(1500)
	RCALL _delay_ms
; 0000 00D9 //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
; 0000 00DA LMS2A_V = LOW;
	CBI  0x5,6
; 0000 00DB LMS2A_R = HIGH;
	SBI  0x8,0
; 0000 00DC //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA VERDE
; 0000 00DD LPS1_V = HIGH;
	SBI  0x5,0
; 0000 00DE LPS1_R = LOW;
	CBI  0x5,1
; 0000 00DF //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSIE
; 0000 00E0 LPS2_V = LOW;
	CBI  0x5,2
; 0000 00E1 LPS2_R = HIGH;
	SBI  0x5,3
; 0000 00E2 //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA VERDE
; 0000 00E3 LMS2B_V = HIGH;
	SBI  0x8,1
; 0000 00E4 LMS2B_R = LOW;
	CBI  0x8,2
; 0000 00E5 
; 0000 00E6 }
	RET
; .FEND
;void etapa4()
; 0000 00E9 {                       //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
_etapa4:
; .FSTART _etapa4
; 0000 00EA LPS1_V = LOW;
	RCALL SUBOPT_0x3
; 0000 00EB LPS1_R = HIGH;
; 0000 00EC //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
; 0000 00ED LPS2_V = LOW;
; 0000 00EE LPS2_R = HIGH;
; 0000 00EF //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
; 0000 00F0 LMS1_V = LOW;
; 0000 00F1 LMS1_R = HIGH;
; 0000 00F2 //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
; 0000 00F3 LMS2A_V = LOW;
; 0000 00F4 LMS2A_R = HIGH;
; 0000 00F5 
; 0000 00F6 //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA VERDE
; 0000 00F7 LMS2B_V = HIGH;
; 0000 00F8 LMS2B_R = LOW;
	CBI  0x8,2
; 0000 00F9 
; 0000 00FA delay_ms(4000);
	LDI  R26,LOW(4000)
	LDI  R27,HIGH(4000)
	RCALL _delay_ms
; 0000 00FB }
	RET
; .FEND
;void etapa5()
; 0000 00FF {                       //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
_etapa5:
; .FSTART _etapa5
; 0000 0100 LPS1_V = LOW;
	RCALL SUBOPT_0x3
; 0000 0101 LPS1_R = HIGH;
; 0000 0102 //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
; 0000 0103 LPS2_V = LOW;
; 0000 0104 LPS2_R = HIGH;
; 0000 0105 //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
; 0000 0106 LMS1_V = LOW;
; 0000 0107 LMS1_R = HIGH;
; 0000 0108 //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
; 0000 0109 LMS2A_V = LOW;
; 0000 010A LMS2A_R = HIGH;
; 0000 010B 
; 0000 010C //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA GALBEN
; 0000 010D LMS2B_V = HIGH;
; 0000 010E LMS2B_R = HIGH;
	RJMP _0x20A0004
; 0000 010F }
; .FEND
;void etapa6()
; 0000 0112 {                        //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
_etapa6:
; .FSTART _etapa6
; 0000 0113 LMS2B_V = LOW;
	CBI  0x8,1
; 0000 0114 LMS2B_R = HIGH;
	SBI  0x8,2
; 0000 0115 
; 0000 0116 delay_ms(1500);   //DUPA CE SE FACE ROSU PE STRADA 2B, CULORILE CELORLALTE SEMAFOARE COMUTA DUPA 2 SECUNDE
	RCALL SUBOPT_0x1
; 0000 0117 //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
; 0000 0118 LPS1_V = LOW;
; 0000 0119 LPS1_R = HIGH;
; 0000 011A //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA VERDE
; 0000 011B LPS2_V = HIGH;
	SBI  0x5,2
; 0000 011C LPS2_R = LOW;
	CBI  0x5,3
; 0000 011D //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
; 0000 011E LMS1_V = LOW;
	CBI  0x5,4
; 0000 011F LMS1_R = HIGH;
	SBI  0x5,5
; 0000 0120 //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
; 0000 0121 LMS2A_V = LOW;
	CBI  0x5,6
; 0000 0122 LMS2A_R = HIGH;
	RJMP _0x20A0003
; 0000 0123 }
; .FEND
;void etapa7()
; 0000 0126 {                      //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
_etapa7:
; .FSTART _etapa7
; 0000 0127 LPS2_V = LOW;
	CBI  0x5,2
; 0000 0128 LPS2_R = HIGH;
	SBI  0x5,3
; 0000 0129 
; 0000 012A delay_ms(1500);  //DUPA CE SE FACE ROSU LA PIETONII DE PE STRADA 2, CULORILE CELORLALTE SEMAFOARE COMUTA DUPA 2 SECUNDE
	RCALL SUBOPT_0x1
; 0000 012B //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
; 0000 012C LPS1_V = LOW;
; 0000 012D LPS1_R = HIGH;
; 0000 012E //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
; 0000 012F LMS1_V = LOW;
	CBI  0x5,4
; 0000 0130 LMS1_R = HIGH;
	SBI  0x5,5
; 0000 0131 //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA VERDE
; 0000 0132 LMS2A_V = HIGH;
	SBI  0x5,6
; 0000 0133 LMS2A_R = LOW;
	CBI  0x8,0
; 0000 0134 //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
; 0000 0135 LMS2B_V = LOW;
	CBI  0x8,1
; 0000 0136 LMS2B_R = HIGH;
_0x20A0004:
	SBI  0x8,2
; 0000 0137 }
	RET
; .FEND
;void etapa8()
; 0000 013A {                       //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
_etapa8:
; .FSTART _etapa8
; 0000 013B LPS2_V = LOW;
	CBI  0x5,2
; 0000 013C LPS2_R = HIGH;
	SBI  0x5,3
; 0000 013D //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
; 0000 013E LPS1_V = LOW;
	CBI  0x5,0
; 0000 013F LPS1_R = HIGH;
	SBI  0x5,1
; 0000 0140 //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
; 0000 0141 LMS1_V = LOW;
	CBI  0x5,4
; 0000 0142 LMS1_R = HIGH;
	SBI  0x5,5
; 0000 0143 //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
; 0000 0144 LMS2B_V = LOW;
	CBI  0x8,1
; 0000 0145 LMS2B_R = HIGH;
	SBI  0x8,2
; 0000 0146 //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA GALBEN
; 0000 0147 LMS2A_V = HIGH;
	SBI  0x5,6
; 0000 0148 LMS2A_R = HIGH;
_0x20A0003:
	SBI  0x8,0
; 0000 0149 }
	RET
; .FEND
;void flash_PS1()
; 0000 014E //cand timpul pentru traversare este aproape de final
; 0000 014F {
_flash_PS1:
; .FSTART _flash_PS1
; 0000 0150 int initialState = LPS1_V;   //retinem starea culorii verzi a semafoarelor pentru pietonii de pe strada 1
; 0000 0151 int i = 0;
; 0000 0152 for(i = 0 ; i < 4; i++)     //prin parcurgerea buclei for asiguram aprinderea si stingerea led-ului de 4 ori
	RCALL __SAVELOCR4
;	initialState -> R16,R17
;	i -> R18,R19
	LDI  R30,0
	SBIC 0x5,0
	LDI  R30,1
	RCALL SUBOPT_0x4
	__GETWRN 18,19,0
_0xB9:
	__CPWRN 18,19,4
	BRGE _0xBA
; 0000 0153 {
; 0000 0154 LPS1_V = LOW;
	CBI  0x5,0
; 0000 0155 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 0156 LPS1_V = HIGH;
	SBI  0x5,0
; 0000 0157 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 0158 }
	__ADDWRN 18,19,1
	RJMP _0xB9
_0xBA:
; 0000 0159 LPS1_V = initialState;
	CPI  R16,0
	BRNE _0xBF
	CBI  0x5,0
	RJMP _0xC0
_0xBF:
	SBI  0x5,0
_0xC0:
; 0000 015A }
	RJMP _0x20A0002
; .FEND
;void flash_PS2()
; 0000 015D //cand timpul pentru traversare este aproape de final
; 0000 015E {
_flash_PS2:
; .FSTART _flash_PS2
; 0000 015F int initialState = LPS2_V;   //retinem starea culorii verzi a semafoarelor pentru pietonii de pe strada 2
; 0000 0160 int i;
; 0000 0161 for(i = 0 ; i < 4; i++)     //prin parcurgerea buclei for asiguram aprinderea si stingerea led-ului de 4 ori
	RCALL __SAVELOCR4
;	initialState -> R16,R17
;	i -> R18,R19
	LDI  R30,0
	SBIC 0x5,2
	LDI  R30,1
	RCALL SUBOPT_0x4
_0xC2:
	__CPWRN 18,19,4
	BRGE _0xC3
; 0000 0162 {
; 0000 0163 LPS2_V = LOW;
	CBI  0x5,2
; 0000 0164 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 0165 LPS2_V = HIGH;
	SBI  0x5,2
; 0000 0166 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 0167 }
	__ADDWRN 18,19,1
	RJMP _0xC2
_0xC3:
; 0000 0168 LPS2_V = initialState;
	CPI  R16,0
	BRNE _0xC8
	CBI  0x5,2
	RJMP _0xC9
_0xC8:
	SBI  0x5,2
_0xC9:
; 0000 0169 }
_0x20A0002:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
;int get_delay (char arg) {
; 0000 016B int get_delay (char arg) {
_get_delay:
; .FSTART _get_delay
; 0000 016C switch(arg) {               //switch-ul functioneaza doar cu numere, iar noi chiar daca ii dam un caracter, el o sa foloseasca coduri ASCII
	ST   -Y,R26
;	arg -> Y+0
	LD   R30,Y
; 0000 016D case '1': return 15;      //daca se introduce in terminal '1', functia returneaza o durata de 15 secunde (10% din ciclul de 2 minute si 30 sec = 150 sec)
	CPI  R30,LOW(0x31)
	BRNE _0xCD
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	RJMP _0x20A0001
; 0000 016E case '2': return 30;      //daca se introduce in terminal '2', functia returneaza o durata de 30 secunde (20% din ciclul de 2 minute si 30 sec)
_0xCD:
	CPI  R30,LOW(0x32)
	BRNE _0xCE
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	RJMP _0x20A0001
; 0000 016F case '3': return 45;      //daca se introduce in terminal '3', functia returneaza o durata de 45 secunde (30% din ciclul de 2 minute si 30 sec)
_0xCE:
	CPI  R30,LOW(0x33)
	BRNE _0xCF
	LDI  R30,LOW(45)
	LDI  R31,HIGH(45)
	RJMP _0x20A0001
; 0000 0170 case '4': return 60;      //daca se introduce in terminal '4', functia returneaza o durata de 60 secunde (40% din ciclul de 2 minute si 30 sec)
_0xCF:
	CPI  R30,LOW(0x34)
	BRNE _0xD0
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	RJMP _0x20A0001
; 0000 0171 case '5': return 75;      //daca se introduce in terminal '5', functia returneaza o durata de 75 secunde (50% din ciclul de 2 minute si 30 sec)
_0xD0:
	CPI  R30,LOW(0x35)
	BRNE _0xD1
	LDI  R30,LOW(75)
	LDI  R31,HIGH(75)
	RJMP _0x20A0001
; 0000 0172 case '6': return 90;      //daca se introduce in terminal '6', functia returneaza o durata de 60 secunde (60% din ciclul de 2 minute si 30 sec)
_0xD1:
	CPI  R30,LOW(0x36)
	BRNE _0xD2
	LDI  R30,LOW(90)
	LDI  R31,HIGH(90)
	RJMP _0x20A0001
; 0000 0173 case '7': return 105;     //daca se introduce in terminal '7', functia returneaza o durata de 60 secunde (70% din ciclul de 2 minute si 30 sec)
_0xD2:
	CPI  R30,LOW(0x37)
	BRNE _0xD3
	LDI  R30,LOW(105)
	LDI  R31,HIGH(105)
	RJMP _0x20A0001
; 0000 0174 case '8': return 120;     //daca se introduce in terminal '8', functia returneaza o durata de 60 secunde (80% din ciclul de 2 minute si 30 sec)
_0xD3:
	CPI  R30,LOW(0x38)
	BRNE _0xD5
	LDI  R30,LOW(120)
	LDI  R31,HIGH(120)
	RJMP _0x20A0001
; 0000 0175 
; 0000 0176 default : return 5;
_0xD5:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
; 0000 0177 
; 0000 0178 }
; 0000 0179 }
_0x20A0001:
	ADIW R28,1
	RET
; .FEND
;void main (void)
; 0000 017E {
_main:
; .FSTART _main
; 0000 017F unsigned char temp;
; 0000 0180 //initializarea variabilelor prin care setam delay-uri
; 0000 0181 int t_P=0, t_S2A=0, t_S2B=0, t_S1=0;
; 0000 0182 int dif;
; 0000 0183 int flag = 0;
; 0000 0184 int i;
; 0000 0185 
; 0000 0186 
; 0000 0187 char SS[4] = "";     //vector in care retinem caracterele introduse necesare setarii delay-ului
; 0000 0188 int s=0;             //index cu care parcurgem vectorul
; 0000 0189 
; 0000 018A Init_initController();  // this must be the first "init" action/call!
	SBIW R28,16
	LDI  R24,16
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0xD6*2)
	LDI  R31,HIGH(_0xD6*2)
	RCALL __INITLOCB
;	temp -> R17
;	t_P -> R18,R19
;	t_S2A -> R20,R21
;	t_S2B -> Y+14
;	t_S1 -> Y+12
;	dif -> Y+10
;	flag -> Y+8
;	i -> Y+6
;	SS -> Y+2
;	s -> Y+0
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	RCALL _Init_initController
; 0000 018B #asm("sei")             // enable interrupts
	SEI
; 0000 018C LED1 = 1;           	// initial state, will be changed by timer 1
	SBI  0xB,6
; 0000 018D DDRB = 0xFF;         //setarea registrilor B si C ca output
	LDI  R30,LOW(255)
	OUT  0x4,R30
; 0000 018E DDRC = 0xFF;
	OUT  0x7,R30
; 0000 018F 
; 0000 0190 PORTB = PORTC = 0x00;//LOW = 0 HIGH = 1        //toate led-urile controlate de pini din B si C sunt stinse
	LDI  R30,LOW(0)
	OUT  0x8,R30
	OUT  0x5,R30
; 0000 0191 
; 0000 0192 while(TRUE)
_0xD9:
; 0000 0193 {
; 0000 0194 wdogtrig();	        // call often else processor will reset
	WDR
; 0000 0195 if(rx_counter0)     // if a character is available on serial port USART0
	TST  R5
	BRNE PC+2
	RJMP _0xDC
; 0000 0196 {
; 0000 0197 temp = getchar();
	RCALL _getchar
	MOV  R17,R30
; 0000 0198 if( temp ==  'A' ||  temp ==  'B'  || temp ==  'C'  || (temp >= '1' && temp <= '8'))
	CPI  R17,65
	BREQ _0xDE
	CPI  R17,66
	BREQ _0xDE
	CPI  R17,67
	BREQ _0xDE
	CPI  R17,49
	BRLO _0xDF
	CPI  R17,57
	BRLO _0xDE
_0xDF:
	RJMP _0xDD
_0xDE:
; 0000 0199 {
; 0000 019A 
; 0000 019B SS[s++] = temp;   //retinem in SS caracterele introduse, primul caracter e retinut in SS[0] iar s=0, urmatorul caracter este retinut
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	SBIW R30,1
	MOVW R26,R28
	ADIW R26,2
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R17
; 0000 019C // in SS[1], iar s=1
; 0000 019D if(s >= 2) {          //asigurare ca va rula codul chiar si atunci cand sunt introduse caractere in plus
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,2
	BRGE PC+2
	RJMP _0xE2
; 0000 019E if (SS[0] == 'A' )    //compara codul ASCII
	LDD  R26,Y+2
	CPI  R26,LOW(0x41)
	BRNE _0xE3
; 0000 019F {   flag = 1;
	RCALL SUBOPT_0x5
; 0000 01A0 t_S2A = get_delay(SS[1]);    //retinem in t_S2A valoarea intoarsa de functia get_delay
	MOVW R20,R30
; 0000 01A1 dif = 123 - t_S2A;          //ciclul are 150 secunde, dar 27 sec sunt pierdute in cadrul fazelor
	LDI  R30,LOW(123)
	LDI  R31,HIGH(123)
	SUB  R30,R20
	SBC  R31,R21
	RCALL SUBOPT_0x6
; 0000 01A2 t_S1 = dif/3;               //alegem ca timpul ramas sa fie distribuit in mod egal
; 0000 01A3 t_P = dif/3;
; 0000 01A4 t_S2B = dif/3;
	STD  Y+14,R30
	STD  Y+14+1,R31
; 0000 01A5 
; 0000 01A6 }
; 0000 01A7 
; 0000 01A8 
; 0000 01A9 if (SS[0] == 'B' )
_0xE3:
	LDD  R26,Y+2
	CPI  R26,LOW(0x42)
	BRNE _0xE4
; 0000 01AA {  flag = 1;
	RCALL SUBOPT_0x5
; 0000 01AB t_S2B = get_delay(SS[1]);      //retinem in t_S2B valoarea intoarsa de functia get_delay
	STD  Y+14,R30
	STD  Y+14+1,R31
; 0000 01AC dif = 123 - t_S2B;             //ciclul are 150 secunde, dar 27 sec sunt pierdute in cadrul fazelor
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x6
; 0000 01AD t_S1 = dif/3;                  //alegem ca timpul ramas sa fie distribuit in mod egal
; 0000 01AE t_P =  dif/3;
; 0000 01AF t_S2A = dif/3;
	MOVW R20,R30
; 0000 01B0 
; 0000 01B1 }
; 0000 01B2 
; 0000 01B3 
; 0000 01B4 if (SS[0] == 'C' )
_0xE4:
	LDD  R26,Y+2
	CPI  R26,LOW(0x43)
	BRNE _0xE5
; 0000 01B5 {   flag = 1;
	RCALL SUBOPT_0x5
; 0000 01B6 t_S1 = get_delay(SS[1]);       //retinem in t_S1 valoarea intoarsa de functia get_delay
	STD  Y+12,R30
	STD  Y+12+1,R31
; 0000 01B7 dif = 123 - t_S1;              //ciclul are 150 secunde, dar 27 sec sunt pierdute in cadrul fazelor
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL SUBOPT_0x7
	STD  Y+10,R30
	STD  Y+10+1,R31
; 0000 01B8 t_S2B = dif/3;                 //alegem ca timpul ramas sa fie distribuit in mod egal
	RCALL SUBOPT_0x8
	STD  Y+14,R30
	STD  Y+14+1,R31
; 0000 01B9 t_P =  dif/3;
	RCALL SUBOPT_0x8
	MOVW R18,R30
; 0000 01BA t_S2A = dif/3;
	RCALL SUBOPT_0x8
	MOVW R20,R30
; 0000 01BB // printf("\n");
; 0000 01BC // printf("%d\n", t_S1);
; 0000 01BD // printf("%d\n", dif);
; 0000 01BE 
; 0000 01BF }
; 0000 01C0 
; 0000 01C1 if(flag) {           // verificam daca a fost scris un caracter de identificare a strazilor
_0xE5:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SBIW R30,0
	BREQ _0xE6
; 0000 01C2 
; 0000 01C3 while(1) {        // am introdus ciclul intr-o bucla infinita pentru a asigura continuitatea acestuia
_0xE7:
; 0000 01C4 
; 0000 01C5 
; 0000 01C6 etapa1();
	RCALL _etapa1
; 0000 01C7 for(i=0; i< t_S1; i++){
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
_0xEB:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	RCALL SUBOPT_0x9
	BRGE _0xEC
; 0000 01C8 delay_ms (1000);   //cat timp au verde masinile de pe strada 1 identificata prin 'C'
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01C9 }
	RCALL SUBOPT_0xA
	RJMP _0xEB
_0xEC:
; 0000 01CA etapa2();
	RCALL SUBOPT_0xB
; 0000 01CB 
; 0000 01CC delay_ms(3000);         //cat dureaza culoarea galben a semaforului de pe strada 1 ('C')
; 0000 01CD 
; 0000 01CE etapa3();
; 0000 01CF for(i=0; i< t_S2B; i++){
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
_0xEE:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	RCALL SUBOPT_0x9
	BRGE _0xEF
; 0000 01D0 
; 0000 01D1 delay_ms(1000);  //cat timp au verde masinile de pe strada 2B (in acelasi timp pietonii de pe strada 1 au verde)
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01D2 }
	RCALL SUBOPT_0xA
	RJMP _0xEE
_0xEF:
; 0000 01D3 flash_PS1();         //semaforul pietonilor de pe strada 1 lumineaza intermitent cand acestia mai au putin timp pentru a traversa
	RCALL SUBOPT_0xC
; 0000 01D4 
; 0000 01D5 etapa4();
; 0000 01D6 
; 0000 01D7 etapa5();
; 0000 01D8 
; 0000 01D9 delay_ms(3000);     //cat dureaza culoarea galben a semaforului pe strada 2B
; 0000 01DA 
; 0000 01DB etapa6();
; 0000 01DC for(i=0; i< t_P; i++){
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
_0xF1:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R18
	CPC  R27,R19
	BRGE _0xF2
; 0000 01DD 
; 0000 01DE delay_ms(1000);   // semafoarele pietonilor de pe strazile 2A si 2B au culoarea verde
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01DF }
	RCALL SUBOPT_0xA
	RJMP _0xF1
_0xF2:
; 0000 01E0 flash_PS2();          //semafoarele pietonilor de pe strazile 2A si 2B lumineaza intermitent cand acestia mai au putin timp pentru a traversa
	RCALL _flash_PS2
; 0000 01E1 
; 0000 01E2 etapa7();
	RCALL _etapa7
; 0000 01E3 for(i=0; i< t_S2A; i++){
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
_0xF4:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R20
	CPC  R27,R21
	BRGE _0xF5
; 0000 01E4 
; 0000 01E5 delay_ms(1000);   // cat timp au verde masinile de pe strada 2A
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01E6 }
	RCALL SUBOPT_0xA
	RJMP _0xF4
_0xF5:
; 0000 01E7 etapa8();
	RCALL SUBOPT_0xD
; 0000 01E8 
; 0000 01E9 delay_ms(3000);         //cat dureaza culoarea galben a semaforului de pe strada 2A
; 0000 01EA }
	RJMP _0xE7
; 0000 01EB }
; 0000 01EC 
; 0000 01ED }
_0xE6:
; 0000 01EE 
; 0000 01EF 
; 0000 01F0 }
_0xE2:
; 0000 01F1 
; 0000 01F2 else {           //in cazul in care sunt introduse alte caractere decat cele prin care sunt identificate strazile, am stabilit un ciclu implicit
	RJMP _0xF6
_0xDD:
; 0000 01F3 while(1) {
_0xF7:
; 0000 01F4 etapa1();
	RCALL _etapa1
; 0000 01F5 
; 0000 01F6 delay_ms(35000);
	LDI  R26,LOW(35000)
	LDI  R27,HIGH(35000)
	RCALL _delay_ms
; 0000 01F7 
; 0000 01F8 etapa2();
	RCALL SUBOPT_0xB
; 0000 01F9 
; 0000 01FA delay_ms(3000);
; 0000 01FB 
; 0000 01FC etapa3();
; 0000 01FD 
; 0000 01FE delay_ms(35000);
	LDI  R26,LOW(35000)
	LDI  R27,HIGH(35000)
	RCALL _delay_ms
; 0000 01FF 
; 0000 0200 flash_PS1();
	RCALL SUBOPT_0xC
; 0000 0201 
; 0000 0202 etapa4();
; 0000 0203 
; 0000 0204 etapa5();
; 0000 0205 
; 0000 0206 delay_ms(3000);
; 0000 0207 
; 0000 0208 etapa6();
; 0000 0209 
; 0000 020A delay_ms(18000);
	LDI  R26,LOW(18000)
	LDI  R27,HIGH(18000)
	RCALL _delay_ms
; 0000 020B 
; 0000 020C flash_PS2();
	RCALL _flash_PS2
; 0000 020D 
; 0000 020E etapa7();
	RCALL _etapa7
; 0000 020F 
; 0000 0210 delay_ms(35000);
	LDI  R26,LOW(35000)
	LDI  R27,HIGH(35000)
	RCALL _delay_ms
; 0000 0211 
; 0000 0212 etapa8();
	RCALL SUBOPT_0xD
; 0000 0213 
; 0000 0214 delay_ms(3000);
; 0000 0215 }
	RJMP _0xF7
; 0000 0216 }
_0xF6:
; 0000 0217 }
; 0000 0218 
; 0000 0219 
; 0000 021A 
; 0000 021B }
_0xDC:
	RJMP _0xD9
; 0000 021C 
; 0000 021D 
; 0000 021E }// end main loop
_0xFA:
	RJMP _0xFA
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;void Init_initController(void)
; 0001 000B {

	.CSEG
_Init_initController:
; .FSTART _Init_initController
; 0001 000C // Crystal Oscillator division factor: 1
; 0001 000D #pragma optsize-
; 0001 000E CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0001 000F CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0001 0010 #ifdef _OPTIMIZE_SIZE_
; 0001 0011 #pragma optsize+
; 0001 0012 #endif
; 0001 0013 
; 0001 0014 // Input/Output Ports initialization
; 0001 0015 // Port A initialization
; 0001 0016 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0001 0017 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0001 0018 PORTA=0x00;
	OUT  0x2,R30
; 0001 0019 DDRA=0x00;
	OUT  0x1,R30
; 0001 001A 
; 0001 001B // Port B initialization
; 0001 001C PORTB=0x00;
	OUT  0x5,R30
; 0001 001D DDRB=0x00;
	OUT  0x4,R30
; 0001 001E 
; 0001 001F // Port C initialization
; 0001 0020 PORTC=0x00;
	OUT  0x8,R30
; 0001 0021 DDRC=0x00;
	OUT  0x7,R30
; 0001 0022 
; 0001 0023 // Port D initialization
; 0001 0024 PORTD=0b00100000; // D.5 needs pull-up resistor
	LDI  R30,LOW(32)
	OUT  0xB,R30
; 0001 0025 DDRD= 0b01010000; // D.6 is LED, D.4 is test output
	LDI  R30,LOW(80)
	OUT  0xA,R30
; 0001 0026 
; 0001 0027 // Timer/Counter 0 initialization
; 0001 0028 // Clock source: System Clock
; 0001 0029 // Clock value: Timer 0 Stopped
; 0001 002A // Mode: Normal top=FFh
; 0001 002B // OC0 output: Disconnected
; 0001 002C TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0001 002D TCCR0B=0x00;
	OUT  0x25,R30
; 0001 002E TCNT0=0x00;
	OUT  0x26,R30
; 0001 002F OCR0A=0x00;
	OUT  0x27,R30
; 0001 0030 OCR0B=0x00;
	OUT  0x28,R30
; 0001 0031 
; 0001 0032 // Timer/Counter 1 initialization
; 0001 0033 // Clock source: System Clock
; 0001 0034 // Clock value: 19.531 kHz = CLOCK/256
; 0001 0035 // Mode: CTC top=OCR1A
; 0001 0036 // OC1A output: Discon.
; 0001 0037 // OC1B output: Discon.
; 0001 0038 // Noise Canceler: Off
; 0001 0039 // Input Capture on Falling Edge
; 0001 003A // Timer 1 Overflow Interrupt: Off
; 0001 003B // Input Capture Interrupt: Off
; 0001 003C // Compare A Match Interrupt: On
; 0001 003D // Compare B Match Interrupt: Off
; 0001 003E 
; 0001 003F TCCR1A=0x00;
	STS  128,R30
; 0001 0040 TCCR1B=0x0D;
	LDI  R30,LOW(13)
	STS  129,R30
; 0001 0041 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0001 0042 TCNT1L=0x00;
	STS  132,R30
; 0001 0043 ICR1H=0x00;
	STS  135,R30
; 0001 0044 ICR1L=0x00;
	STS  134,R30
; 0001 0045 
; 0001 0046 // 1 sec = 19531 counts = 4C41H counts, from 0 to 4C40
; 0001 0047 // 4C40H = 4CH (MSB) and 40H (LSB)
; 0001 0048 OCR1AH=0x4C;
	LDI  R30,LOW(76)
	STS  137,R30
; 0001 0049 OCR1AL=0x40;
	LDI  R30,LOW(64)
	STS  136,R30
; 0001 004A 
; 0001 004B OCR1BH=0x00;
	LDI  R30,LOW(0)
	STS  139,R30
; 0001 004C OCR1BL=0x00;
	STS  138,R30
; 0001 004D 
; 0001 004E // Timer/Counter 2 initialization
; 0001 004F // Clock source: System Clock
; 0001 0050 // Clock value: Timer2 Stopped
; 0001 0051 // Mode: Normal top=0xFF
; 0001 0052 // OC2A output: Disconnected
; 0001 0053 // OC2B output: Disconnected
; 0001 0054 ASSR=0x00;
	STS  182,R30
; 0001 0055 TCCR2A=0x00;
	STS  176,R30
; 0001 0056 TCCR2B=0x00;
	STS  177,R30
; 0001 0057 TCNT2=0x00;
	STS  178,R30
; 0001 0058 OCR2A=0x00;
	STS  179,R30
; 0001 0059 OCR2B=0x00;
	STS  180,R30
; 0001 005A 
; 0001 005B // External Interrupt(s) initialization
; 0001 005C // INT0: Off
; 0001 005D // INT1: Off
; 0001 005E // INT2: Off
; 0001 005F // Interrupt on any change on pins PCINT0-7: Off
; 0001 0060 // Interrupt on any change on pins PCINT8-15: Off
; 0001 0061 // Interrupt on any change on pins PCINT16-23: Off
; 0001 0062 // Interrupt on any change on pins PCINT24-31: Off
; 0001 0063 EICRA=0x00;
	STS  105,R30
; 0001 0064 EIMSK=0x00;
	OUT  0x1D,R30
; 0001 0065 PCICR=0x00;
	STS  104,R30
; 0001 0066 
; 0001 0067 // Timer/Counter 0,1,2 Interrupt(s) initialization
; 0001 0068 TIMSK0=0x00;
	STS  110,R30
; 0001 0069 TIMSK1=0x02;
	LDI  R30,LOW(2)
	STS  111,R30
; 0001 006A TIMSK2=0x00;
	LDI  R30,LOW(0)
	STS  112,R30
; 0001 006B 
; 0001 006C // USART0 initialization
; 0001 006D // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0001 006E // USART0 Receiver: On
; 0001 006F // USART0 Transmitter: On
; 0001 0070 // USART0 Mode: Asynchronous
; 0001 0071 // USART0 Baud rate: 9600
; 0001 0072 UCSR0A=0x00;
	STS  192,R30
; 0001 0073 UCSR0B=0xD8;
	LDI  R30,LOW(216)
	STS  193,R30
; 0001 0074 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
; 0001 0075 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0001 0076 UBRR0L=0x81;
	LDI  R30,LOW(129)
	STS  196,R30
; 0001 0077 
; 0001 0078 // USART1 initialization
; 0001 0079 // USART1 disabled
; 0001 007A UCSR1B=0x00;
	LDI  R30,LOW(0)
	STS  201,R30
; 0001 007B 
; 0001 007C 
; 0001 007D // Analog Comparator initialization
; 0001 007E // Analog Comparator: Off
; 0001 007F // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0001 0080 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0001 0081 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0001 0082 DIDR1=0x00;
	STS  127,R30
; 0001 0083 
; 0001 0084 // Watchdog Timer initialization
; 0001 0085 // Watchdog Timer Prescaler: OSC/2048
; 0001 0086 #pragma optsize-
; 0001 0087 #asm("wdr")
	WDR
; 0001 0088 // Write 2 consecutive values to enable watchdog
; 0001 0089 // this is NOT a mistake !
; 0001 008A WDTCSR=0x18;
	LDI  R30,LOW(24)
	STS  96,R30
; 0001 008B WDTCSR=0x08;
	LDI  R30,LOW(8)
	STS  96,R30
; 0001 008C #ifdef _OPTIMIZE_SIZE_
; 0001 008D #pragma optsize+
; 0001 008E #endif
; 0001 008F 
; 0001 0090 }
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_rx_buffer0:
	.BYTE 0x8
_tx_buffer0:
	.BYTE 0x8
__seed_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(1500)
	LDI  R27,HIGH(1500)
	RCALL _delay_ms
	CBI  0x5,0
	SBI  0x5,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	CBI  0x5,2
	SBI  0x5,3
	CBI  0x8,1
	SBI  0x8,2
	SBI  0x5,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3:
	CBI  0x5,0
	SBI  0x5,1
	CBI  0x5,2
	SBI  0x5,3
	CBI  0x5,4
	SBI  0x5,5
	CBI  0x5,6
	SBI  0x8,0
	SBI  0x8,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R31,0
	MOVW R16,R30
	__GETWRN 18,19,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+3
	RJMP _get_delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x6:
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL __DIVW21
	STD  Y+12,R30
	STD  Y+12+1,R31
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL __DIVW21
	MOVW R18,R30
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(123)
	LDI  R31,HIGH(123)
	SUB  R30,R26
	SBC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x8:
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xA:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB:
	RCALL _etapa2
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RCALL _delay_ms
	RJMP _etapa3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC:
	RCALL _flash_PS1
	RCALL _etapa4
	RCALL _etapa5
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RCALL _delay_ms
	RJMP _etapa6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	RCALL _etapa8
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RJMP _delay_ms

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	NEG  R27
	NEG  R26
	SBCI R27,0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x1388
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
