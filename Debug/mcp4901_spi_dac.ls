   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  52                     ; 23 void MCP4901_DAC_init( void )
  52                     ; 24 {
  54                     	switch	.text
  55  0000               _MCP4901_DAC_init:
  59                     ; 25   GPIO_Init( DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST );
  61  0000 4bf0          	push	#240
  62  0002 4b10          	push	#16
  63  0004 ae500a        	ldw	x,#20490
  64  0007 cd0000        	call	_GPIO_Init
  66  000a 85            	popw	x
  67                     ; 26   delay_ms( 10 );
  69  000b ae000a        	ldw	x,#10
  71                     ; 27 }
  74  000e cc0000        	jp	_delay_ms
 122                     ; 32 void MCP4901_DAC_write( unsigned char value )
 122                     ; 33 {
 123                     	switch	.text
 124  0011               _MCP4901_DAC_write:
 126  0011 88            	push	a
 127  0012 88            	push	a
 128       00000001      OFST:	set	1
 131                     ; 61     unsigned char address = 0x30;   // 00,11,00,00
 133  0013 a630          	ld	a,#48
 134  0015 6b01          	ld	(OFST+0,sp),a
 136                     ; 62     address |= ( value >> 4 );      // assume 0's shoved in the left
 138  0017 7b02          	ld	a,(OFST+1,sp)
 139  0019 4e            	swap	a
 140  001a a40f          	and	a,#15
 141  001c 1a01          	or	a,(OFST+0,sp)
 142  001e 6b01          	ld	(OFST+0,sp),a
 144                     ; 64     value = ( value << 4 );         // assume 0 shoved in from the right
 146  0020 7b02          	ld	a,(OFST+1,sp)
 147  0022 4e            	swap	a
 148  0023 a4f0          	and	a,#240
 149  0025 6b02          	ld	(OFST+1,sp),a
 151  0027               L54:
 152                     ; 67     while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );
 154  0027 a680          	ld	a,#128
 155  0029 cd0000        	call	_SPI_GetFlagStatus
 157  002c 4d            	tnz	a
 158  002d 26f8          	jrne	L54
 159                     ; 68     GPIO_WriteLow( DAC_CS_port, DAC_CS_pin );
 161  002f 4b10          	push	#16
 162  0031 ae500a        	ldw	x,#20490
 163  0034 cd0000        	call	_GPIO_WriteLow
 165  0037 84            	pop	a
 166                     ; 70     SPI_SendData( address );
 168  0038 7b01          	ld	a,(OFST+0,sp)
 169  003a cd0000        	call	_SPI_SendData
 172  003d               L35:
 173                     ; 71     while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 175  003d a602          	ld	a,#2
 176  003f cd0000        	call	_SPI_GetFlagStatus
 178  0042 4d            	tnz	a
 179  0043 27f8          	jreq	L35
 180                     ; 73     SPI_SendData( value );
 182  0045 7b02          	ld	a,(OFST+1,sp)
 183  0047 cd0000        	call	_SPI_SendData
 186  004a               L16:
 187                     ; 74     while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 189  004a a602          	ld	a,#2
 190  004c cd0000        	call	_SPI_GetFlagStatus
 192  004f 4d            	tnz	a
 193  0050 27f8          	jreq	L16
 194                     ; 78     delay_us( 1 );
 196  0052 ae0001        	ldw	x,#1
 197  0055 cd0000        	call	_delay_us
 199                     ; 84   GPIO_WriteHigh( DAC_CS_port, DAC_CS_pin );
 201  0058 4b10          	push	#16
 202  005a ae500a        	ldw	x,#20490
 203  005d cd0000        	call	_GPIO_WriteHigh
 205                     ; 86 }
 208  0060 5b03          	addw	sp,#3
 209  0062 81            	ret	
 222                     	xdef	_MCP4901_DAC_write
 223                     	xdef	_MCP4901_DAC_init
 224                     	xref	_delay_ms
 225                     	xref	_delay_us
 226                     	xref	_SPI_GetFlagStatus
 227                     	xref	_SPI_SendData
 228                     	xref	_GPIO_WriteLow
 229                     	xref	_GPIO_WriteHigh
 230                     	xref	_GPIO_Init
 231                     	xref	_ADC1_ClearFlag
 232                     	xref	_ADC1_GetFlagStatus
 233                     	xref	_ADC1_StartConversion
 234                     	xref	_ADC1_ScanModeCmd
 253                     	end
