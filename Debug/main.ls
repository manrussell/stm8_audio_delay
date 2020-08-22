   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  18                     	bsct
  19  0000               _state:
  20  0000 00            	dc.b	0
  21  0001               _state_has_been_run:
  22  0001 01            	dc.b	1
  23  0002               _adc_leftChannel:
  24  0002 0000          	dc.w	0
  25  0004               _adc_feedback:
  26  0004 0000          	dc.w	0
  27  0006               _adc_delay:
  28  0006 0000          	dc.w	0
  29  0008               _mapd_value:
  30  0008 0000          	dc.w	0
  31  000a               _read_val:
  32  000a 00            	dc.b	0
  33  000b               _write_addr:
  34  000b 0000          	dc.w	0
  35  000d               _read_addr:
  36  000d 0001          	dc.w	1
  37  000f               _delay:
  38  000f 0000          	dc.w	0
  39                     .const:	section	.text
  40  0000               L3_delay_length_samples:
  41  0000 0000          	dc.w	0
  42  0002 000000000000  	ds.b	6
 117                     ; 68 void main( void )
 117                     ; 69 {
 119                     	switch	.text
 120  0000               _main:
 122  0000 520b          	subw	sp,#11
 123       0000000b      OFST:	set	11
 126                     ; 70     uint8_t  res             = 0;
 128                     ; 71     uint16_t tally           = 0;   // used to check state machine.
 130                     ; 73     uint16_t delay_length_samples[ NUM_Of_ADCPOT_SAMPLES ] = { 0 }; // 4 samples of the pot are calculated
 132  0002 96            	ldw	x,sp
 133  0003 1c0004        	addw	x,#OFST-7
 134  0006 90ae0000      	ldw	y,#L3_delay_length_samples
 135  000a a608          	ld	a,#8
 136  000c cd0000        	call	c_xymvx
 138                     ; 76     TEST_run_all_tests( );
 140  000f cd0000        	call	_TEST_run_all_tests
 142                     ; 78     disableInterrupts( );
 145  0012 9b            	sim	
 147                     ; 79     CLOCK_setup( ); /* setup 16MHz CPU frq and peripheral enable clock */
 150  0013 ad18          	call	_CLOCK_setup
 152                     ; 80     GPIO_setupDebugPin( ); /* what is this ?*/
 154  0015 cd00a4        	call	_GPIO_setupDebugPin
 156                     ; 81     ADC1_setupMultiChannel( );
 158  0018 cd00b0        	call	_ADC1_setupMultiChannel
 160                     ; 82     SPI_setup( ); /* for RAM and DAC */
 162  001b cd00fe        	call	_SPI_setup
 164                     ; 83     MCP_23K256_RAM_init( );
 166  001e cd0000        	call	_MCP_23K256_RAM_init
 168                     ; 84     MCP_23K256_RAM_set_all( 0 );
 170  0021 4f            	clr	a
 171  0022 cd0000        	call	_MCP_23K256_RAM_set_all
 173                     ; 85     MCP4901_DAC_init( );
 175  0025 cd0000        	call	_MCP4901_DAC_init
 177                     ; 86     TIM2_setupTimerInterrupt( ); /* for event driven machine. */
 179  0028 ad63          	call	_TIM2_setupTimerInterrupt
 181                     ; 87     enableInterrupts( );
 184  002a 9a            	rim	
 186  002b               L14:
 188  002b 20fe          	jra	L14
 221                     ; 96 void CLOCK_setup( void )
 221                     ; 97 {
 222                     	switch	.text
 223  002d               _CLOCK_setup:
 227                     ; 98   CLK_DeInit( );
 229  002d cd0000        	call	_CLK_DeInit
 231                     ; 100   CLK_HSECmd( DISABLE ); // DISABLE ->24MHz ext, what do i have 16?
 233  0030 4f            	clr	a
 234  0031 cd0000        	call	_CLK_HSECmd
 236                     ; 101   CLK_LSICmd( DISABLE );
 238  0034 4f            	clr	a
 239  0035 cd0000        	call	_CLK_LSICmd
 241                     ; 102   CLK_HSICmd( ENABLE );   //ENABLE, 16MHz internal
 243  0038 a601          	ld	a,#1
 244  003a cd0000        	call	_CLK_HSICmd
 247  003d               L75:
 248                     ; 103   while( CLK_GetFlagStatus( CLK_FLAG_HSIRDY ) == FALSE );
 250  003d ae0102        	ldw	x,#258
 251  0040 cd0000        	call	_CLK_GetFlagStatus
 253  0043 4d            	tnz	a
 254  0044 27f7          	jreq	L75
 255                     ; 105   CLK_ClockSwitchCmd( ENABLE );
 257  0046 a601          	ld	a,#1
 258  0048 cd0000        	call	_CLK_ClockSwitchCmd
 260                     ; 106   CLK_HSIPrescalerConfig( CLK_PRESCALER_HSIDIV1 );
 262  004b 4f            	clr	a
 263  004c cd0000        	call	_CLK_HSIPrescalerConfig
 265                     ; 107   CLK_SYSCLKConfig( CLK_PRESCALER_CPUDIV1 );
 267  004f a680          	ld	a,#128
 268  0051 cd0000        	call	_CLK_SYSCLKConfig
 270                     ; 109   CLK_ClockSwitchConfig( CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE );
 272  0054 4b01          	push	#1
 273  0056 4b00          	push	#0
 274  0058 ae01e1        	ldw	x,#481
 275  005b cd0000        	call	_CLK_ClockSwitchConfig
 277  005e 85            	popw	x
 278                     ; 111   CLK_PeripheralClockConfig( CLK_PERIPHERAL_I2C,    DISABLE );
 280  005f 5f            	clrw	x
 281  0060 cd0000        	call	_CLK_PeripheralClockConfig
 283                     ; 112   CLK_PeripheralClockConfig( CLK_PERIPHERAL_SPI,    ENABLE );
 285  0063 ae0101        	ldw	x,#257
 286  0066 cd0000        	call	_CLK_PeripheralClockConfig
 288                     ; 113   CLK_PeripheralClockConfig( CLK_PERIPHERAL_UART1,  DISABLE );
 290  0069 ae0300        	ldw	x,#768
 291  006c cd0000        	call	_CLK_PeripheralClockConfig
 293                     ; 114   CLK_PeripheralClockConfig( CLK_PERIPHERAL_AWU,    DISABLE );
 295  006f ae1200        	ldw	x,#4608
 296  0072 cd0000        	call	_CLK_PeripheralClockConfig
 298                     ; 115   CLK_PeripheralClockConfig( CLK_PERIPHERAL_ADC,    ENABLE );
 300  0075 ae1301        	ldw	x,#4865
 301  0078 cd0000        	call	_CLK_PeripheralClockConfig
 303                     ; 116   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER1, DISABLE );
 305  007b ae0700        	ldw	x,#1792
 306  007e cd0000        	call	_CLK_PeripheralClockConfig
 308                     ; 117   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER2, ENABLE );
 310  0081 ae0501        	ldw	x,#1281
 311  0084 cd0000        	call	_CLK_PeripheralClockConfig
 313                     ; 118   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER4, ENABLE );
 315  0087 ae0401        	ldw	x,#1025
 317                     ; 120 }
 320  008a cc0000        	jp	_CLK_PeripheralClockConfig
 348                     ; 132 void TIM2_setupTimerInterrupt( void )
 348                     ; 133 {
 349                     	switch	.text
 350  008d               _TIM2_setupTimerInterrupt:
 354                     ; 134   TIM2_DeInit( );
 356  008d cd0000        	call	_TIM2_DeInit
 358                     ; 135   TIM2_TimeBaseInit( TIM2_PRESCALER_1, 1451 );
 360  0090 ae05ab        	ldw	x,#1451
 361  0093 89            	pushw	x
 362  0094 4f            	clr	a
 363  0095 cd0000        	call	_TIM2_TimeBaseInit
 365  0098 85            	popw	x
 366                     ; 136   TIM2_ITConfig( TIM2_IT_UPDATE, ENABLE );
 368  0099 ae0101        	ldw	x,#257
 369  009c cd0000        	call	_TIM2_ITConfig
 371                     ; 137   TIM2_Cmd( ENABLE );
 373  009f a601          	ld	a,#1
 375                     ; 139 }
 378  00a1 cc0000        	jp	_TIM2_Cmd
 402                     ; 143 void GPIO_setupDebugPin( void )
 402                     ; 144 {
 403                     	switch	.text
 404  00a4               _GPIO_setupDebugPin:
 408                     ; 146     GPIO_Init( LOGICANALYSER_port, LOGICANALYSER_pin, GPIO_MODE_OUT_PP_HIGH_FAST );
 410  00a4 4bf0          	push	#240
 411  00a6 4b08          	push	#8
 412  00a8 ae500a        	ldw	x,#20490
 413  00ab cd0000        	call	_GPIO_Init
 415  00ae 85            	popw	x
 416                     ; 147 }
 419  00af 81            	ret	
 450                     ; 175 void ADC1_setupMultiChannel( void )
 450                     ; 176 {
 451                     	switch	.text
 452  00b0               _ADC1_setupMultiChannel:
 456                     ; 179   GPIO_DeInit( ADC_port );
 458  00b0 ae5005        	ldw	x,#20485
 459  00b3 cd0000        	call	_GPIO_DeInit
 461                     ; 180   GPIO_Init( ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT );
 463  00b6 4b00          	push	#0
 464  00b8 4b0f          	push	#15
 465  00ba ae5005        	ldw	x,#20485
 466  00bd cd0000        	call	_GPIO_Init
 468  00c0 85            	popw	x
 469                     ; 182   ADC1_DeInit( );
 471  00c1 cd0000        	call	_ADC1_DeInit
 473                     ; 184   ADC1_Init( ADC1_CONVERSIONMODE_SINGLE, \
 473                     ; 185   ADC1_CHANNEL_0,\
 473                     ; 186   ADC1_PRESSEL_FCPU_D18, \
 473                     ; 187   ADC1_EXTTRIG_GPIO, \
 473                     ; 188   DISABLE, \
 473                     ; 189   ADC1_ALIGN_RIGHT, \
 473                     ; 190   ADC1_SCHMITTTRIG_CHANNEL0, \
 473                     ; 191   DISABLE );
 475  00c4 4b00          	push	#0
 476  00c6 4b00          	push	#0
 477  00c8 4b08          	push	#8
 478  00ca 4b00          	push	#0
 479  00cc 4b10          	push	#16
 480  00ce 4b70          	push	#112
 481  00d0 5f            	clrw	x
 482  00d1 cd0000        	call	_ADC1_Init
 484  00d4 5b06          	addw	sp,#6
 485                     ; 193   ADC1_Init( ADC1_CONVERSIONMODE_SINGLE, \
 485                     ; 194   ADC1_CHANNEL_1,\
 485                     ; 195   ADC1_PRESSEL_FCPU_D18, \
 485                     ; 196   ADC1_EXTTRIG_GPIO, \
 485                     ; 197   DISABLE, \
 485                     ; 198   ADC1_ALIGN_RIGHT, \
 485                     ; 199   ADC1_SCHMITTTRIG_CHANNEL1, \
 485                     ; 200   DISABLE );
 487  00d6 4b00          	push	#0
 488  00d8 4b01          	push	#1
 489  00da 4b08          	push	#8
 490  00dc 4b00          	push	#0
 491  00de 4b10          	push	#16
 492  00e0 4b70          	push	#112
 493  00e2 ae0001        	ldw	x,#1
 494  00e5 cd0000        	call	_ADC1_Init
 496  00e8 5b06          	addw	sp,#6
 497                     ; 202   ADC1_ConversionConfig( ADC1_CONVERSIONMODE_SINGLE, (ADC1_Channel_TypeDef)( ADC1_CHANNEL_0 | ADC1_CHANNEL_1 ), ADC1_ALIGN_RIGHT );
 499  00ea 4b08          	push	#8
 500  00ec ae0001        	ldw	x,#1
 501  00ef cd0000        	call	_ADC1_ConversionConfig
 503  00f2 84            	pop	a
 504                     ; 204   ADC1_DataBufferCmd( ENABLE );
 506  00f3 a601          	ld	a,#1
 507  00f5 cd0000        	call	_ADC1_DataBufferCmd
 509                     ; 205   ADC1_Cmd( ENABLE );
 511  00f8 a601          	ld	a,#1
 513                     ; 207 }
 516  00fa cc0000        	jp	_ADC1_Cmd
 540                     ; 209 void ADC1_setupSingleChannel( void )
 540                     ; 210 {
 541                     	switch	.text
 542  00fd               _ADC1_setupSingleChannel:
 546                     ; 212 }
 549  00fd 81            	ret	
 576                     ; 222 void SPI_setup( void )
 576                     ; 223 {
 577                     	switch	.text
 578  00fe               _SPI_setup:
 582                     ; 224   GPIO_Init( SPI_PORT, (GPIO_Pin_TypeDef)( SPI_CLK | SPI_MOSI | SPI_MISO ), GPIO_MODE_OUT_PP_HIGH_FAST );
 584  00fe 4bf0          	push	#240
 585  0100 4be0          	push	#224
 586  0102 ae500a        	ldw	x,#20490
 587  0105 cd0000        	call	_GPIO_Init
 589  0108 85            	popw	x
 590                     ; 226   SPI_DeInit( );
 592  0109 cd0000        	call	_SPI_DeInit
 594                     ; 228   SPI_Init( SPI_FIRSTBIT_MSB, \
 594                     ; 229     SPI_BAUDRATEPRESCALER_16, \
 594                     ; 230     SPI_MODE_MASTER, \
 594                     ; 231     SPI_CLOCKPOLARITY_LOW, \
 594                     ; 232     SPI_CLOCKPHASE_1EDGE, \
 594                     ; 233     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 594                     ; 234     SPI_NSS_SOFT, \
 594                     ; 235     0x0 );
 596  010c 4b00          	push	#0
 597  010e 4b02          	push	#2
 598  0110 4b00          	push	#0
 599  0112 4b00          	push	#0
 600  0114 4b00          	push	#0
 601  0116 4b04          	push	#4
 602  0118 ae0018        	ldw	x,#24
 603  011b cd0000        	call	_SPI_Init
 605  011e 5b06          	addw	sp,#6
 606                     ; 237   SPI_Cmd( ENABLE );
 608  0120 a601          	ld	a,#1
 610                     ; 238 }
 613  0122 cc0000        	jp	_SPI_Cmd
 718                     	xdef	_main
 719                     	xdef	_delay
 720                     	xdef	_read_addr
 721                     	xdef	_write_addr
 722                     	xdef	_read_val
 723                     	xdef	_mapd_value
 724                     	xdef	_adc_delay
 725                     	xdef	_adc_feedback
 726                     	xdef	_adc_leftChannel
 727                     	xdef	_state_has_been_run
 728                     	xdef	_state
 729                     	xref	_TEST_run_all_tests
 730                     	xref	_MCP_23K256_RAM_set_all
 731                     	xref	_MCP_23K256_RAM_init
 732                     	xref	_MCP4901_DAC_init
 733                     	xdef	_TIM2_setupTimerInterrupt
 734                     	xdef	_ADC1_setupSingleChannel
 735                     	xdef	_ADC1_setupMultiChannel
 736                     	xdef	_SPI_setup
 737                     	xdef	_GPIO_setupDebugPin
 738                     	xdef	_CLOCK_setup
 739                     	xref	_TIM2_ITConfig
 740                     	xref	_TIM2_Cmd
 741                     	xref	_TIM2_TimeBaseInit
 742                     	xref	_TIM2_DeInit
 743                     	xref	_SPI_Cmd
 744                     	xref	_SPI_Init
 745                     	xref	_SPI_DeInit
 746                     	xref	_GPIO_Init
 747                     	xref	_GPIO_DeInit
 748                     	xref	_CLK_GetFlagStatus
 749                     	xref	_CLK_SYSCLKConfig
 750                     	xref	_CLK_HSIPrescalerConfig
 751                     	xref	_CLK_ClockSwitchConfig
 752                     	xref	_CLK_PeripheralClockConfig
 753                     	xref	_CLK_ClockSwitchCmd
 754                     	xref	_CLK_LSICmd
 755                     	xref	_CLK_HSICmd
 756                     	xref	_CLK_HSECmd
 757                     	xref	_CLK_DeInit
 758                     	xref	_ADC1_ClearFlag
 759                     	xref	_ADC1_GetFlagStatus
 760                     	xref	_ADC1_StartConversion
 761                     	xref	_ADC1_ConversionConfig
 762                     	xref	_ADC1_DataBufferCmd
 763                     	xref	_ADC1_ScanModeCmd
 764                     	xref	_ADC1_Cmd
 765                     	xref	_ADC1_Init
 766                     	xref	_ADC1_DeInit
 767                     	xref.b	c_x
 786                     	xref	c_xymvx
 787                     	end
