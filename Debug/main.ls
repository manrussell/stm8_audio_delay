   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  84                     ; 49 void main(void)
  84                     ; 50 {
  86                     	switch	.text
  87  0000               _main:
  89  0000 5206          	subw	sp,#6
  90       00000006      OFST:	set	6
  93                     ; 51 	uint16_t i = 1;
  95  0002 ae0001        	ldw	x,#1
  96  0005 1f01          	ldw	(OFST-5,sp),x
  98                     ; 52 	uint16_t x = 8;
 100                     ; 53 	uint16_t pwm_duty = 0;
 102                     ; 55 	clock_setup();
 104  0007 ad6e          	call	_clock_setup
 106                     ; 56 	GPIO_setup();
 108  0009 cd00d3        	call	_GPIO_setup
 110                     ; 57 	ADC1_setup();
 112  000c cd00f6        	call	_ADC1_setup
 114                     ; 58 	TIM2_setup();
 116  000f cd0113        	call	_TIM2_setup
 118                     ; 60 	GPIO_WriteHigh(LED_port, LED_pin);
 120  0012 4b10          	push	#16
 121  0014 ae500f        	ldw	x,#20495
 122  0017 cd0000        	call	_GPIO_WriteHigh
 124  001a 84            	pop	a
 125                     ; 62 	GPIO_WriteLow(LED_port, LED_pin);
 127  001b 4b10          	push	#16
 128  001d ae500f        	ldw	x,#20495
 129  0020 cd0000        	call	_GPIO_WriteLow
 131  0023 84            	pop	a
 132  0024               L73:
 133                     ; 67 		i +=1;
 135  0024 1e01          	ldw	x,(OFST-5,sp)
 136  0026 1c0001        	addw	x,#1
 137  0029 1f01          	ldw	(OFST-5,sp),x
 139                     ; 69 		ADC1_StartConversion();
 141  002b cd0000        	call	_ADC1_StartConversion
 144  002e               L54:
 145                     ; 70 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 147  002e a680          	ld	a,#128
 148  0030 cd0000        	call	_ADC1_GetFlagStatus
 150  0033 4d            	tnz	a
 151  0034 27f8          	jreq	L54
 152                     ; 72 		x = ADC1_GetConversionValue();
 154  0036 cd0000        	call	_ADC1_GetConversionValue
 156                     ; 73 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 158  0039 a680          	ld	a,#128
 159  003b cd0000        	call	_ADC1_ClearFlag
 161                     ; 75 		for(pwm_duty = 0; pwm_duty < 1000; pwm_duty += 10)
 163  003e 5f            	clrw	x
 164  003f 1f05          	ldw	(OFST-1,sp),x
 166  0041               L15:
 167                     ; 77 				 TIM2_SetCompare1(pwm_duty);
 169  0041 1e05          	ldw	x,(OFST-1,sp)
 170  0043 cd0000        	call	_TIM2_SetCompare1
 172                     ; 78 				 delay_ms(10);
 174  0046 ae000a        	ldw	x,#10
 175  0049 cd0153        	call	_delay_ms
 177                     ; 75 		for(pwm_duty = 0; pwm_duty < 1000; pwm_duty += 10)
 179  004c 1e05          	ldw	x,(OFST-1,sp)
 180  004e 1c000a        	addw	x,#10
 181  0051 1f05          	ldw	(OFST-1,sp),x
 185  0053 1e05          	ldw	x,(OFST-1,sp)
 186  0055 a303e8        	cpw	x,#1000
 187  0058 25e7          	jrult	L15
 188                     ; 81 		for(pwm_duty = 1000; pwm_duty > 0; pwm_duty -= 10)
 190  005a ae03e8        	ldw	x,#1000
 191  005d 1f05          	ldw	(OFST-1,sp),x
 193  005f               L75:
 194                     ; 83 				 TIM2_SetCompare1(pwm_duty);
 196  005f 1e05          	ldw	x,(OFST-1,sp)
 197  0061 cd0000        	call	_TIM2_SetCompare1
 199                     ; 84 				 delay_ms(10);
 201  0064 ae000a        	ldw	x,#10
 202  0067 cd0153        	call	_delay_ms
 204                     ; 81 		for(pwm_duty = 1000; pwm_duty > 0; pwm_duty -= 10)
 206  006a 1e05          	ldw	x,(OFST-1,sp)
 207  006c 1d000a        	subw	x,#10
 208  006f 1f05          	ldw	(OFST-1,sp),x
 212  0071 1e05          	ldw	x,(OFST-1,sp)
 213  0073 26ea          	jrne	L75
 215  0075 20ad          	jra	L73
 248                     ; 91 void clock_setup(void)
 248                     ; 92 {
 249                     	switch	.text
 250  0077               _clock_setup:
 254                     ; 93   CLK_DeInit();
 256  0077 cd0000        	call	_CLK_DeInit
 258                     ; 95   CLK_HSECmd(DISABLE);
 260  007a 4f            	clr	a
 261  007b cd0000        	call	_CLK_HSECmd
 263                     ; 96   CLK_LSICmd(DISABLE);
 265  007e 4f            	clr	a
 266  007f cd0000        	call	_CLK_LSICmd
 268                     ; 97   CLK_HSICmd(ENABLE);
 270  0082 a601          	ld	a,#1
 271  0084 cd0000        	call	_CLK_HSICmd
 274  0087               L77:
 275                     ; 98   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 277  0087 ae0102        	ldw	x,#258
 278  008a cd0000        	call	_CLK_GetFlagStatus
 280  008d 4d            	tnz	a
 281  008e 27f7          	jreq	L77
 282                     ; 100   CLK_ClockSwitchCmd(ENABLE);
 284  0090 a601          	ld	a,#1
 285  0092 cd0000        	call	_CLK_ClockSwitchCmd
 287                     ; 101   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
 289  0095 a618          	ld	a,#24
 290  0097 cd0000        	call	_CLK_HSIPrescalerConfig
 292                     ; 102   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 294  009a a680          	ld	a,#128
 295  009c cd0000        	call	_CLK_SYSCLKConfig
 297                     ; 104   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 299  009f 4b01          	push	#1
 300  00a1 4b00          	push	#0
 301  00a3 ae01e1        	ldw	x,#481
 302  00a6 cd0000        	call	_CLK_ClockSwitchConfig
 304  00a9 85            	popw	x
 305                     ; 106   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 307  00aa 5f            	clrw	x
 308  00ab cd0000        	call	_CLK_PeripheralClockConfig
 310                     ; 108   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 312  00ae ae0300        	ldw	x,#768
 313  00b1 cd0000        	call	_CLK_PeripheralClockConfig
 315                     ; 109   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 317  00b4 ae1200        	ldw	x,#4608
 318  00b7 cd0000        	call	_CLK_PeripheralClockConfig
 320                     ; 110   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 322  00ba ae1301        	ldw	x,#4865
 323  00bd cd0000        	call	_CLK_PeripheralClockConfig
 325                     ; 111   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 327  00c0 ae0700        	ldw	x,#1792
 328  00c3 cd0000        	call	_CLK_PeripheralClockConfig
 330                     ; 112   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 332  00c6 ae0501        	ldw	x,#1281
 333  00c9 cd0000        	call	_CLK_PeripheralClockConfig
 335                     ; 113   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 337  00cc ae0400        	ldw	x,#1024
 338  00cf cd0000        	call	_CLK_PeripheralClockConfig
 340                     ; 115 }
 343  00d2 81            	ret
 368                     ; 117 void GPIO_setup(void)
 368                     ; 118 {                               
 369                     	switch	.text
 370  00d3               _GPIO_setup:
 374                     ; 119   GPIO_DeInit(GPIOC);
 376  00d3 ae500a        	ldw	x,#20490
 377  00d6 cd0000        	call	_GPIO_DeInit
 379                     ; 123 	GPIO_DeInit(GPIOB);
 381  00d9 ae5005        	ldw	x,#20485
 382  00dc cd0000        	call	_GPIO_DeInit
 384                     ; 124   GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
 386  00df 4b00          	push	#0
 387  00e1 4b01          	push	#1
 388  00e3 ae5005        	ldw	x,#20485
 389  00e6 cd0000        	call	_GPIO_Init
 391  00e9 85            	popw	x
 392                     ; 126   GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 394  00ea 4bf0          	push	#240
 395  00ec 4b10          	push	#16
 396  00ee ae500f        	ldw	x,#20495
 397  00f1 cd0000        	call	_GPIO_Init
 399  00f4 85            	popw	x
 400                     ; 127 }
 403  00f5 81            	ret
 429                     ; 129 void ADC1_setup(void)
 429                     ; 130 {
 430                     	switch	.text
 431  00f6               _ADC1_setup:
 435                     ; 131   ADC1_DeInit();         
 437  00f6 cd0000        	call	_ADC1_DeInit
 439                     ; 133   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
 439                     ; 134   ADC1_CHANNEL_0,\
 439                     ; 135   ADC1_PRESSEL_FCPU_D18, \
 439                     ; 136   ADC1_EXTTRIG_GPIO, \
 439                     ; 137   DISABLE, \
 439                     ; 138   ADC1_ALIGN_RIGHT, \
 439                     ; 139   ADC1_SCHMITTTRIG_CHANNEL0, \
 439                     ; 140   DISABLE);
 441  00f9 4b00          	push	#0
 442  00fb 4b00          	push	#0
 443  00fd 4b08          	push	#8
 444  00ff 4b00          	push	#0
 445  0101 4b10          	push	#16
 446  0103 4b70          	push	#112
 447  0105 ae0100        	ldw	x,#256
 448  0108 cd0000        	call	_ADC1_Init
 450  010b 5b06          	addw	sp,#6
 451                     ; 142   ADC1_Cmd(ENABLE);
 453  010d a601          	ld	a,#1
 454  010f cd0000        	call	_ADC1_Cmd
 456                     ; 144 }
 459  0112 81            	ret
 486                     ; 149 void TIM2_setup(void)
 486                     ; 150 {
 487                     	switch	.text
 488  0113               _TIM2_setup:
 492                     ; 151   TIM2_DeInit();
 494  0113 cd0000        	call	_TIM2_DeInit
 496                     ; 152   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
 498  0116 ae03e8        	ldw	x,#1000
 499  0119 89            	pushw	x
 500  011a a605          	ld	a,#5
 501  011c cd0000        	call	_TIM2_TimeBaseInit
 503  011f 85            	popw	x
 504                     ; 153   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
 506  0120 4b00          	push	#0
 507  0122 ae03e8        	ldw	x,#1000
 508  0125 89            	pushw	x
 509  0126 ae6011        	ldw	x,#24593
 510  0129 cd0000        	call	_TIM2_OC1Init
 512  012c 5b03          	addw	sp,#3
 513                     ; 160   TIM2_Cmd(ENABLE);
 515  012e a601          	ld	a,#1
 516  0130 cd0000        	call	_TIM2_Cmd
 518                     ; 162 }
 521  0133 81            	ret
 565                     ; 168 void delay_us(unsigned int  value)
 565                     ; 169 {
 566                     	switch	.text
 567  0134               _delay_us:
 569  0134 89            	pushw	x
 570       00000002      OFST:	set	2
 573                     ; 170 	register unsigned int loops =  (dly_const * value) ;
 575  0135 cd0000        	call	c_uitof
 577  0138 ae0000        	ldw	x,#L161
 578  013b cd0000        	call	c_fmul
 580  013e cd0000        	call	c_ftoi
 582  0141 1f01          	ldw	(OFST-1,sp),x
 585  0143 2008          	jra	L171
 586  0145               L561:
 587                     ; 174 		_asm ("nop");
 590  0145 9d            nop
 592                     ; 175 		loops--;
 594  0146 1e01          	ldw	x,(OFST-1,sp)
 595  0148 1d0001        	subw	x,#1
 596  014b 1f01          	ldw	(OFST-1,sp),x
 598  014d               L171:
 599                     ; 172 	while(loops)
 601  014d 1e01          	ldw	x,(OFST-1,sp)
 602  014f 26f4          	jrne	L561
 603                     ; 177 }
 607  0151 85            	popw	x
 608  0152 81            	ret
 643                     ; 179 void delay_ms(unsigned int  value)
 643                     ; 180 {
 644                     	switch	.text
 645  0153               _delay_ms:
 647  0153 89            	pushw	x
 648       00000000      OFST:	set	0
 651  0154 200c          	jra	L512
 652  0156               L312:
 653                     ; 183 		delay_us(1000);
 655  0156 ae03e8        	ldw	x,#1000
 656  0159 add9          	call	_delay_us
 658                     ; 184 		value--;
 660  015b 1e01          	ldw	x,(OFST+1,sp)
 661  015d 1d0001        	subw	x,#1
 662  0160 1f01          	ldw	(OFST+1,sp),x
 663  0162               L512:
 664                     ; 181 	while(value)
 666  0162 1e01          	ldw	x,(OFST+1,sp)
 667  0164 26f0          	jrne	L312
 668                     ; 186 }
 672  0166 85            	popw	x
 673  0167 81            	ret
 708                     ; 200 void assert_failed(u8* file, u32 line)
 708                     ; 201 { 
 709                     	switch	.text
 710  0168               _assert_failed:
 714  0168               L732:
 715  0168 20fe          	jra	L732
 728                     	xdef	_main
 729                     	xdef	_delay_ms
 730                     	xdef	_delay_us
 731                     	xdef	_TIM2_setup
 732                     	xdef	_ADC1_setup
 733                     	xdef	_GPIO_setup
 734                     	xdef	_clock_setup
 735                     	xdef	_assert_failed
 736                     	xref	_TIM2_SetCompare1
 737                     	xref	_TIM2_Cmd
 738                     	xref	_TIM2_OC1Init
 739                     	xref	_TIM2_TimeBaseInit
 740                     	xref	_TIM2_DeInit
 741                     	xref	_GPIO_WriteLow
 742                     	xref	_GPIO_WriteHigh
 743                     	xref	_GPIO_Init
 744                     	xref	_GPIO_DeInit
 745                     	xref	_CLK_GetFlagStatus
 746                     	xref	_CLK_SYSCLKConfig
 747                     	xref	_CLK_HSIPrescalerConfig
 748                     	xref	_CLK_ClockSwitchConfig
 749                     	xref	_CLK_PeripheralClockConfig
 750                     	xref	_CLK_ClockSwitchCmd
 751                     	xref	_CLK_LSICmd
 752                     	xref	_CLK_HSICmd
 753                     	xref	_CLK_HSECmd
 754                     	xref	_CLK_DeInit
 755                     	xref	_ADC1_ClearFlag
 756                     	xref	_ADC1_GetFlagStatus
 757                     	xref	_ADC1_GetConversionValue
 758                     	xref	_ADC1_StartConversion
 759                     	xref	_ADC1_Cmd
 760                     	xref	_ADC1_Init
 761                     	xref	_ADC1_DeInit
 762                     .const:	section	.text
 763  0000               L161:
 764  0000 3e000000      	dc.w	15872,0
 765                     	xref.b	c_x
 785                     	xref	c_ftoi
 786                     	xref	c_fmul
 787                     	xref	c_uitof
 788                     	end
