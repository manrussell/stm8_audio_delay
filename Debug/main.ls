   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  83                     ; 49 void main(void)
  83                     ; 50 {
  85                     	switch	.text
  86  0000               _main:
  88  0000 5206          	subw	sp,#6
  89       00000006      OFST:	set	6
  92                     ; 51 	uint16_t i = 1;
  94  0002 ae0001        	ldw	x,#1
  95  0005 1f03          	ldw	(OFST-3,sp),x
  97                     ; 52 	uint16_t x = 8;
  99                     ; 53 	uint16_t pwm_duty = 0;
 101                     ; 55 	clock_setup();
 103  0007 ad44          	call	_clock_setup
 105                     ; 56 	GPIO_setup();
 107  0009 cd00a8        	call	_GPIO_setup
 109                     ; 57 	ADC1_setup();
 111  000c cd00cb        	call	_ADC1_setup
 113                     ; 58 	TIM2_setup();
 115  000f cd00e8        	call	_TIM2_setup
 117                     ; 60 	GPIO_WriteHigh(LED_port, LED_pin);
 119  0012 4b10          	push	#16
 120  0014 ae500f        	ldw	x,#20495
 121  0017 cd0000        	call	_GPIO_WriteHigh
 123  001a 84            	pop	a
 124                     ; 62 	GPIO_WriteLow(LED_port, LED_pin);
 126  001b 4b10          	push	#16
 127  001d ae500f        	ldw	x,#20495
 128  0020 cd0000        	call	_GPIO_WriteLow
 130  0023 84            	pop	a
 131  0024               L73:
 132                     ; 67 		i +=1;
 134  0024 1e03          	ldw	x,(OFST-3,sp)
 135  0026 1c0001        	addw	x,#1
 136  0029 1f03          	ldw	(OFST-3,sp),x
 138                     ; 69 		ADC1_StartConversion();
 140  002b cd0000        	call	_ADC1_StartConversion
 143  002e               L54:
 144                     ; 70 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 146  002e a680          	ld	a,#128
 147  0030 cd0000        	call	_ADC1_GetFlagStatus
 149  0033 4d            	tnz	a
 150  0034 27f8          	jreq	L54
 151                     ; 73 		x = (ADC1_GetConversionValue() %1000); // for led
 153  0036 cd0000        	call	_ADC1_GetConversionValue
 155  0039 90ae03e8      	ldw	y,#1000
 156  003d 65            	divw	x,y
 157  003e 51            	exgw	x,y
 158  003f 1f05          	ldw	(OFST-1,sp),x
 160                     ; 74 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 162  0041 a680          	ld	a,#128
 163  0043 cd0000        	call	_ADC1_ClearFlag
 165                     ; 76 		TIM2_SetCompare1(x);
 167  0046 1e05          	ldw	x,(OFST-1,sp)
 168  0048 cd0000        	call	_TIM2_SetCompare1
 171  004b 20d7          	jra	L73
 204                     ; 95 void clock_setup(void)
 204                     ; 96 {
 205                     	switch	.text
 206  004d               _clock_setup:
 210                     ; 97   CLK_DeInit();
 212  004d cd0000        	call	_CLK_DeInit
 214                     ; 99   CLK_HSECmd(DISABLE);
 216  0050 4f            	clr	a
 217  0051 cd0000        	call	_CLK_HSECmd
 219                     ; 100   CLK_LSICmd(DISABLE);
 221  0054 4f            	clr	a
 222  0055 cd0000        	call	_CLK_LSICmd
 224                     ; 101   CLK_HSICmd(ENABLE);
 226  0058 a601          	ld	a,#1
 227  005a cd0000        	call	_CLK_HSICmd
 230  005d               L36:
 231                     ; 102   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 233  005d ae0102        	ldw	x,#258
 234  0060 cd0000        	call	_CLK_GetFlagStatus
 236  0063 4d            	tnz	a
 237  0064 27f7          	jreq	L36
 238                     ; 104   CLK_ClockSwitchCmd(ENABLE);
 240  0066 a601          	ld	a,#1
 241  0068 cd0000        	call	_CLK_ClockSwitchCmd
 243                     ; 105   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 245  006b 4f            	clr	a
 246  006c cd0000        	call	_CLK_HSIPrescalerConfig
 248                     ; 106   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 250  006f a680          	ld	a,#128
 251  0071 cd0000        	call	_CLK_SYSCLKConfig
 253                     ; 108   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 255  0074 4b01          	push	#1
 256  0076 4b00          	push	#0
 257  0078 ae01e1        	ldw	x,#481
 258  007b cd0000        	call	_CLK_ClockSwitchConfig
 260  007e 85            	popw	x
 261                     ; 110   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 263  007f 5f            	clrw	x
 264  0080 cd0000        	call	_CLK_PeripheralClockConfig
 266                     ; 112   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 268  0083 ae0300        	ldw	x,#768
 269  0086 cd0000        	call	_CLK_PeripheralClockConfig
 271                     ; 113   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 273  0089 ae1200        	ldw	x,#4608
 274  008c cd0000        	call	_CLK_PeripheralClockConfig
 276                     ; 114   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 278  008f ae1301        	ldw	x,#4865
 279  0092 cd0000        	call	_CLK_PeripheralClockConfig
 281                     ; 115   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 283  0095 ae0700        	ldw	x,#1792
 284  0098 cd0000        	call	_CLK_PeripheralClockConfig
 286                     ; 116   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 288  009b ae0501        	ldw	x,#1281
 289  009e cd0000        	call	_CLK_PeripheralClockConfig
 291                     ; 117   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 293  00a1 ae0400        	ldw	x,#1024
 294  00a4 cd0000        	call	_CLK_PeripheralClockConfig
 296                     ; 119 }
 299  00a7 81            	ret
 324                     ; 121 void GPIO_setup(void)
 324                     ; 122 {                               
 325                     	switch	.text
 326  00a8               _GPIO_setup:
 330                     ; 123   GPIO_DeInit(GPIOC);
 332  00a8 ae500a        	ldw	x,#20490
 333  00ab cd0000        	call	_GPIO_DeInit
 335                     ; 127 	GPIO_DeInit(GPIOB);
 337  00ae ae5005        	ldw	x,#20485
 338  00b1 cd0000        	call	_GPIO_DeInit
 340                     ; 128   GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
 342  00b4 4b00          	push	#0
 343  00b6 4b01          	push	#1
 344  00b8 ae5005        	ldw	x,#20485
 345  00bb cd0000        	call	_GPIO_Init
 347  00be 85            	popw	x
 348                     ; 130   GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 350  00bf 4bf0          	push	#240
 351  00c1 4b10          	push	#16
 352  00c3 ae500f        	ldw	x,#20495
 353  00c6 cd0000        	call	_GPIO_Init
 355  00c9 85            	popw	x
 356                     ; 131 }
 359  00ca 81            	ret
 385                     ; 133 void ADC1_setup(void)
 385                     ; 134 {
 386                     	switch	.text
 387  00cb               _ADC1_setup:
 391                     ; 135   ADC1_DeInit();         
 393  00cb cd0000        	call	_ADC1_DeInit
 395                     ; 137   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
 395                     ; 138   ADC1_CHANNEL_0,\
 395                     ; 139   ADC1_PRESSEL_FCPU_D18, \
 395                     ; 140   ADC1_EXTTRIG_GPIO, \
 395                     ; 141   DISABLE, \
 395                     ; 142   ADC1_ALIGN_RIGHT, \
 395                     ; 143   ADC1_SCHMITTTRIG_CHANNEL0, \
 395                     ; 144   DISABLE);
 397  00ce 4b00          	push	#0
 398  00d0 4b00          	push	#0
 399  00d2 4b08          	push	#8
 400  00d4 4b00          	push	#0
 401  00d6 4b10          	push	#16
 402  00d8 4b70          	push	#112
 403  00da ae0100        	ldw	x,#256
 404  00dd cd0000        	call	_ADC1_Init
 406  00e0 5b06          	addw	sp,#6
 407                     ; 146   ADC1_Cmd(ENABLE);
 409  00e2 a601          	ld	a,#1
 410  00e4 cd0000        	call	_ADC1_Cmd
 412                     ; 148 }
 415  00e7 81            	ret
 442                     ; 153 void TIM2_setup(void)
 442                     ; 154 {
 443                     	switch	.text
 444  00e8               _TIM2_setup:
 448                     ; 155   TIM2_DeInit();
 450  00e8 cd0000        	call	_TIM2_DeInit
 452                     ; 156   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
 454  00eb ae03e8        	ldw	x,#1000
 455  00ee 89            	pushw	x
 456  00ef a605          	ld	a,#5
 457  00f1 cd0000        	call	_TIM2_TimeBaseInit
 459  00f4 85            	popw	x
 460                     ; 157   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
 462  00f5 4b00          	push	#0
 463  00f7 ae03e8        	ldw	x,#1000
 464  00fa 89            	pushw	x
 465  00fb ae6011        	ldw	x,#24593
 466  00fe cd0000        	call	_TIM2_OC1Init
 468  0101 5b03          	addw	sp,#3
 469                     ; 164   TIM2_Cmd(ENABLE);
 471  0103 a601          	ld	a,#1
 472  0105 cd0000        	call	_TIM2_Cmd
 474                     ; 166 }
 477  0108 81            	ret
 521                     ; 172 void delay_us(unsigned int  value)
 521                     ; 173 {
 522                     	switch	.text
 523  0109               _delay_us:
 525  0109 89            	pushw	x
 526       00000002      OFST:	set	2
 529                     ; 174 	register unsigned int loops =  (dly_const * value) ;
 531  010a cd0000        	call	c_uitof
 533  010d ae0000        	ldw	x,#L541
 534  0110 cd0000        	call	c_fmul
 536  0113 cd0000        	call	c_ftoi
 538  0116 1f01          	ldw	(OFST-1,sp),x
 541  0118 2008          	jra	L551
 542  011a               L151:
 543                     ; 178 		_asm ("nop");
 546  011a 9d            nop
 548                     ; 179 		loops--;
 550  011b 1e01          	ldw	x,(OFST-1,sp)
 551  011d 1d0001        	subw	x,#1
 552  0120 1f01          	ldw	(OFST-1,sp),x
 554  0122               L551:
 555                     ; 176 	while(loops)
 557  0122 1e01          	ldw	x,(OFST-1,sp)
 558  0124 26f4          	jrne	L151
 559                     ; 181 }
 563  0126 85            	popw	x
 564  0127 81            	ret
 599                     ; 183 void delay_ms(unsigned int  value)
 599                     ; 184 {
 600                     	switch	.text
 601  0128               _delay_ms:
 603  0128 89            	pushw	x
 604       00000000      OFST:	set	0
 607  0129 200c          	jra	L102
 608  012b               L771:
 609                     ; 187 		delay_us(1000);
 611  012b ae03e8        	ldw	x,#1000
 612  012e add9          	call	_delay_us
 614                     ; 188 		value--;
 616  0130 1e01          	ldw	x,(OFST+1,sp)
 617  0132 1d0001        	subw	x,#1
 618  0135 1f01          	ldw	(OFST+1,sp),x
 619  0137               L102:
 620                     ; 185 	while(value)
 622  0137 1e01          	ldw	x,(OFST+1,sp)
 623  0139 26f0          	jrne	L771
 624                     ; 190 }
 628  013b 85            	popw	x
 629  013c 81            	ret
 664                     ; 204 void assert_failed(u8* file, u32 line)
 664                     ; 205 { 
 665                     	switch	.text
 666  013d               _assert_failed:
 670  013d               L322:
 671  013d 20fe          	jra	L322
 684                     	xdef	_main
 685                     	xdef	_delay_ms
 686                     	xdef	_delay_us
 687                     	xdef	_TIM2_setup
 688                     	xdef	_ADC1_setup
 689                     	xdef	_GPIO_setup
 690                     	xdef	_clock_setup
 691                     	xdef	_assert_failed
 692                     	xref	_TIM2_SetCompare1
 693                     	xref	_TIM2_Cmd
 694                     	xref	_TIM2_OC1Init
 695                     	xref	_TIM2_TimeBaseInit
 696                     	xref	_TIM2_DeInit
 697                     	xref	_GPIO_WriteLow
 698                     	xref	_GPIO_WriteHigh
 699                     	xref	_GPIO_Init
 700                     	xref	_GPIO_DeInit
 701                     	xref	_CLK_GetFlagStatus
 702                     	xref	_CLK_SYSCLKConfig
 703                     	xref	_CLK_HSIPrescalerConfig
 704                     	xref	_CLK_ClockSwitchConfig
 705                     	xref	_CLK_PeripheralClockConfig
 706                     	xref	_CLK_ClockSwitchCmd
 707                     	xref	_CLK_LSICmd
 708                     	xref	_CLK_HSICmd
 709                     	xref	_CLK_HSECmd
 710                     	xref	_CLK_DeInit
 711                     	xref	_ADC1_ClearFlag
 712                     	xref	_ADC1_GetFlagStatus
 713                     	xref	_ADC1_GetConversionValue
 714                     	xref	_ADC1_StartConversion
 715                     	xref	_ADC1_Cmd
 716                     	xref	_ADC1_Init
 717                     	xref	_ADC1_DeInit
 718                     .const:	section	.text
 719  0000               L541:
 720  0000 3e000000      	dc.w	15872,0
 721                     	xref.b	c_x
 741                     	xref	c_ftoi
 742                     	xref	c_fmul
 743                     	xref	c_uitof
 744                     	end
