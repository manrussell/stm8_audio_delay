   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 144                     ; 133 void main( void )
 144                     ; 134 {
 146                     	switch	.text
 147  0000               _main:
 149  0000 520f          	subw	sp,#15
 150       0000000f      OFST:	set	15
 153                     ; 135     uint16_t adc_leftChannel = 0;
 155                     ; 136     uint16_t adc_feedback    = 0;
 157                     ; 137     uint16_t adc_delay       = 0;
 159                     ; 138     uint8_t  mapd_value      = 0;    // mapped adc valu
 161                     ; 139     uint8_t  read_val        = 0;    // read val from ram
 163  0002 0f08          	clr	(OFST-7,sp)
 165                     ; 140     uint16_t write_addr      = 0;    // write addr in ram
 167  0004 5f            	clrw	x
 168  0005 1f0c          	ldw	(OFST-3,sp),x
 170                     ; 141     uint16_t read_addr       = 0;    // read addr in val
 172  0007 1f09          	ldw	(OFST-6,sp),x
 174                     ; 142     uint16_t delay           = 110;  // length of delay in samples
 176                     ; 143     uint8_t  res             = 0;
 178                     ; 145     clock_setup();
 180  0009 cd026f        	call	_clock_setup
 182                     ; 146     GPIO_setup();
 184  000c cd02cf        	call	_GPIO_setup
 186                     ; 147     ADC1_setup();
 188  000f cd02f2        	call	_ADC1_setup
 190                     ; 148     SPI_setup();
 192  0012 cd03b1        	call	_SPI_setup
 194                     ; 149     MCP_23K256_init();
 196  0015 cd03cd        	call	_MCP_23K256_init
 198                     ; 150     MCP4901_DAC_init();
 200  0018 cd053d        	call	_MCP4901_DAC_init
 202  001b               L76:
 203                     ; 184         ADC1_ScanModeCmd( ENABLE );
 205  001b a601          	ld	a,#1
 206  001d cd0000        	call	_ADC1_ScanModeCmd
 208                     ; 185         ADC1_StartConversion( );
 210  0020 cd0000        	call	_ADC1_StartConversion
 213  0023               L57:
 214                     ; 186         while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 216  0023 a680          	ld	a,#128
 217  0025 cd0000        	call	_ADC1_GetFlagStatus
 219  0028 4d            	tnz	a
 220  0029 27f8          	jreq	L57
 221                     ; 188         adc_leftChannel = ADC1_GetBufferValue( 0); //ADC_LEFTCHANNEL );     // 0
 223  002b 4f            	clr	a
 224  002c cd0000        	call	_ADC1_GetBufferValue
 226  002f 1f06          	ldw	(OFST-9,sp),x
 228                     ; 189         adc_delay       = ADC1_GetBufferValue( 1); //ADC_FEEDBACK_AMOUNT ); // 1
 230  0031 a601          	ld	a,#1
 231  0033 cd0000        	call	_ADC1_GetBufferValue
 233  0036 1f0e          	ldw	(OFST-1,sp),x
 235                     ; 191         ADC1_ClearFlag( ADC1_FLAG_EOC );
 237  0038 a680          	ld	a,#128
 238  003a cd0000        	call	_ADC1_ClearFlag
 240                     ; 194         delay = ( adc_delay << 2 ); //(adc_delay >> 2);
 242  003d 1e0e          	ldw	x,(OFST-1,sp)
 243  003f 58            	sllw	x
 244  0040 58            	sllw	x
 245  0041 1f0e          	ldw	(OFST-1,sp),x
 247                     ; 201         mapd_value = (adc_leftChannel >> 2);
 249  0043 1e06          	ldw	x,(OFST-9,sp)
 250  0045 54            	srlw	x
 251  0046 54            	srlw	x
 252  0047 01            	rrwa	x,a
 253  0048 6b0b          	ld	(OFST-4,sp),a
 255                     ; 204         mapd_value = mapd_value/2 +  read_val/2;
 257  004a 5f            	clrw	x
 258  004b 7b08          	ld	a,(OFST-7,sp)
 259  004d 97            	ld	xl,a
 260  004e 57            	sraw	x
 261  004f 1f01          	ldw	(OFST-14,sp),x
 263  0051 5f            	clrw	x
 264  0052 7b0b          	ld	a,(OFST-4,sp)
 265  0054 97            	ld	xl,a
 266  0055 57            	sraw	x
 267  0056 72fb01        	addw	x,(OFST-14,sp)
 268  0059 01            	rrwa	x,a
 269  005a 6b0b          	ld	(OFST-4,sp),a
 271                     ; 215             read_addr = write_addr - delay;
 273  005c 1e0c          	ldw	x,(OFST-3,sp)
 274  005e 72f00e        	subw	x,(OFST-1,sp)
 275  0061 1f09          	ldw	(OFST-6,sp),x
 277                     ; 219         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 279  0063 88            	push	a
 280  0064 1e0d          	ldw	x,(OFST-2,sp)
 281  0066 cd046e        	call	_MCP_23K256_RAM_write_byte
 283  0069 84            	pop	a
 284                     ; 222         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 286  006a 96            	ldw	x,sp
 287  006b 1c0008        	addw	x,#OFST-7
 288  006e 89            	pushw	x
 289  006f 1e0b          	ldw	x,(OFST-4,sp)
 290  0071 cd04cb        	call	_MCP_23K256_RAM_read_byte
 292  0074 85            	popw	x
 293                     ; 225         MCP4901_DAC_write(read_val);
 295  0075 7b08          	ld	a,(OFST-7,sp)
 296  0077 cd054d        	call	_MCP4901_DAC_write
 298                     ; 228         write_addr++;
 300  007a 1e0c          	ldw	x,(OFST-3,sp)
 301  007c 5c            	incw	x
 302  007d 1f0c          	ldw	(OFST-3,sp),x
 304                     ; 231         delay_us(90);
 306  007f ae005a        	ldw	x,#90
 307  0082 cd059e        	call	_delay_us
 310  0085 2094          	jra	L76
 375                     ; 246 uint8_t TEST_ram_test_001(void)
 375                     ; 247 {
 376                     	switch	.text
 377  0087               _TEST_ram_test_001:
 379  0087 5205          	subw	sp,#5
 380       00000005      OFST:	set	5
 383                     ; 248     uint8_t cnt = 0;
 385                     ; 249     uint8_t data = 0;
 388                     ; 250     uint8_t wdata = 0;
 390                     ; 251     uint16_t addr = 0;
 392                     ; 254     data = BYTE_MODE;
 394  0089 0f03          	clr	(OFST-2,sp)
 396                     ; 255     MCP_23K256_write_status_register(data);
 398  008b 4f            	clr	a
 399  008c cd0431        	call	_MCP_23K256_write_status_register
 401                     ; 258     MCP_23K256_read_status_register(&data);
 403  008f 96            	ldw	x,sp
 404  0090 1c0003        	addw	x,#OFST-2
 405  0093 cd03de        	call	_MCP_23K256_read_status_register
 407                     ; 302 wdata = 2;
 409  0096 a602          	ld	a,#2
 410  0098 6b02          	ld	(OFST-3,sp),a
 412                     ; 303 addr =0;
 414  009a 5f            	clrw	x
 415  009b 1f04          	ldw	(OFST-1,sp),x
 417                     ; 305     MCP_23K256_RAM_write_byte(addr, wdata);
 419  009d 4b02          	push	#2
 420  009f cd046e        	call	_MCP_23K256_RAM_write_byte
 422  00a2 84            	pop	a
 423                     ; 308     MCP_23K256_RAM_read_byte(addr, &data);
 425  00a3 96            	ldw	x,sp
 426  00a4 1c0003        	addw	x,#OFST-2
 427  00a7 89            	pushw	x
 428  00a8 1e06          	ldw	x,(OFST+1,sp)
 429  00aa cd04cb        	call	_MCP_23K256_RAM_read_byte
 431  00ad a6fa          	ld	a,#250
 432  00af 85            	popw	x
 433                     ; 310     if (wdata != data)
 435                     ; 315 wdata = 250;
 437  00b0 6b02          	ld	(OFST-3,sp),a
 439                     ; 316 addr =1;
 441  00b2 ae0001        	ldw	x,#1
 442  00b5 1f04          	ldw	(OFST-1,sp),x
 444                     ; 318     MCP_23K256_RAM_write_byte(addr, wdata);
 446  00b7 4bfa          	push	#250
 447  00b9 cd046e        	call	_MCP_23K256_RAM_write_byte
 449  00bc 84            	pop	a
 450                     ; 321     MCP_23K256_RAM_read_byte(addr, &data);
 452  00bd 96            	ldw	x,sp
 453  00be 1c0003        	addw	x,#OFST-2
 454  00c1 89            	pushw	x
 455  00c2 1e06          	ldw	x,(OFST+1,sp)
 456  00c4 cd04cb        	call	_MCP_23K256_RAM_read_byte
 458  00c7 a604          	ld	a,#4
 459  00c9 85            	popw	x
 460                     ; 323     if (wdata != data)
 462                     ; 328 wdata = 4;
 464  00ca 6b02          	ld	(OFST-3,sp),a
 466                     ; 329 addr =2;
 468  00cc ae0002        	ldw	x,#2
 469  00cf 1f04          	ldw	(OFST-1,sp),x
 471                     ; 331     MCP_23K256_RAM_write_byte(addr, wdata);
 473  00d1 4b04          	push	#4
 474  00d3 cd046e        	call	_MCP_23K256_RAM_write_byte
 476  00d6 84            	pop	a
 477                     ; 334     MCP_23K256_RAM_read_byte(addr, &data);
 479  00d7 96            	ldw	x,sp
 480  00d8 1c0003        	addw	x,#OFST-2
 481  00db 89            	pushw	x
 482  00dc 1e06          	ldw	x,(OFST+1,sp)
 483  00de cd04cb        	call	_MCP_23K256_RAM_read_byte
 485  00e1 85            	popw	x
 486                     ; 336     if (wdata != data)
 488                     ; 342     for(addr = 0; addr<3; addr++)
 490  00e2 5f            	clrw	x
 491  00e3 1f04          	ldw	(OFST-1,sp),x
 493  00e5               L141:
 494                     ; 344         MCP_23K256_RAM_read_byte(addr, &data);
 496  00e5 96            	ldw	x,sp
 497  00e6 1c0003        	addw	x,#OFST-2
 498  00e9 89            	pushw	x
 499  00ea 1e06          	ldw	x,(OFST+1,sp)
 500  00ec cd04cb        	call	_MCP_23K256_RAM_read_byte
 502  00ef 85            	popw	x
 503                     ; 342     for(addr = 0; addr<3; addr++)
 505  00f0 1e04          	ldw	x,(OFST-1,sp)
 506  00f2 5c            	incw	x
 507  00f3 1f04          	ldw	(OFST-1,sp),x
 511  00f5 a30003        	cpw	x,#3
 512  00f8 25eb          	jrult	L141
 513                     ; 346     return 0;
 515  00fa 4f            	clr	a
 518  00fb 5b05          	addw	sp,#5
 519  00fd 81            	ret	
 576                     ; 353 uint8_t TEST_rampfunc_in_ram_to_dac(void)
 576                     ; 354 {
 577                     	switch	.text
 578  00fe               _TEST_rampfunc_in_ram_to_dac:
 580  00fe 5204          	subw	sp,#4
 581       00000004      OFST:	set	4
 584                     ; 355     uint8_t data = 0;
 586  0100 0f02          	clr	(OFST-2,sp)
 588                     ; 356     uint8_t wdata = 0;
 590  0102 0f01          	clr	(OFST-3,sp)
 592                     ; 357     uint16_t addr = 0;
 594                     ; 360     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 596  0104 5f            	clrw	x
 597  0105 1f03          	ldw	(OFST-1,sp),x
 599  0107 7b01          	ld	a,(OFST-3,sp)
 600  0109               L571:
 601                     ; 362         MCP_23K256_RAM_write_byte(addr, wdata);
 603  0109 88            	push	a
 604  010a 1e04          	ldw	x,(OFST+0,sp)
 605  010c cd046e        	call	_MCP_23K256_RAM_write_byte
 607  010f 84            	pop	a
 608                     ; 360     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 610  0110 1e03          	ldw	x,(OFST-1,sp)
 611  0112 5c            	incw	x
 612  0113 1f03          	ldw	(OFST-1,sp),x
 614  0115 7b01          	ld	a,(OFST-3,sp)
 615  0117 ab04          	add	a,#4
 616  0119 6b01          	ld	(OFST-3,sp),a
 620  011b a300ff        	cpw	x,#255
 621  011e 25e9          	jrult	L571
 622  0120               L302:
 623                     ; 368         for(addr = 0; addr<255; addr++)
 625  0120 5f            	clrw	x
 626  0121 1f03          	ldw	(OFST-1,sp),x
 628  0123               L702:
 629                     ; 370             MCP_23K256_RAM_read_byte(addr, &data);
 631  0123 96            	ldw	x,sp
 632  0124 1c0002        	addw	x,#OFST-2
 633  0127 89            	pushw	x
 634  0128 1e05          	ldw	x,(OFST+1,sp)
 635  012a cd04cb        	call	_MCP_23K256_RAM_read_byte
 637  012d 85            	popw	x
 638                     ; 371             MCP4901_DAC_write(data);
 640  012e 7b02          	ld	a,(OFST-2,sp)
 641  0130 cd054d        	call	_MCP4901_DAC_write
 643                     ; 372             delay_us(90);   //11kHz sample rate // phasor == frequ
 645  0133 ae005a        	ldw	x,#90
 646  0136 cd059e        	call	_delay_us
 648                     ; 368         for(addr = 0; addr<255; addr++)
 650  0139 1e03          	ldw	x,(OFST-1,sp)
 651  013b 5c            	incw	x
 652  013c 1f03          	ldw	(OFST-1,sp),x
 656  013e a300ff        	cpw	x,#255
 657  0141 25e0          	jrult	L702
 659  0143 20db          	jra	L302
 694                     ; 380 void TEST_adc_to_dac(uint8_t *x)
 694                     ; 381 {
 695                     	switch	.text
 696  0145               _TEST_adc_to_dac:
 700                     ; 405 }
 703  0145 81            	ret	
 764                     ; 408 void TEST_adc_to_ram_to_dac(void)
 764                     ; 409 {
 765                     	switch	.text
 766  0146               _TEST_adc_to_ram_to_dac:
 768  0146 5205          	subw	sp,#5
 769       00000005      OFST:	set	5
 772                     ; 410     uint16_t adc_val = 0;
 774                     ; 411     uint16_t addr = 0;
 776  0148 5f            	clrw	x
 777  0149 1f03          	ldw	(OFST-2,sp),x
 779                     ; 412     uint8_t mapd_value = 0;
 781  014b 0f05          	clr	(OFST+0,sp)
 783  014d               L162:
 784                     ; 417         ADC1_StartConversion();
 786  014d cd0000        	call	_ADC1_StartConversion
 789  0150               L762:
 790                     ; 418         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 792  0150 a680          	ld	a,#128
 793  0152 cd0000        	call	_ADC1_GetFlagStatus
 795  0155 4d            	tnz	a
 796  0156 27f8          	jreq	L762
 797                     ; 420         adc_val = ADC1_GetConversionValue(); // for led knob
 799  0158 cd0000        	call	_ADC1_GetConversionValue
 801  015b 1f01          	ldw	(OFST-4,sp),x
 803                     ; 421         ADC1_ClearFlag(ADC1_FLAG_EOC);
 805  015d a680          	ld	a,#128
 806  015f cd0000        	call	_ADC1_ClearFlag
 808                     ; 428         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 810  0162 1e01          	ldw	x,(OFST-4,sp)
 811  0164 cd0000        	call	c_uitof
 813  0167 ae0004        	ldw	x,#L772
 814  016a cd0000        	call	c_fmul
 816  016d cd0000        	call	c_ftol
 818  0170 b603          	ld	a,c_lreg+3
 819  0172 6b05          	ld	(OFST+0,sp),a
 821                     ; 431         MCP_23K256_RAM_write_byte(addr, mapd_value);
 823  0174 88            	push	a
 824  0175 1e04          	ldw	x,(OFST-1,sp)
 825  0177 cd046e        	call	_MCP_23K256_RAM_write_byte
 827  017a 84            	pop	a
 828                     ; 434         mapd_value = 0; // check value
 830  017b 0f05          	clr	(OFST+0,sp)
 832                     ; 435         MCP_23K256_RAM_read_byte(addr, &mapd_value);
 834  017d 96            	ldw	x,sp
 835  017e 1c0005        	addw	x,#OFST+0
 836  0181 89            	pushw	x
 837  0182 1e05          	ldw	x,(OFST+0,sp)
 838  0184 cd04cb        	call	_MCP_23K256_RAM_read_byte
 840  0187 85            	popw	x
 841                     ; 438         addr++;
 843  0188 1e03          	ldw	x,(OFST-2,sp)
 844  018a 5c            	incw	x
 845  018b 1f03          	ldw	(OFST-2,sp),x
 847                     ; 440         MCP4901_DAC_write(mapd_value);
 849  018d 7b05          	ld	a,(OFST+0,sp)
 850  018f cd054d        	call	_MCP4901_DAC_write
 852                     ; 443         delay_us(90);
 854  0192 ae005a        	ldw	x,#90
 855  0195 cd059e        	call	_delay_us
 858  0198 20b3          	jra	L162
 955                     ; 450 void TEST_adc_to_ram_to_dac_with_delay(void)
 955                     ; 451 {
 956                     	switch	.text
 957  019a               _TEST_adc_to_ram_to_dac_with_delay:
 959  019a 520b          	subw	sp,#11
 960       0000000b      OFST:	set	11
 963                     ; 452     uint16_t adc_val = 0;
 965                     ; 453     uint8_t mapd_value = 0; // mapped adc valu
 967                     ; 454     uint8_t read_val = 0;   //read val from ram
 969  019c 0f05          	clr	(OFST-6,sp)
 971                     ; 455     uint16_t write_addr = 0;    //write addr in ram
 973  019e 5f            	clrw	x
 974  019f 1f0a          	ldw	(OFST-1,sp),x
 976                     ; 456     uint16_t read_addr = 0; // read addr in val
 978  01a1 1f06          	ldw	(OFST-5,sp),x
 980                     ; 457     uint16_t delay = 110; // length of delay in samples
 982  01a3 ae006e        	ldw	x,#110
 983  01a6 1f08          	ldw	(OFST-3,sp),x
 985                     ; 458     uint8_t res = 0;
 987  01a8               L153:
 988                     ; 464         ADC1_StartConversion();
 990  01a8 cd0000        	call	_ADC1_StartConversion
 993  01ab               L753:
 994                     ; 465         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 996  01ab a680          	ld	a,#128
 997  01ad cd0000        	call	_ADC1_GetFlagStatus
 999  01b0 4d            	tnz	a
1000  01b1 27f8          	jreq	L753
1001                     ; 467         adc_val = ADC1_GetConversionValue(); // for led knob
1003  01b3 cd0000        	call	_ADC1_GetConversionValue
1005  01b6 1f02          	ldw	(OFST-9,sp),x
1007                     ; 468         ADC1_ClearFlag(ADC1_FLAG_EOC);
1009  01b8 a680          	ld	a,#128
1010  01ba cd0000        	call	_ADC1_ClearFlag
1012                     ; 475         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
1014  01bd 1e02          	ldw	x,(OFST-9,sp)
1015  01bf cd0000        	call	c_uitof
1017  01c2 ae0004        	ldw	x,#L772
1018  01c5 cd0000        	call	c_fmul
1020  01c8 cd0000        	call	c_ftol
1022  01cb b603          	ld	a,c_lreg+3
1023  01cd 6b04          	ld	(OFST-7,sp),a
1025                     ; 486             read_addr = write_addr - delay;
1027  01cf 1e0a          	ldw	x,(OFST-1,sp)
1028  01d1 72f008        	subw	x,(OFST-3,sp)
1029  01d4 1f06          	ldw	(OFST-5,sp),x
1031                     ; 490         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1033  01d6 88            	push	a
1034  01d7 1e0b          	ldw	x,(OFST+0,sp)
1035  01d9 cd046e        	call	_MCP_23K256_RAM_write_byte
1037  01dc 84            	pop	a
1038                     ; 493         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1040  01dd 96            	ldw	x,sp
1041  01de 1c0005        	addw	x,#OFST-6
1042  01e1 89            	pushw	x
1043  01e2 1e08          	ldw	x,(OFST-3,sp)
1044  01e4 cd04cb        	call	_MCP_23K256_RAM_read_byte
1046  01e7 85            	popw	x
1047                     ; 496         MCP4901_DAC_write(read_val);
1049  01e8 7b05          	ld	a,(OFST-6,sp)
1050  01ea cd054d        	call	_MCP4901_DAC_write
1052                     ; 499         write_addr++;
1054  01ed 1e0a          	ldw	x,(OFST-1,sp)
1055  01ef 5c            	incw	x
1056  01f0 1f0a          	ldw	(OFST-1,sp),x
1058                     ; 502         delay_us(90);
1060  01f2 ae005a        	ldw	x,#90
1061  01f5 cd059e        	call	_delay_us
1064  01f8 20ae          	jra	L153
1172                     ; 510 void TEST_adc_to_ram_to_dac_with_with_fback(void)
1172                     ; 511 {
1173                     	switch	.text
1174  01fa               _TEST_adc_to_ram_to_dac_with_with_fback:
1176  01fa 520d          	subw	sp,#13
1177       0000000d      OFST:	set	13
1180                     ; 513     uint16_t adc0_val = 0;  //er are these 8 or 16 big?
1182                     ; 514     uint16_t adc1_val = 0;
1184                     ; 515     uint8_t mapd_value = 0; // mapped adc valu
1186                     ; 516     uint8_t read_val = 0;   //read val from ram
1188  01fc 0f06          	clr	(OFST-7,sp)
1190                     ; 517     uint16_t write_addr = 0;    //write addr in ram
1192  01fe 5f            	clrw	x
1193  01ff 1f0a          	ldw	(OFST-3,sp),x
1195                     ; 518     uint16_t read_addr = 0; // read addr in val
1197  0201 1f07          	ldw	(OFST-6,sp),x
1199                     ; 519     uint16_t delay = 110; // length of delay in samples
1201                     ; 520     uint8_t res = 0;
1203  0203               L534:
1204                     ; 535     ADC1_ScanModeCmd(ENABLE);
1206  0203 a601          	ld	a,#1
1207  0205 cd0000        	call	_ADC1_ScanModeCmd
1209                     ; 536     ADC1_StartConversion();
1211  0208 cd0000        	call	_ADC1_StartConversion
1214  020b               L344:
1215                     ; 537     while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1217  020b a680          	ld	a,#128
1218  020d cd0000        	call	_ADC1_GetFlagStatus
1220  0210 4d            	tnz	a
1221  0211 27f8          	jreq	L344
1222                     ; 539     adc0_val = ADC1_GetBufferValue(0);
1224  0213 4f            	clr	a
1225  0214 cd0000        	call	_ADC1_GetBufferValue
1227  0217 1f04          	ldw	(OFST-9,sp),x
1229                     ; 540     adc1_val = ADC1_GetBufferValue(1);
1231  0219 a601          	ld	a,#1
1232  021b cd0000        	call	_ADC1_GetBufferValue
1234  021e 1f0c          	ldw	(OFST-1,sp),x
1236                     ; 541     ADC1_ClearFlag(ADC1_FLAG_EOC);
1238  0220 a680          	ld	a,#128
1239  0222 cd0000        	call	_ADC1_ClearFlag
1241                     ; 544     delay = (adc1_val>>2);
1243  0225 1e0c          	ldw	x,(OFST-1,sp)
1244  0227 54            	srlw	x
1245  0228 54            	srlw	x
1246  0229 1f0c          	ldw	(OFST-1,sp),x
1248                     ; 554         mapd_value = (adc0_val>>2) ; // do i need the float or not ??? -No use a lft shift
1250  022b 1e04          	ldw	x,(OFST-9,sp)
1251  022d 54            	srlw	x
1252  022e 54            	srlw	x
1253  022f 01            	rrwa	x,a
1254  0230 6b09          	ld	(OFST-4,sp),a
1256                     ; 559         mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
1258  0232 5f            	clrw	x
1259  0233 7b06          	ld	a,(OFST-7,sp)
1260  0235 97            	ld	xl,a
1261  0236 57            	sraw	x
1262  0237 1f01          	ldw	(OFST-12,sp),x
1264  0239 5f            	clrw	x
1265  023a 7b09          	ld	a,(OFST-4,sp)
1266  023c 97            	ld	xl,a
1267  023d 57            	sraw	x
1268  023e 72fb01        	addw	x,(OFST-12,sp)
1269  0241 01            	rrwa	x,a
1270  0242 6b09          	ld	(OFST-4,sp),a
1272                     ; 570             read_addr = write_addr - delay;
1274  0244 1e0a          	ldw	x,(OFST-3,sp)
1275  0246 72f00c        	subw	x,(OFST-1,sp)
1276  0249 1f07          	ldw	(OFST-6,sp),x
1278                     ; 574         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1280  024b 88            	push	a
1281  024c 1e0b          	ldw	x,(OFST-2,sp)
1282  024e cd046e        	call	_MCP_23K256_RAM_write_byte
1284  0251 84            	pop	a
1285                     ; 577         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1287  0252 96            	ldw	x,sp
1288  0253 1c0006        	addw	x,#OFST-7
1289  0256 89            	pushw	x
1290  0257 1e09          	ldw	x,(OFST-4,sp)
1291  0259 cd04cb        	call	_MCP_23K256_RAM_read_byte
1293  025c 85            	popw	x
1294                     ; 580         MCP4901_DAC_write(read_val);
1296  025d 7b06          	ld	a,(OFST-7,sp)
1297  025f cd054d        	call	_MCP4901_DAC_write
1299                     ; 583         write_addr++;
1301  0262 1e0a          	ldw	x,(OFST-3,sp)
1302  0264 5c            	incw	x
1303  0265 1f0a          	ldw	(OFST-3,sp),x
1305                     ; 586         delay_us(90);
1307  0267 ae005a        	ldw	x,#90
1308  026a cd059e        	call	_delay_us
1311  026d 2094          	jra	L534
1344                     ; 592 void clock_setup(void)
1344                     ; 593 {
1345                     	switch	.text
1346  026f               _clock_setup:
1350                     ; 594   CLK_DeInit();
1352  026f cd0000        	call	_CLK_DeInit
1354                     ; 596   CLK_HSECmd(DISABLE);
1356  0272 4f            	clr	a
1357  0273 cd0000        	call	_CLK_HSECmd
1359                     ; 597   CLK_LSICmd(DISABLE);
1361  0276 4f            	clr	a
1362  0277 cd0000        	call	_CLK_LSICmd
1364                     ; 598   CLK_HSICmd(ENABLE);
1366  027a a601          	ld	a,#1
1367  027c cd0000        	call	_CLK_HSICmd
1370  027f               L164:
1371                     ; 599   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
1373  027f ae0102        	ldw	x,#258
1374  0282 cd0000        	call	_CLK_GetFlagStatus
1376  0285 4d            	tnz	a
1377  0286 27f7          	jreq	L164
1378                     ; 601   CLK_ClockSwitchCmd(ENABLE);
1380  0288 a601          	ld	a,#1
1381  028a cd0000        	call	_CLK_ClockSwitchCmd
1383                     ; 602   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1385  028d 4f            	clr	a
1386  028e cd0000        	call	_CLK_HSIPrescalerConfig
1388                     ; 603   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
1390  0291 a680          	ld	a,#128
1391  0293 cd0000        	call	_CLK_SYSCLKConfig
1393                     ; 605   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
1395  0296 4b01          	push	#1
1396  0298 4b00          	push	#0
1397  029a ae01e1        	ldw	x,#481
1398  029d cd0000        	call	_CLK_ClockSwitchConfig
1400  02a0 85            	popw	x
1401                     ; 607   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
1403  02a1 5f            	clrw	x
1404  02a2 cd0000        	call	_CLK_PeripheralClockConfig
1406                     ; 608   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
1408  02a5 ae0101        	ldw	x,#257
1409  02a8 cd0000        	call	_CLK_PeripheralClockConfig
1411                     ; 609   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
1413  02ab ae0300        	ldw	x,#768
1414  02ae cd0000        	call	_CLK_PeripheralClockConfig
1416                     ; 610   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
1418  02b1 ae1200        	ldw	x,#4608
1419  02b4 cd0000        	call	_CLK_PeripheralClockConfig
1421                     ; 611   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
1423  02b7 ae1301        	ldw	x,#4865
1424  02ba cd0000        	call	_CLK_PeripheralClockConfig
1426                     ; 612   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
1428  02bd ae0700        	ldw	x,#1792
1429  02c0 cd0000        	call	_CLK_PeripheralClockConfig
1431                     ; 613   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
1433  02c3 ae0501        	ldw	x,#1281
1434  02c6 cd0000        	call	_CLK_PeripheralClockConfig
1436                     ; 614   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
1438  02c9 ae0400        	ldw	x,#1024
1440                     ; 616 }
1443  02cc cc0000        	jp	_CLK_PeripheralClockConfig
1468                     ; 618 void GPIO_setup(void)
1468                     ; 619 {
1469                     	switch	.text
1470  02cf               _GPIO_setup:
1474                     ; 620   GPIO_DeInit(GPIOC);
1476  02cf ae500a        	ldw	x,#20490
1477  02d2 cd0000        	call	_GPIO_DeInit
1479                     ; 625     GPIO_DeInit(ADC_port);
1481  02d5 ae5005        	ldw	x,#20485
1482  02d8 cd0000        	call	_GPIO_DeInit
1484                     ; 631     GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
1486  02db 4b00          	push	#0
1487  02dd 4b0f          	push	#15
1488  02df ae5005        	ldw	x,#20485
1489  02e2 cd0000        	call	_GPIO_Init
1491  02e5 85            	popw	x
1492                     ; 636     GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ),
1492                     ; 637                GPIO_MODE_OUT_PP_HIGH_FAST);
1494  02e6 4bf0          	push	#240
1495  02e8 4b60          	push	#96
1496  02ea ae500a        	ldw	x,#20490
1497  02ed cd0000        	call	_GPIO_Init
1499  02f0 85            	popw	x
1500                     ; 638 }
1503  02f1 81            	ret	
1531                     ; 659 void ADC1_setup(void)
1531                     ; 660 {
1532                     	switch	.text
1533  02f2               _ADC1_setup:
1537                     ; 661   ADC1_DeInit();
1539  02f2 cd0000        	call	_ADC1_DeInit
1541                     ; 663   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1541                     ; 664   ADC1_CHANNEL_0,\
1541                     ; 665   ADC1_PRESSEL_FCPU_D18, \
1541                     ; 666   ADC1_EXTTRIG_GPIO, \
1541                     ; 667   DISABLE, \
1541                     ; 668   ADC1_ALIGN_RIGHT, \
1541                     ; 669   ADC1_SCHMITTTRIG_CHANNEL0, \
1541                     ; 670   DISABLE);
1543  02f5 4b00          	push	#0
1544  02f7 4b00          	push	#0
1545  02f9 4b08          	push	#8
1546  02fb 4b00          	push	#0
1547  02fd 4b10          	push	#16
1548  02ff 4b70          	push	#112
1549  0301 ae0100        	ldw	x,#256
1550  0304 cd0000        	call	_ADC1_Init
1552  0307 5b06          	addw	sp,#6
1553                     ; 672   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1553                     ; 673   ADC1_CHANNEL_1,\
1553                     ; 674   ADC1_PRESSEL_FCPU_D18, \
1553                     ; 675   ADC1_EXTTRIG_GPIO, \
1553                     ; 676   DISABLE, \
1553                     ; 677   ADC1_ALIGN_RIGHT, \
1553                     ; 678   ADC1_SCHMITTTRIG_CHANNEL1, \
1553                     ; 679   DISABLE);
1555  0309 4b00          	push	#0
1556  030b 4b01          	push	#1
1557  030d 4b08          	push	#8
1558  030f 4b00          	push	#0
1559  0311 4b10          	push	#16
1560  0313 4b70          	push	#112
1561  0315 ae0101        	ldw	x,#257
1562  0318 cd0000        	call	_ADC1_Init
1564  031b 5b06          	addw	sp,#6
1565                     ; 681   ADC1_ConversionConfig(ADC1_CONVERSIONMODE_CONTINUOUS, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);
1567  031d 4b08          	push	#8
1568  031f ae0101        	ldw	x,#257
1569  0322 cd0000        	call	_ADC1_ConversionConfig
1571  0325 84            	pop	a
1572                     ; 683   ADC1_DataBufferCmd(ENABLE);
1574  0326 a601          	ld	a,#1
1575  0328 cd0000        	call	_ADC1_DataBufferCmd
1577                     ; 684   ADC1_Cmd(ENABLE);
1579  032b a601          	ld	a,#1
1581                     ; 686 }
1584  032d cc0000        	jp	_ADC1_Cmd
1607                     ; 691 void TIM2_setup(void)
1607                     ; 692 {
1608                     	switch	.text
1609  0330               _TIM2_setup:
1613                     ; 704 }
1616  0330 81            	ret	
1655                     ; 708 void delay_us_new(unsigned int us)
1655                     ; 709 {
1656                     	switch	.text
1657  0331               _delay_us_new:
1659  0331 89            	pushw	x
1660       00000000      OFST:	set	0
1663                     ; 710     TIM4_DeInit();
1665  0332 cd0000        	call	_TIM4_DeInit
1667                     ; 712     if((us <= 200) && (us >= 0))
1669  0335 1e01          	ldw	x,(OFST+1,sp)
1670  0337 a300c9        	cpw	x,#201
1671  033a 2405          	jruge	L335
1672                     ; 714         TIM4_TimeBaseInit(TIM4_PRESCALER_16, 200);
1674  033c ae04c8        	ldw	x,#1224
1676                     ; 715         TIM4_Cmd(ENABLE);
1679  033f 2041          	jp	LC001
1680  0341               L335:
1681                     ; 717     else if((us <= 400) && (us > 200))
1683  0341 a30191        	cpw	x,#401
1684  0344 240e          	jruge	L735
1686  0346 a300c9        	cpw	x,#201
1687  0349 2509          	jrult	L735
1688                     ; 719         us >>= 1;
1690  034b 0401          	srl	(OFST+1,sp)
1691                     ; 720         TIM4_TimeBaseInit(TIM4_PRESCALER_32, 200);
1693  034d ae05c8        	ldw	x,#1480
1694  0350 0602          	rrc	(OFST+2,sp)
1696                     ; 721         TIM4_Cmd(ENABLE);
1699  0352 202e          	jp	LC001
1700  0354               L735:
1701                     ; 723     else if((us <= 800) && (us > 400))
1703  0354 a30321        	cpw	x,#801
1704  0357 2413          	jruge	L345
1706  0359 a30191        	cpw	x,#401
1707  035c 250e          	jrult	L345
1708                     ; 725         us >>= 2;
1710  035e a602          	ld	a,#2
1711  0360               L213:
1712  0360 0401          	srl	(OFST+1,sp)
1713  0362 0602          	rrc	(OFST+2,sp)
1714  0364 4a            	dec	a
1715  0365 26f9          	jrne	L213
1716                     ; 726         TIM4_TimeBaseInit(TIM4_PRESCALER_64, 200);
1718  0367 ae06c8        	ldw	x,#1736
1720                     ; 727         TIM4_Cmd(ENABLE);
1723  036a 2016          	jp	LC001
1724  036c               L345:
1725                     ; 729     else if((us <= 1600) && (us > 800))
1727  036c a30641        	cpw	x,#1601
1728  036f 2419          	jruge	L355
1730  0371 a30321        	cpw	x,#801
1731  0374 2514          	jrult	L355
1732                     ; 731         us >>= 3;
1734  0376 a603          	ld	a,#3
1735  0378               L023:
1736  0378 0401          	srl	(OFST+1,sp)
1737  037a 0602          	rrc	(OFST+2,sp)
1738  037c 4a            	dec	a
1739  037d 26f9          	jrne	L023
1740                     ; 732         TIM4_TimeBaseInit(TIM4_PRESCALER_128, 200);
1742  037f ae07c8        	ldw	x,#1992
1744                     ; 733         TIM4_Cmd(ENABLE);
1746  0382               LC001:
1747  0382 cd0000        	call	_TIM4_TimeBaseInit
1751  0385 a601          	ld	a,#1
1752  0387 cd0000        	call	_TIM4_Cmd
1754  038a               L355:
1755                     ; 736     while(TIM4_GetCounter() < us);
1757  038a cd0000        	call	_TIM4_GetCounter
1759  038d 5f            	clrw	x
1760  038e 97            	ld	xl,a
1761  038f 1301          	cpw	x,(OFST+1,sp)
1762  0391 25f7          	jrult	L355
1763                     ; 737     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
1765  0393 a601          	ld	a,#1
1766  0395 cd0000        	call	_TIM4_ClearFlag
1768                     ; 738     TIM4_Cmd(DISABLE);
1770  0398 4f            	clr	a
1771  0399 cd0000        	call	_TIM4_Cmd
1773                     ; 739 }
1776  039c 85            	popw	x
1777  039d 81            	ret	
1812                     ; 743 void delay_ms_new(unsigned int ms)
1812                     ; 744 {
1813                     	switch	.text
1814  039e               _delay_ms_new:
1816  039e 89            	pushw	x
1817       00000000      OFST:	set	0
1820  039f 2006          	jra	L775
1821  03a1               L575:
1822                     ; 747         delay_us(1000);
1824  03a1 ae03e8        	ldw	x,#1000
1825  03a4 cd059e        	call	_delay_us
1827  03a7               L775:
1828                     ; 745     while(ms--)
1830  03a7 1e01          	ldw	x,(OFST+1,sp)
1831  03a9 5a            	decw	x
1832  03aa 1f01          	ldw	(OFST+1,sp),x
1833  03ac 5c            	incw	x
1834  03ad 26f2          	jrne	L575
1835                     ; 749 }
1839  03af 85            	popw	x
1840  03b0 81            	ret	
1866                     ; 752 void SPI_setup(void)
1866                     ; 753 {
1867                     	switch	.text
1868  03b1               _SPI_setup:
1872                     ; 754   SPI_DeInit();
1874  03b1 cd0000        	call	_SPI_DeInit
1876                     ; 759   SPI_Init(SPI_FIRSTBIT_MSB, \
1876                     ; 760     SPI_BAUDRATEPRESCALER_16, \
1876                     ; 761     SPI_MODE_MASTER, \
1876                     ; 762     SPI_CLOCKPOLARITY_LOW, \
1876                     ; 763     SPI_CLOCKPHASE_1EDGE, \
1876                     ; 764     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
1876                     ; 765     SPI_NSS_SOFT, \
1876                     ; 766     0x0);
1878  03b4 4b00          	push	#0
1879  03b6 4b02          	push	#2
1880  03b8 4b00          	push	#0
1881  03ba 4b00          	push	#0
1882  03bc 4b00          	push	#0
1883  03be 4b04          	push	#4
1884  03c0 ae0018        	ldw	x,#24
1885  03c3 cd0000        	call	_SPI_Init
1887  03c6 5b06          	addw	sp,#6
1888                     ; 768   SPI_Cmd(ENABLE);
1890  03c8 a601          	ld	a,#1
1892                     ; 769 }
1895  03ca cc0000        	jp	_SPI_Cmd
1920                     ; 771 void MCP_23K256_init()
1920                     ; 772 {
1921                     	switch	.text
1922  03cd               _MCP_23K256_init:
1926                     ; 773     GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
1928  03cd 4bf0          	push	#240
1929  03cf 4b02          	push	#2
1930  03d1 ae5000        	ldw	x,#20480
1931  03d4 cd0000        	call	_GPIO_Init
1933  03d7 85            	popw	x
1934                     ; 774   delay_ms(10);
1936  03d8 ae000a        	ldw	x,#10
1938                     ; 775 }
1941  03db cc05b5        	jp	_delay_ms
1983                     ; 780 void MCP_23K256_read_status_register(uint8_t *data)
1983                     ; 781 {
1984                     	switch	.text
1985  03de               _MCP_23K256_read_status_register:
1987  03de 89            	pushw	x
1988       00000000      OFST:	set	0
1991  03df               L346:
1992                     ; 783   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1994  03df a680          	ld	a,#128
1995  03e1 cd0000        	call	_SPI_GetFlagStatus
1997  03e4 4d            	tnz	a
1998  03e5 26f8          	jrne	L346
1999                     ; 785   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2001  03e7 4b02          	push	#2
2002  03e9 ae5000        	ldw	x,#20480
2003  03ec cd0000        	call	_GPIO_WriteLow
2005  03ef 84            	pop	a
2006                     ; 787   SPI_SendData(RDSR); // read ststus reg
2008  03f0 a605          	ld	a,#5
2009  03f2 cd0000        	call	_SPI_SendData
2012  03f5               L156:
2013                     ; 789   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2015  03f5 a602          	ld	a,#2
2016  03f7 cd0000        	call	_SPI_GetFlagStatus
2018  03fa 4d            	tnz	a
2019  03fb 27f8          	jreq	L156
2021  03fd               L756:
2022                     ; 792 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2024  03fd a601          	ld	a,#1
2025  03ff cd0000        	call	_SPI_GetFlagStatus
2027  0402 4d            	tnz	a
2028  0403 27f8          	jreq	L756
2029                     ; 793 SPI_SendData( 255 );
2031  0405 a6ff          	ld	a,#255
2032  0407 cd0000        	call	_SPI_SendData
2035  040a               L566:
2036                     ; 794 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2038  040a a602          	ld	a,#2
2039  040c cd0000        	call	_SPI_GetFlagStatus
2041  040f 4d            	tnz	a
2042  0410 27f8          	jreq	L566
2043                     ; 796   *data = SPI_ReceiveData();
2045  0412 cd0000        	call	_SPI_ReceiveData
2047  0415 1e01          	ldw	x,(OFST+1,sp)
2048  0417 f7            	ld	(x),a
2050  0418               L576:
2051                     ; 798   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
2053  0418 a601          	ld	a,#1
2054  041a cd0000        	call	_SPI_GetFlagStatus
2056  041d 4d            	tnz	a
2057  041e 27f8          	jreq	L576
2058                     ; 802     delay_us(1);
2060  0420 ae0001        	ldw	x,#1
2061  0423 cd059e        	call	_delay_us
2063                     ; 804   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2065  0426 4b02          	push	#2
2066  0428 ae5000        	ldw	x,#20480
2067  042b cd0000        	call	_GPIO_WriteHigh
2069                     ; 805 }
2072  042e 5b03          	addw	sp,#3
2073  0430 81            	ret	
2113                     ; 814 void MCP_23K256_write_status_register(uint8_t data)
2113                     ; 815 {
2114                     	switch	.text
2115  0431               _MCP_23K256_write_status_register:
2117  0431 88            	push	a
2118       00000000      OFST:	set	0
2121  0432               L127:
2122                     ; 817   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2124  0432 a680          	ld	a,#128
2125  0434 cd0000        	call	_SPI_GetFlagStatus
2127  0437 4d            	tnz	a
2128  0438 26f8          	jrne	L127
2129                     ; 819   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2131  043a 4b02          	push	#2
2132  043c ae5000        	ldw	x,#20480
2133  043f cd0000        	call	_GPIO_WriteLow
2135  0442 84            	pop	a
2136                     ; 822   SPI_SendData(WRSR);
2138  0443 a601          	ld	a,#1
2139  0445 cd0000        	call	_SPI_SendData
2142  0448               L727:
2143                     ; 823   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2145  0448 a602          	ld	a,#2
2146  044a cd0000        	call	_SPI_GetFlagStatus
2148  044d 4d            	tnz	a
2149  044e 27f8          	jreq	L727
2150                     ; 826   SPI_SendData(data);
2152  0450 7b01          	ld	a,(OFST+1,sp)
2153  0452 cd0000        	call	_SPI_SendData
2156  0455               L537:
2157                     ; 827   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2159  0455 a602          	ld	a,#2
2160  0457 cd0000        	call	_SPI_GetFlagStatus
2162  045a 4d            	tnz	a
2163  045b 27f8          	jreq	L537
2164                     ; 831     delay_us(1);
2166  045d ae0001        	ldw	x,#1
2167  0460 cd059e        	call	_delay_us
2169                     ; 833   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2171  0463 4b02          	push	#2
2172  0465 ae5000        	ldw	x,#20480
2173  0468 cd0000        	call	_GPIO_WriteHigh
2175                     ; 835 }
2178  046b 5b02          	addw	sp,#2
2179  046d 81            	ret	
2237                     ; 844 void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
2237                     ; 845 {
2238                     	switch	.text
2239  046e               _MCP_23K256_RAM_write_byte:
2241  046e 89            	pushw	x
2242  046f 88            	push	a
2243       00000001      OFST:	set	1
2246                     ; 846     uint8_t addr = 0;
2249  0470               L177:
2250                     ; 848   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2252  0470 a680          	ld	a,#128
2253  0472 cd0000        	call	_SPI_GetFlagStatus
2255  0475 4d            	tnz	a
2256  0476 26f8          	jrne	L177
2257                     ; 850   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2259  0478 4b02          	push	#2
2260  047a ae5000        	ldw	x,#20480
2261  047d cd0000        	call	_GPIO_WriteLow
2263  0480 84            	pop	a
2264                     ; 853   SPI_SendData(WRITE); // instruction 2 write
2266  0481 a602          	ld	a,#2
2267  0483 cd0000        	call	_SPI_SendData
2270  0486               L777:
2271                     ; 854   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2273  0486 a602          	ld	a,#2
2274  0488 cd0000        	call	_SPI_GetFlagStatus
2276  048b 4d            	tnz	a
2277  048c 27f8          	jreq	L777
2278                     ; 857     addr = address>>8;
2280  048e 7b02          	ld	a,(OFST+1,sp)
2281  0490 6b01          	ld	(OFST+0,sp),a
2283                     ; 858   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2285  0492 cd0000        	call	_SPI_SendData
2288  0495               L5001:
2289                     ; 859   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2291  0495 a602          	ld	a,#2
2292  0497 cd0000        	call	_SPI_GetFlagStatus
2294  049a 4d            	tnz	a
2295  049b 27f8          	jreq	L5001
2296                     ; 862     addr = (address&255);
2298  049d 7b03          	ld	a,(OFST+2,sp)
2299  049f 6b01          	ld	(OFST+0,sp),a
2301                     ; 863   SPI_SendData( addr );
2303  04a1 cd0000        	call	_SPI_SendData
2306  04a4               L3101:
2307                     ; 864   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2309  04a4 a602          	ld	a,#2
2310  04a6 cd0000        	call	_SPI_GetFlagStatus
2312  04a9 4d            	tnz	a
2313  04aa 27f8          	jreq	L3101
2314                     ; 866   SPI_SendData(value);
2316  04ac 7b06          	ld	a,(OFST+5,sp)
2317  04ae cd0000        	call	_SPI_SendData
2320  04b1               L1201:
2321                     ; 868   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2323  04b1 a602          	ld	a,#2
2324  04b3 cd0000        	call	_SPI_GetFlagStatus
2326  04b6 4d            	tnz	a
2327  04b7 27f8          	jreq	L1201
2328                     ; 872     delay_us(1);
2330  04b9 ae0001        	ldw	x,#1
2331  04bc cd059e        	call	_delay_us
2333                     ; 874   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2335  04bf 4b02          	push	#2
2336  04c1 ae5000        	ldw	x,#20480
2337  04c4 cd0000        	call	_GPIO_WriteHigh
2339  04c7 84            	pop	a
2340                     ; 877 }
2343  04c8 5b03          	addw	sp,#3
2344  04ca 81            	ret	
2404                     ; 884 void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
2404                     ; 885 {
2405                     	switch	.text
2406  04cb               _MCP_23K256_RAM_read_byte:
2408  04cb 89            	pushw	x
2409  04cc 88            	push	a
2410       00000001      OFST:	set	1
2413                     ; 886     uint8_t addr = 0;
2416  04cd               L5501:
2417                     ; 888   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2419  04cd a680          	ld	a,#128
2420  04cf cd0000        	call	_SPI_GetFlagStatus
2422  04d2 4d            	tnz	a
2423  04d3 26f8          	jrne	L5501
2424                     ; 890   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2426  04d5 4b02          	push	#2
2427  04d7 ae5000        	ldw	x,#20480
2428  04da cd0000        	call	_GPIO_WriteLow
2430  04dd 84            	pop	a
2431                     ; 892   SPI_SendData(READ); // instruction 3 read
2433  04de a603          	ld	a,#3
2434  04e0 cd0000        	call	_SPI_SendData
2437  04e3               L3601:
2438                     ; 894   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2440  04e3 a602          	ld	a,#2
2441  04e5 cd0000        	call	_SPI_GetFlagStatus
2443  04e8 4d            	tnz	a
2444  04e9 27f8          	jreq	L3601
2445                     ; 897     addr = address>>8;
2447  04eb 7b02          	ld	a,(OFST+1,sp)
2448  04ed 6b01          	ld	(OFST+0,sp),a
2450                     ; 898   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2452  04ef cd0000        	call	_SPI_SendData
2455  04f2               L1701:
2456                     ; 899   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2458  04f2 a602          	ld	a,#2
2459  04f4 cd0000        	call	_SPI_GetFlagStatus
2461  04f7 4d            	tnz	a
2462  04f8 27f8          	jreq	L1701
2463                     ; 902     addr = (address&255);
2465  04fa 7b03          	ld	a,(OFST+2,sp)
2466  04fc 6b01          	ld	(OFST+0,sp),a
2468                     ; 903   SPI_SendData( addr );
2470  04fe cd0000        	call	_SPI_SendData
2473  0501               L7701:
2474                     ; 904   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2476  0501 a602          	ld	a,#2
2477  0503 cd0000        	call	_SPI_GetFlagStatus
2479  0506 4d            	tnz	a
2480  0507 27f8          	jreq	L7701
2482  0509               L5011:
2483                     ; 908 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2485  0509 a601          	ld	a,#1
2486  050b cd0000        	call	_SPI_GetFlagStatus
2488  050e 4d            	tnz	a
2489  050f 27f8          	jreq	L5011
2490                     ; 909 SPI_SendData( 255 );
2492  0511 a6ff          	ld	a,#255
2493  0513 cd0000        	call	_SPI_SendData
2496  0516               L3111:
2497                     ; 910 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2499  0516 a602          	ld	a,#2
2500  0518 cd0000        	call	_SPI_GetFlagStatus
2502  051b 4d            	tnz	a
2503  051c 27f8          	jreq	L3111
2505  051e               L1211:
2506                     ; 911 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
2508  051e a601          	ld	a,#1
2509  0520 cd0000        	call	_SPI_GetFlagStatus
2511  0523 4d            	tnz	a
2512  0524 27f8          	jreq	L1211
2513                     ; 914   *value = SPI_ReceiveData();
2515  0526 cd0000        	call	_SPI_ReceiveData
2517  0529 1e06          	ldw	x,(OFST+5,sp)
2518  052b f7            	ld	(x),a
2519                     ; 921     delay_us(1);
2521  052c ae0001        	ldw	x,#1
2522  052f ad6d          	call	_delay_us
2524                     ; 923   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2526  0531 4b02          	push	#2
2527  0533 ae5000        	ldw	x,#20480
2528  0536 cd0000        	call	_GPIO_WriteHigh
2530  0539 84            	pop	a
2531                     ; 924 }
2534  053a 5b03          	addw	sp,#3
2535  053c 81            	ret	
2560                     ; 929 void MCP4901_DAC_init(void)
2560                     ; 930 {
2561                     	switch	.text
2562  053d               _MCP4901_DAC_init:
2566                     ; 931   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
2568  053d 4bf0          	push	#240
2569  053f 4b10          	push	#16
2570  0541 ae500a        	ldw	x,#20490
2571  0544 cd0000        	call	_GPIO_Init
2573  0547 85            	popw	x
2574                     ; 932   delay_ms(10);
2576  0548 ae000a        	ldw	x,#10
2578                     ; 933 }
2581  054b 2068          	jp	_delay_ms
2629                     ; 939 void MCP4901_DAC_write( unsigned char value)
2629                     ; 940 {
2630                     	switch	.text
2631  054d               _MCP4901_DAC_write:
2633  054d 88            	push	a
2634  054e 88            	push	a
2635       00000001      OFST:	set	1
2638                     ; 968     unsigned char address = 0x30; // 00,11,00,00
2640  054f a630          	ld	a,#48
2641  0551 6b01          	ld	(OFST+0,sp),a
2643                     ; 969     address |= ( value>>4); // assume 0's shoved in the left
2645  0553 7b02          	ld	a,(OFST+1,sp)
2646  0555 4e            	swap	a
2647  0556 a40f          	and	a,#15
2648  0558 1a01          	or	a,(OFST+0,sp)
2649  055a 6b01          	ld	(OFST+0,sp),a
2651                     ; 971     value = ( value<<4 ); // assume 0 shoved in from the right
2653  055c 7b02          	ld	a,(OFST+1,sp)
2654  055e 4e            	swap	a
2655  055f a4f0          	and	a,#240
2656  0561 6b02          	ld	(OFST+1,sp),a
2658  0563               L1611:
2659                     ; 974   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2661  0563 a680          	ld	a,#128
2662  0565 cd0000        	call	_SPI_GetFlagStatus
2664  0568 4d            	tnz	a
2665  0569 26f8          	jrne	L1611
2666                     ; 976   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
2668  056b 4b10          	push	#16
2669  056d ae500a        	ldw	x,#20490
2670  0570 cd0000        	call	_GPIO_WriteLow
2672  0573 84            	pop	a
2673                     ; 978   SPI_SendData(address);
2675  0574 7b01          	ld	a,(OFST+0,sp)
2676  0576 cd0000        	call	_SPI_SendData
2679  0579               L7611:
2680                     ; 980   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2682  0579 a602          	ld	a,#2
2683  057b cd0000        	call	_SPI_GetFlagStatus
2685  057e 4d            	tnz	a
2686  057f 27f8          	jreq	L7611
2687                     ; 982   SPI_SendData(value);
2689  0581 7b02          	ld	a,(OFST+1,sp)
2690  0583 cd0000        	call	_SPI_SendData
2693  0586               L5711:
2694                     ; 984   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2696  0586 a602          	ld	a,#2
2697  0588 cd0000        	call	_SPI_GetFlagStatus
2699  058b 4d            	tnz	a
2700  058c 27f8          	jreq	L5711
2701                     ; 988     delay_us(1);
2703  058e ae0001        	ldw	x,#1
2704  0591 ad0b          	call	_delay_us
2706                     ; 995   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
2708  0593 4b10          	push	#16
2709  0595 ae500a        	ldw	x,#20490
2710  0598 cd0000        	call	_GPIO_WriteHigh
2712                     ; 997 }
2715  059b 5b03          	addw	sp,#3
2716  059d 81            	ret	
2760                     ; 1006 void delay_us(unsigned int  value)
2760                     ; 1007 {
2761                     	switch	.text
2762  059e               _delay_us:
2764  059e 89            	pushw	x
2765       00000002      OFST:	set	2
2768                     ; 1008     register unsigned int loops =  (dly_const * value) ;
2770  059f cd0000        	call	c_uitof
2772  05a2 ae0000        	ldw	x,#L7221
2773  05a5 cd0000        	call	c_fmul
2775  05a8 cd0000        	call	c_ftoi
2778  05ab 2002          	jra	L7321
2779  05ad               L3321:
2780                     ; 1012         _asm ("nop");
2783  05ad 9d            	nop	
2785                     ; 1013         loops--;
2787  05ae 5a            	decw	x
2788  05af               L7321:
2789  05af 1f01          	ldw	(OFST-1,sp),x
2791                     ; 1010     while(loops)
2793  05b1 26fa          	jrne	L3321
2794                     ; 1015 }
2798  05b3 85            	popw	x
2799  05b4 81            	ret	
2834                     ; 1017 void delay_ms(unsigned int  value)
2834                     ; 1018 {
2835                     	switch	.text
2836  05b5               _delay_ms:
2838  05b5 89            	pushw	x
2839       00000000      OFST:	set	0
2842  05b6 200a          	jra	L3621
2843  05b8               L1621:
2844                     ; 1021         delay_us(1000);
2846  05b8 ae03e8        	ldw	x,#1000
2847  05bb ade1          	call	_delay_us
2849                     ; 1022         value--;
2851  05bd 1e01          	ldw	x,(OFST+1,sp)
2852  05bf 5a            	decw	x
2853  05c0 1f01          	ldw	(OFST+1,sp),x
2854  05c2               L3621:
2855                     ; 1019     while(value)
2857  05c2 1e01          	ldw	x,(OFST+1,sp)
2858  05c4 26f2          	jrne	L1621
2859                     ; 1024 }
2863  05c6 85            	popw	x
2864  05c7 81            	ret	
2877                     	xdef	_delay_ms_new
2878                     	xdef	_delay_us_new
2879                     	xdef	_TIM2_setup
2880                     	xdef	_main
2881                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
2882                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
2883                     	xdef	_TEST_adc_to_ram_to_dac
2884                     	xdef	_TEST_adc_to_dac
2885                     	xdef	_TEST_rampfunc_in_ram_to_dac
2886                     	xdef	_TEST_ram_test_001
2887                     	xdef	_delay_ms
2888                     	xdef	_delay_us
2889                     	xdef	_MCP_23K256_write_status_register
2890                     	xdef	_MCP_23K256_read_status_register
2891                     	xdef	_MCP_23K256_RAM_write_byte
2892                     	xdef	_MCP_23K256_RAM_read_byte
2893                     	xdef	_MCP_23K256_init
2894                     	xdef	_MCP4901_DAC_init
2895                     	xdef	_MCP4901_DAC_write
2896                     	xdef	_ADC1_setup
2897                     	xdef	_SPI_setup
2898                     	xdef	_GPIO_setup
2899                     	xdef	_clock_setup
2900                     	xref	_TIM4_ClearFlag
2901                     	xref	_TIM4_GetCounter
2902                     	xref	_TIM4_Cmd
2903                     	xref	_TIM4_TimeBaseInit
2904                     	xref	_TIM4_DeInit
2905                     	xref	_SPI_GetFlagStatus
2906                     	xref	_SPI_ReceiveData
2907                     	xref	_SPI_SendData
2908                     	xref	_SPI_Cmd
2909                     	xref	_SPI_Init
2910                     	xref	_SPI_DeInit
2911                     	xref	_GPIO_WriteLow
2912                     	xref	_GPIO_WriteHigh
2913                     	xref	_GPIO_Init
2914                     	xref	_GPIO_DeInit
2915                     	xref	_CLK_GetFlagStatus
2916                     	xref	_CLK_SYSCLKConfig
2917                     	xref	_CLK_HSIPrescalerConfig
2918                     	xref	_CLK_ClockSwitchConfig
2919                     	xref	_CLK_PeripheralClockConfig
2920                     	xref	_CLK_ClockSwitchCmd
2921                     	xref	_CLK_LSICmd
2922                     	xref	_CLK_HSICmd
2923                     	xref	_CLK_HSECmd
2924                     	xref	_CLK_DeInit
2925                     	xref	_ADC1_ClearFlag
2926                     	xref	_ADC1_GetFlagStatus
2927                     	xref	_ADC1_GetBufferValue
2928                     	xref	_ADC1_GetConversionValue
2929                     	xref	_ADC1_StartConversion
2930                     	xref	_ADC1_ConversionConfig
2931                     	xref	_ADC1_DataBufferCmd
2932                     	xref	_ADC1_ScanModeCmd
2933                     	xref	_ADC1_Cmd
2934                     	xref	_ADC1_Init
2935                     	xref	_ADC1_DeInit
2936                     .const:	section	.text
2937  0000               L7221:
2938  0000 3e000000      	dc.w	15872,0
2939  0004               L772:
2940  0004 3e800000      	dc.w	16000,0
2941                     	xref.b	c_lreg
2942                     	xref.b	c_x
2962                     	xref	c_ftoi
2963                     	xref	c_ftol
2964                     	xref	c_fmul
2965                     	xref	c_uitof
2966                     	end
