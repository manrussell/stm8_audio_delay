   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  48                     ; 23 void MCP4901_DAC_init( void )
  48                     ; 24 {
  50                     	switch	.text
  51  0000               _MCP4901_DAC_init:
  55                     ; 25   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  57  0000 4bf0          	push	#240
  58  0002 4b10          	push	#16
  59  0004 ae500a        	ldw	x,#20490
  60  0007 cd0000        	call	_GPIO_Init
  62  000a 85            	popw	x
  63                     ; 26   delay_ms(10);
  65  000b ae000a        	ldw	x,#10
  67                     ; 27 }
  70  000e cc0000        	jp	_delay_ms
 118                     ; 32 void MCP4901_DAC_write( unsigned char value )
 118                     ; 33 {
 119                     	switch	.text
 120  0011               _MCP4901_DAC_write:
 122  0011 88            	push	a
 123  0012 88            	push	a
 124       00000001      OFST:	set	1
 127                     ; 61     unsigned char address = 0x30; // 00,11,00,00
 129  0013 a630          	ld	a,#48
 130  0015 6b01          	ld	(OFST+0,sp),a
 132                     ; 62     address |= ( value>>4); // assume 0's shoved in the left
 134  0017 7b02          	ld	a,(OFST+1,sp)
 135  0019 4e            	swap	a
 136  001a a40f          	and	a,#15
 137  001c 1a01          	or	a,(OFST+0,sp)
 138  001e 6b01          	ld	(OFST+0,sp),a
 140                     ; 64     value = ( value<<4 ); // assume 0 shoved in from the right
 142  0020 7b02          	ld	a,(OFST+1,sp)
 143  0022 4e            	swap	a
 144  0023 a4f0          	and	a,#240
 145  0025 6b02          	ld	(OFST+1,sp),a
 147  0027               L54:
 148                     ; 67   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 150  0027 a680          	ld	a,#128
 151  0029 cd0000        	call	_SPI_GetFlagStatus
 153  002c 4d            	tnz	a
 154  002d 26f8          	jrne	L54
 155                     ; 69   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
 157  002f 4b10          	push	#16
 158  0031 ae500a        	ldw	x,#20490
 159  0034 cd0000        	call	_GPIO_WriteLow
 161  0037 84            	pop	a
 162                     ; 71   SPI_SendData(address);
 164  0038 7b01          	ld	a,(OFST+0,sp)
 165  003a cd0000        	call	_SPI_SendData
 168  003d               L35:
 169                     ; 73   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 171  003d a602          	ld	a,#2
 172  003f cd0000        	call	_SPI_GetFlagStatus
 174  0042 4d            	tnz	a
 175  0043 27f8          	jreq	L35
 176                     ; 75   SPI_SendData(value);
 178  0045 7b02          	ld	a,(OFST+1,sp)
 179  0047 cd0000        	call	_SPI_SendData
 182  004a               L16:
 183                     ; 77   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 185  004a a602          	ld	a,#2
 186  004c cd0000        	call	_SPI_GetFlagStatus
 188  004f 4d            	tnz	a
 189  0050 27f8          	jreq	L16
 190                     ; 81     delay_us(1);
 192  0052 ae0001        	ldw	x,#1
 193  0055 cd0000        	call	_delay_us
 195                     ; 88   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
 197  0058 4b10          	push	#16
 198  005a ae500a        	ldw	x,#20490
 199  005d cd0000        	call	_GPIO_WriteHigh
 201                     ; 90 }
 204  0060 5b03          	addw	sp,#3
 205  0062 81            	ret	
 218                     	xdef	_MCP4901_DAC_write
 219                     	xdef	_MCP4901_DAC_init
 220                     	xref	_delay_ms
 221                     	xref	_delay_us
 222                     	xref	_SPI_GetFlagStatus
 223                     	xref	_SPI_SendData
 224                     	xref	_GPIO_WriteLow
 225                     	xref	_GPIO_WriteHigh
 226                     	xref	_GPIO_Init
 245                     	end
