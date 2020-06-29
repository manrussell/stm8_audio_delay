   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  50                     ; 22 void MCP_23K256_RAM_init( void )
  50                     ; 23 {
  52                     	switch	.text
  53  0000               _MCP_23K256_RAM_init:
  57                     ; 24     GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  59  0000 4bf0          	push	#240
  60  0002 4b02          	push	#2
  61  0004 ae5000        	ldw	x,#20480
  62  0007 cd0000        	call	_GPIO_Init
  64  000a 85            	popw	x
  65                     ; 25     delay_ms(10);
  67  000b ae000a        	ldw	x,#10
  69                     ; 26 }
  72  000e cc0000        	jp	_delay_ms
 114                     ; 31 void MCP_23K256_RAM_read_status_register( uint8_t *data )
 114                     ; 32 {
 115                     	switch	.text
 116  0011               _MCP_23K256_RAM_read_status_register:
 118  0011 89            	pushw	x
 119       00000000      OFST:	set	0
 122  0012               L14:
 123                     ; 34   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 125  0012 a680          	ld	a,#128
 126  0014 cd0000        	call	_SPI_GetFlagStatus
 128  0017 4d            	tnz	a
 129  0018 26f8          	jrne	L14
 130                     ; 36   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
 132  001a 4b02          	push	#2
 133  001c ae5000        	ldw	x,#20480
 134  001f cd0000        	call	_GPIO_WriteLow
 136  0022 84            	pop	a
 137                     ; 38   SPI_SendData(RDSR); // read ststus reg
 139  0023 a605          	ld	a,#5
 140  0025 cd0000        	call	_SPI_SendData
 143  0028               L74:
 144                     ; 40   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 146  0028 a602          	ld	a,#2
 147  002a cd0000        	call	_SPI_GetFlagStatus
 149  002d 4d            	tnz	a
 150  002e 27f8          	jreq	L74
 152  0030               L55:
 153                     ; 43 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
 155  0030 a601          	ld	a,#1
 156  0032 cd0000        	call	_SPI_GetFlagStatus
 158  0035 4d            	tnz	a
 159  0036 27f8          	jreq	L55
 160                     ; 44 SPI_SendData( 255 );
 162  0038 a6ff          	ld	a,#255
 163  003a cd0000        	call	_SPI_SendData
 166  003d               L36:
 167                     ; 45 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 169  003d a602          	ld	a,#2
 170  003f cd0000        	call	_SPI_GetFlagStatus
 172  0042 4d            	tnz	a
 173  0043 27f8          	jreq	L36
 174                     ; 47   *data = SPI_ReceiveData();
 176  0045 cd0000        	call	_SPI_ReceiveData
 178  0048 1e01          	ldw	x,(OFST+1,sp)
 179  004a f7            	ld	(x),a
 181  004b               L37:
 182                     ; 49   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
 184  004b a601          	ld	a,#1
 185  004d cd0000        	call	_SPI_GetFlagStatus
 187  0050 4d            	tnz	a
 188  0051 27f8          	jreq	L37
 189                     ; 53     delay_us(1);
 191  0053 ae0001        	ldw	x,#1
 192  0056 cd0000        	call	_delay_us
 194                     ; 55   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
 196  0059 4b02          	push	#2
 197  005b ae5000        	ldw	x,#20480
 198  005e cd0000        	call	_GPIO_WriteHigh
 200                     ; 56 }
 203  0061 5b03          	addw	sp,#3
 204  0063 81            	ret	
 244                     ; 65 void MCP_23K256_RAM_write_status_register( uint8_t data )
 244                     ; 66 {
 245                     	switch	.text
 246  0064               _MCP_23K256_RAM_write_status_register:
 248  0064 88            	push	a
 249       00000000      OFST:	set	0
 252  0065               L711:
 253                     ; 68   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 255  0065 a680          	ld	a,#128
 256  0067 cd0000        	call	_SPI_GetFlagStatus
 258  006a 4d            	tnz	a
 259  006b 26f8          	jrne	L711
 260                     ; 70   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
 262  006d 4b02          	push	#2
 263  006f ae5000        	ldw	x,#20480
 264  0072 cd0000        	call	_GPIO_WriteLow
 266  0075 84            	pop	a
 267                     ; 73   SPI_SendData(WRSR);
 269  0076 a601          	ld	a,#1
 270  0078 cd0000        	call	_SPI_SendData
 273  007b               L521:
 274                     ; 74   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 276  007b a602          	ld	a,#2
 277  007d cd0000        	call	_SPI_GetFlagStatus
 279  0080 4d            	tnz	a
 280  0081 27f8          	jreq	L521
 281                     ; 77   SPI_SendData(data);
 283  0083 7b01          	ld	a,(OFST+1,sp)
 284  0085 cd0000        	call	_SPI_SendData
 287  0088               L331:
 288                     ; 78   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 290  0088 a602          	ld	a,#2
 291  008a cd0000        	call	_SPI_GetFlagStatus
 293  008d 4d            	tnz	a
 294  008e 27f8          	jreq	L331
 295                     ; 82     delay_us(1);
 297  0090 ae0001        	ldw	x,#1
 298  0093 cd0000        	call	_delay_us
 300                     ; 84   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
 302  0096 4b02          	push	#2
 303  0098 ae5000        	ldw	x,#20480
 304  009b cd0000        	call	_GPIO_WriteHigh
 306                     ; 86 }
 309  009e 5b02          	addw	sp,#2
 310  00a0 81            	ret	
 368                     ; 91 void MCP_23K256_RAM_write_byte( uint16_t address, unsigned char value )
 368                     ; 92 {
 369                     	switch	.text
 370  00a1               _MCP_23K256_RAM_write_byte:
 372  00a1 89            	pushw	x
 373  00a2 88            	push	a
 374       00000001      OFST:	set	1
 377                     ; 93     uint8_t addr = 0;
 380  00a3               L761:
 381                     ; 95   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 383  00a3 a680          	ld	a,#128
 384  00a5 cd0000        	call	_SPI_GetFlagStatus
 386  00a8 4d            	tnz	a
 387  00a9 26f8          	jrne	L761
 388                     ; 97   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
 390  00ab 4b02          	push	#2
 391  00ad ae5000        	ldw	x,#20480
 392  00b0 cd0000        	call	_GPIO_WriteLow
 394  00b3 84            	pop	a
 395                     ; 100   SPI_SendData(WRITE); // instruction 2 write
 397  00b4 a602          	ld	a,#2
 398  00b6 cd0000        	call	_SPI_SendData
 401  00b9               L571:
 402                     ; 101   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 404  00b9 a602          	ld	a,#2
 405  00bb cd0000        	call	_SPI_GetFlagStatus
 407  00be 4d            	tnz	a
 408  00bf 27f8          	jreq	L571
 409                     ; 104     addr = address>>8;
 411  00c1 7b02          	ld	a,(OFST+1,sp)
 412  00c3 6b01          	ld	(OFST+0,sp),a
 414                     ; 105   SPI_SendData(addr); // send 16 bit address // MSB is don't care
 416  00c5 cd0000        	call	_SPI_SendData
 419  00c8               L302:
 420                     ; 106   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 422  00c8 a602          	ld	a,#2
 423  00ca cd0000        	call	_SPI_GetFlagStatus
 425  00cd 4d            	tnz	a
 426  00ce 27f8          	jreq	L302
 427                     ; 109     addr = (address&255);
 429  00d0 7b03          	ld	a,(OFST+2,sp)
 430  00d2 6b01          	ld	(OFST+0,sp),a
 432                     ; 110   SPI_SendData( addr );
 434  00d4 cd0000        	call	_SPI_SendData
 437  00d7               L112:
 438                     ; 111   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 440  00d7 a602          	ld	a,#2
 441  00d9 cd0000        	call	_SPI_GetFlagStatus
 443  00dc 4d            	tnz	a
 444  00dd 27f8          	jreq	L112
 445                     ; 113   SPI_SendData(value);
 447  00df 7b06          	ld	a,(OFST+5,sp)
 448  00e1 cd0000        	call	_SPI_SendData
 451  00e4               L712:
 452                     ; 115   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 454  00e4 a602          	ld	a,#2
 455  00e6 cd0000        	call	_SPI_GetFlagStatus
 457  00e9 4d            	tnz	a
 458  00ea 27f8          	jreq	L712
 459                     ; 119     delay_us(1);
 461  00ec ae0001        	ldw	x,#1
 462  00ef cd0000        	call	_delay_us
 464                     ; 121   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
 466  00f2 4b02          	push	#2
 467  00f4 ae5000        	ldw	x,#20480
 468  00f7 cd0000        	call	_GPIO_WriteHigh
 470  00fa 84            	pop	a
 471                     ; 124 }
 474  00fb 5b03          	addw	sp,#3
 475  00fd 81            	ret	
 535                     ; 129 void MCP_23K256_RAM_read_byte( uint16_t address, unsigned char *value )
 535                     ; 130 {
 536                     	switch	.text
 537  00fe               _MCP_23K256_RAM_read_byte:
 539  00fe 89            	pushw	x
 540  00ff 88            	push	a
 541       00000001      OFST:	set	1
 544                     ; 131     uint8_t addr = 0;
 547  0100               L352:
 548                     ; 133   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 550  0100 a680          	ld	a,#128
 551  0102 cd0000        	call	_SPI_GetFlagStatus
 553  0105 4d            	tnz	a
 554  0106 26f8          	jrne	L352
 555                     ; 135   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
 557  0108 4b02          	push	#2
 558  010a ae5000        	ldw	x,#20480
 559  010d cd0000        	call	_GPIO_WriteLow
 561  0110 84            	pop	a
 562                     ; 137   SPI_SendData(READ); // instruction 3 read
 564  0111 a603          	ld	a,#3
 565  0113 cd0000        	call	_SPI_SendData
 568  0116               L162:
 569                     ; 139   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 571  0116 a602          	ld	a,#2
 572  0118 cd0000        	call	_SPI_GetFlagStatus
 574  011b 4d            	tnz	a
 575  011c 27f8          	jreq	L162
 576                     ; 142     addr = address>>8;
 578  011e 7b02          	ld	a,(OFST+1,sp)
 579  0120 6b01          	ld	(OFST+0,sp),a
 581                     ; 143   SPI_SendData(addr); // send 16 bit address // MSB is don't care
 583  0122 cd0000        	call	_SPI_SendData
 586  0125               L762:
 587                     ; 144   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 589  0125 a602          	ld	a,#2
 590  0127 cd0000        	call	_SPI_GetFlagStatus
 592  012a 4d            	tnz	a
 593  012b 27f8          	jreq	L762
 594                     ; 147     addr = (address&255);
 596  012d 7b03          	ld	a,(OFST+2,sp)
 597  012f 6b01          	ld	(OFST+0,sp),a
 599                     ; 148   SPI_SendData( addr );
 601  0131 cd0000        	call	_SPI_SendData
 604  0134               L572:
 605                     ; 149   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 607  0134 a602          	ld	a,#2
 608  0136 cd0000        	call	_SPI_GetFlagStatus
 610  0139 4d            	tnz	a
 611  013a 27f8          	jreq	L572
 613  013c               L303:
 614                     ; 153 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
 616  013c a601          	ld	a,#1
 617  013e cd0000        	call	_SPI_GetFlagStatus
 619  0141 4d            	tnz	a
 620  0142 27f8          	jreq	L303
 621                     ; 154 SPI_SendData( 255 );
 623  0144 a6ff          	ld	a,#255
 624  0146 cd0000        	call	_SPI_SendData
 627  0149               L113:
 628                     ; 155 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 630  0149 a602          	ld	a,#2
 631  014b cd0000        	call	_SPI_GetFlagStatus
 633  014e 4d            	tnz	a
 634  014f 27f8          	jreq	L113
 636  0151               L713:
 637                     ; 156 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
 639  0151 a601          	ld	a,#1
 640  0153 cd0000        	call	_SPI_GetFlagStatus
 642  0156 4d            	tnz	a
 643  0157 27f8          	jreq	L713
 644                     ; 159     *value = SPI_ReceiveData();
 646  0159 cd0000        	call	_SPI_ReceiveData
 648  015c 1e06          	ldw	x,(OFST+5,sp)
 649  015e f7            	ld	(x),a
 650                     ; 163     delay_us(1);
 652  015f ae0001        	ldw	x,#1
 653  0162 cd0000        	call	_delay_us
 655                     ; 165     GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
 657  0165 4b02          	push	#2
 658  0167 ae5000        	ldw	x,#20480
 659  016a cd0000        	call	_GPIO_WriteHigh
 661  016d 84            	pop	a
 662                     ; 166 }
 665  016e 5b03          	addw	sp,#3
 666  0170 81            	ret	
 679                     	xdef	_MCP_23K256_RAM_read_byte
 680                     	xdef	_MCP_23K256_RAM_write_byte
 681                     	xdef	_MCP_23K256_RAM_write_status_register
 682                     	xdef	_MCP_23K256_RAM_read_status_register
 683                     	xdef	_MCP_23K256_RAM_init
 684                     	xref	_delay_ms
 685                     	xref	_delay_us
 686                     	xref	_SPI_GetFlagStatus
 687                     	xref	_SPI_ReceiveData
 688                     	xref	_SPI_SendData
 689                     	xref	_GPIO_WriteLow
 690                     	xref	_GPIO_WriteHigh
 691                     	xref	_GPIO_Init
 710                     	end
