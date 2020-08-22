   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  18                     	bsct
  19  0000               _testIncomplete:
  20  0000 01            	dc.b	1
  82                     ; 39 void TEST_run_all_tests( void )
  82                     ; 40 {
  84                     	switch	.text
  85  0000               _TEST_run_all_tests:
  87  0000 89            	pushw	x
  88       00000002      OFST:	set	2
  91                     ; 41     uint8_t HW_TEST_state = 0;  /* What inc's this? */
  93  0001 0f01          	clr	(OFST-1,sp)
  95                     ; 42     uint8_t runningTests = 1;   /* what changes this? */
  97  0003 a601          	ld	a,#1
  98  0005 6b02          	ld	(OFST+0,sp),a
 101  0007 204b          	jra	L76
 102  0009               L56:
 103                     ; 48         switch( HW_TEST_state )
 105  0009 7b01          	ld	a,(OFST-1,sp)
 107                     ; 81                 while( 1 );
 108  000b 271a          	jreq	L11
 109  000d 4a            	dec	a
 110  000e 271c          	jreq	L31
 111  0010 4a            	dec	a
 112  0011 271d          	jreq	L51
 113  0013 4a            	dec	a
 114  0014 272e          	jreq	L72
 115  0016 4a            	dec	a
 116  0017 271c          	jreq	L12
 117  0019 4a            	dec	a
 118  001a 271e          	jreq	L32
 119  001c 4a            	dec	a
 120  001d 2720          	jreq	L52
 121  001f 4a            	dec	a
 122  0020 2722          	jreq	L72
 123  0022 4a            	dec	a
 124  0023 2723          	jreq	L13
 125  0025 2023          	jra	L77
 126  0027               L11:
 127                     ; 50             case 0:
 127                     ; 51                 /* Toggles pin every 1ms */
 127                     ; 52                 TEST_clock_speed( );
 129  0027 cd02e3        	call	_TEST_clock_speed
 131                     ; 53                 break;
 133  002a 2020          	jra	L57
 134  002c               L31:
 135                     ; 54             case 1:
 135                     ; 55                 /* Rename, readWrite test */
 135                     ; 56                 /* If any fail, it get get stuck in the while loop. */
 135                     ; 57                 TEST_ram_test_001( );
 137  002c ad2f          	call	_TEST_ram_test_001
 139                     ; 58                 break;
 141  002e 201c          	jra	L57
 142  0030               L51:
 143                     ; 59             case 2:
 143                     ; 60                 TEST_adc_to_dac( );
 145  0030 cd010f        	call	_TEST_adc_to_dac
 147                     ; 61                 break;
 149  0033 2017          	jra	L57
 150                     ; 62             case 3:
 150                     ; 63                 TEST_rampfunc_in_ram_to_dac( );
 152                     ; 64                 break;
 154  0035               L12:
 155                     ; 65             case 4:
 155                     ; 66                 TEST_adc_to_ram_to_dac( );
 157  0035 cd015d        	call	_TEST_adc_to_ram_to_dac
 159                     ; 67                 break;
 161  0038 2012          	jra	L57
 162  003a               L32:
 163                     ; 68             case 5:
 163                     ; 69                 TEST_adc_to_ram_to_dac_with_delay( );
 165  003a cd01d1        	call	_TEST_adc_to_ram_to_dac_with_delay
 167                     ; 70                 break;
 169  003d 200d          	jra	L57
 170  003f               L52:
 171                     ; 71             case 6:
 171                     ; 72                 TEST_adc_to_ram_to_dac_with_with_fback( );
 173  003f cd024f        	call	_TEST_adc_to_ram_to_dac_with_with_fback
 175                     ; 73                 break;
 177  0042 2008          	jra	L57
 178  0044               L72:
 179                     ; 74             case 7:
 179                     ; 75                 TEST_rampfunc_in_ram_to_dac( );
 182  0044 ad66          	call	_TEST_rampfunc_in_ram_to_dac
 184                     ; 76                 break;
 186  0046 2004          	jra	L57
 187  0048               L13:
 188                     ; 77             case 8:
 188                     ; 78                 runningTests = 0;
 190  0048 6b02          	ld	(OFST+0,sp),a
 192  004a               L77:
 193                     ; 81                 while( 1 );
 195  004a 20fe          	jra	L77
 196  004c               L57:
 197                     ; 84         HW_TEST_state++;
 199  004c 0c01          	inc	(OFST-1,sp)
 201                     ; 86         delay_us( 1000 );
 203  004e ae03e8        	ldw	x,#1000
 204  0051 cd0000        	call	_delay_us
 206  0054               L76:
 207                     ; 46     while ( runningTests )
 209  0054 7b02          	ld	a,(OFST+0,sp)
 210  0056 26b1          	jrne	L56
 211                     ; 89     huge_Deinit( ); // incomplete ( ? )
 213  0058 cd034b        	call	L7_huge_Deinit
 215                     ; 91 }
 218  005b 85            	popw	x
 219  005c 81            	ret	
 222                     .const:	section	.text
 223  0000               L301_RAM_MODE:
 224  0000 00            	dc.b	0
 225  0001 40            	dc.b	64
 226  0002 80            	dc.b	128
 227  0003 00            	dc.b	0
 305                     ; 110 void TEST_ram_test_001( void )
 305                     ; 111 {
 306                     	switch	.text
 307  005d               _TEST_ram_test_001:
 309  005d 5209          	subw	sp,#9
 310       00000009      OFST:	set	9
 313                     ; 112     uint8_t  data  = 0;
 315  005f 0f06          	clr	(OFST-3,sp)
 317                     ; 113     uint8_t  wdata = 0;
 319                     ; 114     uint16_t addr  = 0;
 321                     ; 115     uint8_t  RAM_MODE[ NUM_OF_SPI_MODES ] = { BYTE_MODE, SEQ_MODE, PAGE_MODE, BYTE_MODE };
 323  0061 96            	ldw	x,sp
 324  0062 5c            	incw	x
 325  0063 90ae0000      	ldw	y,#L301_RAM_MODE
 326  0067 a604          	ld	a,#4
 327  0069 cd0000        	call	c_xymvx
 329                     ; 116     uint8_t  mode = 0;
 331                     ; 119     CLOCK_setup( );
 333  006c cd0000        	call	_CLOCK_setup
 335                     ; 120     setupNextTestButton( );
 337  006f cd0305        	call	L3_setupNextTestButton
 339                     ; 123     disableInterrupts( );
 342  0072 9b            	sim	
 344                     ; 124     SPI_setup( );
 347  0073 cd0000        	call	_SPI_setup
 349                     ; 125     RAM_init( );
 351  0076 cd0000        	call	_MCP_23K256_RAM_init
 353                     ; 127     enableInterrupts( );
 356  0079 9a            	rim	
 358                     ; 147 RAM_write_status_register( BYTE_MODE );
 361  007a 4f            	clr	a
 362  007b cd0000        	call	_MCP_23K256_RAM_write_status_register
 364                     ; 154     wdata = 0x55;
 366  007e a655          	ld	a,#85
 367  0080 6b07          	ld	(OFST-2,sp),a
 369                     ; 155     addr  = 0;
 371                     ; 157     for( addr = 0; addr < SRAM_SIZE; addr++ ) //is it <= or <  --Test!
 373  0082 5f            	clrw	x
 374  0083 1f08          	ldw	(OFST-1,sp),x
 376  0085               L341:
 377                     ; 159         RAM_write_byte( addr, wdata );
 379  0085 88            	push	a
 380  0086 1e09          	ldw	x,(OFST+0,sp)
 381  0088 cd0000        	call	_MCP_23K256_RAM_write_byte
 383  008b 84            	pop	a
 384                     ; 160         MCP_23K256_RAM_read_byte( addr, &data );
 386  008c 96            	ldw	x,sp
 387  008d 1c0006        	addw	x,#OFST-3
 388  0090 89            	pushw	x
 389  0091 1e0a          	ldw	x,(OFST+1,sp)
 390  0093 cd0000        	call	_MCP_23K256_RAM_read_byte
 392  0096 85            	popw	x
 393                     ; 161         if ( wdata != data )
 395  0097 7b07          	ld	a,(OFST-2,sp)
 396  0099 1106          	cp	a,(OFST-3,sp)
 397  009b 2702          	jreq	L151
 398  009d               L351:
 399                     ; 164             while( 1 );
 401  009d 20fe          	jra	L351
 402  009f               L151:
 403                     ; 157     for( addr = 0; addr < SRAM_SIZE; addr++ ) //is it <= or <  --Test!
 405  009f 1e08          	ldw	x,(OFST-1,sp)
 406  00a1 5c            	incw	x
 407  00a2 1f08          	ldw	(OFST-1,sp),x
 411  00a4 a37d00        	cpw	x,#32000
 412  00a7 25dc          	jrult	L341
 413                     ; 167 }
 416  00a9 5b09          	addw	sp,#9
 417  00ab 81            	ret	
 482                     ; 173 void TEST_rampfunc_in_ram_to_dac( void )
 482                     ; 174 {
 483                     	switch	.text
 484  00ac               _TEST_rampfunc_in_ram_to_dac:
 486  00ac 5204          	subw	sp,#4
 487       00000004      OFST:	set	4
 490                     ; 175     uint8_t  data  = 0;
 492  00ae 0f02          	clr	(OFST-2,sp)
 494                     ; 176     uint8_t  wdata = 0;
 496  00b0 0f01          	clr	(OFST-3,sp)
 498                     ; 177     uint16_t addr  = 0;
 500                     ; 178     testIncomplete = 1;
 502  00b2 35010000      	mov	_testIncomplete,#1
 503                     ; 181     disableInterrupts( );
 506  00b6 9b            	sim	
 508                     ; 182     CLOCK_setup( );
 511  00b7 cd0000        	call	_CLOCK_setup
 513                     ; 183     setupNextTestButton( );
 515  00ba cd0305        	call	L3_setupNextTestButton
 517                     ; 185     SPI_setup( );
 519  00bd cd0000        	call	_SPI_setup
 521                     ; 186     RAM_init( );
 523  00c0 cd0000        	call	_MCP_23K256_RAM_init
 525                     ; 187     DAC_init( );
 527  00c3 cd0000        	call	_MCP4901_DAC_init
 529                     ; 188     enableInterrupts( );
 532  00c6 9a            	rim	
 534                     ; 191     for( addr = 0, wdata; addr<255; addr++, wdata+=4 )
 537  00c7 5f            	clrw	x
 538  00c8 1f03          	ldw	(OFST-1,sp),x
 540  00ca 7b01          	ld	a,(OFST-3,sp)
 541  00cc               L502:
 542                     ; 193         RAM_write_byte( addr, wdata );
 544  00cc 88            	push	a
 545  00cd 1e04          	ldw	x,(OFST+0,sp)
 546  00cf cd0000        	call	_MCP_23K256_RAM_write_byte
 548  00d2 84            	pop	a
 549                     ; 191     for( addr = 0, wdata; addr<255; addr++, wdata+=4 )
 551  00d3 1e03          	ldw	x,(OFST-1,sp)
 552  00d5 5c            	incw	x
 553  00d6 1f03          	ldw	(OFST-1,sp),x
 555  00d8 7b01          	ld	a,(OFST-3,sp)
 556  00da ab04          	add	a,#4
 557  00dc 6b01          	ld	(OFST-3,sp),a
 561  00de a300ff        	cpw	x,#255
 562  00e1 25e9          	jrult	L502
 564  00e3 2023          	jra	L512
 565  00e5               L312:
 566                     ; 199         for( addr = 0; addr<255; addr++ )
 568  00e5 5f            	clrw	x
 569  00e6 1f03          	ldw	(OFST-1,sp),x
 571  00e8               L122:
 572                     ; 201             RAM_read_byte( addr, &data );
 574  00e8 96            	ldw	x,sp
 575  00e9 1c0002        	addw	x,#OFST-2
 576  00ec 89            	pushw	x
 577  00ed 1e05          	ldw	x,(OFST+1,sp)
 578  00ef cd0000        	call	_MCP_23K256_RAM_read_byte
 580  00f2 85            	popw	x
 581                     ; 202             DAC_write( data );
 583  00f3 7b02          	ld	a,(OFST-2,sp)
 584  00f5 cd0000        	call	_MCP4901_DAC_write
 586                     ; 203             delay_us( 90 );   // ~11kHz sample rate // phasor == frequ
 588  00f8 ae005a        	ldw	x,#90
 589  00fb cd0000        	call	_delay_us
 591                     ; 199         for( addr = 0; addr<255; addr++ )
 593  00fe 1e03          	ldw	x,(OFST-1,sp)
 594  0100 5c            	incw	x
 595  0101 1f03          	ldw	(OFST-1,sp),x
 599  0103 a300ff        	cpw	x,#255
 600  0106 25e0          	jrult	L122
 601  0108               L512:
 602                     ; 197     while( testIncomplete )
 604  0108 b600          	ld	a,_testIncomplete
 605  010a 26d9          	jrne	L312
 606                     ; 210 }
 609  010c 5b04          	addw	sp,#4
 610  010e 81            	ret	
 660                     ; 213 void TEST_adc_to_dac( void )
 660                     ; 214 {
 661                     	switch	.text
 662  010f               _TEST_adc_to_dac:
 664  010f 89            	pushw	x
 665       00000002      OFST:	set	2
 668                     ; 215     uint16_t adcVal = 0;
 670                     ; 216     testIncomplete = 1;
 672  0110 35010000      	mov	_testIncomplete,#1
 673                     ; 219     disableInterrupts( );
 676  0114 9b            	sim	
 678                     ; 220     CLOCK_setup( );
 681  0115 cd0000        	call	_CLOCK_setup
 683                     ; 221     setupNextTestButton( );
 685  0118 cd0305        	call	L3_setupNextTestButton
 687                     ; 223     ADC1_setupMultiChannel( );
 689  011b cd0000        	call	_ADC1_setupMultiChannel
 691                     ; 224     SPI_setup( );
 693  011e cd0000        	call	_SPI_setup
 695                     ; 225     DAC_init( );
 697  0121 cd0000        	call	_MCP4901_DAC_init
 699                     ; 226     enableInterrupts( );
 702  0124 9a            	rim	
 706  0125 2030          	jra	L152
 707  0127               L742:
 708                     ; 90     ADC1_ScanModeCmd( ENABLE );
 711  0127 a601          	ld	a,#1
 712  0129 cd0000        	call	_ADC1_ScanModeCmd
 714                     ; 91     ADC1_StartConversion( );
 716  012c cd0000        	call	_ADC1_StartConversion
 719  012f               L752:
 720                     ; 92     while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 722  012f a680          	ld	a,#128
 723  0131 cd0000        	call	_ADC1_GetFlagStatus
 725  0134 4d            	tnz	a
 726  0135 27f8          	jreq	L752
 727                     ; 93     ADC1_ClearFlag( ADC1_FLAG_EOC );
 729  0137 a680          	ld	a,#128
 730  0139 cd0000        	call	_ADC1_ClearFlag
 732                     ; 239         adcVal  = ADC1_GetBufferValue( 1 ); //magic number!
 734  013c a601          	ld	a,#1
 735  013e cd0000        	call	_ADC1_GetBufferValue
 737  0141 1f01          	ldw	(OFST-1,sp),x
 739                     ; 242         adcVal >>= 2;
 741  0143 a602          	ld	a,#2
 742  0145               L421:
 743  0145 0401          	srl	(OFST-1,sp)
 744  0147 0602          	rrc	(OFST+0,sp)
 745  0149 4a            	dec	a
 746  014a 26f9          	jrne	L421
 748                     ; 243         DAC_write( (uint8_t)adcVal );
 750  014c 7b02          	ld	a,(OFST+0,sp)
 751  014e cd0000        	call	_MCP4901_DAC_write
 753                     ; 246         delay_us( 90 );
 755  0151 ae005a        	ldw	x,#90
 756  0154 cd0000        	call	_delay_us
 758  0157               L152:
 759                     ; 228     while( testIncomplete )
 761  0157 b600          	ld	a,_testIncomplete
 762  0159 26cc          	jrne	L742
 763                     ; 251 }
 766  015b 85            	popw	x
 767  015c 81            	ret	
 840                     ; 254 void TEST_adc_to_ram_to_dac( void )
 840                     ; 255 {
 841                     	switch	.text
 842  015d               _TEST_adc_to_ram_to_dac:
 844  015d 5205          	subw	sp,#5
 845       00000005      OFST:	set	5
 848                     ; 256     uint16_t addr = 0;
 850  015f 5f            	clrw	x
 851  0160 1f02          	ldw	(OFST-3,sp),x
 853                     ; 257     uint16_t adcVal = 0;
 855                     ; 258     uint8_t  ramData = 0;
 857  0162 0f01          	clr	(OFST-4,sp)
 859                     ; 259     testIncomplete = 1;
 861  0164 35010000      	mov	_testIncomplete,#1
 862                     ; 262     disableInterrupts( );
 865  0168 9b            	sim	
 867                     ; 263     CLOCK_setup( );
 870  0169 cd0000        	call	_CLOCK_setup
 872                     ; 264     setupNextTestButton( );
 874  016c cd0305        	call	L3_setupNextTestButton
 876                     ; 266     ADC1_setupMultiChannel( );
 878  016f cd0000        	call	_ADC1_setupMultiChannel
 880                     ; 267     SPI_setup( );
 882  0172 cd0000        	call	_SPI_setup
 884                     ; 268     RAM_init( );
 886  0175 cd0000        	call	_MCP_23K256_RAM_init
 888                     ; 269     DAC_init( );
 890  0178 cd0000        	call	_MCP4901_DAC_init
 892                     ; 270     enableInterrupts( );
 895  017b 9a            	rim	
 899  017c 204c          	jra	L513
 900  017e               L313:
 901                     ; 90     ADC1_ScanModeCmd( ENABLE );
 904  017e a601          	ld	a,#1
 905  0180 cd0000        	call	_ADC1_ScanModeCmd
 907                     ; 91     ADC1_StartConversion( );
 909  0183 cd0000        	call	_ADC1_StartConversion
 912  0186               L323:
 913                     ; 92     while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 915  0186 a680          	ld	a,#128
 916  0188 cd0000        	call	_ADC1_GetFlagStatus
 918  018b 4d            	tnz	a
 919  018c 27f8          	jreq	L323
 920                     ; 93     ADC1_ClearFlag( ADC1_FLAG_EOC );
 922  018e a680          	ld	a,#128
 923  0190 cd0000        	call	_ADC1_ClearFlag
 925                     ; 276         adcVal  = ADC1_GetBufferValue( 1 ); //magic number!
 927  0193 a601          	ld	a,#1
 928  0195 cd0000        	call	_ADC1_GetBufferValue
 930  0198 1f04          	ldw	(OFST-1,sp),x
 932                     ; 279         adcVal >>= 2;
 934  019a a602          	ld	a,#2
 935  019c               L261:
 936  019c 0404          	srl	(OFST-1,sp)
 937  019e 0605          	rrc	(OFST+0,sp)
 938  01a0 4a            	dec	a
 939  01a1 26f9          	jrne	L261
 941                     ; 282         RAM_write_byte( addr, (uint8_t)adcVal );
 943  01a3 7b05          	ld	a,(OFST+0,sp)
 944  01a5 88            	push	a
 945  01a6 1e03          	ldw	x,(OFST-2,sp)
 946  01a8 cd0000        	call	_MCP_23K256_RAM_write_byte
 948  01ab 84            	pop	a
 949                     ; 285         RAM_read_byte( addr, &ramData ); // er adcVal is uint16 this returna uint8 ..
 951  01ac 96            	ldw	x,sp
 952  01ad 5c            	incw	x
 953  01ae 89            	pushw	x
 954  01af 1e04          	ldw	x,(OFST-1,sp)
 955  01b1 cd0000        	call	_MCP_23K256_RAM_read_byte
 957  01b4 85            	popw	x
 958                     ; 287         DAC_write( ramData );
 960  01b5 7b01          	ld	a,(OFST-4,sp)
 961  01b7 cd0000        	call	_MCP4901_DAC_write
 963                     ; 290         addr++;
 965  01ba 1e02          	ldw	x,(OFST-3,sp)
 966  01bc 5c            	incw	x
 967  01bd 1f02          	ldw	(OFST-3,sp),x
 969                     ; 293         delay_us( 90 );
 971  01bf ae005a        	ldw	x,#90
 972  01c2 cd0000        	call	_delay_us
 974                     ; 296         testIncomplete = moveToNextTest( );
 976  01c5 cd0324        	call	L5_moveToNextTest
 978  01c8 b700          	ld	_testIncomplete,a
 979  01ca               L513:
 980                     ; 272     while( testIncomplete )
 982  01ca b600          	ld	a,_testIncomplete
 983  01cc 26b0          	jrne	L313
 984                     ; 298 }
 987  01ce 5b05          	addw	sp,#5
 988  01d0 81            	ret	
