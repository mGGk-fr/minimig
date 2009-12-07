
	; HI-TECH PICC-18 STD COMPILER (Microchip PIC micro) V9.51PL2
	; Copyright (C) 1984-2008 HI-TECH Software
	;Serial no. HCPIC18-36668
	;This licence will expire on Tue, 11 Dec 2029

	; Auto-generated runtime startup code for final link stage.

	;
	; Compiler options:
	;
	; --chip=18F252 --ide=hitide --summary=mem,file -G -M --asmlist \
	; --codeoffset=0 --emi=wordwrite --warn=0 --errors=10 --char=unsigned \
	; --double=24 --cp=16 -Bl -Ll --output=+intel --output=-mcof \
	; --runtime=+init --runtime=+clear --runtime=+clib --runtime=+keep \
	; -oMiniMigPic.hex osdFont.obj osd.obj mmc.obj menu.obj main.obj \
	; hdd.obj hardware.obj fileBrowser.obj fat16.obj config.obj boot.obj \
	; adf.obj
	;


	GLOBAL	_main,start,_exit
	FNROOT	_main
	FNCONF	param,?a,?

	pic18cxx	equ	1

	psect	config,class=CONFIG,delta=1
	psect	idloc,class=IDLOC,delta=1
	psect	eeprom_data,class=EEDATA,delta=1
	psect	const,class=CODE,delta=1,reloc=2
	psect	rbss,class=COMRAM,space=1
	psect	bss,class=RAM,space=1
	psect	rdata,class=COMRAM,space=1
	psect	irdata,class=CODE,space=0,reloc=2
	psect	bss,class=RAM,space=1
	psect	data,class=RAM,space=1
	psect	idata,class=CODE,space=0,reloc=2
	psect	nvram,class=NVRAM,space=1
	psect	nvrram,class=COMRAM,space=1
	psect	nvbit,class=COMRAM,bit,space=1
	psect	temp,ovrld,class=COMRAM,space=1
	psect	struct,ovrld,class=COMRAM,space=1
	psect	rbit,class=COMRAM,bit,space=1
	psect	bigbss,class=BIGRAM,space=1
	psect	bigdata,class=BIGRAM,space=1
	psect	ibigdata,class=CODE,space=0,reloc=2
	psect	farbss,class=FARRAM,space=0,reloc=2,delta=1
	psect	fardata,class=FARRAM,space=0,reloc=2,delta=1
	psect	ifardata,class=CODE,space=0,reloc=2,delta=1

	psect	reset_vec,class=CODE,delta=1,reloc=2
	psect	powerup,class=CODE,delta=1,reloc=2
	psect	intcode,class=CODE,delta=1,reloc=2
	psect	intcodelo,class=CODE,delta=1,reloc=2
	psect	intret,class=CODE,delta=1,reloc=2
	psect	intentry,class=CODE,delta=1,reloc=2

	psect	intsave_regs,class=BIGRAM,space=1
	psect	lowtext,class=CODE,delta=1,reloc=2,limit=0ffffh
	psect	init,class=CODE,delta=1,reloc=2
	psect	text,class=CODE,delta=1,reloc=2
global	intlevel0,intlevel1
intlevel0:
intlevel1:
	psect	end_init,class=CODE,delta=1,reloc=2
	psect	clrtext,class=CODE,delta=1,reloc=2

	psect	param,class=RAM,space=1
wreg	EQU	0FE8h
fsr0l	EQU	0FE9h
fsr0h	EQU	0FEAh
fsr1l	EQU	0FE1h
fsr1h	EQU	0FE2h
fsr2l	EQU	0FD9h
fsr2h	EQU	0FDAh
indf0	EQU	0FEFh
postinc0	EQU	0FEEh
postdec0	EQU	0FEDh
postinc1	EQU	0FE6h
postdec1	EQU	0FE5h
postinc2	EQU	0FDEh
postdec2	EQU	0FDDh
tblptrl	EQU	0FF6h
tblptrh	EQU	0FF7h
tblptru	EQU	0FF8h
tablat		EQU	0FF5h
prodl		EQU	0FF3h

	PSECT	ramtop,class=RAM
	global	__S1			; top of RAM usage
	global	__ramtop
	global	__LRAM,__HRAM
__ramtop:

	PSECT	reset_vec
	nop	; NOP for reset vector (precedes GOTO instruction)
	goto	start

	PSECT	init
start:
_exit:
	dw 0xffff	; NOP required for 4000/FETCH errata workaround
; fardata psect  - 0 bytes to load

; farbss psect  - 0 bytes to clear

; clearing bss psect - 826 bytes to clear
GLOBAL	__Lbss
	lfsr	0,__LRAM
	lfsr	1,826	; loop variable
	call	clear_ram

; clearing rbit, rbss psect - 1 bytes to clear
GLOBAL	__Lrbss
	clrf	__Lrbss+0,c

; clearing bigbss psect - 680 bytes to clear
GLOBAL	__Lbigbss
	lfsr	0,__Lbigbss
	lfsr	1,680	; loop variable
	call	clear_ram

; bigdata psect - 1 bytes to load
GLOBAL	__Lbigdata,__Libigdata
	lfsr	0,__Lbigdata
	; load TBLPTR registers with __Libigdata (FFCh)
	movlw	low (__Libigdata)
	movwf	tblptrl
	movlw	low (__Libigdata/100h)
	movwf	tblptrh
	tblrd	*+
	movff	tablat,postinc0

; data psect - 4 bytes to load
GLOBAL	__Ldata,__Lidata
	lfsr	0,__Ldata
	; load TBLPTR registers with __Lidata (FF8h)
	movlw	low (__Lidata)
	movwf	tblptrl
	movlw	low (__Lidata/100h)
	movwf	tblptrh
	lfsr	1,4	; loop variable
; Copy the ROM data image to destination in RAM
copy_data:
	tblrd	*+
	movff	tablat,postinc0
	movf	postdec1,w	;decrement loop variable
	movf	fsr1l,w
	bnz	copy_data
	movf	fsr1h,w
	bnz	copy_data

; rdata psect - 0 bytes to load

	PSECT	end_init
	goto	_main		;go do the main stuff
; Clear these memory locations
clear_ram:
	clrf	postinc0	;clear, increment FSR0
	movf	postdec1,w	;decrement loop variable
	movf	fsr1l,w
	bnz	clear_ram
	movf	fsr1h,w
	bnz	clear_ram
	return

	END	start
