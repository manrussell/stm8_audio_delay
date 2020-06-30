   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 144                     ; 70 void main( void )
 144                     ; 71 {
 146                     	switch	.text
 147  0000               _main:
 149  0000 520f          	subw	sp,#15
 150       0000000f      OFST:	set	15
 153                     ; 72     uint16_t adc_leftChannel = 0;
 155                     ; 73     uint16_t adc_feedback    = 0;
 157                     ; 74     uint16_t adc_delay       = 0;
 159                     ; 75     uint8_t  mapd_value      = 0;    // mapped adc valu
 161                     ; 76     uint8_t  read_val        = 0;    // read val from ram
 163  0002 0f08          	clr	(OFST-7,sp)
 165                     ; 77     uint16_t write_addr      = 0;    // write addr in ram
 167  0004 5f            	clrw	x
 168  0005 1f0c          	ldw	(OFST-3,sp),x
 170                     ; 78     uint16_t read_addr       = 0;    // read addr in val
 172  0007 1f09          	ldw	(OFST-6,sp),x
 174                     ; 79     uint16_t delay           = 110;  // length of delay in samples
 176                     ; 80     uint8_t  res             = 0;
 178                     ; 82     clock_setup();
 180  0009 ad77          	call	_clock_setup
 182                     ; 83     GPIO_setup();
 184  000b cd00e2        	call	_GPIO_setup
 186                     ; 84     ADC1_setup();
 188  000e cd00e3        	call	_ADC1_setup
 190                     ; 85     SPI_setup();
 192  0011 cd0130        	call	_SPI_setup
 194                     ; 86     MCP_23K256_RAM_init();
 196  0014 cd0000        	call	_MCP_23K256_RAM_init
 198                     ; 87     MCP4901_DAC_init();
 200  0017 cd0000        	call	_MCP4901_DAC_init
 202  001a               L76:
 203                     ; 96         ADC1_ScanModeCmd( ENABLE );
 205  001a a601          	ld	a,#1
 206  001c cd0000        	call	_ADC1_ScanModeCmd
 208                     ; 97         ADC1_StartConversion( );
 210  001f cd0000        	call	_ADC1_StartConversion
 213  0022               L57:
 214                     ; 98         while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 216  0022 a680          	ld	a,#128
 217  0024 cd0000        	call	_ADC1_GetFlagStatus
 219  0027 4d            	tnz	a
 220  0028 27f8          	jreq	L57
 221                     ; 99         ADC1_ClearFlag(ADC1_FLAG_EOC);
 223  002a a680          	ld	a,#128
 224  002c cd0000        	call	_ADC1_ClearFlag
 226                     ; 100         adc_leftChannel = ADC1_GetBufferValue( 0); //ADC_LEFTCHANNEL );     // 0
 228  002f 4f            	clr	a
 229  0030 cd0000        	call	_ADC1_GetBufferValue
 231  0033 1f06          	ldw	(OFST-9,sp),x
 233                     ; 101         adc_delay       = ADC1_GetBufferValue( 1); //ADC_FEEDBACK_AMOUNT ); // 1
 235  0035 a601          	ld	a,#1
 236  0037 cd0000        	call	_ADC1_GetBufferValue
 239                     ; 106         delay = ( adc_delay << 2 ); //(adc_delay >> 2);
 241  003a 58            	sllw	x
 242  003b 58            	sllw	x
 243  003c 1f0e          	ldw	(OFST-1,sp),x
 245                     ; 113         mapd_value = (adc_leftChannel >> 2);
 247  003e 1e06          	ldw	x,(OFST-9,sp)
 248  0040 54            	srlw	x
 249  0041 54            	srlw	x
 250  0042 01            	rrwa	x,a
 251  0043 6b0b          	ld	(OFST-4,sp),a
 253                     ; 116         mapd_value = mapd_value/2 +  read_val/2;
 255  0045 5f            	clrw	x
 256  0046 7b08          	ld	a,(OFST-7,sp)
 257  0048 97            	ld	xl,a
 258  0049 57            	sraw	x
 259  004a 1f01          	ldw	(OFST-14,sp),x
 261  004c 5f            	clrw	x
 262  004d 7b0b          	ld	a,(OFST-4,sp)
 263  004f 97            	ld	xl,a
 264  0050 57            	sraw	x
 265  0051 72fb01        	addw	x,(OFST-14,sp)
 266  0054 01            	rrwa	x,a
 267  0055 6b0b          	ld	(OFST-4,sp),a
 269                     ; 127             read_addr = write_addr - delay;
 271  0057 1e0c          	ldw	x,(OFST-3,sp)
 272  0059 72f00e        	subw	x,(OFST-1,sp)
 273  005c 1f09          	ldw	(OFST-6,sp),x
 275                     ; 131         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 277  005e 88            	push	a
 278  005f 1e0d          	ldw	x,(OFST-2,sp)
 279  0061 cd0000        	call	_MCP_23K256_RAM_write_byte
 281  0064 84            	pop	a
 282                     ; 134         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 284  0065 96            	ldw	x,sp
 285  0066 1c0008        	addw	x,#OFST-7
 286  0069 89            	pushw	x
 287  006a 1e0b          	ldw	x,(OFST-4,sp)
 288  006c cd0000        	call	_MCP_23K256_RAM_read_byte
 290  006f 85            	popw	x
 291                     ; 137         MCP4901_DAC_write(read_val);
 293  0070 7b08          	ld	a,(OFST-7,sp)
 294  0072 cd0000        	call	_MCP4901_DAC_write
 296                     ; 140         write_addr++;
 298  0075 1e0c          	ldw	x,(OFST-3,sp)
 299  0077 5c            	incw	x
 300  0078 1f0c          	ldw	(OFST-3,sp),x
 302                     ; 143         delay_us(90);
 304  007a ae005a        	ldw	x,#90
 305  007d cd0000        	call	_delay_us
 308  0080 2098          	jra	L76
 341                     ; 149 void clock_setup(void)
 341                     ; 150 {
 342                     	switch	.text
 343  0082               _clock_setup:
 347                     ; 151   CLK_DeInit();
 349  0082 cd0000        	call	_CLK_DeInit
 351                     ; 153   CLK_HSECmd(DISABLE); // DISABLE ->24MHz ext, what do i have 16?
 353  0085 4f            	clr	a
 354  0086 cd0000        	call	_CLK_HSECmd
 356                     ; 154   CLK_LSICmd(DISABLE);
 358  0089 4f            	clr	a
 359  008a cd0000        	call	_CLK_LSICmd
 361                     ; 155   CLK_HSICmd(ENABLE);   //ENABLE, 16MHz internal
 363  008d a601          	ld	a,#1
 364  008f cd0000        	call	_CLK_HSICmd
 367  0092               L311:
 368                     ; 156   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 370  0092 ae0102        	ldw	x,#258
 371  0095 cd0000        	call	_CLK_GetFlagStatus
 373  0098 4d            	tnz	a
 374  0099 27f7          	jreq	L311
 375                     ; 158   CLK_ClockSwitchCmd(ENABLE);
 377  009b a601          	ld	a,#1
 378  009d cd0000        	call	_CLK_ClockSwitchCmd
 380                     ; 159   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 382  00a0 4f            	clr	a
 383  00a1 cd0000        	call	_CLK_HSIPrescalerConfig
 385                     ; 160   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 387  00a4 a680          	ld	a,#128
 388  00a6 cd0000        	call	_CLK_SYSCLKConfig
 390                     ; 162   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 392  00a9 4b01          	push	#1
 393  00ab 4b00          	push	#0
 394  00ad ae01e1        	ldw	x,#481
 395  00b0 cd0000        	call	_CLK_ClockSwitchConfig
 397  00b3 85            	popw	x
 398                     ; 164   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 400  00b4 5f            	clrw	x
 401  00b5 cd0000        	call	_CLK_PeripheralClockConfig
 403                     ; 165   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
 405  00b8 ae0101        	ldw	x,#257
 406  00bb cd0000        	call	_CLK_PeripheralClockConfig
 408                     ; 166   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 410  00be ae0300        	ldw	x,#768
 411  00c1 cd0000        	call	_CLK_PeripheralClockConfig
 413                     ; 167   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 415  00c4 ae1200        	ldw	x,#4608
 416  00c7 cd0000        	call	_CLK_PeripheralClockConfig
 418                     ; 168   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 420  00ca ae1301        	ldw	x,#4865
 421  00cd cd0000        	call	_CLK_PeripheralClockConfig
 423                     ; 169   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 425  00d0 ae0700        	ldw	x,#1792
 426  00d3 cd0000        	call	_CLK_PeripheralClockConfig
 428                     ; 170   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 430  00d6 ae0500        	ldw	x,#1280
 431  00d9 cd0000        	call	_CLK_PeripheralClockConfig
 433                     ; 171   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 435  00dc ae0401        	ldw	x,#1025
 437                     ; 173 }
 440  00df cc0000        	jp	_CLK_PeripheralClockConfig
 463                     ; 175 void GPIO_setup(void)
 463                     ; 176 {
 464                     	switch	.text
 465  00e2               _GPIO_setup:
 469                     ; 178 }
 472  00e2 81            	ret	
 502                     ; 206 void ADC1_setup(void)
 502                     ; 207 {
 503                     	switch	.text
 504  00e3               _ADC1_setup:
 508                     ; 210   GPIO_DeInit(ADC_port);
 510  00e3 ae5005        	ldw	x,#20485
 511  00e6 cd0000        	call	_GPIO_DeInit
 513                     ; 211   GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
 515  00e9 4b00          	push	#0
 516  00eb 4b0f          	push	#15
 517  00ed ae5005        	ldw	x,#20485
 518  00f0 cd0000        	call	_GPIO_Init
 520  00f3 85            	popw	x
 521                     ; 213   ADC1_DeInit();
 523  00f4 cd0000        	call	_ADC1_DeInit
 525                     ; 215   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 525                     ; 216   ADC1_CHANNEL_0,\
 525                     ; 217   ADC1_PRESSEL_FCPU_D18, \
 525                     ; 218   ADC1_EXTTRIG_GPIO, \
 525                     ; 219   DISABLE, \
 525                     ; 220   ADC1_ALIGN_RIGHT, \
 525                     ; 221   ADC1_SCHMITTTRIG_CHANNEL0, \
 525                     ; 222   DISABLE);
 527  00f7 4b00          	push	#0
 528  00f9 4b00          	push	#0
 529  00fb 4b08          	push	#8
 530  00fd 4b00          	push	#0
 531  00ff 4b10          	push	#16
 532  0101 4b70          	push	#112
 533  0103 5f            	clrw	x
 534  0104 cd0000        	call	_ADC1_Init
 536  0107 5b06          	addw	sp,#6
 537                     ; 224   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
 537                     ; 225   ADC1_CHANNEL_1,\
 537                     ; 226   ADC1_PRESSEL_FCPU_D18, \
 537                     ; 227   ADC1_EXTTRIG_GPIO, \
 537                     ; 228   DISABLE, \
 537                     ; 229   ADC1_ALIGN_RIGHT, \
 537                     ; 230   ADC1_SCHMITTTRIG_CHANNEL1, \
 537                     ; 231   DISABLE);
 539  0109 4b00          	push	#0
 540  010b 4b01          	push	#1
 541  010d 4b08          	push	#8
 542  010f 4b00          	push	#0
 543  0111 4b10          	push	#16
 544  0113 4b70          	push	#112
 545  0115 ae0001        	ldw	x,#1
 546  0118 cd0000        	call	_ADC1_Init
 548  011b 5b06          	addw	sp,#6
 549                     ; 233   ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);
 551  011d 4b08          	push	#8
 552  011f ae0001        	ldw	x,#1
 553  0122 cd0000        	call	_ADC1_ConversionConfig
 555  0125 84            	pop	a
 556                     ; 235   ADC1_DataBufferCmd(ENABLE);
 558  0126 a601          	ld	a,#1
 559  0128 cd0000        	call	_ADC1_DataBufferCmd
 561                     ; 236   ADC1_Cmd(ENABLE);
 563  012b a601          	ld	a,#1
 565                     ; 238 }
 568  012d cc0000        	jp	_ADC1_Cmd
 595                     ; 259 void SPI_setup(void)
 595                     ; 260 {
 596                     	switch	.text
 597  0130               _SPI_setup:
 601                     ; 261   GPIO_Init(SPI_PORT, (GPIO_Pin_TypeDef)(SPI_CLK | SPI_MOSI | SPI_MISO), GPIO_MODE_OUT_PP_HIGH_FAST);
 603  0130 4bf0          	push	#240
 604  0132 4be0          	push	#224
 605  0134 ae500a        	ldw	x,#20490
 606  0137 cd0000        	call	_GPIO_Init
 608  013a 85            	popw	x
 609                     ; 263   SPI_DeInit();
 611  013b cd0000        	call	_SPI_DeInit
 613                     ; 265   SPI_Init(SPI_FIRSTBIT_MSB, \
 613                     ; 266     SPI_BAUDRATEPRESCALER_16, \
 613                     ; 267     SPI_MODE_MASTER, \
 613                     ; 268     SPI_CLOCKPOLARITY_LOW, \
 613                     ; 269     SPI_CLOCKPHASE_1EDGE, \
 613                     ; 270     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
 613                     ; 271     SPI_NSS_SOFT, \
 613                     ; 272     0x0);
 615  013e 4b00          	push	#0
 616  0140 4b02          	push	#2
 617  0142 4b00          	push	#0
 618  0144 4b00          	push	#0
 619  0146 4b00          	push	#0
 620  0148 4b04          	push	#4
 621  014a ae0018        	ldw	x,#24
 622  014d cd0000        	call	_SPI_Init
 624  0150 5b06          	addw	sp,#6
 625                     ; 274   SPI_Cmd(ENABLE);
 627  0152 a601          	ld	a,#1
 629                     ; 275 }
 632  0154 cc0000        	jp	_SPI_Cmd
 645                     	xdef	_main
 646                     	xdef	_ADC1_setup
 647                     	xdef	_SPI_setup
 648                     	xdef	_GPIO_setup
 649                     	xdef	_clock_setup
 650                     	xref	_MCP_23K256_RAM_read_byte
 651                     	xref	_MCP_23K256_RAM_write_byte
 652                     	xref	_MCP_23K256_RAM_init
 653                     	xref	_MCP4901_DAC_write
 654                     	xref	_MCP4901_DAC_init
 655                     	xref	_delay_us
 656                     	xref	_SPI_Cmd
 657                     	xref	_SPI_Init
 658                     	xref	_SPI_DeInit
 659                     	xref	_GPIO_Init
 660                     	xref	_GPIO_DeInit
 661                     	xref	_CLK_GetFlagStatus
 662                     	xref	_CLK_SYSCLKConfig
 663                     	xref	_CLK_HSIPrescalerConfig
 664                     	xref	_CLK_ClockSwitchConfig
 665                     	xref	_CLK_PeripheralClockConfig
 666                     	xref	_CLK_ClockSwitchCmd
 667                     	xref	_CLK_LSICmd
 668                     	xref	_CLK_HSICmd
 669                     	xref	_CLK_HSECmd
 670                     	xref	_CLK_DeInit
 671                     	xref	_ADC1_ClearFlag
 672                     	xref	_ADC1_GetFlagStatus
 673                     	xref	_ADC1_GetBufferValue
 674                     	xref	_ADC1_StartConversion
 675                     	xref	_ADC1_ConversionConfig
 676                     	xref	_ADC1_DataBufferCmd
 677                     	xref	_ADC1_ScanModeCmd
 678                     	xref	_ADC1_Cmd
 679                     	xref	_ADC1_Init
 680                     	xref	_ADC1_DeInit
 699                     	end
