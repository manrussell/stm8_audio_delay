   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  88                     ; 95 void main(void)
  88                     ; 96 {
  90                     	switch	.text
  91  0000               _main:
  93  0000 5205          	subw	sp,#5
  94       00000005      OFST:	set	5
  97                     ; 97 	uint16_t x = 8;
  99                     ; 98 	uint16_t y = 0;
 101                     ; 100 	uint8_t res = 0;
 103                     ; 102 	clock_setup();
 105  0002 cd00c7        	call	_clock_setup
 107                     ; 103 	GPIO_setup();
 109  0005 cd0127        	call	_GPIO_setup
 111                     ; 104 	ADC1_setup();
 113  0008 cd014a        	call	_ADC1_setup
 115                     ; 106 	SPI_setup();	
 117  000b cd0186        	call	_SPI_setup
 119                     ; 107 	MCP_23K256_init();
 121  000e cd01a2        	call	_MCP_23K256_init
 123                     ; 108 	MCP4901_DAC_init();
 125  0011 cd0312        	call	_MCP4901_DAC_init
 127                     ; 114 	res = RAM_test_001();
 129  0014 ad3a          	call	_RAM_test_001
 131  0016 6b03          	ld	(OFST-2,sp),a
 133                     ; 115 	if(res != 0)
 135  0018 2702          	jreq	L54
 136  001a               L14:
 137                     ; 117 		while(1);
 139  001a 20fe          	jra	L14
 140  001c               L54:
 141                     ; 137 			ADC1_StartConversion();
 143  001c cd0000        	call	_ADC1_StartConversion
 146  001f               L35:
 147                     ; 138 			while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 149  001f a680          	ld	a,#128
 150  0021 cd0000        	call	_ADC1_GetFlagStatus
 152  0024 4d            	tnz	a
 153  0025 27f8          	jreq	L35
 154                     ; 140 			x = ADC1_GetConversionValue(); // for led knob
 156  0027 cd0000        	call	_ADC1_GetConversionValue
 158  002a 1f04          	ldw	(OFST-1,sp),x
 160                     ; 141 			ADC1_ClearFlag(ADC1_FLAG_EOC);
 162  002c a680          	ld	a,#128
 163  002e cd0000        	call	_ADC1_ClearFlag
 165                     ; 148 			x = 0.25 *(float)x ; // do i need the float or not ???
 167  0031 1e04          	ldw	x,(OFST-1,sp)
 168  0033 cd0000        	call	c_uitof
 170  0036 ae0004        	ldw	x,#L36
 171  0039 cd0000        	call	c_fmul
 173  003c cd0000        	call	c_ftoi
 175  003f 1f04          	ldw	(OFST-1,sp),x
 177                     ; 152 		MCP4901_DAC_write(0,x);
 179  0041 5f            	clrw	x
 180  0042 7b05          	ld	a,(OFST+0,sp)
 181  0044 97            	ld	xl,a
 182  0045 cd0322        	call	_MCP4901_DAC_write
 184                     ; 155 		delay_us(90);
 186  0048 ae005a        	ldw	x,#90
 187  004b cd0372        	call	_delay_us
 190  004e 20cc          	jra	L54
 255                     ; 171 uint8_t RAM_test_001(void)
 255                     ; 172 {
 256                     	switch	.text
 257  0050               _RAM_test_001:
 259  0050 5205          	subw	sp,#5
 260       00000005      OFST:	set	5
 263                     ; 173 	uint8_t cnt = 0;
 265                     ; 174 	uint8_t data = 0;
 268                     ; 175 	uint8_t wdata = 0;
 270                     ; 176 	uint16_t addr = 0;
 272                     ; 179 	data = BYTE_MODE;
 274  0052 0f03          	clr	(OFST-2,sp)
 276                     ; 180 	MCP_23K256_write_status_register(data);
 278  0054 4f            	clr	a
 279  0055 cd0206        	call	_MCP_23K256_write_status_register
 281                     ; 183 	MCP_23K256_read_status_register(&data);
 283  0058 96            	ldw	x,sp
 284  0059 1c0003        	addw	x,#OFST-2
 285  005c cd01b3        	call	_MCP_23K256_read_status_register
 287                     ; 227 wdata = 2;
 289  005f a602          	ld	a,#2
 290  0061 6b02          	ld	(OFST-3,sp),a
 292                     ; 228 addr =0;
 294  0063 5f            	clrw	x
 295  0064 1f04          	ldw	(OFST-1,sp),x
 297                     ; 230 	MCP_23K256_RAM_write_byte(addr, wdata);
 299  0066 4b02          	push	#2
 300  0068 cd0243        	call	_MCP_23K256_RAM_write_byte
 302  006b 84            	pop	a
 303                     ; 233 	MCP_23K256_RAM_read_byte(addr, &data);
 305  006c 96            	ldw	x,sp
 306  006d 1c0003        	addw	x,#OFST-2
 307  0070 89            	pushw	x
 308  0071 1e06          	ldw	x,(OFST+1,sp)
 309  0073 cd02a0        	call	_MCP_23K256_RAM_read_byte
 311  0076 a6fa          	ld	a,#250
 312  0078 85            	popw	x
 313                     ; 235 	if (wdata != data)
 315                     ; 240 wdata = 250;
 317  0079 6b02          	ld	(OFST-3,sp),a
 319                     ; 241 addr =1;
 321  007b ae0001        	ldw	x,#1
 322  007e 1f04          	ldw	(OFST-1,sp),x
 324                     ; 243 	MCP_23K256_RAM_write_byte(addr, wdata);
 326  0080 4bfa          	push	#250
 327  0082 cd0243        	call	_MCP_23K256_RAM_write_byte
 329  0085 84            	pop	a
 330                     ; 246 	MCP_23K256_RAM_read_byte(addr, &data);
 332  0086 96            	ldw	x,sp
 333  0087 1c0003        	addw	x,#OFST-2
 334  008a 89            	pushw	x
 335  008b 1e06          	ldw	x,(OFST+1,sp)
 336  008d cd02a0        	call	_MCP_23K256_RAM_read_byte
 338  0090 a604          	ld	a,#4
 339  0092 85            	popw	x
 340                     ; 248 	if (wdata != data)
 342                     ; 253 wdata = 4;
 344  0093 6b02          	ld	(OFST-3,sp),a
 346                     ; 254 addr =2;
 348  0095 ae0002        	ldw	x,#2
 349  0098 1f04          	ldw	(OFST-1,sp),x
 351                     ; 256 	MCP_23K256_RAM_write_byte(addr, wdata);
 353  009a 4b04          	push	#4
 354  009c cd0243        	call	_MCP_23K256_RAM_write_byte
 356  009f 84            	pop	a
 357                     ; 259 	MCP_23K256_RAM_read_byte(addr, &data);
 359  00a0 96            	ldw	x,sp
 360  00a1 1c0003        	addw	x,#OFST-2
 361  00a4 89            	pushw	x
 362  00a5 1e06          	ldw	x,(OFST+1,sp)
 363  00a7 cd02a0        	call	_MCP_23K256_RAM_read_byte
 365  00aa 85            	popw	x
 366                     ; 261 	if (wdata != data)
 368                     ; 267 	for(addr = 0; addr<3; addr++)
 370  00ab 5f            	clrw	x
 371  00ac 1f04          	ldw	(OFST-1,sp),x
 373  00ae               L721:
 374                     ; 269 		MCP_23K256_RAM_read_byte(addr, &data);
 376  00ae 96            	ldw	x,sp
 377  00af 1c0003        	addw	x,#OFST-2
 378  00b2 89            	pushw	x
 379  00b3 1e06          	ldw	x,(OFST+1,sp)
 380  00b5 cd02a0        	call	_MCP_23K256_RAM_read_byte
 382  00b8 85            	popw	x
 383                     ; 267 	for(addr = 0; addr<3; addr++)
 385  00b9 1e04          	ldw	x,(OFST-1,sp)
 386  00bb 5c            	incw	x
 387  00bc 1f04          	ldw	(OFST-1,sp),x
 391  00be a30003        	cpw	x,#3
 392  00c1 25eb          	jrult	L721
 393                     ; 271 	return 0;
 395  00c3 4f            	clr	a
 398  00c4 5b05          	addw	sp,#5
 399  00c6 81            	ret	
 432                     ; 274 void clock_setup(void)
 432                     ; 275 {
 433                     	switch	.text
 434  00c7               _clock_setup:
 438                     ; 276   CLK_DeInit();
 440  00c7 cd0000        	call	_CLK_DeInit
 442                     ; 278   CLK_HSECmd(DISABLE);
 444  00ca 4f            	clr	a
 445  00cb cd0000        	call	_CLK_HSECmd
 447                     ; 279   CLK_LSICmd(DISABLE);
 449  00ce 4f            	clr	a
 450  00cf cd0000        	call	_CLK_LSICmd
 452                     ; 280   CLK_HSICmd(ENABLE);
 454  00d2 a601          	ld	a,#1
 455  00d4 cd0000        	call	_CLK_HSICmd
 458  00d7               L741:
 459                     ; 281   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 461  00d7 ae0102        	ldw	x,#258
 462  00da cd0000        	call	_CLK_GetFlagStatus
 464  00dd 4d            	tnz	a
 465  00de 27f7          	jreq	L741
 466                     ; 283   CLK_ClockSwitchCmd(ENABLE);
 468  00e0 a601          	ld	a,#1
 469  00e2 cd0000        	call	_CLK_ClockSwitchCmd
 471                     ; 284   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 473  00e5 4f            	clr	a
 474  00e6 cd0000        	call	_CLK_HSIPrescalerConfig
 476                     ; 285   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 478  00e9 a680          	ld	a,#128
 479  00eb cd0000        	call	_CLK_SYSCLKConfig
 481                     ; 287   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 483  00ee 4b01          	push	#1
 484  00f0 4b00          	push	#0
 485  00f2 ae01e1        	ldw	x,#481
 486  00f5 cd0000        	call	_CLK_ClockSwitchConfig
 488  00f8 85            	popw	x
 489                     ; 289   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 491  00f9 5f            	clrw	x
 492  00fa cd0000        	call	_CLK_PeripheralClockConfig
 494                     ; 290   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 496  00fd ae0101        	ldw	x,#257
 497  0100 cd0000        	call	_CLK_PeripheralClockConfig
 499                     ; 291   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 501  0103 ae0300        	ldw	x,#768
 502  0106 cd0000        	call	_CLK_PeripheralClockConfig
 504                     ; 292   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 506  0109 ae1200        	ldw	x,#4608
 507  010c cd0000        	call	_CLK_PeripheralClockConfig
 509                     ; 293   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 511  010f ae1301        	ldw	x,#4865
 512  0112 cd0000        	call	_CLK_PeripheralClockConfig
 514                     ; 294   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 516  0115 ae0700        	ldw	x,#1792
 517  0118 cd0000        	call	_CLK_PeripheralClockConfig
 519                     ; 295   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 521  011b ae0501        	ldw	x,#1281
 522  011e cd0000        	call	_CLK_PeripheralClockConfig
 524                     ; 296   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 526  0121 ae0400        	ldw	x,#1024
 528                     ; 298 }
 531  0124 cc0000        	jp	_CLK_PeripheralClockConfig
 556                     ; 300 void GPIO_setup(void)
 556                     ; 301 {                               
 557                     	switch	.text
 558  0127               _GPIO_setup:
 562                     ; 302   GPIO_DeInit(GPIOC);
 564  0127 ae500a        	ldw	x,#20490
 565  012a cd0000        	call	_GPIO_DeInit
 567                     ; 306 	GPIO_DeInit(GPIOB);
 569  012d ae5005        	ldw	x,#20485
 570  0130 cd0000        	call	_GPIO_DeInit
 572                     ; 307   GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
 574  0133 4b00          	push	#0
 575  0135 4b01          	push	#1
 576  0137 ae5005        	ldw	x,#20485
 577  013a cd0000        	call	_GPIO_Init
 579  013d 85            	popw	x
 580                     ; 312 	GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ), 
 580                     ; 313                GPIO_MODE_OUT_PP_HIGH_FAST);
 582  013e 4bf0          	push	#240
 583  0140 4b60          	push	#96
 584  0142 ae500a        	ldw	x,#20490
 585  0145 cd0000        	call	_GPIO_Init
 587  0148 85            	popw	x
 588                     ; 314 }
 591  0149 81            	ret	
 617                     ; 316 void ADC1_setup(void)
 617                     ; 317 {
 618                     	switch	.text
 619  014a               _ADC1_setup:
 623                     ; 318   ADC1_DeInit();         
 625  014a cd0000        	call	_ADC1_DeInit
 627                     ; 320   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
 627                     ; 321   ADC1_CHANNEL_0,\
 627                     ; 322   ADC1_PRESSEL_FCPU_D18, \
 627                     ; 323   ADC1_EXTTRIG_GPIO, \
 627                     ; 324   DISABLE, \
 627                     ; 325   ADC1_ALIGN_RIGHT, \
 627                     ; 326   ADC1_SCHMITTTRIG_CHANNEL0, \
 627                     ; 327   DISABLE);
 629  014d 4b00          	push	#0
 630  014f 4b00          	push	#0
 631  0151 4b08          	push	#8
 632  0153 4b00          	push	#0
 633  0155 4b10          	push	#16
 634  0157 4b70          	push	#112
 635  0159 ae0100        	ldw	x,#256
 636  015c cd0000        	call	_ADC1_Init
 638  015f 5b06          	addw	sp,#6
 639                     ; 329   ADC1_Cmd(ENABLE);
 641  0161 a601          	ld	a,#1
 643                     ; 331 }
 646  0163 cc0000        	jp	_ADC1_Cmd
 673                     ; 336 void TIM2_setup(void)
 673                     ; 337 {
 674                     	switch	.text
 675  0166               _TIM2_setup:
 679                     ; 338   TIM2_DeInit();
 681  0166 cd0000        	call	_TIM2_DeInit
 683                     ; 339   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
 685  0169 ae03e8        	ldw	x,#1000
 686  016c 89            	pushw	x
 687  016d a605          	ld	a,#5
 688  016f cd0000        	call	_TIM2_TimeBaseInit
 690  0172 85            	popw	x
 691                     ; 340   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
 693  0173 4b00          	push	#0
 694  0175 ae03e8        	ldw	x,#1000
 695  0178 89            	pushw	x
 696  0179 ae6011        	ldw	x,#24593
 697  017c cd0000        	call	_TIM2_OC1Init
 699  017f 5b03          	addw	sp,#3
 700                     ; 341   TIM2_Cmd(ENABLE);
 702  0181 a601          	ld	a,#1
 704                     ; 343 }
 707  0183 cc0000        	jp	_TIM2_Cmd
 733                     ; 346 void SPI_setup(void)
 733                     ; 347 {
 734                     	switch	.text
 735  0186               _SPI_setup:
 739                     ; 348   SPI_DeInit();
 741  0186 cd0000        	call	_SPI_DeInit
 743                     ; 353   SPI_Init(SPI_FIRSTBIT_MSB, \
 743                     ; 354 	SPI_BAUDRATEPRESCALER_16, \
 743                     ; 355 	SPI_MODE_MASTER, \
 743                     ; 356 	SPI_CLOCKPOLARITY_LOW, \
 743                     ; 357 	SPI_CLOCKPHASE_1EDGE, \
 743                     ; 358 	SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 743                     ; 359 	SPI_NSS_SOFT, \
 743                     ; 360 	0x0);
 745  0189 4b00          	push	#0
 746  018b 4b02          	push	#2
 747  018d 4b00          	push	#0
 748  018f 4b00          	push	#0
 749  0191 4b00          	push	#0
 750  0193 4b04          	push	#4
 751  0195 ae0018        	ldw	x,#24
 752  0198 cd0000        	call	_SPI_Init
 754  019b 5b06          	addw	sp,#6
 755                     ; 362   SPI_Cmd(ENABLE);
 757  019d a601          	ld	a,#1
 759                     ; 363 }
 762  019f cc0000        	jp	_SPI_Cmd
 787                     ; 365 void MCP_23K256_init()
 787                     ; 366 {
 788                     	switch	.text
 789  01a2               _MCP_23K256_init:
 793                     ; 367 	GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 795  01a2 4bf0          	push	#240
 796  01a4 4b02          	push	#2
 797  01a6 ae5000        	ldw	x,#20480
 798  01a9 cd0000        	call	_GPIO_Init
 800  01ac 85            	popw	x
 801                     ; 368   delay_ms(10);
 803  01ad ae000a        	ldw	x,#10
 805                     ; 369 }
 808  01b0 cc0389        	jp	_delay_ms
 850                     ; 374 void MCP_23K256_read_status_register(uint8_t *data)
 850                     ; 375 {
 851                     	switch	.text
 852  01b3               _MCP_23K256_read_status_register:
 854  01b3 89            	pushw	x
 855       00000000      OFST:	set	0
 858  01b4               L342:
 859                     ; 377   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 861  01b4 a680          	ld	a,#128
 862  01b6 cd0000        	call	_SPI_GetFlagStatus
 864  01b9 4d            	tnz	a
 865  01ba 26f8          	jrne	L342
 866                     ; 379   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
 868  01bc 4b02          	push	#2
 869  01be ae5000        	ldw	x,#20480
 870  01c1 cd0000        	call	_GPIO_WriteLow
 872  01c4 84            	pop	a
 873                     ; 381   SPI_SendData(RDSR); // read ststus reg
 875  01c5 a605          	ld	a,#5
 876  01c7 cd0000        	call	_SPI_SendData
 879  01ca               L152:
 880                     ; 383   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 882  01ca a602          	ld	a,#2
 883  01cc cd0000        	call	_SPI_GetFlagStatus
 885  01cf 4d            	tnz	a
 886  01d0 27f8          	jreq	L152
 888  01d2               L752:
 889                     ; 386 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
 891  01d2 a601          	ld	a,#1
 892  01d4 cd0000        	call	_SPI_GetFlagStatus
 894  01d7 4d            	tnz	a
 895  01d8 27f8          	jreq	L752
 896                     ; 387 SPI_SendData( 255 );
 898  01da a6ff          	ld	a,#255
 899  01dc cd0000        	call	_SPI_SendData
 902  01df               L562:
 903                     ; 388 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
 905  01df a602          	ld	a,#2
 906  01e1 cd0000        	call	_SPI_GetFlagStatus
 908  01e4 4d            	tnz	a
 909  01e5 27f8          	jreq	L562
 910                     ; 390   *data = SPI_ReceiveData(); 
 912  01e7 cd0000        	call	_SPI_ReceiveData
 914  01ea 1e01          	ldw	x,(OFST+1,sp)
 915  01ec f7            	ld	(x),a
 917  01ed               L572:
 918                     ; 392   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
 920  01ed a601          	ld	a,#1
 921  01ef cd0000        	call	_SPI_GetFlagStatus
 923  01f2 4d            	tnz	a
 924  01f3 27f8          	jreq	L572
 925                     ; 396 	delay_us(1);
 927  01f5 ae0001        	ldw	x,#1
 928  01f8 cd0372        	call	_delay_us
 930                     ; 398   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
 932  01fb 4b02          	push	#2
 933  01fd ae5000        	ldw	x,#20480
 934  0200 cd0000        	call	_GPIO_WriteHigh
 936                     ; 399 }
 939  0203 5b03          	addw	sp,#3
 940  0205 81            	ret	
 980                     ; 408 void MCP_23K256_write_status_register(uint8_t data)
 980                     ; 409 {
 981                     	switch	.text
 982  0206               _MCP_23K256_write_status_register:
 984  0206 88            	push	a
 985       00000000      OFST:	set	0
 988  0207               L123:
 989                     ; 411   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
 991  0207 a680          	ld	a,#128
 992  0209 cd0000        	call	_SPI_GetFlagStatus
 994  020c 4d            	tnz	a
 995  020d 26f8          	jrne	L123
 996                     ; 413   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
 998  020f 4b02          	push	#2
 999  0211 ae5000        	ldw	x,#20480
1000  0214 cd0000        	call	_GPIO_WriteLow
1002  0217 84            	pop	a
1003                     ; 416   SPI_SendData(WRSR); 
1005  0218 a601          	ld	a,#1
1006  021a cd0000        	call	_SPI_SendData
1009  021d               L723:
1010                     ; 417   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1012  021d a602          	ld	a,#2
1013  021f cd0000        	call	_SPI_GetFlagStatus
1015  0222 4d            	tnz	a
1016  0223 27f8          	jreq	L723
1017                     ; 420   SPI_SendData(data); 
1019  0225 7b01          	ld	a,(OFST+1,sp)
1020  0227 cd0000        	call	_SPI_SendData
1023  022a               L533:
1024                     ; 421   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1026  022a a602          	ld	a,#2
1027  022c cd0000        	call	_SPI_GetFlagStatus
1029  022f 4d            	tnz	a
1030  0230 27f8          	jreq	L533
1031                     ; 425 	delay_us(1);
1033  0232 ae0001        	ldw	x,#1
1034  0235 cd0372        	call	_delay_us
1036                     ; 427   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1038  0238 4b02          	push	#2
1039  023a ae5000        	ldw	x,#20480
1040  023d cd0000        	call	_GPIO_WriteHigh
1042                     ; 429 }
1045  0240 5b02          	addw	sp,#2
1046  0242 81            	ret	
1104                     ; 438 void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
1104                     ; 439 {
1105                     	switch	.text
1106  0243               _MCP_23K256_RAM_write_byte:
1108  0243 89            	pushw	x
1109  0244 88            	push	a
1110       00000001      OFST:	set	1
1113                     ; 440 	uint8_t addr = 0;
1116  0245               L173:
1117                     ; 442   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1119  0245 a680          	ld	a,#128
1120  0247 cd0000        	call	_SPI_GetFlagStatus
1122  024a 4d            	tnz	a
1123  024b 26f8          	jrne	L173
1124                     ; 444   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1126  024d 4b02          	push	#2
1127  024f ae5000        	ldw	x,#20480
1128  0252 cd0000        	call	_GPIO_WriteLow
1130  0255 84            	pop	a
1131                     ; 447   SPI_SendData(WRITE); // instruction 2 write
1133  0256 a602          	ld	a,#2
1134  0258 cd0000        	call	_SPI_SendData
1137  025b               L773:
1138                     ; 448   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1140  025b a602          	ld	a,#2
1141  025d cd0000        	call	_SPI_GetFlagStatus
1143  0260 4d            	tnz	a
1144  0261 27f8          	jreq	L773
1145                     ; 451 	addr = address>>8;
1147  0263 7b02          	ld	a,(OFST+1,sp)
1148  0265 6b01          	ld	(OFST+0,sp),a
1150                     ; 452   SPI_SendData(addr); // send 16 bit address // MSB is don't care
1152  0267 cd0000        	call	_SPI_SendData
1155  026a               L504:
1156                     ; 453   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1158  026a a602          	ld	a,#2
1159  026c cd0000        	call	_SPI_GetFlagStatus
1161  026f 4d            	tnz	a
1162  0270 27f8          	jreq	L504
1163                     ; 456 	addr = (address&255);
1165  0272 7b03          	ld	a,(OFST+2,sp)
1166  0274 6b01          	ld	(OFST+0,sp),a
1168                     ; 457   SPI_SendData( addr );
1170  0276 cd0000        	call	_SPI_SendData
1173  0279               L314:
1174                     ; 458   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1176  0279 a602          	ld	a,#2
1177  027b cd0000        	call	_SPI_GetFlagStatus
1179  027e 4d            	tnz	a
1180  027f 27f8          	jreq	L314
1181                     ; 460   SPI_SendData(value); 
1183  0281 7b06          	ld	a,(OFST+5,sp)
1184  0283 cd0000        	call	_SPI_SendData
1187  0286               L124:
1188                     ; 462   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1190  0286 a602          	ld	a,#2
1191  0288 cd0000        	call	_SPI_GetFlagStatus
1193  028b 4d            	tnz	a
1194  028c 27f8          	jreq	L124
1195                     ; 466 	delay_us(1);
1197  028e ae0001        	ldw	x,#1
1198  0291 cd0372        	call	_delay_us
1200                     ; 468   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1202  0294 4b02          	push	#2
1203  0296 ae5000        	ldw	x,#20480
1204  0299 cd0000        	call	_GPIO_WriteHigh
1206  029c 84            	pop	a
1207                     ; 471 }
1210  029d 5b03          	addw	sp,#3
1211  029f 81            	ret	
1271                     ; 478 void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
1271                     ; 479 {		
1272                     	switch	.text
1273  02a0               _MCP_23K256_RAM_read_byte:
1275  02a0 89            	pushw	x
1276  02a1 88            	push	a
1277       00000001      OFST:	set	1
1280                     ; 480 	uint8_t addr = 0;
1283  02a2               L554:
1284                     ; 482   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1286  02a2 a680          	ld	a,#128
1287  02a4 cd0000        	call	_SPI_GetFlagStatus
1289  02a7 4d            	tnz	a
1290  02a8 26f8          	jrne	L554
1291                     ; 484   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1293  02aa 4b02          	push	#2
1294  02ac ae5000        	ldw	x,#20480
1295  02af cd0000        	call	_GPIO_WriteLow
1297  02b2 84            	pop	a
1298                     ; 486   SPI_SendData(READ); // instruction 3 read
1300  02b3 a603          	ld	a,#3
1301  02b5 cd0000        	call	_SPI_SendData
1304  02b8               L364:
1305                     ; 488   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1307  02b8 a602          	ld	a,#2
1308  02ba cd0000        	call	_SPI_GetFlagStatus
1310  02bd 4d            	tnz	a
1311  02be 27f8          	jreq	L364
1312                     ; 491 	addr = address>>8;
1314  02c0 7b02          	ld	a,(OFST+1,sp)
1315  02c2 6b01          	ld	(OFST+0,sp),a
1317                     ; 492   SPI_SendData(addr); // send 16 bit address // MSB is don't care
1319  02c4 cd0000        	call	_SPI_SendData
1322  02c7               L174:
1323                     ; 493   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1325  02c7 a602          	ld	a,#2
1326  02c9 cd0000        	call	_SPI_GetFlagStatus
1328  02cc 4d            	tnz	a
1329  02cd 27f8          	jreq	L174
1330                     ; 496 	addr = (address&255);
1332  02cf 7b03          	ld	a,(OFST+2,sp)
1333  02d1 6b01          	ld	(OFST+0,sp),a
1335                     ; 497   SPI_SendData( addr );
1337  02d3 cd0000        	call	_SPI_SendData
1340  02d6               L774:
1341                     ; 498   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1343  02d6 a602          	ld	a,#2
1344  02d8 cd0000        	call	_SPI_GetFlagStatus
1346  02db 4d            	tnz	a
1347  02dc 27f8          	jreq	L774
1349  02de               L505:
1350                     ; 502 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
1352  02de a601          	ld	a,#1
1353  02e0 cd0000        	call	_SPI_GetFlagStatus
1355  02e3 4d            	tnz	a
1356  02e4 27f8          	jreq	L505
1357                     ; 503 SPI_SendData( 255 );
1359  02e6 a6ff          	ld	a,#255
1360  02e8 cd0000        	call	_SPI_SendData
1363  02eb               L315:
1364                     ; 504 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1366  02eb a602          	ld	a,#2
1367  02ed cd0000        	call	_SPI_GetFlagStatus
1369  02f0 4d            	tnz	a
1370  02f1 27f8          	jreq	L315
1372  02f3               L125:
1373                     ; 505 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));	
1375  02f3 a601          	ld	a,#1
1376  02f5 cd0000        	call	_SPI_GetFlagStatus
1378  02f8 4d            	tnz	a
1379  02f9 27f8          	jreq	L125
1380                     ; 508   *value = SPI_ReceiveData();  
1382  02fb cd0000        	call	_SPI_ReceiveData
1384  02fe 1e06          	ldw	x,(OFST+5,sp)
1385  0300 f7            	ld	(x),a
1386                     ; 515 	delay_us(1);
1388  0301 ae0001        	ldw	x,#1
1389  0304 ad6c          	call	_delay_us
1391                     ; 517   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1393  0306 4b02          	push	#2
1394  0308 ae5000        	ldw	x,#20480
1395  030b cd0000        	call	_GPIO_WriteHigh
1397  030e 84            	pop	a
1398                     ; 518 }
1401  030f 5b03          	addw	sp,#3
1402  0311 81            	ret	
1427                     ; 523 void MCP4901_DAC_init(void)
1427                     ; 524 {
1428                     	switch	.text
1429  0312               _MCP4901_DAC_init:
1433                     ; 525   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
1435  0312 4bf0          	push	#240
1436  0314 4b10          	push	#16
1437  0316 ae500a        	ldw	x,#20490
1438  0319 cd0000        	call	_GPIO_Init
1440  031c 85            	popw	x
1441                     ; 526   delay_ms(10);
1443  031d ae000a        	ldw	x,#10
1445                     ; 527 }
1448  0320 2067          	jp	_delay_ms
1496                     ; 533 void MCP4901_DAC_write(unsigned char address, unsigned char value)
1496                     ; 534 {
1497                     	switch	.text
1498  0322               _MCP4901_DAC_write:
1500  0322 89            	pushw	x
1501       00000000      OFST:	set	0
1504                     ; 561 	address = 0x30; // 00,11,00,00
1506  0323 a630          	ld	a,#48
1507  0325 6b01          	ld	(OFST+1,sp),a
1508                     ; 562 	address |= ( value>>4); // assume 0's shoved in the left
1510  0327 7b02          	ld	a,(OFST+2,sp)
1511  0329 4e            	swap	a
1512  032a a40f          	and	a,#15
1513  032c 1a01          	or	a,(OFST+1,sp)
1514  032e 6b01          	ld	(OFST+1,sp),a
1515                     ; 564 	value = ( value<<4 ); // assume 0 shoved in from the right
1517  0330 7b02          	ld	a,(OFST+2,sp)
1518  0332 4e            	swap	a
1519  0333 a4f0          	and	a,#240
1520  0335 6b02          	ld	(OFST+2,sp),a
1522  0337               L165:
1523                     ; 567   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1525  0337 a680          	ld	a,#128
1526  0339 cd0000        	call	_SPI_GetFlagStatus
1528  033c 4d            	tnz	a
1529  033d 26f8          	jrne	L165
1530                     ; 569   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
1532  033f 4b10          	push	#16
1533  0341 ae500a        	ldw	x,#20490
1534  0344 cd0000        	call	_GPIO_WriteLow
1536  0347 84            	pop	a
1537                     ; 571   SPI_SendData(address);
1539  0348 7b01          	ld	a,(OFST+1,sp)
1540  034a cd0000        	call	_SPI_SendData
1543  034d               L765:
1544                     ; 573   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1546  034d a602          	ld	a,#2
1547  034f cd0000        	call	_SPI_GetFlagStatus
1549  0352 4d            	tnz	a
1550  0353 27f8          	jreq	L765
1551                     ; 575   SPI_SendData(value); 
1553  0355 7b02          	ld	a,(OFST+2,sp)
1554  0357 cd0000        	call	_SPI_SendData
1557  035a               L575:
1558                     ; 577   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1560  035a a602          	ld	a,#2
1561  035c cd0000        	call	_SPI_GetFlagStatus
1563  035f 4d            	tnz	a
1564  0360 27f8          	jreq	L575
1565                     ; 581 	delay_us(1);
1567  0362 ae0001        	ldw	x,#1
1568  0365 ad0b          	call	_delay_us
1570                     ; 588   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
1572  0367 4b10          	push	#16
1573  0369 ae500a        	ldw	x,#20490
1574  036c cd0000        	call	_GPIO_WriteHigh
1576                     ; 590 }
1579  036f 5b03          	addw	sp,#3
1580  0371 81            	ret	
1624                     ; 599 void delay_us(unsigned int  value)
1624                     ; 600 {
1625                     	switch	.text
1626  0372               _delay_us:
1628  0372 89            	pushw	x
1629       00000002      OFST:	set	2
1632                     ; 601 	register unsigned int loops =  (dly_const * value) ;
1634  0373 cd0000        	call	c_uitof
1636  0376 ae0000        	ldw	x,#L726
1637  0379 cd0000        	call	c_fmul
1639  037c cd0000        	call	c_ftoi
1642  037f 2002          	jra	L736
1643  0381               L336:
1644                     ; 605 		_asm ("nop");
1647  0381 9d            	nop	
1649                     ; 606 		loops--;
1651  0382 5a            	decw	x
1652  0383               L736:
1653  0383 1f01          	ldw	(OFST-1,sp),x
1655                     ; 603 	while(loops)
1657  0385 26fa          	jrne	L336
1658                     ; 608 }
1662  0387 85            	popw	x
1663  0388 81            	ret	
1698                     ; 610 void delay_ms(unsigned int  value)
1698                     ; 611 {
1699                     	switch	.text
1700  0389               _delay_ms:
1702  0389 89            	pushw	x
1703       00000000      OFST:	set	0
1706  038a 200a          	jra	L366
1707  038c               L166:
1708                     ; 614 		delay_us(1000);
1710  038c ae03e8        	ldw	x,#1000
1711  038f ade1          	call	_delay_us
1713                     ; 615 		value--;
1715  0391 1e01          	ldw	x,(OFST+1,sp)
1716  0393 5a            	decw	x
1717  0394 1f01          	ldw	(OFST+1,sp),x
1718  0396               L366:
1719                     ; 612 	while(value)
1721  0396 1e01          	ldw	x,(OFST+1,sp)
1722  0398 26f2          	jrne	L166
1723                     ; 617 }
1727  039a 85            	popw	x
1728  039b 81            	ret	
1741                     	xdef	_main
1742                     	xdef	_RAM_test_001
1743                     	xdef	_delay_ms
1744                     	xdef	_delay_us
1745                     	xdef	_MCP_23K256_write_status_register
1746                     	xdef	_MCP_23K256_read_status_register
1747                     	xdef	_MCP_23K256_RAM_write_byte
1748                     	xdef	_MCP_23K256_RAM_read_byte
1749                     	xdef	_MCP_23K256_init
1750                     	xdef	_MCP4901_DAC_init
1751                     	xdef	_MCP4901_DAC_write
1752                     	xdef	_TIM2_setup
1753                     	xdef	_ADC1_setup
1754                     	xdef	_SPI_setup
1755                     	xdef	_GPIO_setup
1756                     	xdef	_clock_setup
1757                     	xref	_TIM2_Cmd
1758                     	xref	_TIM2_OC1Init
1759                     	xref	_TIM2_TimeBaseInit
1760                     	xref	_TIM2_DeInit
1761                     	xref	_SPI_GetFlagStatus
1762                     	xref	_SPI_ReceiveData
1763                     	xref	_SPI_SendData
1764                     	xref	_SPI_Cmd
1765                     	xref	_SPI_Init
1766                     	xref	_SPI_DeInit
1767                     	xref	_GPIO_WriteLow
1768                     	xref	_GPIO_WriteHigh
1769                     	xref	_GPIO_Init
1770                     	xref	_GPIO_DeInit
1771                     	xref	_CLK_GetFlagStatus
1772                     	xref	_CLK_SYSCLKConfig
1773                     	xref	_CLK_HSIPrescalerConfig
1774                     	xref	_CLK_ClockSwitchConfig
1775                     	xref	_CLK_PeripheralClockConfig
1776                     	xref	_CLK_ClockSwitchCmd
1777                     	xref	_CLK_LSICmd
1778                     	xref	_CLK_HSICmd
1779                     	xref	_CLK_HSECmd
1780                     	xref	_CLK_DeInit
1781                     	xref	_ADC1_ClearFlag
1782                     	xref	_ADC1_GetFlagStatus
1783                     	xref	_ADC1_GetConversionValue
1784                     	xref	_ADC1_StartConversion
1785                     	xref	_ADC1_Cmd
1786                     	xref	_ADC1_Init
1787                     	xref	_ADC1_DeInit
1788                     .const:	section	.text
1789  0000               L726:
1790  0000 3e000000      	dc.w	15872,0
1791  0004               L36:
1792  0004 3e800000      	dc.w	16000,0
1793                     	xref.b	c_x
1813                     	xref	c_ftoi
1814                     	xref	c_fmul
1815                     	xref	c_uitof
1816                     	end
