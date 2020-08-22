   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  54                     ; 22 void MCP_23K256_RAM_init( void )
  54                     ; 23 {
  56                     	switch	.text
  57  0000               _MCP_23K256_RAM_init:
  61                     ; 24     GPIO_Init( RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST );
  63  0000 4bf0          	push	#240
  64  0002 4b02          	push	#2
  65  0004 ae5000        	ldw	x,#20480
  66  0007 cd0000        	call	_GPIO_Init
  68  000a 85            	popw	x
  69                     ; 25     delay_ms( 10 );
  71  000b ae000a        	ldw	x,#10
  73                     ; 26 }
  76  000e cc0000        	jp	_delay_ms
 118                     ; 31 void MCP_23K256_RAM_read_status_register( uint8_t *data )
 118                     ; 32 {
 119                     	switch	.text
 120  0011               _MCP_23K256_RAM_read_status_register:
 122  0011 89            	pushw	x
 123       00000000      OFST:	set	0
 126  0012               L14:
 127                     ; 34   while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );
 129  0012 a680          	ld	a,#128
 130  0014 cd0000        	call	_SPI_GetFlagStatus
 132  0017 4d            	tnz	a
 133  0018 26f8          	jrne	L14
 134                     ; 36   GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );
 136  001a 4b02          	push	#2
 137  001c ae5000        	ldw	x,#20480
 138  001f cd0000        	call	_GPIO_WriteLow
 140  0022 84            	pop	a
 141                     ; 38   SPI_SendData( RDSR ); // read ststus reg
 143  0023 a605          	ld	a,#5
 144  0025 cd0000        	call	_SPI_SendData
 147  0028               L74:
 148                     ; 40   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 150  0028 a602          	ld	a,#2
 151  002a cd0000        	call	_SPI_GetFlagStatus
 153  002d 4d            	tnz	a
 154  002e 27f8          	jreq	L74
 156  0030               L55:
 157                     ; 43 while( SPI_GetFlagStatus( SPI_FLAG_RXNE ) == RESET );
 159  0030 a601          	ld	a,#1
 160  0032 cd0000        	call	_SPI_GetFlagStatus
 162  0035 4d            	tnz	a
 163  0036 27f8          	jreq	L55
 164                     ; 44 SPI_SendData( 255 );
 166  0038 a6ff          	ld	a,#255
 167  003a cd0000        	call	_SPI_SendData
 170  003d               L36:
 171                     ; 45 while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 173  003d a602          	ld	a,#2
 174  003f cd0000        	call	_SPI_GetFlagStatus
 176  0042 4d            	tnz	a
 177  0043 27f8          	jreq	L36
 178                     ; 47   *data = SPI_ReceiveData( );
 180  0045 cd0000        	call	_SPI_ReceiveData
 182  0048 1e01          	ldw	x,(OFST+1,sp)
 183  004a f7            	ld	(x),a
 185  004b               L37:
 186                     ; 49   while( ! SPI_GetFlagStatus( SPI_FLAG_RXNE ) );
 188  004b a601          	ld	a,#1
 189  004d cd0000        	call	_SPI_GetFlagStatus
 191  0050 4d            	tnz	a
 192  0051 27f8          	jreq	L37
 193                     ; 53     delay_us( 1 );
 195  0053 ae0001        	ldw	x,#1
 196  0056 cd0000        	call	_delay_us
 198                     ; 55   GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );
 200  0059 4b02          	push	#2
 201  005b ae5000        	ldw	x,#20480
 202  005e cd0000        	call	_GPIO_WriteHigh
 204                     ; 56 }
 207  0061 5b03          	addw	sp,#3
 208  0063 81            	ret	
 248                     ; 65 void MCP_23K256_RAM_write_status_register( uint8_t data )
 248                     ; 66 {
 249                     	switch	.text
 250  0064               _MCP_23K256_RAM_write_status_register:
 252  0064 88            	push	a
 253       00000000      OFST:	set	0
 256  0065               L711:
 257                     ; 68   while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );
 259  0065 a680          	ld	a,#128
 260  0067 cd0000        	call	_SPI_GetFlagStatus
 262  006a 4d            	tnz	a
 263  006b 26f8          	jrne	L711
 264                     ; 70   GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );
 266  006d 4b02          	push	#2
 267  006f ae5000        	ldw	x,#20480
 268  0072 cd0000        	call	_GPIO_WriteLow
 270  0075 84            	pop	a
 271                     ; 73   SPI_SendData( WRSR );
 273  0076 a601          	ld	a,#1
 274  0078 cd0000        	call	_SPI_SendData
 277  007b               L521:
 278                     ; 74   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 280  007b a602          	ld	a,#2
 281  007d cd0000        	call	_SPI_GetFlagStatus
 283  0080 4d            	tnz	a
 284  0081 27f8          	jreq	L521
 285                     ; 77   SPI_SendData( data );
 287  0083 7b01          	ld	a,(OFST+1,sp)
 288  0085 cd0000        	call	_SPI_SendData
 291  0088               L331:
 292                     ; 78   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 294  0088 a602          	ld	a,#2
 295  008a cd0000        	call	_SPI_GetFlagStatus
 297  008d 4d            	tnz	a
 298  008e 27f8          	jreq	L331
 299                     ; 82     delay_us( 1 );
 301  0090 ae0001        	ldw	x,#1
 302  0093 cd0000        	call	_delay_us
 304                     ; 84   GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );
 306  0096 4b02          	push	#2
 307  0098 ae5000        	ldw	x,#20480
 308  009b cd0000        	call	_GPIO_WriteHigh
 310                     ; 86 }
 313  009e 5b02          	addw	sp,#2
 314  00a0 81            	ret	
 372                     ; 91 void MCP_23K256_RAM_write_byte( uint16_t address, unsigned char value )
 372                     ; 92 {
 373                     	switch	.text
 374  00a1               _MCP_23K256_RAM_write_byte:
 376  00a1 89            	pushw	x
 377  00a2 88            	push	a
 378       00000001      OFST:	set	1
 381                     ; 93     uint8_t addr = 0;
 384  00a3               L761:
 385                     ; 95   while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );
 387  00a3 a680          	ld	a,#128
 388  00a5 cd0000        	call	_SPI_GetFlagStatus
 390  00a8 4d            	tnz	a
 391  00a9 26f8          	jrne	L761
 392                     ; 97   GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );
 394  00ab 4b02          	push	#2
 395  00ad ae5000        	ldw	x,#20480
 396  00b0 cd0000        	call	_GPIO_WriteLow
 398  00b3 84            	pop	a
 399                     ; 100   SPI_SendData( WRITE ); // instruction 2 write
 401  00b4 a602          	ld	a,#2
 402  00b6 cd0000        	call	_SPI_SendData
 405  00b9               L571:
 406                     ; 101   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 408  00b9 a602          	ld	a,#2
 409  00bb cd0000        	call	_SPI_GetFlagStatus
 411  00be 4d            	tnz	a
 412  00bf 27f8          	jreq	L571
 413                     ; 104     addr = address >> 8;
 415  00c1 7b02          	ld	a,(OFST+1,sp)
 416  00c3 6b01          	ld	(OFST+0,sp),a
 418                     ; 105   SPI_SendData( addr ); // send 16 bit address // MSB is don't care
 420  00c5 cd0000        	call	_SPI_SendData
 423  00c8               L302:
 424                     ; 106   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 426  00c8 a602          	ld	a,#2
 427  00ca cd0000        	call	_SPI_GetFlagStatus
 429  00cd 4d            	tnz	a
 430  00ce 27f8          	jreq	L302
 431                     ; 109     addr = ( address & 255 );
 433  00d0 7b03          	ld	a,(OFST+2,sp)
 434  00d2 6b01          	ld	(OFST+0,sp),a
 436                     ; 110   SPI_SendData( addr );
 438  00d4 cd0000        	call	_SPI_SendData
 441  00d7               L112:
 442                     ; 111   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 444  00d7 a602          	ld	a,#2
 445  00d9 cd0000        	call	_SPI_GetFlagStatus
 447  00dc 4d            	tnz	a
 448  00dd 27f8          	jreq	L112
 449                     ; 113   SPI_SendData( value );
 451  00df 7b06          	ld	a,(OFST+5,sp)
 452  00e1 cd0000        	call	_SPI_SendData
 455  00e4               L712:
 456                     ; 115   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 458  00e4 a602          	ld	a,#2
 459  00e6 cd0000        	call	_SPI_GetFlagStatus
 461  00e9 4d            	tnz	a
 462  00ea 27f8          	jreq	L712
 463                     ; 119     delay_us( 1 );
 465  00ec ae0001        	ldw	x,#1
 466  00ef cd0000        	call	_delay_us
 468                     ; 121   GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );
 470  00f2 4b02          	push	#2
 471  00f4 ae5000        	ldw	x,#20480
 472  00f7 cd0000        	call	_GPIO_WriteHigh
 474  00fa 84            	pop	a
 475                     ; 122 }
 478  00fb 5b03          	addw	sp,#3
 479  00fd 81            	ret	
 539                     ; 127 void MCP_23K256_RAM_read_byte( uint16_t address, unsigned char *value )
 539                     ; 128 {
 540                     	switch	.text
 541  00fe               _MCP_23K256_RAM_read_byte:
 543  00fe 89            	pushw	x
 544  00ff 88            	push	a
 545       00000001      OFST:	set	1
 548                     ; 129     uint8_t addr = 0;
 551  0100               L352:
 552                     ; 131   while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );
 554  0100 a680          	ld	a,#128
 555  0102 cd0000        	call	_SPI_GetFlagStatus
 557  0105 4d            	tnz	a
 558  0106 26f8          	jrne	L352
 559                     ; 133   GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );
 561  0108 4b02          	push	#2
 562  010a ae5000        	ldw	x,#20480
 563  010d cd0000        	call	_GPIO_WriteLow
 565  0110 84            	pop	a
 566                     ; 135   SPI_SendData( READ ); // instruction 3 read
 568  0111 a603          	ld	a,#3
 569  0113 cd0000        	call	_SPI_SendData
 572  0116               L162:
 573                     ; 137   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 575  0116 a602          	ld	a,#2
 576  0118 cd0000        	call	_SPI_GetFlagStatus
 578  011b 4d            	tnz	a
 579  011c 27f8          	jreq	L162
 580                     ; 140     addr = address >> 8;
 582  011e 7b02          	ld	a,(OFST+1,sp)
 583  0120 6b01          	ld	(OFST+0,sp),a
 585                     ; 141   SPI_SendData( addr ); // send 16 bit address // MSB is don't care
 587  0122 cd0000        	call	_SPI_SendData
 590  0125               L762:
 591                     ; 142   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 593  0125 a602          	ld	a,#2
 594  0127 cd0000        	call	_SPI_GetFlagStatus
 596  012a 4d            	tnz	a
 597  012b 27f8          	jreq	L762
 598                     ; 145     addr = ( address & 255 );
 600  012d 7b03          	ld	a,(OFST+2,sp)
 601  012f 6b01          	ld	(OFST+0,sp),a
 603                     ; 146   SPI_SendData( addr );
 605  0131 cd0000        	call	_SPI_SendData
 608  0134               L572:
 609                     ; 147   while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 611  0134 a602          	ld	a,#2
 612  0136 cd0000        	call	_SPI_GetFlagStatus
 614  0139 4d            	tnz	a
 615  013a 27f8          	jreq	L572
 617  013c               L303:
 618                     ; 151 while( SPI_GetFlagStatus( SPI_FLAG_RXNE ) == RESET );
 620  013c a601          	ld	a,#1
 621  013e cd0000        	call	_SPI_GetFlagStatus
 623  0141 4d            	tnz	a
 624  0142 27f8          	jreq	L303
 625                     ; 152 SPI_SendData( 255 );
 627  0144 a6ff          	ld	a,#255
 628  0146 cd0000        	call	_SPI_SendData
 631  0149               L113:
 632                     ; 153 while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
 634  0149 a602          	ld	a,#2
 635  014b cd0000        	call	_SPI_GetFlagStatus
 637  014e 4d            	tnz	a
 638  014f 27f8          	jreq	L113
 640  0151               L713:
 641                     ; 154 while( ! SPI_GetFlagStatus( SPI_FLAG_RXNE ) );
 643  0151 a601          	ld	a,#1
 644  0153 cd0000        	call	_SPI_GetFlagStatus
 646  0156 4d            	tnz	a
 647  0157 27f8          	jreq	L713
 648                     ; 157     *value = SPI_ReceiveData( );
 650  0159 cd0000        	call	_SPI_ReceiveData
 652  015c 1e06          	ldw	x,(OFST+5,sp)
 653  015e f7            	ld	(x),a
 654                     ; 161     delay_us( 1 );
 656  015f ae0001        	ldw	x,#1
 657  0162 cd0000        	call	_delay_us
 659                     ; 163     GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );
 661  0165 4b02          	push	#2
 662  0167 ae5000        	ldw	x,#20480
 663  016a cd0000        	call	_GPIO_WriteHigh
 665  016d 84            	pop	a
 666                     ; 164 }
 669  016e 5b03          	addw	sp,#3
 670  0170 81            	ret	
 715                     ; 173 void MCP_23K256_RAM_set_all( unsigned char value )
 715                     ; 174 {
 716                     	switch	.text
 717  0171               _MCP_23K256_RAM_set_all:
 719  0171 88            	push	a
 720  0172 89            	pushw	x
 721       00000002      OFST:	set	2
 724                     ; 177     for ( addr = 0; addr < SRAM_SIZE; addr++ )
 726  0173 5f            	clrw	x
 727  0174 1f01          	ldw	(OFST-1,sp),x
 729  0176               L543:
 730                     ; 179         MCP_23K256_RAM_write_byte( addr, value );
 732  0176 7b03          	ld	a,(OFST+1,sp)
 733  0178 88            	push	a
 734  0179 1e02          	ldw	x,(OFST+0,sp)
 735  017b cd00a1        	call	_MCP_23K256_RAM_write_byte
 737  017e 84            	pop	a
 738                     ; 177     for ( addr = 0; addr < SRAM_SIZE; addr++ )
 740  017f 1e01          	ldw	x,(OFST-1,sp)
 741  0181 5c            	incw	x
 742  0182 1f01          	ldw	(OFST-1,sp),x
 746  0184 a37d00        	cpw	x,#32000
 747  0187 25ed          	jrult	L543
 748                     ; 181 }
 751  0189 5b03          	addw	sp,#3
 752  018b 81            	ret	
 765                     	xdef	_MCP_23K256_RAM_set_all
 766                     	xdef	_MCP_23K256_RAM_read_byte
 767                     	xdef	_MCP_23K256_RAM_write_byte
 768                     	xdef	_MCP_23K256_RAM_write_status_register
 769                     	xdef	_MCP_23K256_RAM_read_status_register
 770                     	xdef	_MCP_23K256_RAM_init
 771                     	xref	_delay_ms
 772                     	xref	_delay_us
 773                     	xref	_SPI_GetFlagStatus
 774                     	xref	_SPI_ReceiveData
 775                     	xref	_SPI_SendData
 776                     	xref	_GPIO_WriteLow
 777                     	xref	_GPIO_WriteHigh
 778                     	xref	_GPIO_Init
 779                     	xref	_ADC1_ClearFlag
 780                     	xref	_ADC1_GetFlagStatus
 781                     	xref	_ADC1_StartConversion
 782                     	xref	_ADC1_ScanModeCmd
 801                     	end
