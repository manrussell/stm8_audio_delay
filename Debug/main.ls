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
 180  0009 cd026b        	call	_clock_setup
 182                     ; 146     GPIO_setup();
 184  000c cd02cb        	call	_GPIO_setup
 186                     ; 147     ADC1_setup();
 188  000f cd02ee        	call	_ADC1_setup
 190                     ; 148     SPI_setup();
 192  0012 cd03ab        	call	_SPI_setup
 194                     ; 149     MCP_23K256_init();
 196  0015 cd03c7        	call	_MCP_23K256_init
 198                     ; 150     MCP4901_DAC_init();
 200  0018 cd0537        	call	_MCP4901_DAC_init
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
 221                     ; 187         ADC1_ClearFlag(ADC1_FLAG_EOC);
 223  002b a680          	ld	a,#128
 224  002d cd0000        	call	_ADC1_ClearFlag
 226                     ; 188         adc_leftChannel = ADC1_GetBufferValue( 0); //ADC_LEFTCHANNEL );     // 0
 228  0030 4f            	clr	a
 229  0031 cd0000        	call	_ADC1_GetBufferValue
 231  0034 1f06          	ldw	(OFST-9,sp),x
 233                     ; 189         adc_delay       = ADC1_GetBufferValue( 1); //ADC_FEEDBACK_AMOUNT ); // 1
 235  0036 a601          	ld	a,#1
 236  0038 cd0000        	call	_ADC1_GetBufferValue
 239                     ; 194         delay = ( adc_delay << 2 ); //(adc_delay >> 2);
 241  003b 58            	sllw	x
 242  003c 58            	sllw	x
 243  003d 1f0e          	ldw	(OFST-1,sp),x
 245                     ; 201         mapd_value = (adc_leftChannel >> 2);
 247  003f 1e06          	ldw	x,(OFST-9,sp)
 248  0041 54            	srlw	x
 249  0042 54            	srlw	x
 250  0043 01            	rrwa	x,a
 251  0044 6b0b          	ld	(OFST-4,sp),a
 253                     ; 204         mapd_value = mapd_value/2 +  read_val/2;
 255  0046 5f            	clrw	x
 256  0047 7b08          	ld	a,(OFST-7,sp)
 257  0049 97            	ld	xl,a
 258  004a 57            	sraw	x
 259  004b 1f01          	ldw	(OFST-14,sp),x
 261  004d 5f            	clrw	x
 262  004e 7b0b          	ld	a,(OFST-4,sp)
 263  0050 97            	ld	xl,a
 264  0051 57            	sraw	x
 265  0052 72fb01        	addw	x,(OFST-14,sp)
 266  0055 01            	rrwa	x,a
 267  0056 6b0b          	ld	(OFST-4,sp),a
 269                     ; 215             read_addr = write_addr - delay;
 271  0058 1e0c          	ldw	x,(OFST-3,sp)
 272  005a 72f00e        	subw	x,(OFST-1,sp)
 273  005d 1f09          	ldw	(OFST-6,sp),x
 275                     ; 219         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 277  005f 88            	push	a
 278  0060 1e0d          	ldw	x,(OFST-2,sp)
 279  0062 cd0468        	call	_MCP_23K256_RAM_write_byte
 281  0065 84            	pop	a
 282                     ; 222         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 284  0066 96            	ldw	x,sp
 285  0067 1c0008        	addw	x,#OFST-7
 286  006a 89            	pushw	x
 287  006b 1e0b          	ldw	x,(OFST-4,sp)
 288  006d cd04c5        	call	_MCP_23K256_RAM_read_byte
 290  0070 85            	popw	x
 291                     ; 225         MCP4901_DAC_write(read_val);
 293  0071 7b08          	ld	a,(OFST-7,sp)
 294  0073 cd0547        	call	_MCP4901_DAC_write
 296                     ; 228         write_addr++;
 298  0076 1e0c          	ldw	x,(OFST-3,sp)
 299  0078 5c            	incw	x
 300  0079 1f0c          	ldw	(OFST-3,sp),x
 302                     ; 231         delay_us(90);
 304  007b ae005a        	ldw	x,#90
 305  007e cd0598        	call	_delay_us
 308  0081 2098          	jra	L76
 373                     ; 246 uint8_t TEST_ram_test_001(void)
 373                     ; 247 {
 374                     	switch	.text
 375  0083               _TEST_ram_test_001:
 377  0083 5205          	subw	sp,#5
 378       00000005      OFST:	set	5
 381                     ; 248     uint8_t cnt = 0;
 383                     ; 249     uint8_t data = 0;
 386                     ; 250     uint8_t wdata = 0;
 388                     ; 251     uint16_t addr = 0;
 390                     ; 254     data = BYTE_MODE;
 392  0085 0f03          	clr	(OFST-2,sp)
 394                     ; 255     MCP_23K256_write_status_register(data);
 396  0087 4f            	clr	a
 397  0088 cd042b        	call	_MCP_23K256_write_status_register
 399                     ; 258     MCP_23K256_read_status_register(&data);
 401  008b 96            	ldw	x,sp
 402  008c 1c0003        	addw	x,#OFST-2
 403  008f cd03d8        	call	_MCP_23K256_read_status_register
 405                     ; 302 wdata = 2;
 407  0092 a602          	ld	a,#2
 408  0094 6b02          	ld	(OFST-3,sp),a
 410                     ; 303 addr =0;
 412  0096 5f            	clrw	x
 413  0097 1f04          	ldw	(OFST-1,sp),x
 415                     ; 305     MCP_23K256_RAM_write_byte(addr, wdata);
 417  0099 4b02          	push	#2
 418  009b cd0468        	call	_MCP_23K256_RAM_write_byte
 420  009e 84            	pop	a
 421                     ; 308     MCP_23K256_RAM_read_byte(addr, &data);
 423  009f 96            	ldw	x,sp
 424  00a0 1c0003        	addw	x,#OFST-2
 425  00a3 89            	pushw	x
 426  00a4 1e06          	ldw	x,(OFST+1,sp)
 427  00a6 cd04c5        	call	_MCP_23K256_RAM_read_byte
 429  00a9 a6fa          	ld	a,#250
 430  00ab 85            	popw	x
 431                     ; 310     if (wdata != data)
 433                     ; 315 wdata = 250;
 435  00ac 6b02          	ld	(OFST-3,sp),a
 437                     ; 316 addr =1;
 439  00ae ae0001        	ldw	x,#1
 440  00b1 1f04          	ldw	(OFST-1,sp),x
 442                     ; 318     MCP_23K256_RAM_write_byte(addr, wdata);
 444  00b3 4bfa          	push	#250
 445  00b5 cd0468        	call	_MCP_23K256_RAM_write_byte
 447  00b8 84            	pop	a
 448                     ; 321     MCP_23K256_RAM_read_byte(addr, &data);
 450  00b9 96            	ldw	x,sp
 451  00ba 1c0003        	addw	x,#OFST-2
 452  00bd 89            	pushw	x
 453  00be 1e06          	ldw	x,(OFST+1,sp)
 454  00c0 cd04c5        	call	_MCP_23K256_RAM_read_byte
 456  00c3 a604          	ld	a,#4
 457  00c5 85            	popw	x
 458                     ; 323     if (wdata != data)
 460                     ; 328 wdata = 4;
 462  00c6 6b02          	ld	(OFST-3,sp),a
 464                     ; 329 addr =2;
 466  00c8 ae0002        	ldw	x,#2
 467  00cb 1f04          	ldw	(OFST-1,sp),x
 469                     ; 331     MCP_23K256_RAM_write_byte(addr, wdata);
 471  00cd 4b04          	push	#4
 472  00cf cd0468        	call	_MCP_23K256_RAM_write_byte
 474  00d2 84            	pop	a
 475                     ; 334     MCP_23K256_RAM_read_byte(addr, &data);
 477  00d3 96            	ldw	x,sp
 478  00d4 1c0003        	addw	x,#OFST-2
 479  00d7 89            	pushw	x
 480  00d8 1e06          	ldw	x,(OFST+1,sp)
 481  00da cd04c5        	call	_MCP_23K256_RAM_read_byte
 483  00dd 85            	popw	x
 484                     ; 336     if (wdata != data)
 486                     ; 342     for(addr = 0; addr<3; addr++)
 488  00de 5f            	clrw	x
 489  00df 1f04          	ldw	(OFST-1,sp),x
 491  00e1               L141:
 492                     ; 344         MCP_23K256_RAM_read_byte(addr, &data);
 494  00e1 96            	ldw	x,sp
 495  00e2 1c0003        	addw	x,#OFST-2
 496  00e5 89            	pushw	x
 497  00e6 1e06          	ldw	x,(OFST+1,sp)
 498  00e8 cd04c5        	call	_MCP_23K256_RAM_read_byte
 500  00eb 85            	popw	x
 501                     ; 342     for(addr = 0; addr<3; addr++)
 503  00ec 1e04          	ldw	x,(OFST-1,sp)
 504  00ee 5c            	incw	x
 505  00ef 1f04          	ldw	(OFST-1,sp),x
 509  00f1 a30003        	cpw	x,#3
 510  00f4 25eb          	jrult	L141
 511                     ; 346     return 0;
 513  00f6 4f            	clr	a
 516  00f7 5b05          	addw	sp,#5
 517  00f9 81            	ret	
 574                     ; 353 uint8_t TEST_rampfunc_in_ram_to_dac(void)
 574                     ; 354 {
 575                     	switch	.text
 576  00fa               _TEST_rampfunc_in_ram_to_dac:
 578  00fa 5204          	subw	sp,#4
 579       00000004      OFST:	set	4
 582                     ; 355     uint8_t data = 0;
 584  00fc 0f02          	clr	(OFST-2,sp)
 586                     ; 356     uint8_t wdata = 0;
 588  00fe 0f01          	clr	(OFST-3,sp)
 590                     ; 357     uint16_t addr = 0;
 592                     ; 360     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 594  0100 5f            	clrw	x
 595  0101 1f03          	ldw	(OFST-1,sp),x
 597  0103 7b01          	ld	a,(OFST-3,sp)
 598  0105               L571:
 599                     ; 362         MCP_23K256_RAM_write_byte(addr, wdata);
 601  0105 88            	push	a
 602  0106 1e04          	ldw	x,(OFST+0,sp)
 603  0108 cd0468        	call	_MCP_23K256_RAM_write_byte
 605  010b 84            	pop	a
 606                     ; 360     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 608  010c 1e03          	ldw	x,(OFST-1,sp)
 609  010e 5c            	incw	x
 610  010f 1f03          	ldw	(OFST-1,sp),x
 612  0111 7b01          	ld	a,(OFST-3,sp)
 613  0113 ab04          	add	a,#4
 614  0115 6b01          	ld	(OFST-3,sp),a
 618  0117 a300ff        	cpw	x,#255
 619  011a 25e9          	jrult	L571
 620  011c               L302:
 621                     ; 368         for(addr = 0; addr<255; addr++)
 623  011c 5f            	clrw	x
 624  011d 1f03          	ldw	(OFST-1,sp),x
 626  011f               L702:
 627                     ; 370             MCP_23K256_RAM_read_byte(addr, &data);
 629  011f 96            	ldw	x,sp
 630  0120 1c0002        	addw	x,#OFST-2
 631  0123 89            	pushw	x
 632  0124 1e05          	ldw	x,(OFST+1,sp)
 633  0126 cd04c5        	call	_MCP_23K256_RAM_read_byte
 635  0129 85            	popw	x
 636                     ; 371             MCP4901_DAC_write(data);
 638  012a 7b02          	ld	a,(OFST-2,sp)
 639  012c cd0547        	call	_MCP4901_DAC_write
 641                     ; 372             delay_us(90);   //11kHz sample rate // phasor == frequ
 643  012f ae005a        	ldw	x,#90
 644  0132 cd0598        	call	_delay_us
 646                     ; 368         for(addr = 0; addr<255; addr++)
 648  0135 1e03          	ldw	x,(OFST-1,sp)
 649  0137 5c            	incw	x
 650  0138 1f03          	ldw	(OFST-1,sp),x
 654  013a a300ff        	cpw	x,#255
 655  013d 25e0          	jrult	L702
 657  013f 20db          	jra	L302
 692                     ; 380 void TEST_adc_to_dac(uint8_t *x)
 692                     ; 381 {
 693                     	switch	.text
 694  0141               _TEST_adc_to_dac:
 698                     ; 405 }
 701  0141 81            	ret	
 762                     ; 408 void TEST_adc_to_ram_to_dac(void)
 762                     ; 409 {
 763                     	switch	.text
 764  0142               _TEST_adc_to_ram_to_dac:
 766  0142 5205          	subw	sp,#5
 767       00000005      OFST:	set	5
 770                     ; 410     uint16_t adc_val = 0;
 772                     ; 411     uint16_t addr = 0;
 774  0144 5f            	clrw	x
 775  0145 1f03          	ldw	(OFST-2,sp),x
 777                     ; 412     uint8_t mapd_value = 0;
 779  0147 0f05          	clr	(OFST+0,sp)
 781  0149               L162:
 782                     ; 417         ADC1_StartConversion();
 784  0149 cd0000        	call	_ADC1_StartConversion
 787  014c               L762:
 788                     ; 418         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 790  014c a680          	ld	a,#128
 791  014e cd0000        	call	_ADC1_GetFlagStatus
 793  0151 4d            	tnz	a
 794  0152 27f8          	jreq	L762
 795                     ; 420         adc_val = ADC1_GetConversionValue(); // for led knob
 797  0154 cd0000        	call	_ADC1_GetConversionValue
 799  0157 1f01          	ldw	(OFST-4,sp),x
 801                     ; 421         ADC1_ClearFlag(ADC1_FLAG_EOC);
 803  0159 a680          	ld	a,#128
 804  015b cd0000        	call	_ADC1_ClearFlag
 806                     ; 428         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 808  015e 1e01          	ldw	x,(OFST-4,sp)
 809  0160 cd0000        	call	c_uitof
 811  0163 ae0004        	ldw	x,#L772
 812  0166 cd0000        	call	c_fmul
 814  0169 cd0000        	call	c_ftol
 816  016c b603          	ld	a,c_lreg+3
 817  016e 6b05          	ld	(OFST+0,sp),a
 819                     ; 431         MCP_23K256_RAM_write_byte(addr, mapd_value);
 821  0170 88            	push	a
 822  0171 1e04          	ldw	x,(OFST-1,sp)
 823  0173 cd0468        	call	_MCP_23K256_RAM_write_byte
 825  0176 84            	pop	a
 826                     ; 434         mapd_value = 0; // check value
 828  0177 0f05          	clr	(OFST+0,sp)
 830                     ; 435         MCP_23K256_RAM_read_byte(addr, &mapd_value);
 832  0179 96            	ldw	x,sp
 833  017a 1c0005        	addw	x,#OFST+0
 834  017d 89            	pushw	x
 835  017e 1e05          	ldw	x,(OFST+0,sp)
 836  0180 cd04c5        	call	_MCP_23K256_RAM_read_byte
 838  0183 85            	popw	x
 839                     ; 438         addr++;
 841  0184 1e03          	ldw	x,(OFST-2,sp)
 842  0186 5c            	incw	x
 843  0187 1f03          	ldw	(OFST-2,sp),x
 845                     ; 440         MCP4901_DAC_write(mapd_value);
 847  0189 7b05          	ld	a,(OFST+0,sp)
 848  018b cd0547        	call	_MCP4901_DAC_write
 850                     ; 443         delay_us(90);
 852  018e ae005a        	ldw	x,#90
 853  0191 cd0598        	call	_delay_us
 856  0194 20b3          	jra	L162
 953                     ; 450 void TEST_adc_to_ram_to_dac_with_delay(void)
 953                     ; 451 {
 954                     	switch	.text
 955  0196               _TEST_adc_to_ram_to_dac_with_delay:
 957  0196 520b          	subw	sp,#11
 958       0000000b      OFST:	set	11
 961                     ; 452     uint16_t adc_val = 0;
 963                     ; 453     uint8_t mapd_value = 0; // mapped adc valu
 965                     ; 454     uint8_t read_val = 0;   //read val from ram
 967  0198 0f05          	clr	(OFST-6,sp)
 969                     ; 455     uint16_t write_addr = 0;    //write addr in ram
 971  019a 5f            	clrw	x
 972  019b 1f0a          	ldw	(OFST-1,sp),x
 974                     ; 456     uint16_t read_addr = 0; // read addr in val
 976  019d 1f06          	ldw	(OFST-5,sp),x
 978                     ; 457     uint16_t delay = 110; // length of delay in samples
 980  019f ae006e        	ldw	x,#110
 981  01a2 1f08          	ldw	(OFST-3,sp),x
 983                     ; 458     uint8_t res = 0;
 985  01a4               L153:
 986                     ; 464         ADC1_StartConversion();
 988  01a4 cd0000        	call	_ADC1_StartConversion
 991  01a7               L753:
 992                     ; 465         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 994  01a7 a680          	ld	a,#128
 995  01a9 cd0000        	call	_ADC1_GetFlagStatus
 997  01ac 4d            	tnz	a
 998  01ad 27f8          	jreq	L753
 999                     ; 467         adc_val = ADC1_GetConversionValue(); // for led knob
1001  01af cd0000        	call	_ADC1_GetConversionValue
1003  01b2 1f02          	ldw	(OFST-9,sp),x
1005                     ; 468         ADC1_ClearFlag(ADC1_FLAG_EOC);
1007  01b4 a680          	ld	a,#128
1008  01b6 cd0000        	call	_ADC1_ClearFlag
1010                     ; 475         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
1012  01b9 1e02          	ldw	x,(OFST-9,sp)
1013  01bb cd0000        	call	c_uitof
1015  01be ae0004        	ldw	x,#L772
1016  01c1 cd0000        	call	c_fmul
1018  01c4 cd0000        	call	c_ftol
1020  01c7 b603          	ld	a,c_lreg+3
1021  01c9 6b04          	ld	(OFST-7,sp),a
1023                     ; 486             read_addr = write_addr - delay;
1025  01cb 1e0a          	ldw	x,(OFST-1,sp)
1026  01cd 72f008        	subw	x,(OFST-3,sp)
1027  01d0 1f06          	ldw	(OFST-5,sp),x
1029                     ; 490         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1031  01d2 88            	push	a
1032  01d3 1e0b          	ldw	x,(OFST+0,sp)
1033  01d5 cd0468        	call	_MCP_23K256_RAM_write_byte
1035  01d8 84            	pop	a
1036                     ; 493         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1038  01d9 96            	ldw	x,sp
1039  01da 1c0005        	addw	x,#OFST-6
1040  01dd 89            	pushw	x
1041  01de 1e08          	ldw	x,(OFST-3,sp)
1042  01e0 cd04c5        	call	_MCP_23K256_RAM_read_byte
1044  01e3 85            	popw	x
1045                     ; 496         MCP4901_DAC_write(read_val);
1047  01e4 7b05          	ld	a,(OFST-6,sp)
1048  01e6 cd0547        	call	_MCP4901_DAC_write
1050                     ; 499         write_addr++;
1052  01e9 1e0a          	ldw	x,(OFST-1,sp)
1053  01eb 5c            	incw	x
1054  01ec 1f0a          	ldw	(OFST-1,sp),x
1056                     ; 502         delay_us(90);
1058  01ee ae005a        	ldw	x,#90
1059  01f1 cd0598        	call	_delay_us
1062  01f4 20ae          	jra	L153
1170                     ; 510 void TEST_adc_to_ram_to_dac_with_with_fback(void)
1170                     ; 511 {
1171                     	switch	.text
1172  01f6               _TEST_adc_to_ram_to_dac_with_with_fback:
1174  01f6 520d          	subw	sp,#13
1175       0000000d      OFST:	set	13
1178                     ; 513     uint16_t adc0_val = 0;  //er are these 8 or 16 big?
1180                     ; 514     uint16_t adc1_val = 0;
1182                     ; 515     uint8_t mapd_value = 0; // mapped adc valu
1184                     ; 516     uint8_t read_val = 0;   //read val from ram
1186  01f8 0f06          	clr	(OFST-7,sp)
1188                     ; 517     uint16_t write_addr = 0;    //write addr in ram
1190  01fa 5f            	clrw	x
1191  01fb 1f0a          	ldw	(OFST-3,sp),x
1193                     ; 518     uint16_t read_addr = 0; // read addr in val
1195  01fd 1f07          	ldw	(OFST-6,sp),x
1197                     ; 519     uint16_t delay = 110; // length of delay in samples
1199                     ; 520     uint8_t res = 0;
1201  01ff               L534:
1202                     ; 535     ADC1_ScanModeCmd(ENABLE);
1204  01ff a601          	ld	a,#1
1205  0201 cd0000        	call	_ADC1_ScanModeCmd
1207                     ; 536     ADC1_StartConversion();
1209  0204 cd0000        	call	_ADC1_StartConversion
1212  0207               L344:
1213                     ; 537     while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1215  0207 a680          	ld	a,#128
1216  0209 cd0000        	call	_ADC1_GetFlagStatus
1218  020c 4d            	tnz	a
1219  020d 27f8          	jreq	L344
1220                     ; 539     adc0_val = ADC1_GetBufferValue(0);
1222  020f 4f            	clr	a
1223  0210 cd0000        	call	_ADC1_GetBufferValue
1225  0213 1f04          	ldw	(OFST-9,sp),x
1227                     ; 540     adc1_val = ADC1_GetBufferValue(1);
1229  0215 a601          	ld	a,#1
1230  0217 cd0000        	call	_ADC1_GetBufferValue
1232  021a 1f0c          	ldw	(OFST-1,sp),x
1234                     ; 541     ADC1_ClearFlag(ADC1_FLAG_EOC);
1236  021c a680          	ld	a,#128
1237  021e cd0000        	call	_ADC1_ClearFlag
1239                     ; 544     delay = (adc1_val>>2);
1241  0221 1e0c          	ldw	x,(OFST-1,sp)
1242  0223 54            	srlw	x
1243  0224 54            	srlw	x
1244  0225 1f0c          	ldw	(OFST-1,sp),x
1246                     ; 554         mapd_value = (adc0_val>>2) ; // do i need the float or not ??? -No use a lft shift
1248  0227 1e04          	ldw	x,(OFST-9,sp)
1249  0229 54            	srlw	x
1250  022a 54            	srlw	x
1251  022b 01            	rrwa	x,a
1252  022c 6b09          	ld	(OFST-4,sp),a
1254                     ; 559         mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
1256  022e 5f            	clrw	x
1257  022f 7b06          	ld	a,(OFST-7,sp)
1258  0231 97            	ld	xl,a
1259  0232 57            	sraw	x
1260  0233 1f01          	ldw	(OFST-12,sp),x
1262  0235 5f            	clrw	x
1263  0236 7b09          	ld	a,(OFST-4,sp)
1264  0238 97            	ld	xl,a
1265  0239 57            	sraw	x
1266  023a 72fb01        	addw	x,(OFST-12,sp)
1267  023d 01            	rrwa	x,a
1268  023e 6b09          	ld	(OFST-4,sp),a
1270                     ; 570             read_addr = write_addr - delay;
1272  0240 1e0a          	ldw	x,(OFST-3,sp)
1273  0242 72f00c        	subw	x,(OFST-1,sp)
1274  0245 1f07          	ldw	(OFST-6,sp),x
1276                     ; 574         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1278  0247 88            	push	a
1279  0248 1e0b          	ldw	x,(OFST-2,sp)
1280  024a cd0468        	call	_MCP_23K256_RAM_write_byte
1282  024d 84            	pop	a
1283                     ; 577         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1285  024e 96            	ldw	x,sp
1286  024f 1c0006        	addw	x,#OFST-7
1287  0252 89            	pushw	x
1288  0253 1e09          	ldw	x,(OFST-4,sp)
1289  0255 cd04c5        	call	_MCP_23K256_RAM_read_byte
1291  0258 85            	popw	x
1292                     ; 580         MCP4901_DAC_write(read_val);
1294  0259 7b06          	ld	a,(OFST-7,sp)
1295  025b cd0547        	call	_MCP4901_DAC_write
1297                     ; 583         write_addr++;
1299  025e 1e0a          	ldw	x,(OFST-3,sp)
1300  0260 5c            	incw	x
1301  0261 1f0a          	ldw	(OFST-3,sp),x
1303                     ; 586         delay_us(90);
1305  0263 ae005a        	ldw	x,#90
1306  0266 cd0598        	call	_delay_us
1309  0269 2094          	jra	L534
1342                     ; 592 void clock_setup(void)
1342                     ; 593 {
1343                     	switch	.text
1344  026b               _clock_setup:
1348                     ; 594   CLK_DeInit();
1350  026b cd0000        	call	_CLK_DeInit
1352                     ; 596   CLK_HSECmd(DISABLE);
1354  026e 4f            	clr	a
1355  026f cd0000        	call	_CLK_HSECmd
1357                     ; 597   CLK_LSICmd(DISABLE);
1359  0272 4f            	clr	a
1360  0273 cd0000        	call	_CLK_LSICmd
1362                     ; 598   CLK_HSICmd(ENABLE);
1364  0276 a601          	ld	a,#1
1365  0278 cd0000        	call	_CLK_HSICmd
1368  027b               L164:
1369                     ; 599   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
1371  027b ae0102        	ldw	x,#258
1372  027e cd0000        	call	_CLK_GetFlagStatus
1374  0281 4d            	tnz	a
1375  0282 27f7          	jreq	L164
1376                     ; 601   CLK_ClockSwitchCmd(ENABLE);
1378  0284 a601          	ld	a,#1
1379  0286 cd0000        	call	_CLK_ClockSwitchCmd
1381                     ; 602   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1383  0289 4f            	clr	a
1384  028a cd0000        	call	_CLK_HSIPrescalerConfig
1386                     ; 603   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
1388  028d a680          	ld	a,#128
1389  028f cd0000        	call	_CLK_SYSCLKConfig
1391                     ; 605   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
1393  0292 4b01          	push	#1
1394  0294 4b00          	push	#0
1395  0296 ae01e1        	ldw	x,#481
1396  0299 cd0000        	call	_CLK_ClockSwitchConfig
1398  029c 85            	popw	x
1399                     ; 607   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
1401  029d 5f            	clrw	x
1402  029e cd0000        	call	_CLK_PeripheralClockConfig
1404                     ; 608   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
1406  02a1 ae0101        	ldw	x,#257
1407  02a4 cd0000        	call	_CLK_PeripheralClockConfig
1409                     ; 609   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
1411  02a7 ae0300        	ldw	x,#768
1412  02aa cd0000        	call	_CLK_PeripheralClockConfig
1414                     ; 610   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
1416  02ad ae1200        	ldw	x,#4608
1417  02b0 cd0000        	call	_CLK_PeripheralClockConfig
1419                     ; 611   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
1421  02b3 ae1301        	ldw	x,#4865
1422  02b6 cd0000        	call	_CLK_PeripheralClockConfig
1424                     ; 612   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
1426  02b9 ae0700        	ldw	x,#1792
1427  02bc cd0000        	call	_CLK_PeripheralClockConfig
1429                     ; 613   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
1431  02bf ae0501        	ldw	x,#1281
1432  02c2 cd0000        	call	_CLK_PeripheralClockConfig
1434                     ; 614   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
1436  02c5 ae0400        	ldw	x,#1024
1438                     ; 616 }
1441  02c8 cc0000        	jp	_CLK_PeripheralClockConfig
1466                     ; 618 void GPIO_setup(void)
1466                     ; 619 {
1467                     	switch	.text
1468  02cb               _GPIO_setup:
1472                     ; 620   GPIO_DeInit(GPIOC);
1474  02cb ae500a        	ldw	x,#20490
1475  02ce cd0000        	call	_GPIO_DeInit
1477                     ; 625     GPIO_DeInit(ADC_port);
1479  02d1 ae5005        	ldw	x,#20485
1480  02d4 cd0000        	call	_GPIO_DeInit
1482                     ; 631     GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
1484  02d7 4b00          	push	#0
1485  02d9 4b0f          	push	#15
1486  02db ae5005        	ldw	x,#20485
1487  02de cd0000        	call	_GPIO_Init
1489  02e1 85            	popw	x
1490                     ; 636     GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ),
1490                     ; 637                GPIO_MODE_OUT_PP_HIGH_FAST);
1492  02e2 4bf0          	push	#240
1493  02e4 4b60          	push	#96
1494  02e6 ae500a        	ldw	x,#20490
1495  02e9 cd0000        	call	_GPIO_Init
1497  02ec 85            	popw	x
1498                     ; 638 }
1501  02ed 81            	ret	
1529                     ; 666 void ADC1_setup(void)
1529                     ; 667 {
1530                     	switch	.text
1531  02ee               _ADC1_setup:
1535                     ; 668   ADC1_DeInit();
1537  02ee cd0000        	call	_ADC1_DeInit
1539                     ; 670   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
1539                     ; 671   ADC1_CHANNEL_0,\
1539                     ; 672   ADC1_PRESSEL_FCPU_D18, \
1539                     ; 673   ADC1_EXTTRIG_GPIO, \
1539                     ; 674   DISABLE, \
1539                     ; 675   ADC1_ALIGN_RIGHT, \
1539                     ; 676   ADC1_SCHMITTTRIG_CHANNEL0, \
1539                     ; 677   DISABLE);
1541  02f1 4b00          	push	#0
1542  02f3 4b00          	push	#0
1543  02f5 4b08          	push	#8
1544  02f7 4b00          	push	#0
1545  02f9 4b10          	push	#16
1546  02fb 4b70          	push	#112
1547  02fd 5f            	clrw	x
1548  02fe cd0000        	call	_ADC1_Init
1550  0301 5b06          	addw	sp,#6
1551                     ; 679   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
1551                     ; 680   ADC1_CHANNEL_1,\
1551                     ; 681   ADC1_PRESSEL_FCPU_D18, \
1551                     ; 682   ADC1_EXTTRIG_GPIO, \
1551                     ; 683   DISABLE, \
1551                     ; 684   ADC1_ALIGN_RIGHT, \
1551                     ; 685   ADC1_SCHMITTTRIG_CHANNEL1, \
1551                     ; 686   DISABLE);
1553  0303 4b00          	push	#0
1554  0305 4b01          	push	#1
1555  0307 4b08          	push	#8
1556  0309 4b00          	push	#0
1557  030b 4b10          	push	#16
1558  030d 4b70          	push	#112
1559  030f ae0001        	ldw	x,#1
1560  0312 cd0000        	call	_ADC1_Init
1562  0315 5b06          	addw	sp,#6
1563                     ; 688   ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);
1565  0317 4b08          	push	#8
1566  0319 ae0001        	ldw	x,#1
1567  031c cd0000        	call	_ADC1_ConversionConfig
1569  031f 84            	pop	a
1570                     ; 690   ADC1_DataBufferCmd(ENABLE);
1572  0320 a601          	ld	a,#1
1573  0322 cd0000        	call	_ADC1_DataBufferCmd
1575                     ; 691   ADC1_Cmd(ENABLE);
1577  0325 a601          	ld	a,#1
1579                     ; 693 }
1582  0327 cc0000        	jp	_ADC1_Cmd
1605                     ; 698 void TIM2_setup(void)
1605                     ; 699 {
1606                     	switch	.text
1607  032a               _TIM2_setup:
1611                     ; 711 }
1614  032a 81            	ret	
1653                     ; 715 void delay_us_new(unsigned int us)
1653                     ; 716 {
1654                     	switch	.text
1655  032b               _delay_us_new:
1657  032b 89            	pushw	x
1658       00000000      OFST:	set	0
1661                     ; 717     TIM4_DeInit();
1663  032c cd0000        	call	_TIM4_DeInit
1665                     ; 719     if((us <= 200) && (us >= 0))
1667  032f 1e01          	ldw	x,(OFST+1,sp)
1668  0331 a300c9        	cpw	x,#201
1669  0334 2405          	jruge	L335
1670                     ; 721         TIM4_TimeBaseInit(TIM4_PRESCALER_16, 200);
1672  0336 ae04c8        	ldw	x,#1224
1674                     ; 722         TIM4_Cmd(ENABLE);
1677  0339 2041          	jp	LC001
1678  033b               L335:
1679                     ; 724     else if((us <= 400) && (us > 200))
1681  033b a30191        	cpw	x,#401
1682  033e 240e          	jruge	L735
1684  0340 a300c9        	cpw	x,#201
1685  0343 2509          	jrult	L735
1686                     ; 726         us >>= 1;
1688  0345 0401          	srl	(OFST+1,sp)
1689                     ; 727         TIM4_TimeBaseInit(TIM4_PRESCALER_32, 200);
1691  0347 ae05c8        	ldw	x,#1480
1692  034a 0602          	rrc	(OFST+2,sp)
1694                     ; 728         TIM4_Cmd(ENABLE);
1697  034c 202e          	jp	LC001
1698  034e               L735:
1699                     ; 730     else if((us <= 800) && (us > 400))
1701  034e a30321        	cpw	x,#801
1702  0351 2413          	jruge	L345
1704  0353 a30191        	cpw	x,#401
1705  0356 250e          	jrult	L345
1706                     ; 732         us >>= 2;
1708  0358 a602          	ld	a,#2
1709  035a               L213:
1710  035a 0401          	srl	(OFST+1,sp)
1711  035c 0602          	rrc	(OFST+2,sp)
1712  035e 4a            	dec	a
1713  035f 26f9          	jrne	L213
1714                     ; 733         TIM4_TimeBaseInit(TIM4_PRESCALER_64, 200);
1716  0361 ae06c8        	ldw	x,#1736
1718                     ; 734         TIM4_Cmd(ENABLE);
1721  0364 2016          	jp	LC001
1722  0366               L345:
1723                     ; 736     else if((us <= 1600) && (us > 800))
1725  0366 a30641        	cpw	x,#1601
1726  0369 2419          	jruge	L355
1728  036b a30321        	cpw	x,#801
1729  036e 2514          	jrult	L355
1730                     ; 738         us >>= 3;
1732  0370 a603          	ld	a,#3
1733  0372               L023:
1734  0372 0401          	srl	(OFST+1,sp)
1735  0374 0602          	rrc	(OFST+2,sp)
1736  0376 4a            	dec	a
1737  0377 26f9          	jrne	L023
1738                     ; 739         TIM4_TimeBaseInit(TIM4_PRESCALER_128, 200);
1740  0379 ae07c8        	ldw	x,#1992
1742                     ; 740         TIM4_Cmd(ENABLE);
1744  037c               LC001:
1745  037c cd0000        	call	_TIM4_TimeBaseInit
1749  037f a601          	ld	a,#1
1750  0381 cd0000        	call	_TIM4_Cmd
1752  0384               L355:
1753                     ; 743     while(TIM4_GetCounter() < us);
1755  0384 cd0000        	call	_TIM4_GetCounter
1757  0387 5f            	clrw	x
1758  0388 97            	ld	xl,a
1759  0389 1301          	cpw	x,(OFST+1,sp)
1760  038b 25f7          	jrult	L355
1761                     ; 744     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
1763  038d a601          	ld	a,#1
1764  038f cd0000        	call	_TIM4_ClearFlag
1766                     ; 745     TIM4_Cmd(DISABLE);
1768  0392 4f            	clr	a
1769  0393 cd0000        	call	_TIM4_Cmd
1771                     ; 746 }
1774  0396 85            	popw	x
1775  0397 81            	ret	
1810                     ; 750 void delay_ms_new(unsigned int ms)
1810                     ; 751 {
1811                     	switch	.text
1812  0398               _delay_ms_new:
1814  0398 89            	pushw	x
1815       00000000      OFST:	set	0
1818  0399 2006          	jra	L775
1819  039b               L575:
1820                     ; 754         delay_us(1000);
1822  039b ae03e8        	ldw	x,#1000
1823  039e cd0598        	call	_delay_us
1825  03a1               L775:
1826                     ; 752     while(ms--)
1828  03a1 1e01          	ldw	x,(OFST+1,sp)
1829  03a3 5a            	decw	x
1830  03a4 1f01          	ldw	(OFST+1,sp),x
1831  03a6 5c            	incw	x
1832  03a7 26f2          	jrne	L575
1833                     ; 756 }
1837  03a9 85            	popw	x
1838  03aa 81            	ret	
1864                     ; 759 void SPI_setup(void)
1864                     ; 760 {
1865                     	switch	.text
1866  03ab               _SPI_setup:
1870                     ; 761   SPI_DeInit();
1872  03ab cd0000        	call	_SPI_DeInit
1874                     ; 766   SPI_Init(SPI_FIRSTBIT_MSB, \
1874                     ; 767     SPI_BAUDRATEPRESCALER_16, \
1874                     ; 768     SPI_MODE_MASTER, \
1874                     ; 769     SPI_CLOCKPOLARITY_LOW, \
1874                     ; 770     SPI_CLOCKPHASE_1EDGE, \
1874                     ; 771     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
1874                     ; 772     SPI_NSS_SOFT, \
1874                     ; 773     0x0);
1876  03ae 4b00          	push	#0
1877  03b0 4b02          	push	#2
1878  03b2 4b00          	push	#0
1879  03b4 4b00          	push	#0
1880  03b6 4b00          	push	#0
1881  03b8 4b04          	push	#4
1882  03ba ae0018        	ldw	x,#24
1883  03bd cd0000        	call	_SPI_Init
1885  03c0 5b06          	addw	sp,#6
1886                     ; 775   SPI_Cmd(ENABLE);
1888  03c2 a601          	ld	a,#1
1890                     ; 776 }
1893  03c4 cc0000        	jp	_SPI_Cmd
1918                     ; 778 void MCP_23K256_init()
1918                     ; 779 {
1919                     	switch	.text
1920  03c7               _MCP_23K256_init:
1924                     ; 780     GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
1926  03c7 4bf0          	push	#240
1927  03c9 4b02          	push	#2
1928  03cb ae5000        	ldw	x,#20480
1929  03ce cd0000        	call	_GPIO_Init
1931  03d1 85            	popw	x
1932                     ; 781   delay_ms(10);
1934  03d2 ae000a        	ldw	x,#10
1936                     ; 782 }
1939  03d5 cc05af        	jp	_delay_ms
1981                     ; 787 void MCP_23K256_read_status_register(uint8_t *data)
1981                     ; 788 {
1982                     	switch	.text
1983  03d8               _MCP_23K256_read_status_register:
1985  03d8 89            	pushw	x
1986       00000000      OFST:	set	0
1989  03d9               L346:
1990                     ; 790   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1992  03d9 a680          	ld	a,#128
1993  03db cd0000        	call	_SPI_GetFlagStatus
1995  03de 4d            	tnz	a
1996  03df 26f8          	jrne	L346
1997                     ; 792   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1999  03e1 4b02          	push	#2
2000  03e3 ae5000        	ldw	x,#20480
2001  03e6 cd0000        	call	_GPIO_WriteLow
2003  03e9 84            	pop	a
2004                     ; 794   SPI_SendData(RDSR); // read ststus reg
2006  03ea a605          	ld	a,#5
2007  03ec cd0000        	call	_SPI_SendData
2010  03ef               L156:
2011                     ; 796   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2013  03ef a602          	ld	a,#2
2014  03f1 cd0000        	call	_SPI_GetFlagStatus
2016  03f4 4d            	tnz	a
2017  03f5 27f8          	jreq	L156
2019  03f7               L756:
2020                     ; 799 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2022  03f7 a601          	ld	a,#1
2023  03f9 cd0000        	call	_SPI_GetFlagStatus
2025  03fc 4d            	tnz	a
2026  03fd 27f8          	jreq	L756
2027                     ; 800 SPI_SendData( 255 );
2029  03ff a6ff          	ld	a,#255
2030  0401 cd0000        	call	_SPI_SendData
2033  0404               L566:
2034                     ; 801 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2036  0404 a602          	ld	a,#2
2037  0406 cd0000        	call	_SPI_GetFlagStatus
2039  0409 4d            	tnz	a
2040  040a 27f8          	jreq	L566
2041                     ; 803   *data = SPI_ReceiveData();
2043  040c cd0000        	call	_SPI_ReceiveData
2045  040f 1e01          	ldw	x,(OFST+1,sp)
2046  0411 f7            	ld	(x),a
2048  0412               L576:
2049                     ; 805   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
2051  0412 a601          	ld	a,#1
2052  0414 cd0000        	call	_SPI_GetFlagStatus
2054  0417 4d            	tnz	a
2055  0418 27f8          	jreq	L576
2056                     ; 809     delay_us(1);
2058  041a ae0001        	ldw	x,#1
2059  041d cd0598        	call	_delay_us
2061                     ; 811   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2063  0420 4b02          	push	#2
2064  0422 ae5000        	ldw	x,#20480
2065  0425 cd0000        	call	_GPIO_WriteHigh
2067                     ; 812 }
2070  0428 5b03          	addw	sp,#3
2071  042a 81            	ret	
2111                     ; 821 void MCP_23K256_write_status_register(uint8_t data)
2111                     ; 822 {
2112                     	switch	.text
2113  042b               _MCP_23K256_write_status_register:
2115  042b 88            	push	a
2116       00000000      OFST:	set	0
2119  042c               L127:
2120                     ; 824   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2122  042c a680          	ld	a,#128
2123  042e cd0000        	call	_SPI_GetFlagStatus
2125  0431 4d            	tnz	a
2126  0432 26f8          	jrne	L127
2127                     ; 826   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2129  0434 4b02          	push	#2
2130  0436 ae5000        	ldw	x,#20480
2131  0439 cd0000        	call	_GPIO_WriteLow
2133  043c 84            	pop	a
2134                     ; 829   SPI_SendData(WRSR);
2136  043d a601          	ld	a,#1
2137  043f cd0000        	call	_SPI_SendData
2140  0442               L727:
2141                     ; 830   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2143  0442 a602          	ld	a,#2
2144  0444 cd0000        	call	_SPI_GetFlagStatus
2146  0447 4d            	tnz	a
2147  0448 27f8          	jreq	L727
2148                     ; 833   SPI_SendData(data);
2150  044a 7b01          	ld	a,(OFST+1,sp)
2151  044c cd0000        	call	_SPI_SendData
2154  044f               L537:
2155                     ; 834   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2157  044f a602          	ld	a,#2
2158  0451 cd0000        	call	_SPI_GetFlagStatus
2160  0454 4d            	tnz	a
2161  0455 27f8          	jreq	L537
2162                     ; 838     delay_us(1);
2164  0457 ae0001        	ldw	x,#1
2165  045a cd0598        	call	_delay_us
2167                     ; 840   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2169  045d 4b02          	push	#2
2170  045f ae5000        	ldw	x,#20480
2171  0462 cd0000        	call	_GPIO_WriteHigh
2173                     ; 842 }
2176  0465 5b02          	addw	sp,#2
2177  0467 81            	ret	
2235                     ; 851 void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
2235                     ; 852 {
2236                     	switch	.text
2237  0468               _MCP_23K256_RAM_write_byte:
2239  0468 89            	pushw	x
2240  0469 88            	push	a
2241       00000001      OFST:	set	1
2244                     ; 853     uint8_t addr = 0;
2247  046a               L177:
2248                     ; 855   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2250  046a a680          	ld	a,#128
2251  046c cd0000        	call	_SPI_GetFlagStatus
2253  046f 4d            	tnz	a
2254  0470 26f8          	jrne	L177
2255                     ; 857   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2257  0472 4b02          	push	#2
2258  0474 ae5000        	ldw	x,#20480
2259  0477 cd0000        	call	_GPIO_WriteLow
2261  047a 84            	pop	a
2262                     ; 860   SPI_SendData(WRITE); // instruction 2 write
2264  047b a602          	ld	a,#2
2265  047d cd0000        	call	_SPI_SendData
2268  0480               L777:
2269                     ; 861   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2271  0480 a602          	ld	a,#2
2272  0482 cd0000        	call	_SPI_GetFlagStatus
2274  0485 4d            	tnz	a
2275  0486 27f8          	jreq	L777
2276                     ; 864     addr = address>>8;
2278  0488 7b02          	ld	a,(OFST+1,sp)
2279  048a 6b01          	ld	(OFST+0,sp),a
2281                     ; 865   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2283  048c cd0000        	call	_SPI_SendData
2286  048f               L5001:
2287                     ; 866   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2289  048f a602          	ld	a,#2
2290  0491 cd0000        	call	_SPI_GetFlagStatus
2292  0494 4d            	tnz	a
2293  0495 27f8          	jreq	L5001
2294                     ; 869     addr = (address&255);
2296  0497 7b03          	ld	a,(OFST+2,sp)
2297  0499 6b01          	ld	(OFST+0,sp),a
2299                     ; 870   SPI_SendData( addr );
2301  049b cd0000        	call	_SPI_SendData
2304  049e               L3101:
2305                     ; 871   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2307  049e a602          	ld	a,#2
2308  04a0 cd0000        	call	_SPI_GetFlagStatus
2310  04a3 4d            	tnz	a
2311  04a4 27f8          	jreq	L3101
2312                     ; 873   SPI_SendData(value);
2314  04a6 7b06          	ld	a,(OFST+5,sp)
2315  04a8 cd0000        	call	_SPI_SendData
2318  04ab               L1201:
2319                     ; 875   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2321  04ab a602          	ld	a,#2
2322  04ad cd0000        	call	_SPI_GetFlagStatus
2324  04b0 4d            	tnz	a
2325  04b1 27f8          	jreq	L1201
2326                     ; 879     delay_us(1);
2328  04b3 ae0001        	ldw	x,#1
2329  04b6 cd0598        	call	_delay_us
2331                     ; 881   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2333  04b9 4b02          	push	#2
2334  04bb ae5000        	ldw	x,#20480
2335  04be cd0000        	call	_GPIO_WriteHigh
2337  04c1 84            	pop	a
2338                     ; 884 }
2341  04c2 5b03          	addw	sp,#3
2342  04c4 81            	ret	
2402                     ; 891 void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
2402                     ; 892 {
2403                     	switch	.text
2404  04c5               _MCP_23K256_RAM_read_byte:
2406  04c5 89            	pushw	x
2407  04c6 88            	push	a
2408       00000001      OFST:	set	1
2411                     ; 893     uint8_t addr = 0;
2414  04c7               L5501:
2415                     ; 895   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2417  04c7 a680          	ld	a,#128
2418  04c9 cd0000        	call	_SPI_GetFlagStatus
2420  04cc 4d            	tnz	a
2421  04cd 26f8          	jrne	L5501
2422                     ; 897   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2424  04cf 4b02          	push	#2
2425  04d1 ae5000        	ldw	x,#20480
2426  04d4 cd0000        	call	_GPIO_WriteLow
2428  04d7 84            	pop	a
2429                     ; 899   SPI_SendData(READ); // instruction 3 read
2431  04d8 a603          	ld	a,#3
2432  04da cd0000        	call	_SPI_SendData
2435  04dd               L3601:
2436                     ; 901   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2438  04dd a602          	ld	a,#2
2439  04df cd0000        	call	_SPI_GetFlagStatus
2441  04e2 4d            	tnz	a
2442  04e3 27f8          	jreq	L3601
2443                     ; 904     addr = address>>8;
2445  04e5 7b02          	ld	a,(OFST+1,sp)
2446  04e7 6b01          	ld	(OFST+0,sp),a
2448                     ; 905   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2450  04e9 cd0000        	call	_SPI_SendData
2453  04ec               L1701:
2454                     ; 906   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2456  04ec a602          	ld	a,#2
2457  04ee cd0000        	call	_SPI_GetFlagStatus
2459  04f1 4d            	tnz	a
2460  04f2 27f8          	jreq	L1701
2461                     ; 909     addr = (address&255);
2463  04f4 7b03          	ld	a,(OFST+2,sp)
2464  04f6 6b01          	ld	(OFST+0,sp),a
2466                     ; 910   SPI_SendData( addr );
2468  04f8 cd0000        	call	_SPI_SendData
2471  04fb               L7701:
2472                     ; 911   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2474  04fb a602          	ld	a,#2
2475  04fd cd0000        	call	_SPI_GetFlagStatus
2477  0500 4d            	tnz	a
2478  0501 27f8          	jreq	L7701
2480  0503               L5011:
2481                     ; 915 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2483  0503 a601          	ld	a,#1
2484  0505 cd0000        	call	_SPI_GetFlagStatus
2486  0508 4d            	tnz	a
2487  0509 27f8          	jreq	L5011
2488                     ; 916 SPI_SendData( 255 );
2490  050b a6ff          	ld	a,#255
2491  050d cd0000        	call	_SPI_SendData
2494  0510               L3111:
2495                     ; 917 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2497  0510 a602          	ld	a,#2
2498  0512 cd0000        	call	_SPI_GetFlagStatus
2500  0515 4d            	tnz	a
2501  0516 27f8          	jreq	L3111
2503  0518               L1211:
2504                     ; 918 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
2506  0518 a601          	ld	a,#1
2507  051a cd0000        	call	_SPI_GetFlagStatus
2509  051d 4d            	tnz	a
2510  051e 27f8          	jreq	L1211
2511                     ; 921   *value = SPI_ReceiveData();
2513  0520 cd0000        	call	_SPI_ReceiveData
2515  0523 1e06          	ldw	x,(OFST+5,sp)
2516  0525 f7            	ld	(x),a
2517                     ; 928     delay_us(1);
2519  0526 ae0001        	ldw	x,#1
2520  0529 ad6d          	call	_delay_us
2522                     ; 930   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2524  052b 4b02          	push	#2
2525  052d ae5000        	ldw	x,#20480
2526  0530 cd0000        	call	_GPIO_WriteHigh
2528  0533 84            	pop	a
2529                     ; 931 }
2532  0534 5b03          	addw	sp,#3
2533  0536 81            	ret	
2558                     ; 936 void MCP4901_DAC_init(void)
2558                     ; 937 {
2559                     	switch	.text
2560  0537               _MCP4901_DAC_init:
2564                     ; 938   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
2566  0537 4bf0          	push	#240
2567  0539 4b10          	push	#16
2568  053b ae500a        	ldw	x,#20490
2569  053e cd0000        	call	_GPIO_Init
2571  0541 85            	popw	x
2572                     ; 939   delay_ms(10);
2574  0542 ae000a        	ldw	x,#10
2576                     ; 940 }
2579  0545 2068          	jp	_delay_ms
2627                     ; 946 void MCP4901_DAC_write( unsigned char value)
2627                     ; 947 {
2628                     	switch	.text
2629  0547               _MCP4901_DAC_write:
2631  0547 88            	push	a
2632  0548 88            	push	a
2633       00000001      OFST:	set	1
2636                     ; 975     unsigned char address = 0x30; // 00,11,00,00
2638  0549 a630          	ld	a,#48
2639  054b 6b01          	ld	(OFST+0,sp),a
2641                     ; 976     address |= ( value>>4); // assume 0's shoved in the left
2643  054d 7b02          	ld	a,(OFST+1,sp)
2644  054f 4e            	swap	a
2645  0550 a40f          	and	a,#15
2646  0552 1a01          	or	a,(OFST+0,sp)
2647  0554 6b01          	ld	(OFST+0,sp),a
2649                     ; 978     value = ( value<<4 ); // assume 0 shoved in from the right
2651  0556 7b02          	ld	a,(OFST+1,sp)
2652  0558 4e            	swap	a
2653  0559 a4f0          	and	a,#240
2654  055b 6b02          	ld	(OFST+1,sp),a
2656  055d               L1611:
2657                     ; 981   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2659  055d a680          	ld	a,#128
2660  055f cd0000        	call	_SPI_GetFlagStatus
2662  0562 4d            	tnz	a
2663  0563 26f8          	jrne	L1611
2664                     ; 983   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
2666  0565 4b10          	push	#16
2667  0567 ae500a        	ldw	x,#20490
2668  056a cd0000        	call	_GPIO_WriteLow
2670  056d 84            	pop	a
2671                     ; 985   SPI_SendData(address);
2673  056e 7b01          	ld	a,(OFST+0,sp)
2674  0570 cd0000        	call	_SPI_SendData
2677  0573               L7611:
2678                     ; 987   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2680  0573 a602          	ld	a,#2
2681  0575 cd0000        	call	_SPI_GetFlagStatus
2683  0578 4d            	tnz	a
2684  0579 27f8          	jreq	L7611
2685                     ; 989   SPI_SendData(value);
2687  057b 7b02          	ld	a,(OFST+1,sp)
2688  057d cd0000        	call	_SPI_SendData
2691  0580               L5711:
2692                     ; 991   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2694  0580 a602          	ld	a,#2
2695  0582 cd0000        	call	_SPI_GetFlagStatus
2697  0585 4d            	tnz	a
2698  0586 27f8          	jreq	L5711
2699                     ; 995     delay_us(1);
2701  0588 ae0001        	ldw	x,#1
2702  058b ad0b          	call	_delay_us
2704                     ; 1002   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
2706  058d 4b10          	push	#16
2707  058f ae500a        	ldw	x,#20490
2708  0592 cd0000        	call	_GPIO_WriteHigh
2710                     ; 1004 }
2713  0595 5b03          	addw	sp,#3
2714  0597 81            	ret	
2758                     ; 1013 void delay_us(unsigned int  value)
2758                     ; 1014 {
2759                     	switch	.text
2760  0598               _delay_us:
2762  0598 89            	pushw	x
2763       00000002      OFST:	set	2
2766                     ; 1015     register unsigned int loops =  (dly_const * value) ;
2768  0599 cd0000        	call	c_uitof
2770  059c ae0000        	ldw	x,#L7221
2771  059f cd0000        	call	c_fmul
2773  05a2 cd0000        	call	c_ftoi
2776  05a5 2002          	jra	L7321
2777  05a7               L3321:
2778                     ; 1019         _asm ("nop");
2781  05a7 9d            	nop	
2783                     ; 1020         loops--;
2785  05a8 5a            	decw	x
2786  05a9               L7321:
2787  05a9 1f01          	ldw	(OFST-1,sp),x
2789                     ; 1017     while(loops)
2791  05ab 26fa          	jrne	L3321
2792                     ; 1022 }
2796  05ad 85            	popw	x
2797  05ae 81            	ret	
2832                     ; 1024 void delay_ms(unsigned int  value)
2832                     ; 1025 {
2833                     	switch	.text
2834  05af               _delay_ms:
2836  05af 89            	pushw	x
2837       00000000      OFST:	set	0
2840  05b0 200a          	jra	L3621
2841  05b2               L1621:
2842                     ; 1028         delay_us(1000);
2844  05b2 ae03e8        	ldw	x,#1000
2845  05b5 ade1          	call	_delay_us
2847                     ; 1029         value--;
2849  05b7 1e01          	ldw	x,(OFST+1,sp)
2850  05b9 5a            	decw	x
2851  05ba 1f01          	ldw	(OFST+1,sp),x
2852  05bc               L3621:
2853                     ; 1026     while(value)
2855  05bc 1e01          	ldw	x,(OFST+1,sp)
2856  05be 26f2          	jrne	L1621
2857                     ; 1031 }
2861  05c0 85            	popw	x
2862  05c1 81            	ret	
2875                     	xdef	_delay_ms_new
2876                     	xdef	_delay_us_new
2877                     	xdef	_TIM2_setup
2878                     	xdef	_main
2879                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
2880                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
2881                     	xdef	_TEST_adc_to_ram_to_dac
2882                     	xdef	_TEST_adc_to_dac
2883                     	xdef	_TEST_rampfunc_in_ram_to_dac
2884                     	xdef	_TEST_ram_test_001
2885                     	xdef	_delay_ms
2886                     	xdef	_delay_us
2887                     	xdef	_MCP_23K256_write_status_register
2888                     	xdef	_MCP_23K256_read_status_register
2889                     	xdef	_MCP_23K256_RAM_write_byte
2890                     	xdef	_MCP_23K256_RAM_read_byte
2891                     	xdef	_MCP_23K256_init
2892                     	xdef	_MCP4901_DAC_init
2893                     	xdef	_MCP4901_DAC_write
2894                     	xdef	_ADC1_setup
2895                     	xdef	_SPI_setup
2896                     	xdef	_GPIO_setup
2897                     	xdef	_clock_setup
2898                     	xref	_TIM4_ClearFlag
2899                     	xref	_TIM4_GetCounter
2900                     	xref	_TIM4_Cmd
2901                     	xref	_TIM4_TimeBaseInit
2902                     	xref	_TIM4_DeInit
2903                     	xref	_SPI_GetFlagStatus
2904                     	xref	_SPI_ReceiveData
2905                     	xref	_SPI_SendData
2906                     	xref	_SPI_Cmd
2907                     	xref	_SPI_Init
2908                     	xref	_SPI_DeInit
2909                     	xref	_GPIO_WriteLow
2910                     	xref	_GPIO_WriteHigh
2911                     	xref	_GPIO_Init
2912                     	xref	_GPIO_DeInit
2913                     	xref	_CLK_GetFlagStatus
2914                     	xref	_CLK_SYSCLKConfig
2915                     	xref	_CLK_HSIPrescalerConfig
2916                     	xref	_CLK_ClockSwitchConfig
2917                     	xref	_CLK_PeripheralClockConfig
2918                     	xref	_CLK_ClockSwitchCmd
2919                     	xref	_CLK_LSICmd
2920                     	xref	_CLK_HSICmd
2921                     	xref	_CLK_HSECmd
2922                     	xref	_CLK_DeInit
2923                     	xref	_ADC1_ClearFlag
2924                     	xref	_ADC1_GetFlagStatus
2925                     	xref	_ADC1_GetBufferValue
2926                     	xref	_ADC1_GetConversionValue
2927                     	xref	_ADC1_StartConversion
2928                     	xref	_ADC1_ConversionConfig
2929                     	xref	_ADC1_DataBufferCmd
2930                     	xref	_ADC1_ScanModeCmd
2931                     	xref	_ADC1_Cmd
2932                     	xref	_ADC1_Init
2933                     	xref	_ADC1_DeInit
2934                     .const:	section	.text
2935  0000               L7221:
2936  0000 3e000000      	dc.w	15872,0
2937  0004               L772:
2938  0004 3e800000      	dc.w	16000,0
2939                     	xref.b	c_lreg
2940                     	xref.b	c_x
2960                     	xref	c_ftoi
2961                     	xref	c_ftol
2962                     	xref	c_fmul
2963                     	xref	c_uitof
2964                     	end
