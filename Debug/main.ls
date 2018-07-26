   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  77                     ; 56 void main(void)
  77                     ; 57 {
  79                     	switch	.text
  80  0000               _main:
  82  0000 5204          	subw	sp,#4
  83       00000004      OFST:	set	4
  86                     ; 58 	uint16_t x = 8;
  88                     ; 59 	uint16_t y = 0;
  90                     ; 62 	clock_setup();
  92  0002 ad40          	call	_clock_setup
  94                     ; 63 	GPIO_setup();
  96  0004 cd00a4        	call	_GPIO_setup
  98                     ; 64 	ADC1_setup();
 100  0007 cd00c7        	call	_ADC1_setup
 102                     ; 66 	SPI_setup();	
 104  000a cd0103        	call	_SPI_setup
 106                     ; 67 	MAX72xx_init();
 108  000d cd011f        	call	_MAX72xx_init
 110  0010               L33:
 111                     ; 89 			ADC1_StartConversion();
 113  0010 cd0000        	call	_ADC1_StartConversion
 116  0013               L14:
 117                     ; 90 			while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 119  0013 a680          	ld	a,#128
 120  0015 cd0000        	call	_ADC1_GetFlagStatus
 122  0018 4d            	tnz	a
 123  0019 27f8          	jreq	L14
 124                     ; 92 			x = ADC1_GetConversionValue(); // for led knob
 126  001b cd0000        	call	_ADC1_GetConversionValue
 128  001e 1f03          	ldw	(OFST-1,sp),x
 130                     ; 93 			ADC1_ClearFlag(ADC1_FLAG_EOC);
 132  0020 a680          	ld	a,#128
 133  0022 cd0000        	call	_ADC1_ClearFlag
 135                     ; 100 			x = 0.25 *(float)x ; // do i need the float or not ???
 137  0025 1e03          	ldw	x,(OFST-1,sp)
 138  0027 cd0000        	call	c_uitof
 140  002a ae0004        	ldw	x,#L15
 141  002d cd0000        	call	c_fmul
 143  0030 cd0000        	call	c_ftoi
 145  0033 1f03          	ldw	(OFST-1,sp),x
 147                     ; 104 		MAX72xx_write(0,x);
 149  0035 5f            	clrw	x
 150  0036 7b04          	ld	a,(OFST+0,sp)
 151  0038 97            	ld	xl,a
 152  0039 cd012f        	call	_MAX72xx_write
 154                     ; 107 		delay_us(90);
 156  003c ae005a        	ldw	x,#90
 157  003f cd017f        	call	_delay_us
 160  0042 20cc          	jra	L33
 193                     ; 114 void clock_setup(void)
 193                     ; 115 {
 194                     	switch	.text
 195  0044               _clock_setup:
 199                     ; 116   CLK_DeInit();
 201  0044 cd0000        	call	_CLK_DeInit
 203                     ; 118   CLK_HSECmd(DISABLE);
 205  0047 4f            	clr	a
 206  0048 cd0000        	call	_CLK_HSECmd
 208                     ; 119   CLK_LSICmd(DISABLE);
 210  004b 4f            	clr	a
 211  004c cd0000        	call	_CLK_LSICmd
 213                     ; 120   CLK_HSICmd(ENABLE);
 215  004f a601          	ld	a,#1
 216  0051 cd0000        	call	_CLK_HSICmd
 219  0054               L76:
 220                     ; 121   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 222  0054 ae0102        	ldw	x,#258
 223  0057 cd0000        	call	_CLK_GetFlagStatus
 225  005a 4d            	tnz	a
 226  005b 27f7          	jreq	L76
 227                     ; 123   CLK_ClockSwitchCmd(ENABLE);
 229  005d a601          	ld	a,#1
 230  005f cd0000        	call	_CLK_ClockSwitchCmd
 232                     ; 124   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 234  0062 4f            	clr	a
 235  0063 cd0000        	call	_CLK_HSIPrescalerConfig
 237                     ; 125   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 239  0066 a680          	ld	a,#128
 240  0068 cd0000        	call	_CLK_SYSCLKConfig
 242                     ; 127   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 244  006b 4b01          	push	#1
 245  006d 4b00          	push	#0
 246  006f ae01e1        	ldw	x,#481
 247  0072 cd0000        	call	_CLK_ClockSwitchConfig
 249  0075 85            	popw	x
 250                     ; 129   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 252  0076 5f            	clrw	x
 253  0077 cd0000        	call	_CLK_PeripheralClockConfig
 255                     ; 130   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 257  007a ae0101        	ldw	x,#257
 258  007d cd0000        	call	_CLK_PeripheralClockConfig
 260                     ; 131   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 262  0080 ae0300        	ldw	x,#768
 263  0083 cd0000        	call	_CLK_PeripheralClockConfig
 265                     ; 132   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 267  0086 ae1200        	ldw	x,#4608
 268  0089 cd0000        	call	_CLK_PeripheralClockConfig
 270                     ; 133   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 272  008c ae1301        	ldw	x,#4865
 273  008f cd0000        	call	_CLK_PeripheralClockConfig
 275                     ; 134   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 277  0092 ae0700        	ldw	x,#1792
 278  0095 cd0000        	call	_CLK_PeripheralClockConfig
 280                     ; 135   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 282  0098 ae0501        	ldw	x,#1281
 283  009b cd0000        	call	_CLK_PeripheralClockConfig
 285                     ; 136   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 287  009e ae0400        	ldw	x,#1024
 289                     ; 138 }
 292  00a1 cc0000        	jp	_CLK_PeripheralClockConfig
 317                     ; 140 void GPIO_setup(void)
 317                     ; 141 {                               
 318                     	switch	.text
 319  00a4               _GPIO_setup:
 323                     ; 142   GPIO_DeInit(GPIOC);
 325  00a4 ae500a        	ldw	x,#20490
 326  00a7 cd0000        	call	_GPIO_DeInit
 328                     ; 146 	GPIO_DeInit(GPIOB);
 330  00aa ae5005        	ldw	x,#20485
 331  00ad cd0000        	call	_GPIO_DeInit
 333                     ; 147   GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
 335  00b0 4b00          	push	#0
 336  00b2 4b01          	push	#1
 337  00b4 ae5005        	ldw	x,#20485
 338  00b7 cd0000        	call	_GPIO_Init
 340  00ba 85            	popw	x
 341                     ; 152 	GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ), 
 341                     ; 153                GPIO_MODE_OUT_PP_HIGH_FAST);
 343  00bb 4bf0          	push	#240
 344  00bd 4b60          	push	#96
 345  00bf ae500a        	ldw	x,#20490
 346  00c2 cd0000        	call	_GPIO_Init
 348  00c5 85            	popw	x
 349                     ; 154 }
 352  00c6 81            	ret	
 378                     ; 156 void ADC1_setup(void)
 378                     ; 157 {
 379                     	switch	.text
 380  00c7               _ADC1_setup:
 384                     ; 158   ADC1_DeInit();         
 386  00c7 cd0000        	call	_ADC1_DeInit
 388                     ; 160   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
 388                     ; 161   ADC1_CHANNEL_0,\
 388                     ; 162   ADC1_PRESSEL_FCPU_D18, \
 388                     ; 163   ADC1_EXTTRIG_GPIO, \
 388                     ; 164   DISABLE, \
 388                     ; 165   ADC1_ALIGN_RIGHT, \
 388                     ; 166   ADC1_SCHMITTTRIG_CHANNEL0, \
 388                     ; 167   DISABLE);
 390  00ca 4b00          	push	#0
 391  00cc 4b00          	push	#0
 392  00ce 4b08          	push	#8
 393  00d0 4b00          	push	#0
 394  00d2 4b10          	push	#16
 395  00d4 4b70          	push	#112
 396  00d6 ae0100        	ldw	x,#256
 397  00d9 cd0000        	call	_ADC1_Init
 399  00dc 5b06          	addw	sp,#6
 400                     ; 169   ADC1_Cmd(ENABLE);
 402  00de a601          	ld	a,#1
 404                     ; 171 }
 407  00e0 cc0000        	jp	_ADC1_Cmd
 434                     ; 176 void TIM2_setup(void)
 434                     ; 177 {
 435                     	switch	.text
 436  00e3               _TIM2_setup:
 440                     ; 178   TIM2_DeInit();
 442  00e3 cd0000        	call	_TIM2_DeInit
 444                     ; 179   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
 446  00e6 ae03e8        	ldw	x,#1000
 447  00e9 89            	pushw	x
 448  00ea a605          	ld	a,#5
 449  00ec cd0000        	call	_TIM2_TimeBaseInit
 451  00ef 85            	popw	x
 452                     ; 180   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
 454  00f0 4b00          	push	#0
 455  00f2 ae03e8        	ldw	x,#1000
 456  00f5 89            	pushw	x
 457  00f6 ae6011        	ldw	x,#24593
 458  00f9 cd0000        	call	_TIM2_OC1Init
 460  00fc 5b03          	addw	sp,#3
 461                     ; 181   TIM2_Cmd(ENABLE);
 463  00fe a601          	ld	a,#1
 465                     ; 183 }
 468  0100 cc0000        	jp	_TIM2_Cmd
 494                     ; 186 void SPI_setup(void)
 494                     ; 187 {
 495                     	switch	.text
 496  0103               _SPI_setup:
 500                     ; 188   SPI_DeInit();
 502  0103 cd0000        	call	_SPI_DeInit
 504                     ; 193   SPI_Init(SPI_FIRSTBIT_MSB, \
 504                     ; 194 	SPI_BAUDRATEPRESCALER_16, \
 504                     ; 195 	SPI_MODE_MASTER, \
 504                     ; 196 	SPI_CLOCKPOLARITY_LOW, \
 504                     ; 197 	SPI_CLOCKPHASE_1EDGE, \
 504                     ; 198 	SPI_DATADIRECTION_1LINE_TX, \
 504                     ; 199 	SPI_NSS_SOFT, \
 504                     ; 200 	0x0);
 506  0106 4b00          	push	#0
 507  0108 4b02          	push	#2
 508  010a 4bc0          	push	#192
 509  010c 4b00          	push	#0
 510  010e 4b00          	push	#0
 511  0110 4b04          	push	#4
 512  0112 ae0018        	ldw	x,#24
 513  0115 cd0000        	call	_SPI_Init
 515  0118 5b06          	addw	sp,#6
 516                     ; 202   SPI_Cmd(ENABLE);
 518  011a a601          	ld	a,#1
 520                     ; 203 }
 523  011c cc0000        	jp	_SPI_Cmd
 548                     ; 207 void MAX72xx_init(void)
 548                     ; 208 {
 549                     	switch	.text
 550  011f               _MAX72xx_init:
 554                     ; 210   GPIO_Init(CS_port, CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 556  011f 4bf0          	push	#240
 557  0121 4b10          	push	#16
 558  0123 ae500a        	ldw	x,#20490
 559  0126 cd0000        	call	_GPIO_Init
 561  0129 85            	popw	x
 562                     ; 211   delay_ms(10);
 564  012a ae000a        	ldw	x,#10
 566                     ; 212 }
 569  012d 2067          	jp	_delay_ms
 617                     ; 215 void MAX72xx_write(unsigned char address, unsigned char value)
 617                     ; 216 {
 618                     	switch	.text
 619  012f               _MAX72xx_write:
 621  012f 89            	pushw	x
 622       00000000      OFST:	set	0
 625                     ; 243 	address = 0x30; // 00,11,00,00
 627  0130 a630          	ld	a,#48
 628  0132 6b01          	ld	(OFST+1,sp),a
 629                     ; 244 	address |= ( value>>4); // assume 0's shoved in the left
 631  0134 7b02          	ld	a,(OFST+2,sp)
 632  0136 4e            	swap	a
 633  0137 a40f          	and	a,#15
 634  0139 1a01          	or	a,(OFST+1,sp)
 635  013b 6b01          	ld	(OFST+1,sp),a
 636                     ; 246 	value = ( value<<4 ); // assume 0 shoved in from the right
 638  013d 7b02          	ld	a,(OFST+2,sp)
 639  013f 4e            	swap	a
 640  0140 a4f0          	and	a,#240
 641  0142 6b02          	ld	(OFST+2,sp),a
 643  0144               L761:
 644                     ; 249   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 646  0144 a680          	ld	a,#128
 647  0146 cd0000        	call	_SPI_GetFlagStatus
 649  0149 4d            	tnz	a
 650  014a 26f8          	jrne	L761
 651                     ; 251   GPIO_WriteLow(CS_port, CS_pin);
 653  014c 4b10          	push	#16
 654  014e ae500a        	ldw	x,#20490
 655  0151 cd0000        	call	_GPIO_WriteLow
 657  0154 84            	pop	a
 658                     ; 253   SPI_SendData(address);
 660  0155 7b01          	ld	a,(OFST+1,sp)
 661  0157 cd0000        	call	_SPI_SendData
 664  015a               L571:
 665                     ; 255   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 667  015a a602          	ld	a,#2
 668  015c cd0000        	call	_SPI_GetFlagStatus
 670  015f 4d            	tnz	a
 671  0160 27f8          	jreq	L571
 672                     ; 257   SPI_SendData(value); 
 674  0162 7b02          	ld	a,(OFST+2,sp)
 675  0164 cd0000        	call	_SPI_SendData
 678  0167               L302:
 679                     ; 259   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 681  0167 a602          	ld	a,#2
 682  0169 cd0000        	call	_SPI_GetFlagStatus
 684  016c 4d            	tnz	a
 685  016d 27f8          	jreq	L302
 686                     ; 262 	delay_us(1);
 688  016f ae0001        	ldw	x,#1
 689  0172 ad0b          	call	_delay_us
 691                     ; 269   GPIO_WriteHigh(CS_port, CS_pin);
 693  0174 4b10          	push	#16
 694  0176 ae500a        	ldw	x,#20490
 695  0179 cd0000        	call	_GPIO_WriteHigh
 697                     ; 271 }
 700  017c 5b03          	addw	sp,#3
 701  017e 81            	ret	
 745                     ; 280 void delay_us(unsigned int  value)
 745                     ; 281 {
 746                     	switch	.text
 747  017f               _delay_us:
 749  017f 89            	pushw	x
 750       00000002      OFST:	set	2
 753                     ; 282 	register unsigned int loops =  (dly_const * value) ;
 755  0180 cd0000        	call	c_uitof
 757  0183 ae0000        	ldw	x,#L532
 758  0186 cd0000        	call	c_fmul
 760  0189 cd0000        	call	c_ftoi
 763  018c 2002          	jra	L542
 764  018e               L142:
 765                     ; 286 		_asm ("nop");
 768  018e 9d            	nop	
 770                     ; 287 		loops--;
 772  018f 5a            	decw	x
 773  0190               L542:
 774  0190 1f01          	ldw	(OFST-1,sp),x
 776                     ; 284 	while(loops)
 778  0192 26fa          	jrne	L142
 779                     ; 289 }
 783  0194 85            	popw	x
 784  0195 81            	ret	
 819                     ; 291 void delay_ms(unsigned int  value)
 819                     ; 292 {
 820                     	switch	.text
 821  0196               _delay_ms:
 823  0196 89            	pushw	x
 824       00000000      OFST:	set	0
 827  0197 200a          	jra	L172
 828  0199               L762:
 829                     ; 295 		delay_us(1000);
 831  0199 ae03e8        	ldw	x,#1000
 832  019c ade1          	call	_delay_us
 834                     ; 296 		value--;
 836  019e 1e01          	ldw	x,(OFST+1,sp)
 837  01a0 5a            	decw	x
 838  01a1 1f01          	ldw	(OFST+1,sp),x
 839  01a3               L172:
 840                     ; 293 	while(value)
 842  01a3 1e01          	ldw	x,(OFST+1,sp)
 843  01a5 26f2          	jrne	L762
 844                     ; 298 }
 848  01a7 85            	popw	x
 849  01a8 81            	ret	
 862                     	xdef	_main
 863                     	xdef	_delay_ms
 864                     	xdef	_delay_us
 865                     	xdef	_MAX72xx_init
 866                     	xdef	_MAX72xx_write
 867                     	xdef	_TIM2_setup
 868                     	xdef	_ADC1_setup
 869                     	xdef	_SPI_setup
 870                     	xdef	_GPIO_setup
 871                     	xdef	_clock_setup
 872                     	xref	_TIM2_Cmd
 873                     	xref	_TIM2_OC1Init
 874                     	xref	_TIM2_TimeBaseInit
 875                     	xref	_TIM2_DeInit
 876                     	xref	_SPI_GetFlagStatus
 877                     	xref	_SPI_SendData
 878                     	xref	_SPI_Cmd
 879                     	xref	_SPI_Init
 880                     	xref	_SPI_DeInit
 881                     	xref	_GPIO_WriteLow
 882                     	xref	_GPIO_WriteHigh
 883                     	xref	_GPIO_Init
 884                     	xref	_GPIO_DeInit
 885                     	xref	_CLK_GetFlagStatus
 886                     	xref	_CLK_SYSCLKConfig
 887                     	xref	_CLK_HSIPrescalerConfig
 888                     	xref	_CLK_ClockSwitchConfig
 889                     	xref	_CLK_PeripheralClockConfig
 890                     	xref	_CLK_ClockSwitchCmd
 891                     	xref	_CLK_LSICmd
 892                     	xref	_CLK_HSICmd
 893                     	xref	_CLK_HSECmd
 894                     	xref	_CLK_DeInit
 895                     	xref	_ADC1_ClearFlag
 896                     	xref	_ADC1_GetFlagStatus
 897                     	xref	_ADC1_GetConversionValue
 898                     	xref	_ADC1_StartConversion
 899                     	xref	_ADC1_Cmd
 900                     	xref	_ADC1_Init
 901                     	xref	_ADC1_DeInit
 902                     .const:	section	.text
 903  0000               L532:
 904  0000 3e000000      	dc.w	15872,0
 905  0004               L15:
 906  0004 3e800000      	dc.w	16000,0
 907                     	xref.b	c_x
 927                     	xref	c_ftoi
 928                     	xref	c_fmul
 929                     	xref	c_uitof
 930                     	end