1079                     ; 301 void TEST_adc_to_ram_to_dac_with_delay( void )
1079                     ; 302 {
1080                     	switch	.text
1081  01d1               _TEST_adc_to_ram_to_dac_with_delay:
1083  01d1 5209          	subw	sp,#9
1084       00000009      OFST:	set	9
1087                     ; 303     uint8_t  read_val = 0;   //read val from ram
1089  01d3 0f01          	clr	(OFST-8,sp)
1091                     ; 304     uint16_t write_addr = 0;    //write addr in ram
1093  01d5 5f            	clrw	x
1094  01d6 1f08          	ldw	(OFST-1,sp),x
1096                     ; 305     uint16_t read_addr = 0; // read addr in val
1098  01d8 1f02          	ldw	(OFST-7,sp),x
1100                     ; 306     uint16_t delayLength = 110; // length of delay in samples
1102  01da ae006e        	ldw	x,#110
1103  01dd 1f06          	ldw	(OFST-3,sp),x
1105                     ; 307     uint16_t adcVal = 0;
1107                     ; 310     disableInterrupts( );
1110  01df 9b            	sim	
1112                     ; 311     CLOCK_setup( );
1115  01e0 cd0000        	call	_CLOCK_setup
1117                     ; 312     setupNextTestButton( );
1119  01e3 cd0305        	call	L3_setupNextTestButton
1121                     ; 314     ADC1_setupMultiChannel( );
1123  01e6 cd0000        	call	_ADC1_setupMultiChannel
1125                     ; 315     SPI_setup( );
1127  01e9 cd0000        	call	_SPI_setup
1129                     ; 316     RAM_init( );
1131  01ec cd0000        	call	_MCP_23K256_RAM_init
1133                     ; 317     DAC_init( );
1135  01ef cd0000        	call	_MCP4901_DAC_init
1137                     ; 318     enableInterrupts( );
1140  01f2 9a            	rim	
1144  01f3 2053          	jra	L173
1145  01f5               L763:
1146                     ; 90     ADC1_ScanModeCmd( ENABLE );
1149  01f5 a601          	ld	a,#1
1150  01f7 cd0000        	call	_ADC1_ScanModeCmd
1152                     ; 91     ADC1_StartConversion( );
1154  01fa cd0000        	call	_ADC1_StartConversion
1157  01fd               L773:
1158                     ; 92     while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
1160  01fd a680          	ld	a,#128
1161  01ff cd0000        	call	_ADC1_GetFlagStatus
1163  0202 4d            	tnz	a
1164  0203 27f8          	jreq	L773
1165                     ; 93     ADC1_ClearFlag( ADC1_FLAG_EOC );
1167  0205 a680          	ld	a,#128
1168  0207 cd0000        	call	_ADC1_ClearFlag
1170                     ; 324         adcVal  = ADC1_GetBufferValue( 1 ); //magic number!
1172  020a a601          	ld	a,#1
1173  020c cd0000        	call	_ADC1_GetBufferValue
1175  020f 1f04          	ldw	(OFST-5,sp),x
1177                     ; 327         adcVal >>= 2;
1179  0211 a602          	ld	a,#2
1180  0213               L622:
1181  0213 0404          	srl	(OFST-5,sp)
1182  0215 0605          	rrc	(OFST-4,sp)
1183  0217 4a            	dec	a
1184  0218 26f9          	jrne	L622
1186                     ; 338             read_addr = write_addr - delayLength;
1188  021a 1e08          	ldw	x,(OFST-1,sp)
1189  021c 72f006        	subw	x,(OFST-3,sp)
1190  021f 1f02          	ldw	(OFST-7,sp),x
1192                     ; 342         RAM_write_byte( write_addr, (uint8_t)adcVal );
1194  0221 7b05          	ld	a,(OFST-4,sp)
1195  0223 88            	push	a
1196  0224 1e09          	ldw	x,(OFST+0,sp)
1197  0226 cd0000        	call	_MCP_23K256_RAM_write_byte
1199  0229 84            	pop	a
1200                     ; 345         RAM_read_byte( read_addr, &read_val );
1202  022a 96            	ldw	x,sp
1203  022b 5c            	incw	x
1204  022c 89            	pushw	x
1205  022d 1e04          	ldw	x,(OFST-5,sp)
1206  022f cd0000        	call	_MCP_23K256_RAM_read_byte
1208  0232 85            	popw	x
1209                     ; 348         DAC_write( read_val );
1211  0233 7b01          	ld	a,(OFST-8,sp)
1212  0235 cd0000        	call	_MCP4901_DAC_write
1214                     ; 351         write_addr++;
1216  0238 1e08          	ldw	x,(OFST-1,sp)
1217  023a 5c            	incw	x
1218  023b 1f08          	ldw	(OFST-1,sp),x
1220                     ; 354         delay_us( 90 );
1222  023d ae005a        	ldw	x,#90
1223  0240 cd0000        	call	_delay_us
1225                     ; 357         testIncomplete = moveToNextTest( );
1227  0243 cd0324        	call	L5_moveToNextTest
1229  0246 b700          	ld	_testIncomplete,a
1230  0248               L173:
1231                     ; 320     while( testIncomplete )
1233  0248 b600          	ld	a,_testIncomplete
1234  024a 26a9          	jrne	L763
1235                     ; 359 }
1238  024c 5b09          	addw	sp,#9
1239  024e 81            	ret	
1349                     ; 363 void TEST_adc_to_ram_to_dac_with_with_fback( void )
1349                     ; 364 {
1350                     	switch	.text
1351  024f               _TEST_adc_to_ram_to_dac_with_with_fback:
1353  024f 520c          	subw	sp,#12
1354       0000000c      OFST:	set	12
1357                     ; 365     uint16_t adc0_val = 0;  //er are these 8 or 16 big?
1359                     ; 366     uint16_t adc1_val = 0;
1361                     ; 367     uint8_t  mapd_value = 0; // mapped adc valu
1363                     ; 368     uint8_t  read_val = 0;   //read val from ram
1365  0251 0f05          	clr	(OFST-7,sp)
1367                     ; 369     uint16_t write_addr = 0;    //write addr in ram
1369  0253 5f            	clrw	x
1370  0254 1f09          	ldw	(OFST-3,sp),x
1372                     ; 370     uint16_t read_addr = 0; // read addr in val
1374  0256 1f06          	ldw	(OFST-6,sp),x
1376                     ; 371     uint16_t delay = 110; // length of delay in samples
1378                     ; 372     testIncomplete = 1;
1380  0258 35010000      	mov	_testIncomplete,#1
1381                     ; 375     disableInterrupts( );
1384  025c 9b            	sim	
1386                     ; 376     CLOCK_setup( );
1389  025d cd0000        	call	_CLOCK_setup
1391                     ; 377     setupNextTestButton( );
1393  0260 cd0305        	call	L3_setupNextTestButton
1395                     ; 379     ADC1_setupMultiChannel( );
1397  0263 cd0000        	call	_ADC1_setupMultiChannel
1399                     ; 380     SPI_setup( );
1401  0266 cd0000        	call	_SPI_setup
1403                     ; 381     RAM_init( );
1405  0269 cd0000        	call	_MCP_23K256_RAM_init
1407                     ; 382     DAC_init( );
1409  026c cd0000        	call	_MCP4901_DAC_init
1411                     ; 383     enableInterrupts( );
1414  026f 9a            	rim	
1418  0270 206a          	jra	L554
1419  0272               L354:
1420                     ; 90     ADC1_ScanModeCmd( ENABLE );
1423  0272 a601          	ld	a,#1
1424  0274 cd0000        	call	_ADC1_ScanModeCmd
1426                     ; 91     ADC1_StartConversion( );
1428  0277 cd0000        	call	_ADC1_StartConversion
1431  027a               L364:
1432                     ; 92     while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
1434  027a a680          	ld	a,#128
1435  027c cd0000        	call	_ADC1_GetFlagStatus
1437  027f 4d            	tnz	a
1438  0280 27f8          	jreq	L364
1439                     ; 93     ADC1_ClearFlag( ADC1_FLAG_EOC );
1441  0282 a680          	ld	a,#128
1442  0284 cd0000        	call	_ADC1_ClearFlag
1444                     ; 389         adc0_val = ADC1_GetBufferValue( 0 );
1446  0287 4f            	clr	a
1447  0288 cd0000        	call	_ADC1_GetBufferValue
1449  028b 1f03          	ldw	(OFST-9,sp),x
1451                     ; 390         adc1_val = ADC1_GetBufferValue( 1 );
1453  028d a601          	ld	a,#1
1454  028f cd0000        	call	_ADC1_GetBufferValue
1457                     ; 393         delay = ( adc1_val >> 2 );
1459  0292 54            	srlw	x
1460  0293 54            	srlw	x
1461  0294 1f0b          	ldw	(OFST-1,sp),x
1463                     ; 403         mapd_value = ( adc0_val >> 2 ) ; // do i need the float or not ??? -No use a lft shift
1465  0296 1e03          	ldw	x,(OFST-9,sp)
1466  0298 54            	srlw	x
1467  0299 54            	srlw	x
1468  029a 01            	rrwa	x,a
1469  029b 6b08          	ld	(OFST-4,sp),a
1471                     ; 408         mapd_value = ( mapd_value / 2 ) + ( read_val / 2 ); // do i need the float or not ???
1473  029d 5f            	clrw	x
1474  029e 7b05          	ld	a,(OFST-7,sp)
1475  02a0 97            	ld	xl,a
1476  02a1 57            	sraw	x
1477  02a2 1f01          	ldw	(OFST-11,sp),x
1479  02a4 5f            	clrw	x
1480  02a5 7b08          	ld	a,(OFST-4,sp)
1481  02a7 97            	ld	xl,a
1482  02a8 57            	sraw	x
1483  02a9 72fb01        	addw	x,(OFST-11,sp)
1484  02ac 01            	rrwa	x,a
1485  02ad 6b08          	ld	(OFST-4,sp),a
1487                     ; 419             read_addr = write_addr - delay;
1489  02af 1e09          	ldw	x,(OFST-3,sp)
1490  02b1 72f00b        	subw	x,(OFST-1,sp)
1491  02b4 1f06          	ldw	(OFST-6,sp),x
1493                     ; 423         RAM_write_byte( write_addr, mapd_value );
1495  02b6 88            	push	a
1496  02b7 1e0a          	ldw	x,(OFST-2,sp)
1497  02b9 cd0000        	call	_MCP_23K256_RAM_write_byte
1499  02bc 84            	pop	a
1500                     ; 426         RAM_read_byte( read_addr, &read_val );
1502  02bd 96            	ldw	x,sp
1503  02be 1c0005        	addw	x,#OFST-7
1504  02c1 89            	pushw	x
1505  02c2 1e08          	ldw	x,(OFST-4,sp)
1506  02c4 cd0000        	call	_MCP_23K256_RAM_read_byte
1508  02c7 85            	popw	x
1509                     ; 429         DAC_write( read_val );
1511  02c8 7b05          	ld	a,(OFST-7,sp)
1512  02ca cd0000        	call	_MCP4901_DAC_write
1514                     ; 432         write_addr++;
1516  02cd 1e09          	ldw	x,(OFST-3,sp)
1517  02cf 5c            	incw	x
1518  02d0 1f09          	ldw	(OFST-3,sp),x
1520                     ; 435         delay_us( 90 );
1522  02d2 ae005a        	ldw	x,#90
1523  02d5 cd0000        	call	_delay_us
1525                     ; 438         testIncomplete = moveToNextTest( );
1527  02d8 ad4a          	call	L5_moveToNextTest
1529  02da b700          	ld	_testIncomplete,a
1530  02dc               L554:
1531                     ; 385     while( testIncomplete )
1533  02dc b600          	ld	a,_testIncomplete
1534  02de 2692          	jrne	L354
1535                     ; 440 }
1538  02e0 5b0c          	addw	sp,#12
1539  02e2 81            	ret	
1568                     ; 447 void TEST_clock_speed( void )
1568                     ; 448 {
1569                     	switch	.text
1570  02e3               _TEST_clock_speed:
1574                     ; 449     testIncomplete = 1;
1576  02e3 35010000      	mov	_testIncomplete,#1
1577                     ; 452     CLOCK_setup( );
1579  02e7 cd0000        	call	_CLOCK_setup
1581                     ; 453     setupNextTestButton( );
1583  02ea ad19          	call	L3_setupNextTestButton
1585                     ; 454     GPIO_setupDebugPin( );
1587  02ec cd0000        	call	_GPIO_setupDebugPin
1590  02ef 200f          	jra	L105
1591  02f1               L774:
1592                     ; 459         delay_ms( 1 ); // clock ~1kHz ??
1594  02f1 ae0001        	ldw	x,#1
1595  02f4 cd0000        	call	_delay_ms
1597                     ; 460         GPIO_WriteReverse( LOGICANALYSER_port, LOGICANALYSER_pin );
1599  02f7 4b08          	push	#8
1600  02f9 ae500a        	ldw	x,#20490
1601  02fc cd0000        	call	_GPIO_WriteReverse
1603  02ff 84            	pop	a
1604  0300               L105:
1605                     ; 457     while ( testIncomplete )
1607  0300 b600          	ld	a,_testIncomplete
1608  0302 26ed          	jrne	L774
1609                     ; 463 }
1612  0304 81            	ret	
1638                     ; 469 static void setupNextTestButton( void )
1638                     ; 470 {
1639                     	switch	.text
1640  0305               L3_setupNextTestButton:
1644                     ; 473     GPIO_Init(NEXT_TEST_BUTTON_PORT, NEXT_TEST_BUTTON_PIN, GPIO_MODE_IN_PU_IT);
1646  0305 4b60          	push	#96
1647  0307 4b02          	push	#2
1648  0309 ae500a        	ldw	x,#20490
1649  030c cd0000        	call	_GPIO_Init
1651  030f 85            	popw	x
1652                     ; 474     EXTI_setup( );
1655                     ; 475 }
1658  0310 2000          	jp	_EXTI_setup
1686                     ; 478 void EXTI_setup( void )
1686                     ; 479 {
1687                     	switch	.text
1688  0312               _EXTI_setup:
1692                     ; 481     ITC_DeInit( );
1694  0312 cd0000        	call	_ITC_DeInit
1696                     ; 485     EXTI_DeInit( );
1698  0315 cd0000        	call	_EXTI_DeInit
1700                     ; 486     EXTI_SetExtIntSensitivity( EXTI_PORT_GPIOC, EXTI_SENSITIVITY_FALL_ONLY );
1702  0318 ae0202        	ldw	x,#514
1703  031b cd0000        	call	_EXTI_SetExtIntSensitivity
1705                     ; 487     EXTI_SetTLISensitivity( EXTI_TLISENSITIVITY_FALL_ONLY );
1707  031e 4f            	clr	a
1708  031f cd0000        	call	_EXTI_SetTLISensitivity
1710                     ; 488     enableInterrupts( );
1713  0322 9a            	rim	
1715                     ; 489 }
1719  0323 81            	ret	
1744                     ; 494 static uint8_t moveToNextTest( void )
1744                     ; 495 {
1745                     	switch	.text
1746  0324               L5_moveToNextTest:
1750                     ; 498     if ( BUTTON_PRESSED )
1752  0324 4b02          	push	#2
1753  0326 ae500a        	ldw	x,#20490
1754  0329 cd0000        	call	_GPIO_ReadInputPin
1756  032c 5b01          	addw	sp,#1
1757  032e 4d            	tnz	a
1758  032f 2617          	jrne	L535
1759                     ; 502         delay_ms( 50 );
1761  0331 ae0032        	ldw	x,#50
1762  0334 cd0000        	call	_delay_ms
1764                     ; 504         return BUTTON_PRESSED;
1766  0337 4b02          	push	#2
1767  0339 ae500a        	ldw	x,#20490
1768  033c cd0000        	call	_GPIO_ReadInputPin
1770  033f 5b01          	addw	sp,#1
1771  0341 4d            	tnz	a
1772  0342 2602          	jrne	L053
1773  0344 4c            	inc	a
1775  0345 81            	ret	
1776  0346               L053:
1777  0346 4f            	clr	a
1780  0347 81            	ret	
1781  0348               L535:
1782                     ; 507     return 1;
1784  0348 a601          	ld	a,#1
1787  034a 81            	ret	
1819                     ; 520 static void huge_Deinit( void )
1819                     ; 521 {
1820                     	switch	.text
1821  034b               L7_huge_Deinit:
1825                     ; 522     disableInterrupts( );
1828  034b 9b            	sim	
1830                     ; 524     ITC_DeInit( );
1833  034c cd0000        	call	_ITC_DeInit
1835                     ; 525     EXTI_DeInit( );
1837  034f cd0000        	call	_EXTI_DeInit
1839                     ; 528     GPIO_DeInit( GPIOA );
1841  0352 ae5000        	ldw	x,#20480
1842  0355 cd0000        	call	_GPIO_DeInit
1844                     ; 529     GPIO_DeInit( GPIOB );
1846  0358 ae5005        	ldw	x,#20485
1847  035b cd0000        	call	_GPIO_DeInit
1849                     ; 530     GPIO_DeInit( GPIOC );
1851  035e ae500a        	ldw	x,#20490
1852  0361 cd0000        	call	_GPIO_DeInit
1854                     ; 531     GPIO_DeInit( GPIOD );
1856  0364 ae500f        	ldw	x,#20495
1857  0367 cd0000        	call	_GPIO_DeInit
1859                     ; 534     ADC1_DeInit( );
1861  036a cd0000        	call	_ADC1_DeInit
1863                     ; 535     SPI_DeInit( );
1865  036d cd0000        	call	_SPI_DeInit
1867                     ; 536     TIM2_DeInit( );
1869  0370 cd0000        	call	_TIM2_DeInit
1871                     ; 537     TIM4_DeInit( );
1873  0373 cd0000        	call	_TIM4_DeInit
1875                     ; 538     CLK_DeInit( );
1878                     ; 541 }
1881  0376 cc0000        	jp	_CLK_DeInit
1905                     	xdef	_testIncomplete
1906                     	xdef	_EXTI_setup
1907                     	xdef	_TEST_run_all_tests
1908                     	xdef	_TEST_clock_speed
1909                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
1910                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
1911                     	xdef	_TEST_adc_to_ram_to_dac
1912                     	xdef	_TEST_adc_to_dac
1913                     	xdef	_TEST_rampfunc_in_ram_to_dac
1914                     	xdef	_TEST_ram_test_001
1915                     	xref	_MCP_23K256_RAM_read_byte
1916                     	xref	_MCP_23K256_RAM_write_byte
1917                     	xref	_MCP_23K256_RAM_write_status_register
1918                     	xref	_MCP_23K256_RAM_init
1919                     	xref	_MCP4901_DAC_write
1920                     	xref	_MCP4901_DAC_init
1921                     	xref	_delay_ms
1922                     	xref	_delay_us
1923                     	xref	_ADC1_setupMultiChannel
1924                     	xref	_SPI_setup
1925                     	xref	_GPIO_setupDebugPin
1926                     	xref	_CLOCK_setup
1927                     	xref	_TIM4_DeInit
1928                     	xref	_TIM2_DeInit
1929                     	xref	_SPI_DeInit
1930                     	xref	_ITC_DeInit
1931                     	xref	_GPIO_ReadInputPin
1932                     	xref	_GPIO_WriteReverse
1933                     	xref	_GPIO_Init
1934                     	xref	_GPIO_DeInit
1935                     	xref	_EXTI_SetTLISensitivity
1936                     	xref	_EXTI_SetExtIntSensitivity
1937                     	xref	_EXTI_DeInit
1938                     	xref	_CLK_DeInit
1939                     	xref	_ADC1_ClearFlag
1940                     	xref	_ADC1_GetFlagStatus
1941                     	xref	_ADC1_GetBufferValue
1942                     	xref	_ADC1_StartConversion
1943                     	xref	_ADC1_ScanModeCmd
1944                     	xref	_ADC1_DeInit
1945                     	xref.b	c_x
1964                     	xref	c_xymvx
1965                     	end
