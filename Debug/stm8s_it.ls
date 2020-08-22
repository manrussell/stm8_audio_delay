   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  66                     ; 63 void TIM2_UPD_IRQHandler( void )
  66                     ; 64 {
  67                     	switch	.text
  68  0000               f_TIM2_UPD_IRQHandler:
  70  0000 8a            	push	cc
  71  0001 84            	pop	a
  72  0002 a4bf          	and	a,#191
  73  0004 88            	push	a
  74  0005 86            	pop	cc
  75       00000002      OFST:	set	2
  76  0006 3b0002        	push	c_x+2
  77  0009 be00          	ldw	x,c_x
  78  000b 89            	pushw	x
  79  000c 3b0002        	push	c_y+2
  80  000f be00          	ldw	x,c_y
  81  0011 89            	pushw	x
  82  0012 89            	pushw	x
  85                     ; 66     GPIO_WriteHigh( LOGICANALYSER_port, LOGICANALYSER_pin );
  87  0013 4b08          	push	#8
  88  0015 ae500a        	ldw	x,#20490
  89  0018 cd0000        	call	_GPIO_WriteHigh
  91  001b ae0001        	ldw	x,#1
  92  001e 84            	pop	a
  93                     ; 68     TIM2_ClearFlag( TIM2_FLAG_UPDATE );
  95  001f cd0000        	call	_TIM2_ClearFlag
  97                     ; 70     switch( state )
  99  0022 b600          	ld	a,_state
 101                     ; 158         default:
 101                     ; 159             /* do nothing */
 101                     ; 160             break;
 102  0024 271b          	jreq	L3
 103  0026 4a            	dec	a
 104  0027 2718          	jreq	L3
 105  0029 4a            	dec	a
 106  002a 2715          	jreq	L3
 107  002c 4a            	dec	a
 108  002d 2712          	jreq	L3
 109  002f a004          	sub	a,#4
 110  0031 2730          	jreq	L11
 111  0033 4a            	dec	a
 112  0034 274b          	jreq	L31
 113  0036 4a            	dec	a
 114  0037 2604acba00ba  	jreq	L51
 115  003d accd00cd      	jra	L14
 116  0041               L3:
 117                     ; 72         case 0:
 117                     ; 73         case 1:
 117                     ; 74         case 2:
 117                     ; 75         case 3:
 117                     ; 76             /* Read ADC's of pots and store in array */
 117                     ; 77             // multi channel ADC's
 117                     ; 78             // how long does the scantake? meaaure this start/stop -> gpio-> oscilloscope
 117                     ; 79             // will want to separate the knobs from signal input,
 117                     ; 80             //
 117                     ; 81             ADC1_ScanModeCmd( ENABLE );
 119  0041 a601          	ld	a,#1
 120  0043 cd0000        	call	_ADC1_ScanModeCmd
 122                     ; 82             ADC1_StartConversion( );
 124  0046 cd0000        	call	_ADC1_StartConversion
 127  0049               L54:
 128                     ; 83             while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 130  0049 a680          	ld	a,#128
 131  004b cd0000        	call	_ADC1_GetFlagStatus
 133  004e 4d            	tnz	a
 134  004f 27f8          	jreq	L54
 135                     ; 84             ADC1_ClearFlag( ADC1_FLAG_EOC );
 137  0051 a680          	ld	a,#128
 138  0053 cd0000        	call	_ADC1_ClearFlag
 140                     ; 86             adc_delay  = ADC1_GetBufferValue( 1 ); // ADC_FEEDBACK_AMOUNT );
 142  0056 a601          	ld	a,#1
 143  0058 cd0000        	call	_ADC1_GetBufferValue
 145  005b bf00          	ldw	_adc_delay,x
 146                     ; 92             delay = ( adc_delay << 2 );
 148  005d 58            	sllw	x
 149  005e 58            	sllw	x
 150  005f bf00          	ldw	_delay,x
 151                     ; 94             break;
 153  0061 206a          	jra	L14
 154                     ; 95         case 4:
 154                     ; 96         case 5:
 154                     ; 97             /* do nothing */
 154                     ; 98             break;
 156                     ; 99         case 6:
 156                     ; 100             /* do average of ADC pots values */
 156                     ; 101             // how long does this take?
 156                     ; 102             // this seems to break, is the maths? do i need a bigger type, or to cast?
 156                     ; 103             //delay = ( delay_length_samples[0] + delay_length_samples[1] + delay_length_samples[2] + delay_length_samples[3] ) / NUM_Of_ADCPOT_SAMPLES;
 156                     ; 104             break;
 158  0063               L11:
 159                     ; 105         case 7:
 159                     ; 106             if ( write_addr >= delay ) // ahhh what if read above?
 161  0063 be00          	ldw	x,_write_addr
 162  0065 b300          	cpw	x,_delay
 163  0067 2503          	jrult	L15
 164                     ; 109                 write_addr = 0;
 166  0069 5f            	clrw	x
 167  006a bf00          	ldw	_write_addr,x
 168  006c               L15:
 169                     ; 112             if ( read_addr >= delay)
 171  006c be00          	ldw	x,_read_addr
 172  006e b300          	cpw	x,_delay
 173  0070 2503          	jrult	L35
 174                     ; 115                 read_addr = 0;
 176  0072 5f            	clrw	x
 177  0073 bf00          	ldw	_read_addr,x
 178  0075               L35:
 179                     ; 119             RAM_read_byte( read_addr, &read_val );            
 181  0075 ae0000        	ldw	x,#_read_val
 182  0078 89            	pushw	x
 183  0079 be00          	ldw	x,_read_addr
 184  007b cd0000        	call	_MCP_23K256_RAM_read_byte
 186  007e 85            	popw	x
 187                     ; 120             break;
 189  007f 204c          	jra	L14
 190  0081               L31:
 191                     ; 121         case 8:
 191                     ; 122             /* Sample Audio ADC, process, write to DAC */
 191                     ; 123             //sample audio input
 191                     ; 124             ADC1_ScanModeCmd( ENABLE );
 193  0081 4c            	inc	a
 194  0082 cd0000        	call	_ADC1_ScanModeCmd
 196                     ; 125             ADC1_StartConversion( );
 198  0085 cd0000        	call	_ADC1_StartConversion
 201  0088               L75:
 202                     ; 126             while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 204  0088 a680          	ld	a,#128
 205  008a cd0000        	call	_ADC1_GetFlagStatus
 207  008d 4d            	tnz	a
 208  008e 27f8          	jreq	L75
 209                     ; 127             ADC1_ClearFlag( ADC1_FLAG_EOC );
 211  0090 a680          	ld	a,#128
 212  0092 cd0000        	call	_ADC1_ClearFlag
 214                     ; 128             adc_leftChannel = ADC1_GetBufferValue( 0 ); //ADC_LEFTCHANNEL );
 216  0095 4f            	clr	a
 217  0096 cd0000        	call	_ADC1_GetBufferValue
 219  0099 bf00          	ldw	_adc_leftChannel,x
 220                     ; 135             mapd_value = ( adc_leftChannel >> 2 );
 222  009b 54            	srlw	x
 223  009c 54            	srlw	x
 224  009d bf00          	ldw	_mapd_value,x
 225                     ; 139             mapd_value = mapd_value + read_val;
 227  009f 5f            	clrw	x
 228  00a0 b600          	ld	a,_read_val
 229  00a2 97            	ld	xl,a
 230  00a3 1f01          	ldw	(OFST-1,sp),x
 232  00a5 72bb0000      	addw	x,_mapd_value
 233                     ; 142             if ( 0xff < mapd_value )
 235  00a9 a30100        	cpw	x,#256
 236  00ac 2503          	jrult	L36
 237                     ; 144                 mapd_value = 0xff;
 239  00ae ae00ff        	ldw	x,#255
 240  00b1               L36:
 241  00b1 bf00          	ldw	_mapd_value,x
 242                     ; 148             DAC_write( mapd_value ); 
 244  00b3 b601          	ld	a,_mapd_value+1
 245  00b5 cd0000        	call	_MCP4901_DAC_write
 247                     ; 149             break;
 249  00b8 2013          	jra	L14
 250  00ba               L51:
 251                     ; 150         case 9:
 251                     ; 151             //write to ram
 251                     ; 152             RAM_write_byte( write_addr, mapd_value );
 253  00ba 3b0001        	push	_mapd_value+1
 254  00bd be00          	ldw	x,_write_addr
 255  00bf cd0000        	call	_MCP_23K256_RAM_write_byte
 257  00c2 be00          	ldw	x,_write_addr
 258  00c4 5c            	incw	x
 259  00c5 bf00          	ldw	_write_addr,x
 260  00c7 be00          	ldw	x,_read_addr
 261  00c9 5c            	incw	x
 262  00ca bf00          	ldw	_read_addr,x
 263  00cc 84            	pop	a
 264                     ; 155             write_addr++;
 266                     ; 156             read_addr++;
 268                     ; 157             break;
 270                     ; 158         default:
 270                     ; 159             /* do nothing */
 270                     ; 160             break;
 272  00cd               L14:
 273                     ; 163     state++;
 275  00cd 3c00          	inc	_state
 276                     ; 164     if ( 10 <= state ) state = 0;
 278  00cf b600          	ld	a,_state
 279  00d1 a10a          	cp	a,#10
 280  00d3 2502          	jrult	L56
 283  00d5 3f00          	clr	_state
 284  00d7               L56:
 285                     ; 166     GPIO_WriteLow( LOGICANALYSER_port, LOGICANALYSER_pin );
 287  00d7 4b08          	push	#8
 288  00d9 ae500a        	ldw	x,#20490
 289  00dc cd0000        	call	_GPIO_WriteLow
 291  00df 84            	pop	a
 292                     ; 167 }
 295  00e0 5b02          	addw	sp,#2
 296  00e2 85            	popw	x
 297  00e3 bf00          	ldw	c_y,x
 298  00e5 320002        	pop	c_y+2
 299  00e8 85            	popw	x
 300  00e9 bf00          	ldw	c_x,x
 301  00eb 320002        	pop	c_x+2
 302  00ee 80            	iret	
 325                     ; 170 void EXTI2_IRQHandler( void )
 325                     ; 171 {
 326                     	switch	.text
 327  00ef               f_EXTI2_IRQHandler:
 331                     ; 172     testIncomplete = 0;
 333  00ef 3f00          	clr	_testIncomplete
 334                     ; 173 }
 337  00f1 80            	iret	
 360                     ; 183 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 360                     ; 184 {
 361                     	switch	.text
 362  00f2               f_NonHandledInterrupt:
 366                     ; 188 }
 369  00f2 80            	iret	
 391                     ; 196 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 391                     ; 197 {
 392                     	switch	.text
 393  00f3               f_TRAP_IRQHandler:
 397                     ; 201 }
 400  00f3 80            	iret	
 422                     ; 208 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 422                     ; 209 
 422                     ; 210 {
 423                     	switch	.text
 424  00f4               f_TLI_IRQHandler:
 428                     ; 214 }
 431  00f4 80            	iret	
 453                     ; 221 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 453                     ; 222 {
 454                     	switch	.text
 455  00f5               f_AWU_IRQHandler:
 459                     ; 226 }
 462  00f5 80            	iret	
 484                     ; 233 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 484                     ; 234 {
 485                     	switch	.text
 486  00f6               f_CLK_IRQHandler:
 490                     ; 238 }
 493  00f6 80            	iret	
 516                     ; 245 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 516                     ; 246 {
 517                     	switch	.text
 518  00f7               f_EXTI_PORTA_IRQHandler:
 522                     ; 250 }
 525  00f7 80            	iret	
 548                     ; 257 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 548                     ; 258 {
 549                     	switch	.text
 550  00f8               f_EXTI_PORTB_IRQHandler:
 554                     ; 262 }
 557  00f8 80            	iret	
 580                     ; 269 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 580                     ; 270 {
 581                     	switch	.text
 582  00f9               f_EXTI_PORTC_IRQHandler:
 586                     ; 274 }
 589  00f9 80            	iret	
 612                     ; 281 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 612                     ; 282 {
 613                     	switch	.text
 614  00fa               f_EXTI_PORTD_IRQHandler:
 618                     ; 286 }
 621  00fa 80            	iret	
 644                     ; 293 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 644                     ; 294 {
 645                     	switch	.text
 646  00fb               f_EXTI_PORTE_IRQHandler:
 650                     ; 298 }
 653  00fb 80            	iret	
 675                     ; 345 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 675                     ; 346 {
 676                     	switch	.text
 677  00fc               f_SPI_IRQHandler:
 681                     ; 350 }
 684  00fc 80            	iret	
 707                     ; 357 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 707                     ; 358 {
 708                     	switch	.text
 709  00fd               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 713                     ; 362 }
 716  00fd 80            	iret	
 739                     ; 369 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 739                     ; 370 {
 740                     	switch	.text
 741  00fe               f_TIM1_CAP_COM_IRQHandler:
 745                     ; 374 }
 748  00fe 80            	iret	
 771                     ; 407  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 771                     ; 408  {
 772                     	switch	.text
 773  00ff               f_TIM2_UPD_OVF_BRK_IRQHandler:
 777                     ; 412  }
 780  00ff 80            	iret	
 803                     ; 419  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 803                     ; 420  {
 804                     	switch	.text
 805  0100               f_TIM2_CAP_COM_IRQHandler:
 809                     ; 424  }
 812  0100 80            	iret	
 835                     ; 434  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 835                     ; 435  {
 836                     	switch	.text
 837  0101               f_TIM3_UPD_OVF_BRK_IRQHandler:
 841                     ; 439  }
 844  0101 80            	iret	
 867                     ; 446  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 867                     ; 447  {
 868                     	switch	.text
 869  0102               f_TIM3_CAP_COM_IRQHandler:
 873                     ; 451  }
 876  0102 80            	iret	
 898                     ; 512 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 898                     ; 513 {
 899                     	switch	.text
 900  0103               f_I2C_IRQHandler:
 904                     ; 517 }
 907  0103 80            	iret	
 930                     ; 525  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 930                     ; 526  {
 931                     	switch	.text
 932  0104               f_UART2_TX_IRQHandler:
 936                     ; 530  }
 939  0104 80            	iret	
 962                     ; 537  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 962                     ; 538  {
 963                     	switch	.text
 964  0105               f_UART2_RX_IRQHandler:
 968                     ; 542  }
 971  0105 80            	iret	
 993                     ; 591  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 993                     ; 592  {
 994                     	switch	.text
 995  0106               f_ADC1_IRQHandler:
 999                     ; 596  }
