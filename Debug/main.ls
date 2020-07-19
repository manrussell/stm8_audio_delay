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
 110                     ; 72 void main( void )
 110                     ; 73 {
 112                     	switch	.text
 113  0000               _main:
 115  0000 520b          	subw	sp,#11
 116       0000000b      OFST:	set	11
 119                     ; 74     uint8_t  res             = 0;
 121                     ; 75     uint16_t tally           = 0;   // used to check state machine.
 123                     ; 77     uint16_t delay_length_samples[NUM_Of_ADCPOT_SAMPLES] = {0}; // 4 samples of the pot are calculated
 125  0002 96            	ldw	x,sp
 126  0003 1c0004        	addw	x,#OFST-7
 127  0006 90ae0000      	ldw	y,#L3_delay_length_samples
 128  000a a608          	ld	a,#8
 129  000c cd0000        	call	c_xymvx
 131                     ; 79     clock_setup( );
 133  000f ad17          	call	_clock_setup
 135                     ; 80     GPIO_setup( );
 137  0011 cd00a1        	call	_GPIO_setup
 139                     ; 81     ADC1_setup( );
 141  0014 cd00ad        	call	_ADC1_setup
 143                     ; 82     SPI_setup( );
 145  0017 cd00fa        	call	_SPI_setup
 147                     ; 83     MCP_23K256_RAM_init( );
 149  001a cd0000        	call	_MCP_23K256_RAM_init
 151                     ; 84     MCP_23K256_RAM_set_all( 0 );
 153  001d 4f            	clr	a
 154  001e cd0000        	call	_MCP_23K256_RAM_set_all
 156                     ; 85     MCP4901_DAC_init( );
 158  0021 cd0000        	call	_MCP4901_DAC_init
 160                     ; 86     TIM2_setup( ); // enables timer interrupts...
 162  0024 ad62          	call	_TIM2_setup
 164  0026               L14:
 166  0026 20fe          	jra	L14
 199                     ; 95 void clock_setup( void )
 199                     ; 96 {
 200                     	switch	.text
 201  0028               _clock_setup:
 205                     ; 97   CLK_DeInit( );
 207  0028 cd0000        	call	_CLK_DeInit
 209                     ; 99   CLK_HSECmd( DISABLE ); // DISABLE ->24MHz ext, what do i have 16?
 211  002b 4f            	clr	a
 212  002c cd0000        	call	_CLK_HSECmd
 214                     ; 100   CLK_LSICmd( DISABLE );
 216  002f 4f            	clr	a
 217  0030 cd0000        	call	_CLK_LSICmd
 219                     ; 101   CLK_HSICmd( ENABLE );   //ENABLE, 16MHz internal
 221  0033 a601          	ld	a,#1
 222  0035 cd0000        	call	_CLK_HSICmd
 225  0038               L75:
 226                     ; 102   while( CLK_GetFlagStatus( CLK_FLAG_HSIRDY ) == FALSE );
 228  0038 ae0102        	ldw	x,#258
 229  003b cd0000        	call	_CLK_GetFlagStatus
 231  003e 4d            	tnz	a
 232  003f 27f7          	jreq	L75
 233                     ; 104   CLK_ClockSwitchCmd( ENABLE );
 235  0041 a601          	ld	a,#1
 236  0043 cd0000        	call	_CLK_ClockSwitchCmd
 238                     ; 105   CLK_HSIPrescalerConfig( CLK_PRESCALER_HSIDIV1 );
 240  0046 4f            	clr	a
 241  0047 cd0000        	call	_CLK_HSIPrescalerConfig
 243                     ; 106   CLK_SYSCLKConfig( CLK_PRESCALER_CPUDIV1 );
 245  004a a680          	ld	a,#128
 246  004c cd0000        	call	_CLK_SYSCLKConfig
 248                     ; 108   CLK_ClockSwitchConfig( CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE );
 250  004f 4b01          	push	#1
 251  0051 4b00          	push	#0
 252  0053 ae01e1        	ldw	x,#481
 253  0056 cd0000        	call	_CLK_ClockSwitchConfig
 255  0059 85            	popw	x
 256                     ; 110   CLK_PeripheralClockConfig( CLK_PERIPHERAL_I2C,    DISABLE );
 258  005a 5f            	clrw	x
 259  005b cd0000        	call	_CLK_PeripheralClockConfig
 261                     ; 111   CLK_PeripheralClockConfig( CLK_PERIPHERAL_SPI,    ENABLE );
 263  005e ae0101        	ldw	x,#257
 264  0061 cd0000        	call	_CLK_PeripheralClockConfig
 266                     ; 112   CLK_PeripheralClockConfig( CLK_PERIPHERAL_UART1,  DISABLE );
 268  0064 ae0300        	ldw	x,#768
 269  0067 cd0000        	call	_CLK_PeripheralClockConfig
 271                     ; 113   CLK_PeripheralClockConfig( CLK_PERIPHERAL_AWU,    DISABLE );
 273  006a ae1200        	ldw	x,#4608
 274  006d cd0000        	call	_CLK_PeripheralClockConfig
 276                     ; 114   CLK_PeripheralClockConfig( CLK_PERIPHERAL_ADC,    ENABLE );
 278  0070 ae1301        	ldw	x,#4865
 279  0073 cd0000        	call	_CLK_PeripheralClockConfig
 281                     ; 115   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER1, DISABLE );
 283  0076 ae0700        	ldw	x,#1792
 284  0079 cd0000        	call	_CLK_PeripheralClockConfig
 286                     ; 116   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER2, ENABLE );
 288  007c ae0501        	ldw	x,#1281
 289  007f cd0000        	call	_CLK_PeripheralClockConfig
 291                     ; 117   CLK_PeripheralClockConfig( CLK_PERIPHERAL_TIMER4, ENABLE );
 293  0082 ae0401        	ldw	x,#1025
 295                     ; 119 }
 298  0085 cc0000        	jp	_CLK_PeripheralClockConfig
 326                     ; 131 void TIM2_setup( void )
 326                     ; 132 {
 327                     	switch	.text
 328  0088               _TIM2_setup:
 332                     ; 133   TIM2_DeInit( );
 334  0088 cd0000        	call	_TIM2_DeInit
 336                     ; 134   TIM2_TimeBaseInit( TIM2_PRESCALER_1, 1451 );
 338  008b ae05ab        	ldw	x,#1451
 339  008e 89            	pushw	x
 340  008f 4f            	clr	a
 341  0090 cd0000        	call	_TIM2_TimeBaseInit
 343  0093 85            	popw	x
 344                     ; 135   TIM2_ITConfig( TIM2_IT_UPDATE, ENABLE );
 346  0094 ae0101        	ldw	x,#257
 347  0097 cd0000        	call	_TIM2_ITConfig
 349                     ; 136   TIM2_Cmd( ENABLE );
 351  009a a601          	ld	a,#1
 352  009c cd0000        	call	_TIM2_Cmd
 354                     ; 137   enableInterrupts( );
 357  009f 9a            	rim	
 359                     ; 138 }
 363  00a0 81            	ret	
 387                     ; 141 void GPIO_setup( void )
 387                     ; 142 {
 388                     	switch	.text
 389  00a1               _GPIO_setup:
 393                     ; 144     GPIO_Init(TEST_port, TEST_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
 395  00a1 4bf0          	push	#240
 396  00a3 4b08          	push	#8
 397  00a5 ae500a        	ldw	x,#20490
 398  00a8 cd0000        	call	_GPIO_Init
 400  00ab 85            	popw	x
 401                     ; 145 }
 404  00ac 81            	ret	
 434                     ; 173 void ADC1_setup( void )
 434                     ; 174 {
 435                     	switch	.text
 436  00ad               _ADC1_setup:
 440                     ; 177   GPIO_DeInit( ADC_port );
 442  00ad ae5005        	ldw	x,#20485
 443  00b0 cd0000        	call	_GPIO_DeInit
 445                     ; 178   GPIO_Init( ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT );
 447  00b3 4b00          	push	#0
 448  00b5 4b0f          	push	#15
 449  00b7 ae5005        	ldw	x,#20485
 450  00ba cd0000        	call	_GPIO_Init
 452  00bd 85            	popw	x
 453                     ; 180   ADC1_DeInit( );
 455  00be cd0000        	call	_ADC1_DeInit
 457                     ; 182   ADC1_Init( ADC1_CONVERSIONMODE_SINGLE, \
 457                     ; 183   ADC1_CHANNEL_0,\
 457                     ; 184   ADC1_PRESSEL_FCPU_D18, \
 457                     ; 185   ADC1_EXTTRIG_GPIO, \
 457                     ; 186   DISABLE, \
 457                     ; 187   ADC1_ALIGN_RIGHT, \
 457                     ; 188   ADC1_SCHMITTTRIG_CHANNEL0, \
 457                     ; 189   DISABLE );
 459  00c1 4b00          	push	#0
 460  00c3 4b00          	push	#0
 461  00c5 4b08          	push	#8
 462  00c7 4b00          	push	#0
 463  00c9 4b10          	push	#16
 464  00cb 4b70          	push	#112
 465  00cd 5f            	clrw	x
 466  00ce cd0000        	call	_ADC1_Init
 468  00d1 5b06          	addw	sp,#6
 469                     ; 191   ADC1_Init( ADC1_CONVERSIONMODE_SINGLE, \
 469                     ; 192   ADC1_CHANNEL_1,\
 469                     ; 193   ADC1_PRESSEL_FCPU_D18, \
 469                     ; 194   ADC1_EXTTRIG_GPIO, \
 469                     ; 195   DISABLE, \
 469                     ; 196   ADC1_ALIGN_RIGHT, \
 469                     ; 197   ADC1_SCHMITTTRIG_CHANNEL1, \
 469                     ; 198   DISABLE );
 471  00d3 4b00          	push	#0
 472  00d5 4b01          	push	#1
 473  00d7 4b08          	push	#8
 474  00d9 4b00          	push	#0
 475  00db 4b10          	push	#16
 476  00dd 4b70          	push	#112
 477  00df ae0001        	ldw	x,#1
 478  00e2 cd0000        	call	_ADC1_Init
 480  00e5 5b06          	addw	sp,#6
 481                     ; 200   ADC1_ConversionConfig( ADC1_CONVERSIONMODE_SINGLE, (ADC1_Channel_TypeDef)( ADC1_CHANNEL_0 | ADC1_CHANNEL_1 ), ADC1_ALIGN_RIGHT );
 483  00e7 4b08          	push	#8
 484  00e9 ae0001        	ldw	x,#1
 485  00ec cd0000        	call	_ADC1_ConversionConfig
 487  00ef 84            	pop	a
 488                     ; 202   ADC1_DataBufferCmd( ENABLE );
 490  00f0 a601          	ld	a,#1
 491  00f2 cd0000        	call	_ADC1_DataBufferCmd
 493                     ; 203   ADC1_Cmd( ENABLE );
 495  00f5 a601          	ld	a,#1
 497                     ; 205 }
 500  00f7 cc0000        	jp	_ADC1_Cmd
 527                     ; 215 void SPI_setup( void )
 527                     ; 216 {
 528                     	switch	.text
 529  00fa               _SPI_setup:
 533                     ; 217   GPIO_Init( SPI_PORT, (GPIO_Pin_TypeDef)( SPI_CLK | SPI_MOSI | SPI_MISO ), GPIO_MODE_OUT_PP_HIGH_FAST );
 535  00fa 4bf0          	push	#240
 536  00fc 4be0          	push	#224
 537  00fe ae500a        	ldw	x,#20490
 538  0101 cd0000        	call	_GPIO_Init
 540  0104 85            	popw	x
 541                     ; 219   SPI_DeInit( );
 543  0105 cd0000        	call	_SPI_DeInit
 545                     ; 221   SPI_Init( SPI_FIRSTBIT_MSB, \
 545                     ; 222     SPI_BAUDRATEPRESCALER_16, \
 545                     ; 223     SPI_MODE_MASTER, \
 545                     ; 224     SPI_CLOCKPOLARITY_LOW, \
 545                     ; 225     SPI_CLOCKPHASE_1EDGE, \
 545                     ; 226     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 545                     ; 227     SPI_NSS_SOFT, \
 545                     ; 228     0x0 );
 547  0108 4b00          	push	#0
 548  010a 4b02          	push	#2
 549  010c 4b00          	push	#0
 550  010e 4b00          	push	#0
 551  0110 4b00          	push	#0
 552  0112 4b04          	push	#4
 553  0114 ae0018        	ldw	x,#24
 554  0117 cd0000        	call	_SPI_Init
 556  011a 5b06          	addw	sp,#6
 557                     ; 230   SPI_Cmd( ENABLE );
 559  011c a601          	ld	a,#1
 561                     ; 231 }
 564  011e cc0000        	jp	_SPI_Cmd
 669                     	xdef	_main
 670                     	xdef	_delay
 671                     	xdef	_read_addr
 672                     	xdef	_write_addr
 673                     	xdef	_read_val
 674                     	xdef	_mapd_value
 675                     	xdef	_adc_delay
 676                     	xdef	_adc_feedback
 677                     	xdef	_adc_leftChannel
 678                     	xdef	_state_has_been_run
 679                     	xdef	_state
 680                     	xdef	_TIM2_setup
 681                     	xdef	_ADC1_setup
 682                     	xdef	_SPI_setup
 683                     	xdef	_GPIO_setup
 684                     	xdef	_clock_setup
 685                     	xref	_MCP_23K256_RAM_set_all
 686                     	xref	_MCP_23K256_RAM_init
 687                     	xref	_MCP4901_DAC_init
 688                     	xref	_TIM2_ITConfig
 689                     	xref	_TIM2_Cmd
 690                     	xref	_TIM2_TimeBaseInit
 691                     	xref	_TIM2_DeInit
 692                     	xref	_SPI_Cmd
 693                     	xref	_SPI_Init
 694                     	xref	_SPI_DeInit
 695                     	xref	_GPIO_Init
 696                     	xref	_GPIO_DeInit
 697                     	xref	_CLK_GetFlagStatus
 698                     	xref	_CLK_SYSCLKConfig
 699                     	xref	_CLK_HSIPrescalerConfig
 700                     	xref	_CLK_ClockSwitchConfig
 701                     	xref	_CLK_PeripheralClockConfig
 702                     	xref	_CLK_ClockSwitchCmd
 703                     	xref	_CLK_LSICmd
 704                     	xref	_CLK_HSICmd
 705                     	xref	_CLK_HSECmd
 706                     	xref	_CLK_DeInit
 707                     	xref	_ADC1_ConversionConfig
 708                     	xref	_ADC1_DataBufferCmd
 709                     	xref	_ADC1_Cmd
 710                     	xref	_ADC1_Init
 711                     	xref	_ADC1_DeInit
 712                     	xref.b	c_x
 731                     	xref	c_xymvx
 732                     	end
