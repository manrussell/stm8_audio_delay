   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  18                     	bsct
  19  0000               _state:
  20  0000 00            	dc.b	0
  21                     .const:	section	.text
  22  0000               L3_delay_length_samples:
  23  0000 0000          	dc.w	0
  24  0002 000000000000  	ds.b	6
 163                     ; 61 void main( void )
 163                     ; 62 {
 165                     	switch	.text
 166  0000               _main:
 168  0000 5217          	subw	sp,#23
 169       00000017      OFST:	set	23
 172                     ; 63     uint16_t adc_leftChannel = 0;
 174                     ; 64     uint16_t adc_feedback    = 0;
 176                     ; 65     uint16_t adc_delay       = 0;
 178                     ; 66     uint8_t  mapd_value      = 0;    // mapped adc valu
 180                     ; 67     uint8_t  read_val        = 0;    // read val from ram
 182  0002 0f0e          	clr	(OFST-9,sp)
 184                     ; 68     uint16_t write_addr      = 0;    // write addr in ram
 186  0004 5f            	clrw	x
 187  0005 1f16          	ldw	(OFST-1,sp),x
 189                     ; 69     uint16_t read_addr       = 0;    // read addr in val
 191  0007 1f0f          	ldw	(OFST-8,sp),x
 193                     ; 70     uint16_t delay           = 110;  // length of delay in samples
 195  0009 ae006e        	ldw	x,#110
 196  000c 1f12          	ldw	(OFST-5,sp),x
 198                     ; 71     uint8_t  res             = 0;
 200                     ; 73     uint16_t delay_length_samples[NUM_Of_ADCPOT_SAMPLES] = {0}; // 4 samples of the pot are calculated
 202  000e 96            	ldw	x,sp
 203  000f 1c0006        	addw	x,#OFST-17
 204  0012 90ae0000      	ldw	y,#L3_delay_length_samples
 205  0016 a608          	ld	a,#8
 206  0018 cd0000        	call	c_xymvx
 208                     ; 75     clock_setup( );
 210  001b cd00d5        	call	_clock_setup
 212                     ; 76     GPIO_setup( );
 214  001e cd014e        	call	_GPIO_setup
 216                     ; 77     ADC1_setup( );
 218  0021 cd014f        	call	_ADC1_setup
 220                     ; 78     SPI_setup( );
 222  0024 cd019c        	call	_SPI_setup
 224                     ; 79     MCP_23K256_RAM_init( );
 226  0027 cd0000        	call	_MCP_23K256_RAM_init
 228                     ; 80     MCP4901_DAC_init( );
 230  002a cd0000        	call	_MCP4901_DAC_init
 232                     ; 81     TIM2_setup( );
 234  002d cd0135        	call	_TIM2_setup
 236  0030               L111:
 237                     ; 86         switch( state )
 239  0030 b600          	ld	a,_state
 241                     ; 173             default:
 241                     ; 174                 /* do nothing */
 241                     ; 175                 break;
 242  0032 270f          	jreq	L5
 243  0034 4a            	dec	a
 244  0035 270c          	jreq	L5
 245  0037 4a            	dec	a
 246  0038 2709          	jreq	L5
 247  003a 4a            	dec	a
 248  003b 2706          	jreq	L5
 249  003d a005          	sub	a,#5
 250  003f 273d          	jreq	L31
 251  0041 20ed          	jra	L111
 252  0043               L5:
 253                     ; 88             case 0:
 253                     ; 89             case 1:
 253                     ; 90             case 2:
 253                     ; 91             case 3:
 253                     ; 92                 /* Read ADC's of pots and store in array */
 253                     ; 93                 // multi channel ADC's
 253                     ; 94                 // how long does the scantake? meaaure this start/stop -> gpio-> oscilloscope
 253                     ; 95                 // will want to separate the knobs from signal input,
 253                     ; 96                 //
 253                     ; 97                 /* could not skip ADC1_GetBufferValue(0), other wise ...? didn't get value for adc_delay .*/
 253                     ; 98                 ADC1_ScanModeCmd( ENABLE );
 255  0043 a601          	ld	a,#1
 256  0045 cd0000        	call	_ADC1_ScanModeCmd
 258                     ; 99                 ADC1_StartConversion( );
 260  0048 cd0000        	call	_ADC1_StartConversion
 263  004b               L321:
 264                     ; 100                 while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 266  004b a680          	ld	a,#128
 267  004d cd0000        	call	_ADC1_GetFlagStatus
 269  0050 4d            	tnz	a
 270  0051 27f8          	jreq	L321
 271                     ; 101                 ADC1_ClearFlag( ADC1_FLAG_EOC );
 273  0053 a680          	ld	a,#128
 274  0055 cd0000        	call	_ADC1_ClearFlag
 276                     ; 103                 adc_delay  = ADC1_GetBufferValue( 1 ); //ADC_FEEDBACK_AMOUNT );
 278  0058 a601          	ld	a,#1
 279  005a cd0000        	call	_ADC1_GetBufferValue
 281  005d 1f14          	ldw	(OFST-3,sp),x
 283                     ; 109                 delay = ( adc_delay << 2 );
 285  005f 58            	sllw	x
 286  0060 58            	sllw	x
 287  0061 1f12          	ldw	(OFST-5,sp),x
 289                     ; 110                 delay_length_samples[ state ] = ( adc_delay << 2 );
 291  0063 1e14          	ldw	x,(OFST-3,sp)
 292  0065 58            	sllw	x
 293  0066 58            	sllw	x
 294  0067 9096          	ldw	y,sp
 295  0069 72a90006      	addw	y,#OFST-17
 296  006d 1701          	ldw	(OFST-22,sp),y
 298  006f 905f          	clrw	y
 299  0071 b600          	ld	a,_state
 300  0073 9097          	ld	yl,a
 301  0075 9058          	sllw	y
 302  0077 72f901        	addw	y,(OFST-22,sp)
 303  007a 90ff          	ldw	(y),x
 304                     ; 112                 break;
 306  007c 20b2          	jra	L111
 307                     ; 113             case 4:
 307                     ; 114             case 5:
 307                     ; 115             case 6:
 307                     ; 116                 /* do nothing */
 307                     ; 117                 break;
 309                     ; 118             case 7:
 309                     ; 119                 /* do average of ADC pots values */
 309                     ; 120                 // how long does this take?
 309                     ; 121                 // this seems to break, is the maths? do i need a bigger type, or to cast?
 309                     ; 122                 //delay = ( delay_length_samples[0] + delay_length_samples[1] + delay_length_samples[2] + delay_length_samples[3] ) / NUM_Of_ADCPOT_SAMPLES;
 309                     ; 123                 break;
 311  007e               L31:
 312                     ; 124             case 8:
 312                     ; 125                 /* Sample Audio ADC, process, write to DAC */
 312                     ; 126                 //sample audio input
 312                     ; 127                 ADC1_ScanModeCmd( ENABLE );
 314  007e 4c            	inc	a
 315  007f cd0000        	call	_ADC1_ScanModeCmd
 317                     ; 128                 ADC1_StartConversion( );
 319  0082 cd0000        	call	_ADC1_StartConversion
 322  0085               L131:
 323                     ; 129                 while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 325  0085 a680          	ld	a,#128
 326  0087 cd0000        	call	_ADC1_GetFlagStatus
 328  008a 4d            	tnz	a
 329  008b 27f8          	jreq	L131
 330                     ; 130                 ADC1_ClearFlag(ADC1_FLAG_EOC);
 332  008d a680          	ld	a,#128
 333  008f cd0000        	call	_ADC1_ClearFlag
 335                     ; 131                 adc_leftChannel = ADC1_GetBufferValue( 0 ); //ADC_LEFTCHANNEL );
 337  0092 4f            	clr	a
 338  0093 cd0000        	call	_ADC1_GetBufferValue
 340  0096 1f14          	ldw	(OFST-3,sp),x
 342                     ; 138                 mapd_value = (adc_leftChannel >> 2);
 344  0098 54            	srlw	x
 345  0099 54            	srlw	x
 346  009a 01            	rrwa	x,a
 347  009b 6b11          	ld	(OFST-6,sp),a
 349                     ; 141                 mapd_value = mapd_value/2 +  read_val/2;
 351  009d 5f            	clrw	x
 352  009e 7b0e          	ld	a,(OFST-9,sp)
 353  00a0 97            	ld	xl,a
 354  00a1 57            	sraw	x
 355  00a2 1f01          	ldw	(OFST-22,sp),x
 357  00a4 5f            	clrw	x
 358  00a5 7b11          	ld	a,(OFST-6,sp)
 359  00a7 97            	ld	xl,a
 360  00a8 57            	sraw	x
 361  00a9 72fb01        	addw	x,(OFST-22,sp)
 362  00ac 01            	rrwa	x,a
 363  00ad 6b11          	ld	(OFST-6,sp),a
 365                     ; 152                     read_addr = write_addr - delay;
 367  00af 1e16          	ldw	x,(OFST-1,sp)
 368  00b1 72f012        	subw	x,(OFST-5,sp)
 369  00b4 1f0f          	ldw	(OFST-8,sp),x
 371                     ; 156                     MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 373  00b6 88            	push	a
 374  00b7 1e17          	ldw	x,(OFST+0,sp)
 375  00b9 cd0000        	call	_MCP_23K256_RAM_write_byte
 377  00bc 84            	pop	a
 378                     ; 159                     MCP_23K256_RAM_read_byte(read_addr, &read_val);
 380  00bd 96            	ldw	x,sp
 381  00be 1c000e        	addw	x,#OFST-9
 382  00c1 89            	pushw	x
 383  00c2 1e11          	ldw	x,(OFST-6,sp)
 384  00c4 cd0000        	call	_MCP_23K256_RAM_read_byte
 386  00c7 85            	popw	x
 387                     ; 162                     MCP4901_DAC_write(read_val);
 389  00c8 7b0e          	ld	a,(OFST-9,sp)
 390  00ca cd0000        	call	_MCP4901_DAC_write
 392                     ; 165                     write_addr++;
 394  00cd 1e16          	ldw	x,(OFST-1,sp)
 395  00cf 5c            	incw	x
 396  00d0 1f16          	ldw	(OFST-1,sp),x
 398                     ; 167                 break;
 400  00d2 cc0030        	jra	L111
 401                     ; 168             case 9:
 401                     ; 169                 /* update ram, read new ram value for feedback */
 401                     ; 170 
 401                     ; 171                 break;
 403                     ; 173             default:
 403                     ; 174                 /* do nothing */
 403                     ; 175                 break;
 438                     ; 180 void clock_setup(void)
 438                     ; 181 {
 439                     	switch	.text
 440  00d5               _clock_setup:
 444                     ; 182   CLK_DeInit();
 446  00d5 cd0000        	call	_CLK_DeInit
 448                     ; 184   CLK_HSECmd(DISABLE); // DISABLE ->24MHz ext, what do i have 16?
 450  00d8 4f            	clr	a
 451  00d9 cd0000        	call	_CLK_HSECmd
 453                     ; 185   CLK_LSICmd(DISABLE);
 455  00dc 4f            	clr	a
 456  00dd cd0000        	call	_CLK_LSICmd
 458                     ; 186   CLK_HSICmd(ENABLE);   //ENABLE, 16MHz internal
 460  00e0 a601          	ld	a,#1
 461  00e2 cd0000        	call	_CLK_HSICmd
 464  00e5               L741:
 465                     ; 187   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 467  00e5 ae0102        	ldw	x,#258
 468  00e8 cd0000        	call	_CLK_GetFlagStatus
 470  00eb 4d            	tnz	a
 471  00ec 27f7          	jreq	L741
 472                     ; 189   CLK_ClockSwitchCmd(ENABLE);
 474  00ee a601          	ld	a,#1
 475  00f0 cd0000        	call	_CLK_ClockSwitchCmd
 477                     ; 190   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 479  00f3 4f            	clr	a
 480  00f4 cd0000        	call	_CLK_HSIPrescalerConfig
 482                     ; 191   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 484  00f7 a680          	ld	a,#128
 485  00f9 cd0000        	call	_CLK_SYSCLKConfig
 487                     ; 193   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 489  00fc 4b01          	push	#1
 490  00fe 4b00          	push	#0
 491  0100 ae01e1        	ldw	x,#481
 492  0103 cd0000        	call	_CLK_ClockSwitchConfig
 494  0106 85            	popw	x
 495                     ; 195   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 497  0107 5f            	clrw	x
 498  0108 cd0000        	call	_CLK_PeripheralClockConfig
 500                     ; 196   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 502  010b ae0101        	ldw	x,#257
 503  010e cd0000        	call	_CLK_PeripheralClockConfig
 505                     ; 197   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 507  0111 ae0300        	ldw	x,#768
 508  0114 cd0000        	call	_CLK_PeripheralClockConfig
 510                     ; 198   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 512  0117 ae1200        	ldw	x,#4608
 513  011a cd0000        	call	_CLK_PeripheralClockConfig
 515                     ; 199   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 517  011d ae1301        	ldw	x,#4865
 518  0120 cd0000        	call	_CLK_PeripheralClockConfig
 520                     ; 200   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 522  0123 ae0700        	ldw	x,#1792
 523  0126 cd0000        	call	_CLK_PeripheralClockConfig
 525                     ; 201   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 527  0129 ae0501        	ldw	x,#1281
 528  012c cd0000        	call	_CLK_PeripheralClockConfig
 530                     ; 202   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 532  012f ae0401        	ldw	x,#1025
 534                     ; 204 }
 537  0132 cc0000        	jp	_CLK_PeripheralClockConfig
 565                     ; 214 void TIM2_setup( void )
 565                     ; 215 {
 566                     	switch	.text
 567  0135               _TIM2_setup:
 571                     ; 216   TIM2_DeInit( );
 573  0135 cd0000        	call	_TIM2_DeInit
 575                     ; 217   TIM2_TimeBaseInit( TIM2_PRESCALER_1, 145 );
 577  0138 ae0091        	ldw	x,#145
 578  013b 89            	pushw	x
 579  013c 4f            	clr	a
 580  013d cd0000        	call	_TIM2_TimeBaseInit
 582  0140 85            	popw	x
 583                     ; 218   TIM2_ITConfig( TIM2_IT_UPDATE, ENABLE );
 585  0141 ae0101        	ldw	x,#257
 586  0144 cd0000        	call	_TIM2_ITConfig
 588                     ; 219   TIM2_Cmd( ENABLE );
 590  0147 a601          	ld	a,#1
 591  0149 cd0000        	call	_TIM2_Cmd
 593                     ; 220   enableInterrupts( );
 596  014c 9a            	rim	
 598                     ; 221 }
 602  014d 81            	ret	
 625                     ; 224 void GPIO_setup( void )
 625                     ; 225 {
 626                     	switch	.text
 627  014e               _GPIO_setup:
 631                     ; 227 }
 634  014e 81            	ret	
 664                     ; 255 void ADC1_setup(void)
 664                     ; 256 {
 665                     	switch	.text
 666  014f               _ADC1_setup:
 670                     ; 259   GPIO_DeInit(ADC_port);
 672  014f ae5005        	ldw	x,#20485
 673  0152 cd0000        	call	_GPIO_DeInit
 675                     ; 260   GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
 677  0155 4b00          	push	#0
 678  0157 4b0f          	push	#15
 679  0159 ae5005        	ldw	x,#20485
 680  015c cd0000        	call	_GPIO_Init
 682  015f 85            	popw	x
 683                     ; 262   ADC1_DeInit();
 685  0160 cd0000        	call	_ADC1_DeInit
 687                     ; 264   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 687                     ; 265   ADC1_CHANNEL_0,\
 687                     ; 266   ADC1_PRESSEL_FCPU_D18, \
 687                     ; 267   ADC1_EXTTRIG_GPIO, \
 687                     ; 268   DISABLE, \
 687                     ; 269   ADC1_ALIGN_RIGHT, \
 687                     ; 270   ADC1_SCHMITTTRIG_CHANNEL0, \
 687                     ; 271   DISABLE);
 689  0163 4b00          	push	#0
 690  0165 4b00          	push	#0
 691  0167 4b08          	push	#8
 692  0169 4b00          	push	#0
 693  016b 4b10          	push	#16
 694  016d 4b70          	push	#112
 695  016f 5f            	clrw	x
 696  0170 cd0000        	call	_ADC1_Init
 698  0173 5b06          	addw	sp,#6
 699                     ; 273   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 699                     ; 274   ADC1_CHANNEL_1,\
 699                     ; 275   ADC1_PRESSEL_FCPU_D18, \
 699                     ; 276   ADC1_EXTTRIG_GPIO, \
 699                     ; 277   DISABLE, \
 699                     ; 278   ADC1_ALIGN_RIGHT, \
 699                     ; 279   ADC1_SCHMITTTRIG_CHANNEL1, \
 699                     ; 280   DISABLE);
 701  0175 4b00          	push	#0
 702  0177 4b01          	push	#1
 703  0179 4b08          	push	#8
 704  017b 4b00          	push	#0
 705  017d 4b10          	push	#16
 706  017f 4b70          	push	#112
 707  0181 ae0001        	ldw	x,#1
 708  0184 cd0000        	call	_ADC1_Init
 710  0187 5b06          	addw	sp,#6
 711                     ; 282   ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);
 713  0189 4b08          	push	#8
 714  018b ae0001        	ldw	x,#1
 715  018e cd0000        	call	_ADC1_ConversionConfig
 717  0191 84            	pop	a
 718                     ; 284   ADC1_DataBufferCmd(ENABLE);
 720  0192 a601          	ld	a,#1
 721  0194 cd0000        	call	_ADC1_DataBufferCmd
 723                     ; 285   ADC1_Cmd(ENABLE);
 725  0197 a601          	ld	a,#1
 727                     ; 287 }
 730  0199 cc0000        	jp	_ADC1_Cmd
 757                     ; 297 void SPI_setup(void)
 757                     ; 298 {
 758                     	switch	.text
 759  019c               _SPI_setup:
 763                     ; 299   GPIO_Init(SPI_PORT, (GPIO_Pin_TypeDef)(SPI_CLK | SPI_MOSI | SPI_MISO), GPIO_MODE_OUT_PP_HIGH_FAST);
 765  019c 4bf0          	push	#240
 766  019e 4be0          	push	#224
 767  01a0 ae500a        	ldw	x,#20490
 768  01a3 cd0000        	call	_GPIO_Init
 770  01a6 85            	popw	x
 771                     ; 301   SPI_DeInit();
 773  01a7 cd0000        	call	_SPI_DeInit
 775                     ; 303   SPI_Init(SPI_FIRSTBIT_MSB, \
 775                     ; 304     SPI_BAUDRATEPRESCALER_16, \
 775                     ; 305     SPI_MODE_MASTER, \
 775                     ; 306     SPI_CLOCKPOLARITY_LOW, \
 775                     ; 307     SPI_CLOCKPHASE_1EDGE, \
 775                     ; 308     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 775                     ; 309     SPI_NSS_SOFT, \
 775                     ; 310     0x0);
 777  01aa 4b00          	push	#0
 778  01ac 4b02          	push	#2
 779  01ae 4b00          	push	#0
 780  01b0 4b00          	push	#0
 781  01b2 4b00          	push	#0
 782  01b4 4b04          	push	#4
 783  01b6 ae0018        	ldw	x,#24
 784  01b9 cd0000        	call	_SPI_Init
 786  01bc 5b06          	addw	sp,#6
 787                     ; 312   SPI_Cmd(ENABLE);
 789  01be a601          	ld	a,#1
 791                     ; 313 }
 794  01c0 cc0000        	jp	_SPI_Cmd
 818                     	xdef	_main
 819                     	xdef	_state
 820                     	xdef	_TIM2_setup
 821                     	xdef	_ADC1_setup
 822                     	xdef	_SPI_setup
 823                     	xdef	_GPIO_setup
 824                     	xdef	_clock_setup
 825                     	xref	_MCP_23K256_RAM_read_byte
 826                     	xref	_MCP_23K256_RAM_write_byte
 827                     	xref	_MCP_23K256_RAM_init
 828                     	xref	_MCP4901_DAC_write
 829                     	xref	_MCP4901_DAC_init
 830                     	xref	_TIM2_ITConfig
 831                     	xref	_TIM2_Cmd
 832                     	xref	_TIM2_TimeBaseInit
 833                     	xref	_TIM2_DeInit
 834                     	xref	_SPI_Cmd
 835                     	xref	_SPI_Init
 836                     	xref	_SPI_DeInit
 837                     	xref	_GPIO_Init
 838                     	xref	_GPIO_DeInit
 839                     	xref	_CLK_GetFlagStatus
 840                     	xref	_CLK_SYSCLKConfig
 841                     	xref	_CLK_HSIPrescalerConfig
 842                     	xref	_CLK_ClockSwitchConfig
 843                     	xref	_CLK_PeripheralClockConfig
 844                     	xref	_CLK_ClockSwitchCmd
 845                     	xref	_CLK_LSICmd
 846                     	xref	_CLK_HSICmd
 847                     	xref	_CLK_HSECmd
 848                     	xref	_CLK_DeInit
 849                     	xref	_ADC1_ClearFlag
 850                     	xref	_ADC1_GetFlagStatus
 851                     	xref	_ADC1_GetBufferValue
 852                     	xref	_ADC1_StartConversion
 853                     	xref	_ADC1_ConversionConfig
 854                     	xref	_ADC1_DataBufferCmd
 855                     	xref	_ADC1_ScanModeCmd
 856                     	xref	_ADC1_Cmd
 857                     	xref	_ADC1_Init
 858                     	xref	_ADC1_DeInit
 859                     	xref.b	c_x
 878                     	xref	c_xymvx
 879                     	end