1002  0106 80            	iret	
1025                     ; 617  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1025                     ; 618  {
1026                     	switch	.text
1027  0107               f_TIM4_UPD_OVF_IRQHandler:
1031                     ; 622  }
1034  0107 80            	iret	
1057                     ; 630 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1057                     ; 631 {
1058                     	switch	.text
1059  0108               f_EEPROM_EEC_IRQHandler:
1063                     ; 635 }
1066  0108 80            	iret	
1078                     	xref.b	_testIncomplete
1079                     	xref.b	_delay
1080                     	xref.b	_read_addr
1081                     	xref.b	_write_addr
1082                     	xref.b	_read_val
1083                     	xref.b	_mapd_value
1084                     	xref.b	_adc_delay
1085                     	xref.b	_adc_leftChannel
1086                     	xref.b	_state
1087                     	xref	_MCP_23K256_RAM_read_byte
1088                     	xref	_MCP_23K256_RAM_write_byte
1089                     	xref	_MCP4901_DAC_write
1090                     	xdef	f_EEPROM_EEC_IRQHandler
1091                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1092                     	xdef	f_ADC1_IRQHandler
1093                     	xdef	f_UART2_TX_IRQHandler
1094                     	xdef	f_UART2_RX_IRQHandler
1095                     	xdef	f_I2C_IRQHandler
1096                     	xdef	f_TIM3_CAP_COM_IRQHandler
1097                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1098                     	xdef	f_TIM2_CAP_COM_IRQHandler
1099                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1100                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1101                     	xdef	f_TIM1_CAP_COM_IRQHandler
1102                     	xdef	f_SPI_IRQHandler
1103                     	xdef	f_EXTI_PORTE_IRQHandler
1104                     	xdef	f_EXTI_PORTD_IRQHandler
1105                     	xdef	f_EXTI_PORTC_IRQHandler
1106                     	xdef	f_EXTI_PORTB_IRQHandler
1107                     	xdef	f_EXTI_PORTA_IRQHandler
1108                     	xdef	f_CLK_IRQHandler
1109                     	xdef	f_AWU_IRQHandler
1110                     	xdef	f_TLI_IRQHandler
1111                     	xdef	f_TRAP_IRQHandler
1112                     	xdef	f_NonHandledInterrupt
1113                     	xref	_TIM2_ClearFlag
1114                     	xref	_GPIO_WriteLow
1115                     	xref	_GPIO_WriteHigh
1116                     	xref	_ADC1_ClearFlag
1117                     	xref	_ADC1_GetFlagStatus
1118                     	xref	_ADC1_GetBufferValue
1119                     	xref	_ADC1_StartConversion
1120                     	xref	_ADC1_ScanModeCmd
1121                     	xdef	f_EXTI2_IRQHandler
1122                     	xdef	f_TIM2_UPD_IRQHandler
1123                     	xref.b	c_x
1124                     	xref.b	c_y
1143                     	end
