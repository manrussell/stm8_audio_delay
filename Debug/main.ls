   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 144                     ; 78 void main( void )
 144                     ; 79 {
 146                     	switch	.text
 147  0000               _main:
 149  0000 520f          	subw	sp,#15
 150       0000000f      OFST:	set	15
 153                     ; 80     uint16_t adc_leftChannel = 0;
 155                     ; 81     uint16_t adc_feedback    = 0;
 157                     ; 82     uint16_t adc_delay       = 0;
 159                     ; 83     uint8_t  mapd_value      = 0;    // mapped adc valu
 161                     ; 84     uint8_t  read_val        = 0;    // read val from ram
 163  0002 0f08          	clr	(OFST-7,sp)
 165                     ; 85     uint16_t write_addr      = 0;    // write addr in ram
 167  0004 5f            	clrw	x
 168  0005 1f0c          	ldw	(OFST-3,sp),x
 170                     ; 86     uint16_t read_addr       = 0;    // read addr in val
 172  0007 1f09          	ldw	(OFST-6,sp),x
 174                     ; 87     uint16_t delay           = 110;  // length of delay in samples
 176                     ; 88     uint8_t  res             = 0;
 178                     ; 90     clock_setup();
 180  0009 ad77          	call	_clock_setup
 182                     ; 91     GPIO_setup();
 184  000b cd00e2        	call	_GPIO_setup
 186                     ; 92     ADC1_setup();
 188  000e cd0105        	call	_ADC1_setup
 190                     ; 93     SPI_setup();
 192  0011 cd0142        	call	_SPI_setup
 194                     ; 94     MCP_23K256_RAM_init();
 196  0014 cd0000        	call	_MCP_23K256_RAM_init
 198                     ; 95     MCP4901_DAC_init();
 200  0017 cd0000        	call	_MCP4901_DAC_init
 202  001a               L76:
 203                     ; 129         ADC1_ScanModeCmd( ENABLE );
 205  001a a601          	ld	a,#1
 206  001c cd0000        	call	_ADC1_ScanModeCmd
 208                     ; 130         ADC1_StartConversion( );
 210  001f cd0000        	call	_ADC1_StartConversion
 213  0022               L57:
 214                     ; 131         while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 216  0022 a680          	ld	a,#128
 217  0024 cd0000        	call	_ADC1_GetFlagStatus
 219  0027 4d            	tnz	a
 220  0028 27f8          	jreq	L57
 221                     ; 132         ADC1_ClearFlag(ADC1_FLAG_EOC);
 223  002a a680          	ld	a,#128
 224  002c cd0000        	call	_ADC1_ClearFlag
 226                     ; 133         adc_leftChannel = ADC1_GetBufferValue( 0); //ADC_LEFTCHANNEL );     // 0
 228  002f 4f            	clr	a
 229  0030 cd0000        	call	_ADC1_GetBufferValue
 231  0033 1f06          	ldw	(OFST-9,sp),x
 233                     ; 134         adc_delay       = ADC1_GetBufferValue( 1); //ADC_FEEDBACK_AMOUNT ); // 1
 235  0035 a601          	ld	a,#1
 236  0037 cd0000        	call	_ADC1_GetBufferValue
 239                     ; 139         delay = ( adc_delay << 2 ); //(adc_delay >> 2);
 241  003a 58            	sllw	x
 242  003b 58            	sllw	x
 243  003c 1f0e          	ldw	(OFST-1,sp),x
 245                     ; 146         mapd_value = (adc_leftChannel >> 2);
 247  003e 1e06          	ldw	x,(OFST-9,sp)
 248  0040 54            	srlw	x
 249  0041 54            	srlw	x
 250  0042 01            	rrwa	x,a
 251  0043 6b0b          	ld	(OFST-4,sp),a
 253                     ; 149         mapd_value = mapd_value/2 +  read_val/2;
 255  0045 5f            	clrw	x
 256  0046 7b08          	ld	a,(OFST-7,sp)
 257  0048 97            	ld	xl,a
 258  0049 57            	sraw	x
 259  004a 1f01          	ldw	(OFST-14,sp),x
 261  004c 5f            	clrw	x
 262  004d 7b0b          	ld	a,(OFST-4,sp)
 263  004f 97            	ld	xl,a
 264  0050 57            	sraw	x
 265  0051 72fb01        	addw	x,(OFST-14,sp)
 266  0054 01            	rrwa	x,a
 267  0055 6b0b          	ld	(OFST-4,sp),a
 269                     ; 160             read_addr = write_addr - delay;
 271  0057 1e0c          	ldw	x,(OFST-3,sp)
 272  0059 72f00e        	subw	x,(OFST-1,sp)
 273  005c 1f09          	ldw	(OFST-6,sp),x
 275                     ; 164         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 277  005e 88            	push	a
 278  005f 1e0d          	ldw	x,(OFST-2,sp)
 279  0061 cd0000        	call	_MCP_23K256_RAM_write_byte
 281  0064 84            	pop	a
 282                     ; 167         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 284  0065 96            	ldw	x,sp
 285  0066 1c0008        	addw	x,#OFST-7
 286  0069 89            	pushw	x
 287  006a 1e0b          	ldw	x,(OFST-4,sp)
 288  006c cd0000        	call	_MCP_23K256_RAM_read_byte
 290  006f 85            	popw	x
 291                     ; 170         MCP4901_DAC_write(read_val);
 293  0070 7b08          	ld	a,(OFST-7,sp)
 294  0072 cd0000        	call	_MCP4901_DAC_write
 296                     ; 173         write_addr++;
 298  0075 1e0c          	ldw	x,(OFST-3,sp)
 299  0077 5c            	incw	x
 300  0078 1f0c          	ldw	(OFST-3,sp),x
 302                     ; 176         delay_us(90);
 304  007a ae005a        	ldw	x,#90
 305  007d cd0000        	call	_delay_us
 308  0080 2098          	jra	L76
 341                     ; 182 void clock_setup(void)
 341                     ; 183 {
 342                     	switch	.text
 343  0082               _clock_setup:
 347                     ; 184   CLK_DeInit();
 349  0082 cd0000        	call	_CLK_DeInit
 351                     ; 186   CLK_HSECmd(DISABLE);
 353  0085 4f            	clr	a
 354  0086 cd0000        	call	_CLK_HSECmd
 356                     ; 187   CLK_LSICmd(DISABLE);
 358  0089 4f            	clr	a
 359  008a cd0000        	call	_CLK_LSICmd
 361                     ; 188   CLK_HSICmd(ENABLE);
 363  008d a601          	ld	a,#1
 364  008f cd0000        	call	_CLK_HSICmd
 367  0092               L311:
 368                     ; 189   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 370  0092 ae0102        	ldw	x,#258
 371  0095 cd0000        	call	_CLK_GetFlagStatus
 373  0098 4d            	tnz	a
 374  0099 27f7          	jreq	L311
 375                     ; 191   CLK_ClockSwitchCmd(ENABLE);
 377  009b a601          	ld	a,#1
 378  009d cd0000        	call	_CLK_ClockSwitchCmd
 380                     ; 192   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 382  00a0 4f            	clr	a
 383  00a1 cd0000        	call	_CLK_HSIPrescalerConfig
 385                     ; 193   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 387  00a4 a680          	ld	a,#128
 388  00a6 cd0000        	call	_CLK_SYSCLKConfig
 390                     ; 195   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 392  00a9 4b01          	push	#1
 393  00ab 4b00          	push	#0
 394  00ad ae01e1        	ldw	x,#481
 395  00b0 cd0000        	call	_CLK_ClockSwitchConfig
 397  00b3 85            	popw	x
 398                     ; 197   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 400  00b4 5f            	clrw	x
 401  00b5 cd0000        	call	_CLK_PeripheralClockConfig
 403                     ; 198   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 405  00b8 ae0101        	ldw	x,#257
 406  00bb cd0000        	call	_CLK_PeripheralClockConfig
 408                     ; 199   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 410  00be ae0300        	ldw	x,#768
 411  00c1 cd0000        	call	_CLK_PeripheralClockConfig
 413                     ; 200   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 415  00c4 ae1200        	ldw	x,#4608
 416  00c7 cd0000        	call	_CLK_PeripheralClockConfig
 418                     ; 201   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 420  00ca ae1301        	ldw	x,#4865
 421  00cd cd0000        	call	_CLK_PeripheralClockConfig
 423                     ; 202   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 425  00d0 ae0700        	ldw	x,#1792
 426  00d3 cd0000        	call	_CLK_PeripheralClockConfig
 428                     ; 203   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 430  00d6 ae0501        	ldw	x,#1281
 431  00d9 cd0000        	call	_CLK_PeripheralClockConfig
 433                     ; 204   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 435  00dc ae0400        	ldw	x,#1024
 437                     ; 206 }
 440  00df cc0000        	jp	_CLK_PeripheralClockConfig
 465                     ; 208 void GPIO_setup(void)
 465                     ; 209 {
 466                     	switch	.text
 467  00e2               _GPIO_setup:
 471                     ; 210   GPIO_DeInit(GPIOC);
 473  00e2 ae500a        	ldw	x,#20490
 474  00e5 cd0000        	call	_GPIO_DeInit
 476                     ; 215     GPIO_DeInit(ADC_port);
 478  00e8 ae5005        	ldw	x,#20485
 479  00eb cd0000        	call	_GPIO_DeInit
 481                     ; 221     GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
 483  00ee 4b00          	push	#0
 484  00f0 4b0f          	push	#15
 485  00f2 ae5005        	ldw	x,#20485
 486  00f5 cd0000        	call	_GPIO_Init
 488  00f8 85            	popw	x
 489                     ; 226     GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ),
 489                     ; 227                GPIO_MODE_OUT_PP_HIGH_FAST);
 491  00f9 4bf0          	push	#240
 492  00fb 4b60          	push	#96
 493  00fd ae500a        	ldw	x,#20490
 494  0100 cd0000        	call	_GPIO_Init
 496  0103 85            	popw	x
 497                     ; 228 }
 500  0104 81            	ret	
 528                     ; 256 void ADC1_setup(void)
 528                     ; 257 {
 529                     	switch	.text
 530  0105               _ADC1_setup:
 534                     ; 258   ADC1_DeInit();
 536  0105 cd0000        	call	_ADC1_DeInit
 538                     ; 260   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 538                     ; 261   ADC1_CHANNEL_0,\
 538                     ; 262   ADC1_PRESSEL_FCPU_D18, \
 538                     ; 263   ADC1_EXTTRIG_GPIO, \
 538                     ; 264   DISABLE, \
 538                     ; 265   ADC1_ALIGN_RIGHT, \
 538                     ; 266   ADC1_SCHMITTTRIG_CHANNEL0, \
 538                     ; 267   DISABLE);
 540  0108 4b00          	push	#0
 541  010a 4b00          	push	#0
 542  010c 4b08          	push	#8
 543  010e 4b00          	push	#0
 544  0110 4b10          	push	#16
 545  0112 4b70          	push	#112
 546  0114 5f            	clrw	x
 547  0115 cd0000        	call	_ADC1_Init
 549  0118 5b06          	addw	sp,#6
 550                     ; 269   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 550                     ; 270   ADC1_CHANNEL_1,\
 550                     ; 271   ADC1_PRESSEL_FCPU_D18, \
 550                     ; 272   ADC1_EXTTRIG_GPIO, \
 550                     ; 273   DISABLE, \
 550                     ; 274   ADC1_ALIGN_RIGHT, \
 550                     ; 275   ADC1_SCHMITTTRIG_CHANNEL1, \
 550                     ; 276   DISABLE);
 552  011a 4b00          	push	#0
 553  011c 4b01          	push	#1
 554  011e 4b08          	push	#8
 555  0120 4b00          	push	#0
 556  0122 4b10          	push	#16
 557  0124 4b70          	push	#112
 558  0126 ae0001        	ldw	x,#1
 559  0129 cd0000        	call	_ADC1_Init
 561  012c 5b06          	addw	sp,#6
 562                     ; 278   ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);
 564  012e 4b08          	push	#8
 565  0130 ae0001        	ldw	x,#1
 566  0133 cd0000        	call	_ADC1_ConversionConfig
 568  0136 84            	pop	a
 569                     ; 280   ADC1_DataBufferCmd(ENABLE);
 571  0137 a601          	ld	a,#1
 572  0139 cd0000        	call	_ADC1_DataBufferCmd
 574                     ; 281   ADC1_Cmd(ENABLE);
 576  013c a601          	ld	a,#1
 578                     ; 283 }
 581  013e cc0000        	jp	_ADC1_Cmd
 604                     ; 288 void TIM2_setup(void)
 604                     ; 289 {
 605                     	switch	.text
 606  0141               _TIM2_setup:
 610                     ; 301 }
 613  0141 81            	ret	
 639                     ; 306 void SPI_setup(void)
 639                     ; 307 {
 640                     	switch	.text
 641  0142               _SPI_setup:
 645                     ; 308   SPI_DeInit();
 647  0142 cd0000        	call	_SPI_DeInit
 649                     ; 313   SPI_Init(SPI_FIRSTBIT_MSB, \
 649                     ; 314     SPI_BAUDRATEPRESCALER_16, \
 649                     ; 315     SPI_MODE_MASTER, \
 649                     ; 316     SPI_CLOCKPOLARITY_LOW, \
 649                     ; 317     SPI_CLOCKPHASE_1EDGE, \
 649                     ; 318     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 649                     ; 319     SPI_NSS_SOFT, \
 649                     ; 320     0x0);
 651  0145 4b00          	push	#0
 652  0147 4b02          	push	#2
 653  0149 4b00          	push	#0
 654  014b 4b00          	push	#0
 655  014d 4b00          	push	#0
 656  014f 4b04          	push	#4
 657  0151 ae0018        	ldw	x,#24
 658  0154 cd0000        	call	_SPI_Init
 660  0157 5b06          	addw	sp,#6
 661                     ; 322   SPI_Cmd(ENABLE);
 663  0159 a601          	ld	a,#1
 665                     ; 323 }
 668  015b cc0000        	jp	_SPI_Cmd
 681                     	xdef	_TIM2_setup
 682                     	xdef	_main
 683                     	xdef	_ADC1_setup
 684                     	xdef	_SPI_setup
 685                     	xdef	_GPIO_setup
 686                     	xdef	_clock_setup
 687                     	xref	_MCP_23K256_RAM_read_byte
 688                     	xref	_MCP_23K256_RAM_write_byte
 689                     	xref	_MCP_23K256_RAM_init
 690                     	xref	_MCP4901_DAC_write
 691                     	xref	_MCP4901_DAC_init
 692                     	xref	_delay_us
 693                     	xref	_SPI_Cmd
 694                     	xref	_SPI_Init
 695                     	xref	_SPI_DeInit
 696                     	xref	_GPIO_Init
 697                     	xref	_GPIO_DeInit
 698                     	xref	_CLK_GetFlagStatus
 699                     	xref	_CLK_SYSCLKConfig
 700                     	xref	_CLK_HSIPrescalerConfig
 701                     	xref	_CLK_ClockSwitchConfig
 702                     	xref	_CLK_PeripheralClockConfig
 703                     	xref	_CLK_ClockSwitchCmd
 704                     	xref	_CLK_LSICmd
 705                     	xref	_CLK_HSICmd
 706                     	xref	_CLK_HSECmd
 707                     	xref	_CLK_DeInit
 708                     	xref	_ADC1_ClearFlag
 709                     	xref	_ADC1_GetFlagStatus
 710                     	xref	_ADC1_GetBufferValue
 711                     	xref	_ADC1_StartConversion
 712                     	xref	_ADC1_ConversionConfig
 713                     	xref	_ADC1_DataBufferCmd
 714                     	xref	_ADC1_ScanModeCmd
 715                     	xref	_ADC1_Cmd
 716                     	xref	_ADC1_Init
 717                     	xref	_ADC1_DeInit
 736                     	end
