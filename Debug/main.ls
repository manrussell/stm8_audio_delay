   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 145                     ; 70 void main( void )
 145                     ; 71 {
 147                     	switch	.text
 148  0000               _main:
 150  0000 520f          	subw	sp,#15
 151       0000000f      OFST:	set	15
 154                     ; 72     uint16_t adc_leftChannel = 0;
 156                     ; 73     uint16_t adc_feedback    = 0;
 158                     ; 74     uint16_t adc_delay       = 0;
 160                     ; 75     uint8_t  mapd_value      = 0;    // mapped adc valu
 162                     ; 76     uint8_t  read_val        = 0;    // read val from ram
 164  0002 0f08          	clr	(OFST-7,sp)
 166                     ; 77     uint16_t write_addr      = 0;    // write addr in ram
 168  0004 5f            	clrw	x
 169  0005 1f0c          	ldw	(OFST-3,sp),x
 171                     ; 78     uint16_t read_addr       = 0;    // read addr in val
 173  0007 1f09          	ldw	(OFST-6,sp),x
 175                     ; 79     uint16_t delay           = 110;  // length of delay in samples
 177                     ; 80     uint8_t  res             = 0;
 179                     ; 82     clock_setup();
 181  0009 ad7a          	call	_clock_setup
 183                     ; 83     GPIO_setup();
 185  000b cd00fe        	call	_GPIO_setup
 187                     ; 84     ADC1_setup();
 189  000e cd00ff        	call	_ADC1_setup
 191                     ; 85     SPI_setup();
 193  0011 cd014c        	call	_SPI_setup
 195                     ; 86     MCP_23K256_RAM_init();
 197  0014 cd0000        	call	_MCP_23K256_RAM_init
 199                     ; 87     MCP4901_DAC_init();
 201  0017 cd0000        	call	_MCP4901_DAC_init
 203                     ; 88     TIM2_setup( );
 205  001a cd00e5        	call	_TIM2_setup
 207  001d               L76:
 208                     ; 97         ADC1_ScanModeCmd( ENABLE );
 210  001d a601          	ld	a,#1
 211  001f cd0000        	call	_ADC1_ScanModeCmd
 213                     ; 98         ADC1_StartConversion( );
 215  0022 cd0000        	call	_ADC1_StartConversion
 218  0025               L57:
 219                     ; 99         while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 221  0025 a680          	ld	a,#128
 222  0027 cd0000        	call	_ADC1_GetFlagStatus
 224  002a 4d            	tnz	a
 225  002b 27f8          	jreq	L57
 226                     ; 100         ADC1_ClearFlag(ADC1_FLAG_EOC);
 228  002d a680          	ld	a,#128
 229  002f cd0000        	call	_ADC1_ClearFlag
 231                     ; 101         adc_leftChannel = ADC1_GetBufferValue( 0); //ADC_LEFTCHANNEL );     // 0
 233  0032 4f            	clr	a
 234  0033 cd0000        	call	_ADC1_GetBufferValue
 236  0036 1f06          	ldw	(OFST-9,sp),x
 238                     ; 102         adc_delay       = ADC1_GetBufferValue( 1); //ADC_FEEDBACK_AMOUNT ); // 1
 240  0038 a601          	ld	a,#1
 241  003a cd0000        	call	_ADC1_GetBufferValue
 244                     ; 107         delay = ( adc_delay << 2 ); //(adc_delay >> 2);
 246  003d 58            	sllw	x
 247  003e 58            	sllw	x
 248  003f 1f0e          	ldw	(OFST-1,sp),x
 250                     ; 114         mapd_value = (adc_leftChannel >> 2);
 252  0041 1e06          	ldw	x,(OFST-9,sp)
 253  0043 54            	srlw	x
 254  0044 54            	srlw	x
 255  0045 01            	rrwa	x,a
 256  0046 6b0b          	ld	(OFST-4,sp),a
 258                     ; 117         mapd_value = mapd_value/2 +  read_val/2;
 260  0048 5f            	clrw	x
 261  0049 7b08          	ld	a,(OFST-7,sp)
 262  004b 97            	ld	xl,a
 263  004c 57            	sraw	x
 264  004d 1f01          	ldw	(OFST-14,sp),x
 266  004f 5f            	clrw	x
 267  0050 7b0b          	ld	a,(OFST-4,sp)
 268  0052 97            	ld	xl,a
 269  0053 57            	sraw	x
 270  0054 72fb01        	addw	x,(OFST-14,sp)
 271  0057 01            	rrwa	x,a
 272  0058 6b0b          	ld	(OFST-4,sp),a
 274                     ; 128             read_addr = write_addr - delay;
 276  005a 1e0c          	ldw	x,(OFST-3,sp)
 277  005c 72f00e        	subw	x,(OFST-1,sp)
 278  005f 1f09          	ldw	(OFST-6,sp),x
 280                     ; 132         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 282  0061 88            	push	a
 283  0062 1e0d          	ldw	x,(OFST-2,sp)
 284  0064 cd0000        	call	_MCP_23K256_RAM_write_byte
 286  0067 84            	pop	a
 287                     ; 135         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 289  0068 96            	ldw	x,sp
 290  0069 1c0008        	addw	x,#OFST-7
 291  006c 89            	pushw	x
 292  006d 1e0b          	ldw	x,(OFST-4,sp)
 293  006f cd0000        	call	_MCP_23K256_RAM_read_byte
 295  0072 85            	popw	x
 296                     ; 138         MCP4901_DAC_write(read_val);
 298  0073 7b08          	ld	a,(OFST-7,sp)
 299  0075 cd0000        	call	_MCP4901_DAC_write
 301                     ; 141         write_addr++;
 303  0078 1e0c          	ldw	x,(OFST-3,sp)
 304  007a 5c            	incw	x
 305  007b 1f0c          	ldw	(OFST-3,sp),x
 307                     ; 144         delay_us(90);
 309  007d ae005a        	ldw	x,#90
 310  0080 cd0000        	call	_delay_us
 313  0083 2098          	jra	L76
 346                     ; 150 void clock_setup(void)
 346                     ; 151 {
 347                     	switch	.text
 348  0085               _clock_setup:
 352                     ; 152   CLK_DeInit();
 354  0085 cd0000        	call	_CLK_DeInit
 356                     ; 154   CLK_HSECmd(DISABLE); // DISABLE ->24MHz ext, what do i have 16?
 358  0088 4f            	clr	a
 359  0089 cd0000        	call	_CLK_HSECmd
 361                     ; 155   CLK_LSICmd(DISABLE);
 363  008c 4f            	clr	a
 364  008d cd0000        	call	_CLK_LSICmd
 366                     ; 156   CLK_HSICmd(ENABLE);   //ENABLE, 16MHz internal
 368  0090 a601          	ld	a,#1
 369  0092 cd0000        	call	_CLK_HSICmd
 372  0095               L311:
 373                     ; 157   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 375  0095 ae0102        	ldw	x,#258
 376  0098 cd0000        	call	_CLK_GetFlagStatus
 378  009b 4d            	tnz	a
 379  009c 27f7          	jreq	L311
 380                     ; 159   CLK_ClockSwitchCmd(ENABLE);
 382  009e a601          	ld	a,#1
 383  00a0 cd0000        	call	_CLK_ClockSwitchCmd
 385                     ; 160   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 387  00a3 4f            	clr	a
 388  00a4 cd0000        	call	_CLK_HSIPrescalerConfig
 390                     ; 161   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 392  00a7 a680          	ld	a,#128
 393  00a9 cd0000        	call	_CLK_SYSCLKConfig
 395                     ; 163   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 397  00ac 4b01          	push	#1
 398  00ae 4b00          	push	#0
 399  00b0 ae01e1        	ldw	x,#481
 400  00b3 cd0000        	call	_CLK_ClockSwitchConfig
 402  00b6 85            	popw	x
 403                     ; 165   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 405  00b7 5f            	clrw	x
 406  00b8 cd0000        	call	_CLK_PeripheralClockConfig
 408                     ; 166   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 410  00bb ae0101        	ldw	x,#257
 411  00be cd0000        	call	_CLK_PeripheralClockConfig
 413                     ; 167   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 415  00c1 ae0300        	ldw	x,#768
 416  00c4 cd0000        	call	_CLK_PeripheralClockConfig
 418                     ; 168   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 420  00c7 ae1200        	ldw	x,#4608
 421  00ca cd0000        	call	_CLK_PeripheralClockConfig
 423                     ; 169   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 425  00cd ae1301        	ldw	x,#4865
 426  00d0 cd0000        	call	_CLK_PeripheralClockConfig
 428                     ; 170   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 430  00d3 ae0700        	ldw	x,#1792
 431  00d6 cd0000        	call	_CLK_PeripheralClockConfig
 433                     ; 171   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 435  00d9 ae0501        	ldw	x,#1281
 436  00dc cd0000        	call	_CLK_PeripheralClockConfig
 438                     ; 172   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 440  00df ae0401        	ldw	x,#1025
 442                     ; 174 }
 445  00e2 cc0000        	jp	_CLK_PeripheralClockConfig
 473                     ; 184 void TIM2_setup( void )
 473                     ; 185 {
 474                     	switch	.text
 475  00e5               _TIM2_setup:
 479                     ; 186   TIM2_DeInit( );
 481  00e5 cd0000        	call	_TIM2_DeInit
 483                     ; 187   TIM2_TimeBaseInit( TIM2_PRESCALER_1, 1451 );
 485  00e8 ae05ab        	ldw	x,#1451
 486  00eb 89            	pushw	x
 487  00ec 4f            	clr	a
 488  00ed cd0000        	call	_TIM2_TimeBaseInit
 490  00f0 85            	popw	x
 491                     ; 188   TIM2_ITConfig( TIM2_IT_UPDATE, ENABLE );
 493  00f1 ae0101        	ldw	x,#257
 494  00f4 cd0000        	call	_TIM2_ITConfig
 496                     ; 189   TIM2_Cmd( ENABLE );
 498  00f7 a601          	ld	a,#1
 499  00f9 cd0000        	call	_TIM2_Cmd
 501                     ; 190   enableInterrupts( );
 504  00fc 9a            	rim	
 506                     ; 191 }
 510  00fd 81            	ret	
 533                     ; 194 void GPIO_setup( void )
 533                     ; 195 {
 534                     	switch	.text
 535  00fe               _GPIO_setup:
 539                     ; 197 }
 542  00fe 81            	ret	
 572                     ; 225 void ADC1_setup(void)
 572                     ; 226 {
 573                     	switch	.text
 574  00ff               _ADC1_setup:
 578                     ; 229   GPIO_DeInit(ADC_port);
 580  00ff ae5005        	ldw	x,#20485
 581  0102 cd0000        	call	_GPIO_DeInit
 583                     ; 230   GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
 585  0105 4b00          	push	#0
 586  0107 4b0f          	push	#15
 587  0109 ae5005        	ldw	x,#20485
 588  010c cd0000        	call	_GPIO_Init
 590  010f 85            	popw	x
 591                     ; 232   ADC1_DeInit();
 593  0110 cd0000        	call	_ADC1_DeInit
 595                     ; 234   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 595                     ; 235   ADC1_CHANNEL_0,\
 595                     ; 236   ADC1_PRESSEL_FCPU_D18, \
 595                     ; 237   ADC1_EXTTRIG_GPIO, \
 595                     ; 238   DISABLE, \
 595                     ; 239   ADC1_ALIGN_RIGHT, \
 595                     ; 240   ADC1_SCHMITTTRIG_CHANNEL0, \
 595                     ; 241   DISABLE);
 597  0113 4b00          	push	#0
 598  0115 4b00          	push	#0
 599  0117 4b08          	push	#8
 600  0119 4b00          	push	#0
 601  011b 4b10          	push	#16
 602  011d 4b70          	push	#112
 603  011f 5f            	clrw	x
 604  0120 cd0000        	call	_ADC1_Init
 606  0123 5b06          	addw	sp,#6
 607                     ; 243   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 607                     ; 244   ADC1_CHANNEL_1,\
 607                     ; 245   ADC1_PRESSEL_FCPU_D18, \
 607                     ; 246   ADC1_EXTTRIG_GPIO, \
 607                     ; 247   DISABLE, \
 607                     ; 248   ADC1_ALIGN_RIGHT, \
 607                     ; 249   ADC1_SCHMITTTRIG_CHANNEL1, \
 607                     ; 250   DISABLE);
 609  0125 4b00          	push	#0
 610  0127 4b01          	push	#1
 611  0129 4b08          	push	#8
 612  012b 4b00          	push	#0
 613  012d 4b10          	push	#16
 614  012f 4b70          	push	#112
 615  0131 ae0001        	ldw	x,#1
 616  0134 cd0000        	call	_ADC1_Init
 618  0137 5b06          	addw	sp,#6
 619                     ; 252   ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);
 621  0139 4b08          	push	#8
 622  013b ae0001        	ldw	x,#1
 623  013e cd0000        	call	_ADC1_ConversionConfig
 625  0141 84            	pop	a
 626                     ; 254   ADC1_DataBufferCmd(ENABLE);
 628  0142 a601          	ld	a,#1
 629  0144 cd0000        	call	_ADC1_DataBufferCmd
 631                     ; 255   ADC1_Cmd(ENABLE);
 633  0147 a601          	ld	a,#1
 635                     ; 257 }
 638  0149 cc0000        	jp	_ADC1_Cmd
 665                     ; 264 void SPI_setup(void)
 665                     ; 265 {
 666                     	switch	.text
 667  014c               _SPI_setup:
 671                     ; 266   GPIO_Init(SPI_PORT, (GPIO_Pin_TypeDef)(SPI_CLK | SPI_MOSI | SPI_MISO), GPIO_MODE_OUT_PP_HIGH_FAST);
 673  014c 4bf0          	push	#240
 674  014e 4be0          	push	#224
 675  0150 ae500a        	ldw	x,#20490
 676  0153 cd0000        	call	_GPIO_Init
 678  0156 85            	popw	x
 679                     ; 268   SPI_DeInit();
 681  0157 cd0000        	call	_SPI_DeInit
 683                     ; 270   SPI_Init(SPI_FIRSTBIT_MSB, \
 683                     ; 271     SPI_BAUDRATEPRESCALER_16, \
 683                     ; 272     SPI_MODE_MASTER, \
 683                     ; 273     SPI_CLOCKPOLARITY_LOW, \
 683                     ; 274     SPI_CLOCKPHASE_1EDGE, \
 683                     ; 275     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 683                     ; 276     SPI_NSS_SOFT, \
 683                     ; 277     0x0);
 685  015a 4b00          	push	#0
 686  015c 4b02          	push	#2
 687  015e 4b00          	push	#0
 688  0160 4b00          	push	#0
 689  0162 4b00          	push	#0
 690  0164 4b04          	push	#4
 691  0166 ae0018        	ldw	x,#24
 692  0169 cd0000        	call	_SPI_Init
 694  016c 5b06          	addw	sp,#6
 695                     ; 279   SPI_Cmd(ENABLE);
 697  016e a601          	ld	a,#1
 699                     ; 280 }
 702  0170 cc0000        	jp	_SPI_Cmd
 715                     	xdef	_main
 716                     	xdef	_TIM2_setup
 717                     	xdef	_ADC1_setup
 718                     	xdef	_SPI_setup
 719                     	xdef	_GPIO_setup
 720                     	xdef	_clock_setup
 721                     	xref	_MCP_23K256_RAM_read_byte
 722                     	xref	_MCP_23K256_RAM_write_byte
 723                     	xref	_MCP_23K256_RAM_init
 724                     	xref	_MCP4901_DAC_write
 725                     	xref	_MCP4901_DAC_init
 726                     	xref	_delay_us
 727                     	xref	_TIM2_ITConfig
 728                     	xref	_TIM2_Cmd
 729                     	xref	_TIM2_TimeBaseInit
 730                     	xref	_TIM2_DeInit
 731                     	xref	_SPI_Cmd
 732                     	xref	_SPI_Init
 733                     	xref	_SPI_DeInit
 734                     	xref	_GPIO_Init
 735                     	xref	_GPIO_DeInit
 736                     	xref	_CLK_GetFlagStatus
 737                     	xref	_CLK_SYSCLKConfig
 738                     	xref	_CLK_HSIPrescalerConfig
 739                     	xref	_CLK_ClockSwitchConfig
 740                     	xref	_CLK_PeripheralClockConfig
 741                     	xref	_CLK_ClockSwitchCmd
 742                     	xref	_CLK_LSICmd
 743                     	xref	_CLK_HSICmd
 744                     	xref	_CLK_HSECmd
 745                     	xref	_CLK_DeInit
 746                     	xref	_ADC1_ClearFlag
 747                     	xref	_ADC1_GetFlagStatus
 748                     	xref	_ADC1_GetBufferValue
 749                     	xref	_ADC1_StartConversion
 750                     	xref	_ADC1_ConversionConfig
 751                     	xref	_ADC1_DataBufferCmd
 752                     	xref	_ADC1_ScanModeCmd
 753                     	xref	_ADC1_Cmd
 754                     	xref	_ADC1_Init
 755                     	xref	_ADC1_DeInit
 774                     	end
