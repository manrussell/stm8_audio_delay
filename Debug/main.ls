   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  83                     ; 56 void main(void)
  83                     ; 57 {
  85                     	switch	.text
  86  0000               _main:
  88  0000 5206          	subw	sp,#6
  89       00000006      OFST:	set	6
  92                     ; 58 	uint16_t i = 1;
  94                     ; 59 	uint16_t x = 8;
  96                     ; 60 	uint16_t pwm_duty = 0;
  98                     ; 62 	clock_setup();
 100  0002 ad3f          	call	_clock_setup
 102                     ; 63 	GPIO_setup();
 104  0004 cd00a4        	call	_GPIO_setup
 106                     ; 64 	ADC1_setup();
 108  0007 cd00c7        	call	_ADC1_setup
 110                     ; 66 	SPI_setup();	
 112  000a cd0105        	call	_SPI_setup
 114                     ; 67 	MAX72xx_init();
 116  000d cd0122        	call	_MAX72xx_init
 118  0010               L73:
 119                     ; 77 		ADC1_StartConversion();
 121  0010 cd0000        	call	_ADC1_StartConversion
 124  0013               L54:
 125                     ; 78 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 127  0013 a680          	ld	a,#128
 128  0015 cd0000        	call	_ADC1_GetFlagStatus
 130  0018 4d            	tnz	a
 131  0019 27f8          	jreq	L54
 132                     ; 82 		x = ADC1_GetConversionValue(); // for led knob
 134  001b cd0000        	call	_ADC1_GetConversionValue
 136  001e 1f05          	ldw	(OFST-1,sp),x
 138                     ; 83 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 140  0020 a680          	ld	a,#128
 141  0022 cd0000        	call	_ADC1_ClearFlag
 143                     ; 100 			x = (x - 0) * (255 - 0) / (1024 - 0) + 0; 
 145  0025 1e05          	ldw	x,(OFST-1,sp)
 146  0027 90ae00ff      	ldw	y,#255
 147  002b cd0000        	call	c_imul
 149  002e 4f            	clr	a
 150  002f 01            	rrwa	x,a
 151  0030 54            	srlw	x
 152  0031 54            	srlw	x
 153  0032 1f05          	ldw	(OFST-1,sp),x
 155                     ; 106 			MAX72xx_write(0,x);
 157  0034 7b06          	ld	a,(OFST+0,sp)
 158  0036 5f            	clrw	x
 159  0037 97            	ld	xl,a
 160  0038 cd0133        	call	_MAX72xx_write
 162                     ; 107 			delay_us(90); //11kHz
 164  003b ae005a        	ldw	x,#90
 165  003e cd0183        	call	_delay_us
 168  0041 20cd          	jra	L73
 201                     ; 116 void clock_setup(void)
 201                     ; 117 {
 202                     	switch	.text
 203  0043               _clock_setup:
 207                     ; 118   CLK_DeInit();
 209  0043 cd0000        	call	_CLK_DeInit
 211                     ; 120   CLK_HSECmd(DISABLE);
 213  0046 4f            	clr	a
 214  0047 cd0000        	call	_CLK_HSECmd
 216                     ; 121   CLK_LSICmd(DISABLE);
 218  004a 4f            	clr	a
 219  004b cd0000        	call	_CLK_LSICmd
 221                     ; 122   CLK_HSICmd(ENABLE);
 223  004e a601          	ld	a,#1
 224  0050 cd0000        	call	_CLK_HSICmd
 227  0053               L36:
 228                     ; 123   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 230  0053 ae0102        	ldw	x,#258
 231  0056 cd0000        	call	_CLK_GetFlagStatus
 233  0059 4d            	tnz	a
 234  005a 27f7          	jreq	L36
 235                     ; 125   CLK_ClockSwitchCmd(ENABLE);
 237  005c a601          	ld	a,#1
 238  005e cd0000        	call	_CLK_ClockSwitchCmd
 240                     ; 126   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 242  0061 4f            	clr	a
 243  0062 cd0000        	call	_CLK_HSIPrescalerConfig
 245                     ; 127   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 247  0065 a680          	ld	a,#128
 248  0067 cd0000        	call	_CLK_SYSCLKConfig
 250                     ; 129   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 252  006a 4b01          	push	#1
 253  006c 4b00          	push	#0
 254  006e ae01e1        	ldw	x,#481
 255  0071 cd0000        	call	_CLK_ClockSwitchConfig
 257  0074 85            	popw	x
 258                     ; 131   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 260  0075 5f            	clrw	x
 261  0076 cd0000        	call	_CLK_PeripheralClockConfig
 263                     ; 132   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 265  0079 ae0101        	ldw	x,#257
 266  007c cd0000        	call	_CLK_PeripheralClockConfig
 268                     ; 133   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 270  007f ae0300        	ldw	x,#768
 271  0082 cd0000        	call	_CLK_PeripheralClockConfig
 273                     ; 134   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 275  0085 ae1200        	ldw	x,#4608
 276  0088 cd0000        	call	_CLK_PeripheralClockConfig
 278                     ; 135   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 280  008b ae1301        	ldw	x,#4865
 281  008e cd0000        	call	_CLK_PeripheralClockConfig
 283                     ; 136   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 285  0091 ae0700        	ldw	x,#1792
 286  0094 cd0000        	call	_CLK_PeripheralClockConfig
 288                     ; 137   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 290  0097 ae0501        	ldw	x,#1281
 291  009a cd0000        	call	_CLK_PeripheralClockConfig
 293                     ; 138   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 295  009d ae0400        	ldw	x,#1024
 296  00a0 cd0000        	call	_CLK_PeripheralClockConfig
 298                     ; 140 }
 301  00a3 81            	ret
 326                     ; 142 void GPIO_setup(void)
 326                     ; 143 {                               
 327                     	switch	.text
 328  00a4               _GPIO_setup:
 332                     ; 144   GPIO_DeInit(GPIOC);
 334  00a4 ae500a        	ldw	x,#20490
 335  00a7 cd0000        	call	_GPIO_DeInit
 337                     ; 148 	GPIO_DeInit(GPIOB);
 339  00aa ae5005        	ldw	x,#20485
 340  00ad cd0000        	call	_GPIO_DeInit
 342                     ; 149   GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
 344  00b0 4b00          	push	#0
 345  00b2 4b01          	push	#1
 346  00b4 ae5005        	ldw	x,#20485
 347  00b7 cd0000        	call	_GPIO_Init
 349  00ba 85            	popw	x
 350                     ; 154 	GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ), 
 350                     ; 155                GPIO_MODE_OUT_PP_HIGH_FAST);
 352  00bb 4bf0          	push	#240
 353  00bd 4b60          	push	#96
 354  00bf ae500a        	ldw	x,#20490
 355  00c2 cd0000        	call	_GPIO_Init
 357  00c5 85            	popw	x
 358                     ; 156 }
 361  00c6 81            	ret
 387                     ; 158 void ADC1_setup(void)
 387                     ; 159 {
 388                     	switch	.text
 389  00c7               _ADC1_setup:
 393                     ; 160   ADC1_DeInit();         
 395  00c7 cd0000        	call	_ADC1_DeInit
 397                     ; 162   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
 397                     ; 163   ADC1_CHANNEL_0,\
 397                     ; 164   ADC1_PRESSEL_FCPU_D18, \
 397                     ; 165   ADC1_EXTTRIG_GPIO, \
 397                     ; 166   DISABLE, \
 397                     ; 167   ADC1_ALIGN_RIGHT, \
 397                     ; 168   ADC1_SCHMITTTRIG_CHANNEL0, \
 397                     ; 169   DISABLE);
 399  00ca 4b00          	push	#0
 400  00cc 4b00          	push	#0
 401  00ce 4b08          	push	#8
 402  00d0 4b00          	push	#0
 403  00d2 4b10          	push	#16
 404  00d4 4b70          	push	#112
 405  00d6 ae0100        	ldw	x,#256
 406  00d9 cd0000        	call	_ADC1_Init
 408  00dc 5b06          	addw	sp,#6
 409                     ; 171   ADC1_Cmd(ENABLE);
 411  00de a601          	ld	a,#1
 412  00e0 cd0000        	call	_ADC1_Cmd
 414                     ; 173 }
 417  00e3 81            	ret
 444                     ; 178 void TIM2_setup(void)
 444                     ; 179 {
 445                     	switch	.text
 446  00e4               _TIM2_setup:
 450                     ; 180   TIM2_DeInit();
 452  00e4 cd0000        	call	_TIM2_DeInit
 454                     ; 181   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
 456  00e7 ae03e8        	ldw	x,#1000
 457  00ea 89            	pushw	x
 458  00eb a605          	ld	a,#5
 459  00ed cd0000        	call	_TIM2_TimeBaseInit
 461  00f0 85            	popw	x
 462                     ; 182   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
 464  00f1 4b00          	push	#0
 465  00f3 ae03e8        	ldw	x,#1000
 466  00f6 89            	pushw	x
 467  00f7 ae6011        	ldw	x,#24593
 468  00fa cd0000        	call	_TIM2_OC1Init
 470  00fd 5b03          	addw	sp,#3
 471                     ; 183   TIM2_Cmd(ENABLE);
 473  00ff a601          	ld	a,#1
 474  0101 cd0000        	call	_TIM2_Cmd
 476                     ; 185 }
 479  0104 81            	ret
 505                     ; 188 void SPI_setup(void)
 505                     ; 189 {
 506                     	switch	.text
 507  0105               _SPI_setup:
 511                     ; 190   SPI_DeInit();
 513  0105 cd0000        	call	_SPI_DeInit
 515                     ; 195   SPI_Init(SPI_FIRSTBIT_MSB, \
 515                     ; 196 	SPI_BAUDRATEPRESCALER_16, \
 515                     ; 197 	SPI_MODE_MASTER, \
 515                     ; 198 	SPI_CLOCKPOLARITY_LOW, \
 515                     ; 199 	SPI_CLOCKPHASE_1EDGE, \
 515                     ; 200 	SPI_DATADIRECTION_1LINE_TX, \
 515                     ; 201 	SPI_NSS_SOFT, \
 515                     ; 202 	0x0);
 517  0108 4b00          	push	#0
 518  010a 4b02          	push	#2
 519  010c 4bc0          	push	#192
 520  010e 4b00          	push	#0
 521  0110 4b00          	push	#0
 522  0112 4b04          	push	#4
 523  0114 ae0018        	ldw	x,#24
 524  0117 cd0000        	call	_SPI_Init
 526  011a 5b06          	addw	sp,#6
 527                     ; 204   SPI_Cmd(ENABLE);
 529  011c a601          	ld	a,#1
 530  011e cd0000        	call	_SPI_Cmd
 532                     ; 205 }
 535  0121 81            	ret
 560                     ; 209 void MAX72xx_init(void)
 560                     ; 210 {
 561                     	switch	.text
 562  0122               _MAX72xx_init:
 566                     ; 212   GPIO_Init(CS_port, CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 568  0122 4bf0          	push	#240
 569  0124 4b10          	push	#16
 570  0126 ae500a        	ldw	x,#20490
 571  0129 cd0000        	call	_GPIO_Init
 573  012c 85            	popw	x
 574                     ; 213   delay_ms(10);
 576  012d ae000a        	ldw	x,#10
 577  0130 ad70          	call	_delay_ms
 579                     ; 214 }
 582  0132 81            	ret
 630                     ; 217 void MAX72xx_write(unsigned char address, unsigned char value)
 630                     ; 218 {
 631                     	switch	.text
 632  0133               _MAX72xx_write:
 634  0133 89            	pushw	x
 635       00000000      OFST:	set	0
 638                     ; 245 	address = 0x30; // 00,11,00,00
 640  0134 a630          	ld	a,#48
 641  0136 6b01          	ld	(OFST+1,sp),a
 642                     ; 246 	address |= ( value>>4); // assume 0's shoved in the left
 644  0138 7b02          	ld	a,(OFST+2,sp)
 645  013a 4e            	swap	a
 646  013b a40f          	and	a,#15
 647  013d 1a01          	or	a,(OFST+1,sp)
 648  013f 6b01          	ld	(OFST+1,sp),a
 649                     ; 248 	value = ( value<<4 ); // assume 0 shoved in from the right
 651  0141 7b02          	ld	a,(OFST+2,sp)
 652  0143 4e            	swap	a
 653  0144 a4f0          	and	a,#240
 654  0146 6b02          	ld	(OFST+2,sp),a
 656  0148               L361:
 657                     ; 251   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 659  0148 a680          	ld	a,#128
 660  014a cd0000        	call	_SPI_GetFlagStatus
 662  014d 4d            	tnz	a
 663  014e 26f8          	jrne	L361
 664                     ; 253   GPIO_WriteLow(CS_port, CS_pin);
 666  0150 4b10          	push	#16
 667  0152 ae500a        	ldw	x,#20490
 668  0155 cd0000        	call	_GPIO_WriteLow
 670  0158 84            	pop	a
 671                     ; 255   SPI_SendData(address);
 673  0159 7b01          	ld	a,(OFST+1,sp)
 674  015b cd0000        	call	_SPI_SendData
 677  015e               L171:
 678                     ; 257   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 680  015e a602          	ld	a,#2
 681  0160 cd0000        	call	_SPI_GetFlagStatus
 683  0163 4d            	tnz	a
 684  0164 27f8          	jreq	L171
 685                     ; 259   SPI_SendData(value); 
 687  0166 7b02          	ld	a,(OFST+2,sp)
 688  0168 cd0000        	call	_SPI_SendData
 691  016b               L771:
 692                     ; 261   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 694  016b a602          	ld	a,#2
 695  016d cd0000        	call	_SPI_GetFlagStatus
 697  0170 4d            	tnz	a
 698  0171 27f8          	jreq	L771
 699                     ; 264 	delay_us(1);
 701  0173 ae0001        	ldw	x,#1
 702  0176 ad0b          	call	_delay_us
 704                     ; 271   GPIO_WriteHigh(CS_port, CS_pin);
 706  0178 4b10          	push	#16
 707  017a ae500a        	ldw	x,#20490
 708  017d cd0000        	call	_GPIO_WriteHigh
 710  0180 84            	pop	a
 711                     ; 273 }
 714  0181 85            	popw	x
 715  0182 81            	ret
 759                     ; 282 void delay_us(unsigned int  value)
 759                     ; 283 {
 760                     	switch	.text
 761  0183               _delay_us:
 763  0183 89            	pushw	x
 764       00000002      OFST:	set	2
 767                     ; 284 	register unsigned int loops =  (dly_const * value) ;
 769  0184 cd0000        	call	c_uitof
 771  0187 ae0000        	ldw	x,#L132
 772  018a cd0000        	call	c_fmul
 774  018d cd0000        	call	c_ftoi
 776  0190 1f01          	ldw	(OFST-1,sp),x
 779  0192 2008          	jra	L142
 780  0194               L532:
 781                     ; 288 		_asm ("nop");
 784  0194 9d            nop
 786                     ; 289 		loops--;
 788  0195 1e01          	ldw	x,(OFST-1,sp)
 789  0197 1d0001        	subw	x,#1
 790  019a 1f01          	ldw	(OFST-1,sp),x
 792  019c               L142:
 793                     ; 286 	while(loops)
 795  019c 1e01          	ldw	x,(OFST-1,sp)
 796  019e 26f4          	jrne	L532
 797                     ; 291 }
 801  01a0 85            	popw	x
 802  01a1 81            	ret
 837                     ; 293 void delay_ms(unsigned int  value)
 837                     ; 294 {
 838                     	switch	.text
 839  01a2               _delay_ms:
 841  01a2 89            	pushw	x
 842       00000000      OFST:	set	0
 845  01a3 200c          	jra	L562
 846  01a5               L362:
 847                     ; 297 		delay_us(1000);
 849  01a5 ae03e8        	ldw	x,#1000
 850  01a8 add9          	call	_delay_us
 852                     ; 298 		value--;
 854  01aa 1e01          	ldw	x,(OFST+1,sp)
 855  01ac 1d0001        	subw	x,#1
 856  01af 1f01          	ldw	(OFST+1,sp),x
 857  01b1               L562:
 858                     ; 295 	while(value)
 860  01b1 1e01          	ldw	x,(OFST+1,sp)
 861  01b3 26f0          	jrne	L362
 862                     ; 300 }
 866  01b5 85            	popw	x
 867  01b6 81            	ret
 880                     	xdef	_main
 881                     	xdef	_delay_ms
 882                     	xdef	_delay_us
 883                     	xdef	_MAX72xx_init
 884                     	xdef	_MAX72xx_write
 885                     	xdef	_TIM2_setup
 886                     	xdef	_ADC1_setup
 887                     	xdef	_SPI_setup
 888                     	xdef	_GPIO_setup
 889                     	xdef	_clock_setup
 890                     	xref	_TIM2_Cmd
 891                     	xref	_TIM2_OC1Init
 892                     	xref	_TIM2_TimeBaseInit
 893                     	xref	_TIM2_DeInit
 894                     	xref	_SPI_GetFlagStatus
 895                     	xref	_SPI_SendData
 896                     	xref	_SPI_Cmd
 897                     	xref	_SPI_Init
 898                     	xref	_SPI_DeInit
 899                     	xref	_GPIO_WriteLow
 900                     	xref	_GPIO_WriteHigh
 901                     	xref	_GPIO_Init
 902                     	xref	_GPIO_DeInit
 903                     	xref	_CLK_GetFlagStatus
 904                     	xref	_CLK_SYSCLKConfig
 905                     	xref	_CLK_HSIPrescalerConfig
 906                     	xref	_CLK_ClockSwitchConfig
 907                     	xref	_CLK_PeripheralClockConfig
 908                     	xref	_CLK_ClockSwitchCmd
 909                     	xref	_CLK_LSICmd
 910                     	xref	_CLK_HSICmd
 911                     	xref	_CLK_HSECmd
 912                     	xref	_CLK_DeInit
 913                     	xref	_ADC1_ClearFlag
 914                     	xref	_ADC1_GetFlagStatus
 915                     	xref	_ADC1_GetConversionValue
 916                     	xref	_ADC1_StartConversion
 917                     	xref	_ADC1_Cmd
 918                     	xref	_ADC1_Init
 919                     	xref	_ADC1_DeInit
 920                     .const:	section	.text
 921  0000               L132:
 922  0000 3e000000      	dc.w	15872,0
 923                     	xref.b	c_x
 943                     	xref	c_ftoi
 944                     	xref	c_fmul
 945                     	xref	c_uitof
 946                     	xref	c_imul
 947                     	end
