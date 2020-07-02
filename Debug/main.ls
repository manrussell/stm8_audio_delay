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
 168  0000 5218          	subw	sp,#24
 169       00000018      OFST:	set	24
 172                     ; 63     uint16_t adc_leftChannel = 0;
 174                     ; 64     uint16_t adc_feedback    = 0;
 176                     ; 65     uint16_t adc_delay       = 0;
 178                     ; 66     uint16_t mapd_value      = 0;   // mapped adc valu
 180  0002 5f            	clrw	x
 181  0003 1f15          	ldw	(OFST-3,sp),x
 183                     ; 67     uint8_t  read_val        = 0;   // read val from ram
 185  0005 0f0e          	clr	(OFST-10,sp)
 187                     ; 68     uint16_t write_addr      = 0;   // write addr in ram
 189  0007 1f17          	ldw	(OFST-1,sp),x
 191                     ; 69     uint16_t read_addr       = 0;   // read addr in val
 193  0009 1f0f          	ldw	(OFST-9,sp),x
 195                     ; 70     uint16_t delay           = 0;   // length of delay in samples
 197  000b 1f13          	ldw	(OFST-5,sp),x
 199                     ; 71     uint8_t  res             = 0;
 201                     ; 73     uint16_t delay_length_samples[NUM_Of_ADCPOT_SAMPLES] = {0}; // 4 samples of the pot are calculated
 203  000d 96            	ldw	x,sp
 204  000e 1c0006        	addw	x,#OFST-18
 205  0011 90ae0000      	ldw	y,#L3_delay_length_samples
 206  0015 a608          	ld	a,#8
 207  0017 cd0000        	call	c_xymvx
 209                     ; 75     clock_setup( );
 211  001a cd00f3        	call	_clock_setup
 213                     ; 76     GPIO_setup( );
 215  001d cd016c        	call	_GPIO_setup
 217                     ; 77     ADC1_setup( );
 219  0020 cd016d        	call	_ADC1_setup
 221                     ; 78     SPI_setup( );
 223  0023 cd01ba        	call	_SPI_setup
 225                     ; 79     MCP_23K256_RAM_init( );
 227  0026 cd0000        	call	_MCP_23K256_RAM_init
 229                     ; 80     MCP4901_DAC_init( );
 231  0029 cd0000        	call	_MCP4901_DAC_init
 233                     ; 81     TIM2_setup( );
 235  002c cd0153        	call	_TIM2_setup
 237  002f               L311:
 238                     ; 86         switch( state )
 240  002f b600          	ld	a,_state
 242                     ; 184             default:
 242                     ; 185                 /* do nothing */
 242                     ; 186                 break;
 243  0031 271b          	jreq	L5
 244  0033 4a            	dec	a
 245  0034 2718          	jreq	L5
 246  0036 4a            	dec	a
 247  0037 2715          	jreq	L5
 248  0039 4a            	dec	a
 249  003a 2712          	jreq	L5
 250  003c a004          	sub	a,#4
 251  003e 2749          	jreq	L31
 252  0040 4a            	dec	a
 253  0041 2603cc00c6    	jreq	L51
 254  0046 4a            	dec	a
 255  0047 2603cc00d9    	jreq	L71
 256  004c 20e1          	jra	L311
 257  004e               L5:
 258                     ; 88             case 0:
 258                     ; 89             case 1:
 258                     ; 90             case 2:
 258                     ; 91             case 3:
 258                     ; 92                 /* Read ADC's of pots and store in array */
 258                     ; 93                 // multi channel ADC's
 258                     ; 94                 // how long does the scantake? meaaure this start/stop -> gpio-> oscilloscope
 258                     ; 95                 // will want to separate the knobs from signal input,
 258                     ; 96                 //
 258                     ; 97                 ADC1_ScanModeCmd( ENABLE );
 260  004e a601          	ld	a,#1
 261  0050 cd0000        	call	_ADC1_ScanModeCmd
 263                     ; 98                 ADC1_StartConversion( );
 265  0053 cd0000        	call	_ADC1_StartConversion
 268  0056               L521:
 269                     ; 99                 while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 271  0056 a680          	ld	a,#128
 272  0058 cd0000        	call	_ADC1_GetFlagStatus
 274  005b 4d            	tnz	a
 275  005c 27f8          	jreq	L521
 276                     ; 100                 ADC1_ClearFlag( ADC1_FLAG_EOC );
 278  005e a680          	ld	a,#128
 279  0060 cd0000        	call	_ADC1_ClearFlag
 281                     ; 102                 adc_delay  = ADC1_GetBufferValue( 1 ); //ADC_FEEDBACK_AMOUNT );
 283  0063 a601          	ld	a,#1
 284  0065 cd0000        	call	_ADC1_GetBufferValue
 286  0068 1f11          	ldw	(OFST-7,sp),x
 288                     ; 108                 delay = ( adc_delay << 2 );
 290  006a 58            	sllw	x
 291  006b 58            	sllw	x
 292  006c 1f13          	ldw	(OFST-5,sp),x
 294                     ; 109                 delay_length_samples[ state ] = ( adc_delay << 2 );
 296  006e 1e11          	ldw	x,(OFST-7,sp)
 297  0070 58            	sllw	x
 298  0071 58            	sllw	x
 299  0072 9096          	ldw	y,sp
 300  0074 72a90006      	addw	y,#OFST-18
 301  0078 1701          	ldw	(OFST-23,sp),y
 303  007a 905f          	clrw	y
 304  007c b600          	ld	a,_state
 305  007e 9097          	ld	yl,a
 306  0080 9058          	sllw	y
 307  0082 72f901        	addw	y,(OFST-23,sp)
 308  0085 90ff          	ldw	(y),x
 309                     ; 111                 break;
 311  0087 20a6          	jra	L311
 312                     ; 112             case 4:
 312                     ; 113             case 5:
 312                     ; 114                 /* do nothing */
 312                     ; 115                 break;
 314                     ; 116             case 6:
 314                     ; 117                 /* do average of ADC pots values */
 314                     ; 118                 // how long does this take?
 314                     ; 119                 // this seems to break, is the maths? do i need a bigger type, or to cast?
 314                     ; 120                 //delay = ( delay_length_samples[0] + delay_length_samples[1] + delay_length_samples[2] + delay_length_samples[3] ) / NUM_Of_ADCPOT_SAMPLES;
 314                     ; 121                 break;
 316  0089               L31:
 317                     ; 122             case 7:
 317                     ; 123                 /* Sample Audio ADC, process, write to DAC */
 317                     ; 124                 //sample audio input
 317                     ; 125                 ADC1_ScanModeCmd( ENABLE );
 319  0089 4c            	inc	a
 320  008a cd0000        	call	_ADC1_ScanModeCmd
 322                     ; 126                 ADC1_StartConversion( );
 324  008d cd0000        	call	_ADC1_StartConversion
 327  0090               L331:
 328                     ; 127                 while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 330  0090 a680          	ld	a,#128
 331  0092 cd0000        	call	_ADC1_GetFlagStatus
 333  0095 4d            	tnz	a
 334  0096 27f8          	jreq	L331
 335                     ; 128                 ADC1_ClearFlag( ADC1_FLAG_EOC );
 337  0098 a680          	ld	a,#128
 338  009a cd0000        	call	_ADC1_ClearFlag
 340                     ; 129                 adc_leftChannel = ADC1_GetBufferValue( 0 ); //ADC_LEFTCHANNEL );
 342  009d 4f            	clr	a
 343  009e cd0000        	call	_ADC1_GetBufferValue
 345  00a1 1f11          	ldw	(OFST-7,sp),x
 347                     ; 136                 mapd_value = ( adc_leftChannel >> 2 );
 349  00a3 54            	srlw	x
 350  00a4 54            	srlw	x
 351  00a5 1f15          	ldw	(OFST-3,sp),x
 353                     ; 140                 mapd_value = mapd_value/2 +  read_val/2;
 355  00a7 5f            	clrw	x
 356  00a8 7b0e          	ld	a,(OFST-10,sp)
 357  00aa 97            	ld	xl,a
 358  00ab 57            	sraw	x
 359  00ac 1f01          	ldw	(OFST-23,sp),x
 361  00ae 1e15          	ldw	x,(OFST-3,sp)
 362  00b0 54            	srlw	x
 363  00b1 72fb01        	addw	x,(OFST-23,sp)
 365                     ; 143                 if ( 0xff < mapd_value )
 367  00b4 a30100        	cpw	x,#256
 368  00b7 2503          	jrult	L731
 369                     ; 145                     mapd_value = 0xff;
 371  00b9 ae00ff        	ldw	x,#255
 373  00bc               L731:
 374  00bc 1f15          	ldw	(OFST-3,sp),x
 375                     ; 149                 MCP4901_DAC_write( mapd_value ); 
 377  00be 7b16          	ld	a,(OFST-2,sp)
 378  00c0 cd0000        	call	_MCP4901_DAC_write
 380                     ; 151                 break;
 382  00c3 cc002f        	jra	L311
 383  00c6               L51:
 384                     ; 163                     read_addr = write_addr - delay;
 386  00c6 1e17          	ldw	x,(OFST-1,sp)
 387  00c8 72f013        	subw	x,(OFST-5,sp)
 388  00cb 1f0f          	ldw	(OFST-9,sp),x
 390                     ; 167                 MCP_23K256_RAM_write_byte( write_addr, mapd_value );
 392  00cd 7b16          	ld	a,(OFST-2,sp)
 393  00cf 88            	push	a
 394  00d0 1e18          	ldw	x,(OFST+0,sp)
 395  00d2 cd0000        	call	_MCP_23K256_RAM_write_byte
 397  00d5 84            	pop	a
 398                     ; 169                 break;
 400  00d6 cc002f        	jra	L311
 401  00d9               L71:
 402                     ; 170             case 9:
 402                     ; 171                 //read from ram
 402                     ; 172                 MCP_23K256_RAM_read_byte( read_addr, &read_val );
 404  00d9 96            	ldw	x,sp
 405  00da 1c000e        	addw	x,#OFST-10
 406  00dd 89            	pushw	x
 407  00de 1e11          	ldw	x,(OFST-7,sp)
 408  00e0 cd0000        	call	_MCP_23K256_RAM_read_byte
 410  00e3 85            	popw	x
 411                     ; 175                 write_addr++;
 413  00e4 1e17          	ldw	x,(OFST-1,sp)
 414  00e6 5c            	incw	x
 415  00e7 1f17          	ldw	(OFST-1,sp),x
 417                     ; 177                 if ( write_addr > delay )
 419  00e9 1313          	cpw	x,(OFST-5,sp)
 420  00eb 23e9          	jrule	L311
 421                     ; 180                     write_addr = 0;
 423  00ed 5f            	clrw	x
 424  00ee 1f17          	ldw	(OFST-1,sp),x
 426  00f0 cc002f        	jra	L311
 427                     ; 184             default:
 427                     ; 185                 /* do nothing */
 427                     ; 186                 break;
 462                     ; 191 void clock_setup( void )
 462                     ; 192 {
 463                     	switch	.text
 464  00f3               _clock_setup:
 468                     ; 193   CLK_DeInit( );
 470  00f3 cd0000        	call	_CLK_DeInit
 472                     ; 195   CLK_HSECmd( DISABLE ); // DISABLE ->24MHz ext, what do i have 16?
 474  00f6 4f            	clr	a
 475  00f7 cd0000        	call	_CLK_HSECmd
 477                     ; 196   CLK_LSICmd( DISABLE );
 479  00fa 4f            	clr	a
 480  00fb cd0000        	call	_CLK_LSICmd
 482                     ; 197   CLK_HSICmd( ENABLE );   //ENABLE, 16MHz internal
 484  00fe a601          	ld	a,#1
 485  0100 cd0000        	call	_CLK_HSICmd
 488  0103               L551:
 489                     ; 198   while( CLK_GetFlagStatus( CLK_FLAG_HSIRDY ) == FALSE );
 491  0103 ae0102        	ldw	x,#258
 492  0106 cd0000        	call	_CLK_GetFlagStatus
 494  0109 4d            	tnz	a
 495  010a 27f7          	jreq	L551
 496                     ; 200   CLK_ClockSwitchCmd( ENABLE );
 498  010c a601          	ld	a,#1
 499  010e cd0000        	call	_CLK_ClockSwitchCmd
 501                     ; 201   CLK_HSIPrescalerConfig( CLK_PRESCALER_HSIDIV1 );
 503  0111 4f            	clr	a
 504  0112 cd0000        	call	_CLK_HSIPrescalerConfig
 506                     ; 202   CLK_SYSCLKConfig( CLK_PRESCALER_CPUDIV1 );
 508  0115 a680          	ld	a,#128
 509  0117 cd0000        	call	_CLK_SYSCLKConfig
 511                     ; 204   CLK_ClockSwitchConfig( CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE );
 513  011a 4b01          	push	#1
 514  011c 4b00          	push	#0
 515  011e ae01e1        	ldw	x,#481
 516  0121 cd0000        	call	_CLK_ClockSwitchConfig
 518  0124 85            	popw	x
 519                     ; 206   CLK_PeripheralClockConfig( CLK_PERIPHERAL_I2C,    DISABLE );
 521  0125 5f            	clrw	x
 522  0126 cd0000        	call	_CLK_PeripheralClockConfig
 524                     ; 207   CLK_PeripheralClockConfig( CLK_PERIPHERAL_SPI,    ENABLE );
 526  0129 ae0101        	ldw	x,#257
 527  012c cd0000        	call	_CLK_PeripheralClockConfig
 529                     ; 208   CLK_PeripheralClockConfig( CLK_PERIPHERAL_UART1,  DISABLE );
 531  012f ae0300        	ldw	x,#768
 532  0132 cd0000        	call	_CLK_PeripheralClockConfig
 534                     ; 209   CLK_PeripheralClockConfig( CLK_PERIPHERAL_AWU,    DISABLE );
 536  0135 ae1200        	ldw	x,#4608
 537  0138 cd0000        	call	_CLK_PeripheralClockConfig
 539                     ; 210   CLK_PeripheralClockConfig( CLK_PERIPHERAL_ADC,    ENABLE );
 541  013b ae1301        	ldw	x,#4865
 542  013e cd0000        	call	_CLK_PeripheralClockConfig
 544                     ; 211   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER1, DISABLE );
 546  0141 ae0700        	ldw	x,#1792
 547  0144 cd0000        	call	_CLK_PeripheralClockConfig
 549                     ; 212   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER2, ENABLE );
 551  0147 ae0501        	ldw	x,#1281
 552  014a cd0000        	call	_CLK_PeripheralClockConfig
 554                     ; 213   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER4, ENABLE );
 556  014d ae0401        	ldw	x,#1025
 558                     ; 215 }
 561  0150 cc0000        	jp	_CLK_PeripheralClockConfig
 589                     ; 225 void TIM2_setup( void )
 589                     ; 226 {
 590                     	switch	.text
 591  0153               _TIM2_setup:
 595                     ; 227   TIM2_DeInit( );
 597  0153 cd0000        	call	_TIM2_DeInit
 599                     ; 228   TIM2_TimeBaseInit( TIM2_PRESCALER_1, 45 );
 601  0156 ae002d        	ldw	x,#45
 602  0159 89            	pushw	x
 603  015a 4f            	clr	a
 604  015b cd0000        	call	_TIM2_TimeBaseInit
 606  015e 85            	popw	x
 607                     ; 229   TIM2_ITConfig( TIM2_IT_UPDATE, ENABLE );
 609  015f ae0101        	ldw	x,#257
 610  0162 cd0000        	call	_TIM2_ITConfig
 612                     ; 230   TIM2_Cmd( ENABLE );
 614  0165 a601          	ld	a,#1
 615  0167 cd0000        	call	_TIM2_Cmd
 617                     ; 231   enableInterrupts( );
 620  016a 9a            	rim	
 622                     ; 232 }
 626  016b 81            	ret	
 649                     ; 235 void GPIO_setup( void )
 649                     ; 236 {
 650                     	switch	.text
 651  016c               _GPIO_setup:
 655                     ; 238 }
 658  016c 81            	ret	
 688                     ; 266 void ADC1_setup( void )
 688                     ; 267 {
 689                     	switch	.text
 690  016d               _ADC1_setup:
 694                     ; 270   GPIO_DeInit( ADC_port );
 696  016d ae5005        	ldw	x,#20485
 697  0170 cd0000        	call	_GPIO_DeInit
 699                     ; 271   GPIO_Init( ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT );
 701  0173 4b00          	push	#0
 702  0175 4b0f          	push	#15
 703  0177 ae5005        	ldw	x,#20485
 704  017a cd0000        	call	_GPIO_Init
 706  017d 85            	popw	x
 707                     ; 273   ADC1_DeInit( );
 709  017e cd0000        	call	_ADC1_DeInit
 711                     ; 275   ADC1_Init( ADC1_CONVERSIONMODE_SINGLE, \
 711                     ; 276   ADC1_CHANNEL_0,\
 711                     ; 277   ADC1_PRESSEL_FCPU_D18, \
 711                     ; 278   ADC1_EXTTRIG_GPIO, \
 711                     ; 279   DISABLE, \
 711                     ; 280   ADC1_ALIGN_RIGHT, \
 711                     ; 281   ADC1_SCHMITTTRIG_CHANNEL0, \
 711                     ; 282   DISABLE );
 713  0181 4b00          	push	#0
 714  0183 4b00          	push	#0
 715  0185 4b08          	push	#8
 716  0187 4b00          	push	#0
 717  0189 4b10          	push	#16
 718  018b 4b70          	push	#112
 719  018d 5f            	clrw	x
 720  018e cd0000        	call	_ADC1_Init
 722  0191 5b06          	addw	sp,#6
 723                     ; 284   ADC1_Init( ADC1_CONVERSIONMODE_SINGLE, \
 723                     ; 285   ADC1_CHANNEL_1,\
 723                     ; 286   ADC1_PRESSEL_FCPU_D18, \
 723                     ; 287   ADC1_EXTTRIG_GPIO, \
 723                     ; 288   DISABLE, \
 723                     ; 289   ADC1_ALIGN_RIGHT, \
 723                     ; 290   ADC1_SCHMITTTRIG_CHANNEL1, \
 723                     ; 291   DISABLE );
 725  0193 4b00          	push	#0
 726  0195 4b01          	push	#1
 727  0197 4b08          	push	#8
 728  0199 4b00          	push	#0
 729  019b 4b10          	push	#16
 730  019d 4b70          	push	#112
 731  019f ae0001        	ldw	x,#1
 732  01a2 cd0000        	call	_ADC1_Init
 734  01a5 5b06          	addw	sp,#6
 735                     ; 293   ADC1_ConversionConfig( ADC1_CONVERSIONMODE_SINGLE, (ADC1_Channel_TypeDef)( ADC1_CHANNEL_0 | ADC1_CHANNEL_1 ), ADC1_ALIGN_RIGHT );
 737  01a7 4b08          	push	#8
 738  01a9 ae0001        	ldw	x,#1
 739  01ac cd0000        	call	_ADC1_ConversionConfig
 741  01af 84            	pop	a
 742                     ; 295   ADC1_DataBufferCmd( ENABLE );
 744  01b0 a601          	ld	a,#1
 745  01b2 cd0000        	call	_ADC1_DataBufferCmd
 747                     ; 296   ADC1_Cmd( ENABLE );
 749  01b5 a601          	ld	a,#1
 751                     ; 298 }
 754  01b7 cc0000        	jp	_ADC1_Cmd
 781                     ; 308 void SPI_setup( void )
 781                     ; 309 {
 782                     	switch	.text
 783  01ba               _SPI_setup:
 787                     ; 310   GPIO_Init( SPI_PORT, (GPIO_Pin_TypeDef)( SPI_CLK | SPI_MOSI | SPI_MISO ), GPIO_MODE_OUT_PP_HIGH_FAST );
 789  01ba 4bf0          	push	#240
 790  01bc 4be0          	push	#224
 791  01be ae500a        	ldw	x,#20490
 792  01c1 cd0000        	call	_GPIO_Init
 794  01c4 85            	popw	x
 795                     ; 312   SPI_DeInit( );
 797  01c5 cd0000        	call	_SPI_DeInit
 799                     ; 314   SPI_Init( SPI_FIRSTBIT_MSB, \
 799                     ; 315     SPI_BAUDRATEPRESCALER_16, \
 799                     ; 316     SPI_MODE_MASTER, \
 799                     ; 317     SPI_CLOCKPOLARITY_LOW, \
 799                     ; 318     SPI_CLOCKPHASE_1EDGE, \
 799                     ; 319     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 799                     ; 320     SPI_NSS_SOFT, \
 799                     ; 321     0x0 );
 801  01c8 4b00          	push	#0
 802  01ca 4b02          	push	#2
 803  01cc 4b00          	push	#0
 804  01ce 4b00          	push	#0
 805  01d0 4b00          	push	#0
 806  01d2 4b04          	push	#4
 807  01d4 ae0018        	ldw	x,#24
 808  01d7 cd0000        	call	_SPI_Init
 810  01da 5b06          	addw	sp,#6
 811                     ; 323   SPI_Cmd( ENABLE );
 813  01dc a601          	ld	a,#1
 815                     ; 324 }
 818  01de cc0000        	jp	_SPI_Cmd
 842                     	xdef	_main
 843                     	xdef	_state
 844                     	xdef	_TIM2_setup
 845                     	xdef	_ADC1_setup
 846                     	xdef	_SPI_setup
 847                     	xdef	_GPIO_setup
 848                     	xdef	_clock_setup
 849                     	xref	_MCP_23K256_RAM_read_byte
 850                     	xref	_MCP_23K256_RAM_write_byte
 851                     	xref	_MCP_23K256_RAM_init
 852                     	xref	_MCP4901_DAC_write
 853                     	xref	_MCP4901_DAC_init
 854                     	xref	_TIM2_ITConfig
 855                     	xref	_TIM2_Cmd
 856                     	xref	_TIM2_TimeBaseInit
 857                     	xref	_TIM2_DeInit
 858                     	xref	_SPI_Cmd
 859                     	xref	_SPI_Init
 860                     	xref	_SPI_DeInit
 861                     	xref	_GPIO_Init
 862                     	xref	_GPIO_DeInit
 863                     	xref	_CLK_GetFlagStatus
 864                     	xref	_CLK_SYSCLKConfig
 865                     	xref	_CLK_HSIPrescalerConfig
 866                     	xref	_CLK_ClockSwitchConfig
 867                     	xref	_CLK_PeripheralClockConfig
 868                     	xref	_CLK_ClockSwitchCmd
 869                     	xref	_CLK_LSICmd
 870                     	xref	_CLK_HSICmd
 871                     	xref	_CLK_HSECmd
 872                     	xref	_CLK_DeInit
 873                     	xref	_ADC1_ClearFlag
 874                     	xref	_ADC1_GetFlagStatus
 875                     	xref	_ADC1_GetBufferValue
 876                     	xref	_ADC1_StartConversion
 877                     	xref	_ADC1_ConversionConfig
 878                     	xref	_ADC1_DataBufferCmd
 879                     	xref	_ADC1_ScanModeCmd
 880                     	xref	_ADC1_Cmd
 881                     	xref	_ADC1_Init
 882                     	xref	_ADC1_DeInit
 883                     	xref.b	c_x
 902                     	xref	c_xymvx
 903                     	end
