   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 144                     ; 135 void main( void )
 144                     ; 136 {
 146                     	switch	.text
 147  0000               _main:
 149  0000 520f          	subw	sp,#15
 150       0000000f      OFST:	set	15
 153                     ; 137     uint16_t adc_leftChannel = 0;
 155                     ; 138     uint16_t adc_feedback    = 0;
 157                     ; 139     uint16_t adc_delay       = 0;
 159                     ; 140     uint8_t  mapd_value      = 0;    // mapped adc valu
 161                     ; 141     uint8_t  read_val        = 0;    // read val from ram
 163  0002 0f08          	clr	(OFST-7,sp)
 165                     ; 142     uint16_t write_addr      = 0;    // write addr in ram
 167  0004 5f            	clrw	x
 168  0005 1f0c          	ldw	(OFST-3,sp),x
 170                     ; 143     uint16_t read_addr       = 0;    // read addr in val
 172  0007 1f09          	ldw	(OFST-6,sp),x
 174                     ; 144     uint16_t delay           = 110;  // length of delay in samples
 176                     ; 145     uint8_t  res             = 0;
 178                     ; 147     clock_setup();
 180  0009 cd026b        	call	_clock_setup
 182                     ; 148     GPIO_setup();
 184  000c cd02cb        	call	_GPIO_setup
 186                     ; 149     ADC1_setup();
 188  000f cd02ee        	call	_ADC1_setup
 190                     ; 150     SPI_setup();
 192  0012 cd032b        	call	_SPI_setup
 194                     ; 151     MCP_23K256_init();
 196  0015 cd0347        	call	_MCP_23K256_init
 198                     ; 152     MCP4901_DAC_init();
 200  0018 cd04b8        	call	_MCP4901_DAC_init
 202  001b               L76:
 203                     ; 186         ADC1_ScanModeCmd( ENABLE );
 205  001b a601          	ld	a,#1
 206  001d cd0000        	call	_ADC1_ScanModeCmd
 208                     ; 187         ADC1_StartConversion( );
 210  0020 cd0000        	call	_ADC1_StartConversion
 213  0023               L57:
 214                     ; 188         while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
 216  0023 a680          	ld	a,#128
 217  0025 cd0000        	call	_ADC1_GetFlagStatus
 219  0028 4d            	tnz	a
 220  0029 27f8          	jreq	L57
 221                     ; 189         ADC1_ClearFlag(ADC1_FLAG_EOC);
 223  002b a680          	ld	a,#128
 224  002d cd0000        	call	_ADC1_ClearFlag
 226                     ; 190         adc_leftChannel = ADC1_GetBufferValue( 0); //ADC_LEFTCHANNEL );     // 0
 228  0030 4f            	clr	a
 229  0031 cd0000        	call	_ADC1_GetBufferValue
 231  0034 1f06          	ldw	(OFST-9,sp),x
 233                     ; 191         adc_delay       = ADC1_GetBufferValue( 1); //ADC_FEEDBACK_AMOUNT ); // 1
 235  0036 a601          	ld	a,#1
 236  0038 cd0000        	call	_ADC1_GetBufferValue
 239                     ; 196         delay = ( adc_delay << 2 ); //(adc_delay >> 2);
 241  003b 58            	sllw	x
 242  003c 58            	sllw	x
 243  003d 1f0e          	ldw	(OFST-1,sp),x
 245                     ; 203         mapd_value = (adc_leftChannel >> 2);
 247  003f 1e06          	ldw	x,(OFST-9,sp)
 248  0041 54            	srlw	x
 249  0042 54            	srlw	x
 250  0043 01            	rrwa	x,a
 251  0044 6b0b          	ld	(OFST-4,sp),a
 253                     ; 206         mapd_value = mapd_value/2 +  read_val/2;
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
 269                     ; 217             read_addr = write_addr - delay;
 271  0058 1e0c          	ldw	x,(OFST-3,sp)
 272  005a 72f00e        	subw	x,(OFST-1,sp)
 273  005d 1f09          	ldw	(OFST-6,sp),x
 275                     ; 221         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 277  005f 88            	push	a
 278  0060 1e0d          	ldw	x,(OFST-2,sp)
 279  0062 cd03e8        	call	_MCP_23K256_RAM_write_byte
 281  0065 84            	pop	a
 282                     ; 224         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 284  0066 96            	ldw	x,sp
 285  0067 1c0008        	addw	x,#OFST-7
 286  006a 89            	pushw	x
 287  006b 1e0b          	ldw	x,(OFST-4,sp)
 288  006d cd0445        	call	_MCP_23K256_RAM_read_byte
 290  0070 85            	popw	x
 291                     ; 227         MCP4901_DAC_write(read_val);
 293  0071 7b08          	ld	a,(OFST-7,sp)
 294  0073 cd04c9        	call	_MCP4901_DAC_write
 296                     ; 230         write_addr++;
 298  0076 1e0c          	ldw	x,(OFST-3,sp)
 299  0078 5c            	incw	x
 300  0079 1f0c          	ldw	(OFST-3,sp),x
 302                     ; 233         delay_us(90);
 304  007b ae005a        	ldw	x,#90
 305  007e cd0000        	call	_delay_us
 308  0081 2098          	jra	L76
 373                     ; 248 uint8_t TEST_ram_test_001(void)
 373                     ; 249 {
 374                     	switch	.text
 375  0083               _TEST_ram_test_001:
 377  0083 5205          	subw	sp,#5
 378       00000005      OFST:	set	5
 381                     ; 250     uint8_t cnt = 0;
 383                     ; 251     uint8_t data = 0;
 386                     ; 252     uint8_t wdata = 0;
 388                     ; 253     uint16_t addr = 0;
 390                     ; 256     data = BYTE_MODE;
 392  0085 0f03          	clr	(OFST-2,sp)
 394                     ; 257     MCP_23K256_write_status_register(data);
 396  0087 4f            	clr	a
 397  0088 cd03ab        	call	_MCP_23K256_write_status_register
 399                     ; 260     MCP_23K256_read_status_register(&data);
 401  008b 96            	ldw	x,sp
 402  008c 1c0003        	addw	x,#OFST-2
 403  008f cd0358        	call	_MCP_23K256_read_status_register
 405                     ; 304 wdata = 2;
 407  0092 a602          	ld	a,#2
 408  0094 6b02          	ld	(OFST-3,sp),a
 410                     ; 305 addr =0;
 412  0096 5f            	clrw	x
 413  0097 1f04          	ldw	(OFST-1,sp),x
 415                     ; 307     MCP_23K256_RAM_write_byte(addr, wdata);
 417  0099 4b02          	push	#2
 418  009b cd03e8        	call	_MCP_23K256_RAM_write_byte
 420  009e 84            	pop	a
 421                     ; 310     MCP_23K256_RAM_read_byte(addr, &data);
 423  009f 96            	ldw	x,sp
 424  00a0 1c0003        	addw	x,#OFST-2
 425  00a3 89            	pushw	x
 426  00a4 1e06          	ldw	x,(OFST+1,sp)
 427  00a6 cd0445        	call	_MCP_23K256_RAM_read_byte
 429  00a9 a6fa          	ld	a,#250
 430  00ab 85            	popw	x
 431                     ; 312     if (wdata != data)
 433                     ; 317 wdata = 250;
 435  00ac 6b02          	ld	(OFST-3,sp),a
 437                     ; 318 addr =1;
 439  00ae ae0001        	ldw	x,#1
 440  00b1 1f04          	ldw	(OFST-1,sp),x
 442                     ; 320     MCP_23K256_RAM_write_byte(addr, wdata);
 444  00b3 4bfa          	push	#250
 445  00b5 cd03e8        	call	_MCP_23K256_RAM_write_byte
 447  00b8 84            	pop	a
 448                     ; 323     MCP_23K256_RAM_read_byte(addr, &data);
 450  00b9 96            	ldw	x,sp
 451  00ba 1c0003        	addw	x,#OFST-2
 452  00bd 89            	pushw	x
 453  00be 1e06          	ldw	x,(OFST+1,sp)
 454  00c0 cd0445        	call	_MCP_23K256_RAM_read_byte
 456  00c3 a604          	ld	a,#4
 457  00c5 85            	popw	x
 458                     ; 325     if (wdata != data)
 460                     ; 330 wdata = 4;
 462  00c6 6b02          	ld	(OFST-3,sp),a
 464                     ; 331 addr =2;
 466  00c8 ae0002        	ldw	x,#2
 467  00cb 1f04          	ldw	(OFST-1,sp),x
 469                     ; 333     MCP_23K256_RAM_write_byte(addr, wdata);
 471  00cd 4b04          	push	#4
 472  00cf cd03e8        	call	_MCP_23K256_RAM_write_byte
 474  00d2 84            	pop	a
 475                     ; 336     MCP_23K256_RAM_read_byte(addr, &data);
 477  00d3 96            	ldw	x,sp
 478  00d4 1c0003        	addw	x,#OFST-2
 479  00d7 89            	pushw	x
 480  00d8 1e06          	ldw	x,(OFST+1,sp)
 481  00da cd0445        	call	_MCP_23K256_RAM_read_byte
 483  00dd 85            	popw	x
 484                     ; 338     if (wdata != data)
 486                     ; 344     for(addr = 0; addr<3; addr++)
 488  00de 5f            	clrw	x
 489  00df 1f04          	ldw	(OFST-1,sp),x
 491  00e1               L141:
 492                     ; 346         MCP_23K256_RAM_read_byte(addr, &data);
 494  00e1 96            	ldw	x,sp
 495  00e2 1c0003        	addw	x,#OFST-2
 496  00e5 89            	pushw	x
 497  00e6 1e06          	ldw	x,(OFST+1,sp)
 498  00e8 cd0445        	call	_MCP_23K256_RAM_read_byte
 500  00eb 85            	popw	x
 501                     ; 344     for(addr = 0; addr<3; addr++)
 503  00ec 1e04          	ldw	x,(OFST-1,sp)
 504  00ee 5c            	incw	x
 505  00ef 1f04          	ldw	(OFST-1,sp),x
 509  00f1 a30003        	cpw	x,#3
 510  00f4 25eb          	jrult	L141
 511                     ; 348     return 0;
 513  00f6 4f            	clr	a
 516  00f7 5b05          	addw	sp,#5
 517  00f9 81            	ret	
 574                     ; 355 uint8_t TEST_rampfunc_in_ram_to_dac(void)
 574                     ; 356 {
 575                     	switch	.text
 576  00fa               _TEST_rampfunc_in_ram_to_dac:
 578  00fa 5204          	subw	sp,#4
 579       00000004      OFST:	set	4
 582                     ; 357     uint8_t data = 0;
 584  00fc 0f02          	clr	(OFST-2,sp)
 586                     ; 358     uint8_t wdata = 0;
 588  00fe 0f01          	clr	(OFST-3,sp)
 590                     ; 359     uint16_t addr = 0;
 592                     ; 362     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 594  0100 5f            	clrw	x
 595  0101 1f03          	ldw	(OFST-1,sp),x
 597  0103 7b01          	ld	a,(OFST-3,sp)
 598  0105               L571:
 599                     ; 364         MCP_23K256_RAM_write_byte(addr, wdata);
 601  0105 88            	push	a
 602  0106 1e04          	ldw	x,(OFST+0,sp)
 603  0108 cd03e8        	call	_MCP_23K256_RAM_write_byte
 605  010b 84            	pop	a
 606                     ; 362     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 608  010c 1e03          	ldw	x,(OFST-1,sp)
 609  010e 5c            	incw	x
 610  010f 1f03          	ldw	(OFST-1,sp),x
 612  0111 7b01          	ld	a,(OFST-3,sp)
 613  0113 ab04          	add	a,#4
 614  0115 6b01          	ld	(OFST-3,sp),a
 618  0117 a300ff        	cpw	x,#255
 619  011a 25e9          	jrult	L571
 620  011c               L302:
 621                     ; 370         for(addr = 0; addr<255; addr++)
 623  011c 5f            	clrw	x
 624  011d 1f03          	ldw	(OFST-1,sp),x
 626  011f               L702:
 627                     ; 372             MCP_23K256_RAM_read_byte(addr, &data);
 629  011f 96            	ldw	x,sp
 630  0120 1c0002        	addw	x,#OFST-2
 631  0123 89            	pushw	x
 632  0124 1e05          	ldw	x,(OFST+1,sp)
 633  0126 cd0445        	call	_MCP_23K256_RAM_read_byte
 635  0129 85            	popw	x
 636                     ; 373             MCP4901_DAC_write(data);
 638  012a 7b02          	ld	a,(OFST-2,sp)
 639  012c cd04c9        	call	_MCP4901_DAC_write
 641                     ; 374             delay_us(90);   //11kHz sample rate // phasor == frequ
 643  012f ae005a        	ldw	x,#90
 644  0132 cd0000        	call	_delay_us
 646                     ; 370         for(addr = 0; addr<255; addr++)
 648  0135 1e03          	ldw	x,(OFST-1,sp)
 649  0137 5c            	incw	x
 650  0138 1f03          	ldw	(OFST-1,sp),x
 654  013a a300ff        	cpw	x,#255
 655  013d 25e0          	jrult	L702
 657  013f 20db          	jra	L302
 692                     ; 382 void TEST_adc_to_dac(uint8_t *x)
 692                     ; 383 {
 693                     	switch	.text
 694  0141               _TEST_adc_to_dac:
 698                     ; 407 }
 701  0141 81            	ret	
 762                     ; 410 void TEST_adc_to_ram_to_dac(void)
 762                     ; 411 {
 763                     	switch	.text
 764  0142               _TEST_adc_to_ram_to_dac:
 766  0142 5205          	subw	sp,#5
 767       00000005      OFST:	set	5
 770                     ; 412     uint16_t adc_val = 0;
 772                     ; 413     uint16_t addr = 0;
 774  0144 5f            	clrw	x
 775  0145 1f03          	ldw	(OFST-2,sp),x
 777                     ; 414     uint8_t mapd_value = 0;
 779  0147 0f05          	clr	(OFST+0,sp)
 781  0149               L162:
 782                     ; 419         ADC1_StartConversion();
 784  0149 cd0000        	call	_ADC1_StartConversion
 787  014c               L762:
 788                     ; 420         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 790  014c a680          	ld	a,#128
 791  014e cd0000        	call	_ADC1_GetFlagStatus
 793  0151 4d            	tnz	a
 794  0152 27f8          	jreq	L762
 795                     ; 422         adc_val = ADC1_GetConversionValue(); // for led knob
 797  0154 cd0000        	call	_ADC1_GetConversionValue
 799  0157 1f01          	ldw	(OFST-4,sp),x
 801                     ; 423         ADC1_ClearFlag(ADC1_FLAG_EOC);
 803  0159 a680          	ld	a,#128
 804  015b cd0000        	call	_ADC1_ClearFlag
 806                     ; 430         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 808  015e 1e01          	ldw	x,(OFST-4,sp)
 809  0160 cd0000        	call	c_uitof
 811  0163 ae0000        	ldw	x,#L772
 812  0166 cd0000        	call	c_fmul
 814  0169 cd0000        	call	c_ftol
 816  016c b603          	ld	a,c_lreg+3
 817  016e 6b05          	ld	(OFST+0,sp),a
 819                     ; 433         MCP_23K256_RAM_write_byte(addr, mapd_value);
 821  0170 88            	push	a
 822  0171 1e04          	ldw	x,(OFST-1,sp)
 823  0173 cd03e8        	call	_MCP_23K256_RAM_write_byte
 825  0176 84            	pop	a
 826                     ; 436         mapd_value = 0; // check value
 828  0177 0f05          	clr	(OFST+0,sp)
 830                     ; 437         MCP_23K256_RAM_read_byte(addr, &mapd_value);
 832  0179 96            	ldw	x,sp
 833  017a 1c0005        	addw	x,#OFST+0
 834  017d 89            	pushw	x
 835  017e 1e05          	ldw	x,(OFST+0,sp)
 836  0180 cd0445        	call	_MCP_23K256_RAM_read_byte
 838  0183 85            	popw	x
 839                     ; 440         addr++;
 841  0184 1e03          	ldw	x,(OFST-2,sp)
 842  0186 5c            	incw	x
 843  0187 1f03          	ldw	(OFST-2,sp),x
 845                     ; 442         MCP4901_DAC_write(mapd_value);
 847  0189 7b05          	ld	a,(OFST+0,sp)
 848  018b cd04c9        	call	_MCP4901_DAC_write
 850                     ; 445         delay_us(90);
 852  018e ae005a        	ldw	x,#90
 853  0191 cd0000        	call	_delay_us
 856  0194 20b3          	jra	L162
 953                     ; 452 void TEST_adc_to_ram_to_dac_with_delay(void)
 953                     ; 453 {
 954                     	switch	.text
 955  0196               _TEST_adc_to_ram_to_dac_with_delay:
 957  0196 520b          	subw	sp,#11
 958       0000000b      OFST:	set	11
 961                     ; 454     uint16_t adc_val = 0;
 963                     ; 455     uint8_t mapd_value = 0; // mapped adc valu
 965                     ; 456     uint8_t read_val = 0;   //read val from ram
 967  0198 0f05          	clr	(OFST-6,sp)
 969                     ; 457     uint16_t write_addr = 0;    //write addr in ram
 971  019a 5f            	clrw	x
 972  019b 1f0a          	ldw	(OFST-1,sp),x
 974                     ; 458     uint16_t read_addr = 0; // read addr in val
 976  019d 1f06          	ldw	(OFST-5,sp),x
 978                     ; 459     uint16_t delay = 110; // length of delay in samples
 980  019f ae006e        	ldw	x,#110
 981  01a2 1f08          	ldw	(OFST-3,sp),x
 983                     ; 460     uint8_t res = 0;
 985  01a4               L153:
 986                     ; 466         ADC1_StartConversion();
 988  01a4 cd0000        	call	_ADC1_StartConversion
 991  01a7               L753:
 992                     ; 467         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 994  01a7 a680          	ld	a,#128
 995  01a9 cd0000        	call	_ADC1_GetFlagStatus
 997  01ac 4d            	tnz	a
 998  01ad 27f8          	jreq	L753
 999                     ; 469         adc_val = ADC1_GetConversionValue(); // for led knob
1001  01af cd0000        	call	_ADC1_GetConversionValue
1003  01b2 1f02          	ldw	(OFST-9,sp),x
1005                     ; 470         ADC1_ClearFlag(ADC1_FLAG_EOC);
1007  01b4 a680          	ld	a,#128
1008  01b6 cd0000        	call	_ADC1_ClearFlag
1010                     ; 477         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
1012  01b9 1e02          	ldw	x,(OFST-9,sp)
1013  01bb cd0000        	call	c_uitof
1015  01be ae0000        	ldw	x,#L772
1016  01c1 cd0000        	call	c_fmul
1018  01c4 cd0000        	call	c_ftol
1020  01c7 b603          	ld	a,c_lreg+3
1021  01c9 6b04          	ld	(OFST-7,sp),a
1023                     ; 488             read_addr = write_addr - delay;
1025  01cb 1e0a          	ldw	x,(OFST-1,sp)
1026  01cd 72f008        	subw	x,(OFST-3,sp)
1027  01d0 1f06          	ldw	(OFST-5,sp),x
1029                     ; 492         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1031  01d2 88            	push	a
1032  01d3 1e0b          	ldw	x,(OFST+0,sp)
1033  01d5 cd03e8        	call	_MCP_23K256_RAM_write_byte
1035  01d8 84            	pop	a
1036                     ; 495         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1038  01d9 96            	ldw	x,sp
1039  01da 1c0005        	addw	x,#OFST-6
1040  01dd 89            	pushw	x
1041  01de 1e08          	ldw	x,(OFST-3,sp)
1042  01e0 cd0445        	call	_MCP_23K256_RAM_read_byte
1044  01e3 85            	popw	x
1045                     ; 498         MCP4901_DAC_write(read_val);
1047  01e4 7b05          	ld	a,(OFST-6,sp)
1048  01e6 cd04c9        	call	_MCP4901_DAC_write
1050                     ; 501         write_addr++;
1052  01e9 1e0a          	ldw	x,(OFST-1,sp)
1053  01eb 5c            	incw	x
1054  01ec 1f0a          	ldw	(OFST-1,sp),x
1056                     ; 504         delay_us(90);
1058  01ee ae005a        	ldw	x,#90
1059  01f1 cd0000        	call	_delay_us
1062  01f4 20ae          	jra	L153
1170                     ; 512 void TEST_adc_to_ram_to_dac_with_with_fback(void)
1170                     ; 513 {
1171                     	switch	.text
1172  01f6               _TEST_adc_to_ram_to_dac_with_with_fback:
1174  01f6 520d          	subw	sp,#13
1175       0000000d      OFST:	set	13
1178                     ; 515     uint16_t adc0_val = 0;  //er are these 8 or 16 big?
1180                     ; 516     uint16_t adc1_val = 0;
1182                     ; 517     uint8_t mapd_value = 0; // mapped adc valu
1184                     ; 518     uint8_t read_val = 0;   //read val from ram
1186  01f8 0f06          	clr	(OFST-7,sp)
1188                     ; 519     uint16_t write_addr = 0;    //write addr in ram
1190  01fa 5f            	clrw	x
1191  01fb 1f0a          	ldw	(OFST-3,sp),x
1193                     ; 520     uint16_t read_addr = 0; // read addr in val
1195  01fd 1f07          	ldw	(OFST-6,sp),x
1197                     ; 521     uint16_t delay = 110; // length of delay in samples
1199                     ; 522     uint8_t res = 0;
1201  01ff               L534:
1202                     ; 537     ADC1_ScanModeCmd(ENABLE);
1204  01ff a601          	ld	a,#1
1205  0201 cd0000        	call	_ADC1_ScanModeCmd
1207                     ; 538     ADC1_StartConversion();
1209  0204 cd0000        	call	_ADC1_StartConversion
1212  0207               L344:
1213                     ; 539     while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1215  0207 a680          	ld	a,#128
1216  0209 cd0000        	call	_ADC1_GetFlagStatus
1218  020c 4d            	tnz	a
1219  020d 27f8          	jreq	L344
1220                     ; 541     adc0_val = ADC1_GetBufferValue(0);
1222  020f 4f            	clr	a
1223  0210 cd0000        	call	_ADC1_GetBufferValue
1225  0213 1f04          	ldw	(OFST-9,sp),x
1227                     ; 542     adc1_val = ADC1_GetBufferValue(1);
1229  0215 a601          	ld	a,#1
1230  0217 cd0000        	call	_ADC1_GetBufferValue
1232  021a 1f0c          	ldw	(OFST-1,sp),x
1234                     ; 543     ADC1_ClearFlag(ADC1_FLAG_EOC);
1236  021c a680          	ld	a,#128
1237  021e cd0000        	call	_ADC1_ClearFlag
1239                     ; 546     delay = (adc1_val>>2);
1241  0221 1e0c          	ldw	x,(OFST-1,sp)
1242  0223 54            	srlw	x
1243  0224 54            	srlw	x
1244  0225 1f0c          	ldw	(OFST-1,sp),x
1246                     ; 556         mapd_value = (adc0_val>>2) ; // do i need the float or not ??? -No use a lft shift
1248  0227 1e04          	ldw	x,(OFST-9,sp)
1249  0229 54            	srlw	x
1250  022a 54            	srlw	x
1251  022b 01            	rrwa	x,a
1252  022c 6b09          	ld	(OFST-4,sp),a
1254                     ; 561         mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
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
1270                     ; 572             read_addr = write_addr - delay;
1272  0240 1e0a          	ldw	x,(OFST-3,sp)
1273  0242 72f00c        	subw	x,(OFST-1,sp)
1274  0245 1f07          	ldw	(OFST-6,sp),x
1276                     ; 576         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1278  0247 88            	push	a
1279  0248 1e0b          	ldw	x,(OFST-2,sp)
1280  024a cd03e8        	call	_MCP_23K256_RAM_write_byte
1282  024d 84            	pop	a
1283                     ; 579         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1285  024e 96            	ldw	x,sp
1286  024f 1c0006        	addw	x,#OFST-7
1287  0252 89            	pushw	x
1288  0253 1e09          	ldw	x,(OFST-4,sp)
1289  0255 cd0445        	call	_MCP_23K256_RAM_read_byte
1291  0258 85            	popw	x
1292                     ; 582         MCP4901_DAC_write(read_val);
1294  0259 7b06          	ld	a,(OFST-7,sp)
1295  025b cd04c9        	call	_MCP4901_DAC_write
1297                     ; 585         write_addr++;
1299  025e 1e0a          	ldw	x,(OFST-3,sp)
1300  0260 5c            	incw	x
1301  0261 1f0a          	ldw	(OFST-3,sp),x
1303                     ; 588         delay_us(90);
1305  0263 ae005a        	ldw	x,#90
1306  0266 cd0000        	call	_delay_us
1309  0269 2094          	jra	L534
1342                     ; 594 void clock_setup(void)
1342                     ; 595 {
1343                     	switch	.text
1344  026b               _clock_setup:
1348                     ; 596   CLK_DeInit();
1350  026b cd0000        	call	_CLK_DeInit
1352                     ; 598   CLK_HSECmd(DISABLE);
1354  026e 4f            	clr	a
1355  026f cd0000        	call	_CLK_HSECmd
1357                     ; 599   CLK_LSICmd(DISABLE);
1359  0272 4f            	clr	a
1360  0273 cd0000        	call	_CLK_LSICmd
1362                     ; 600   CLK_HSICmd(ENABLE);
1364  0276 a601          	ld	a,#1
1365  0278 cd0000        	call	_CLK_HSICmd
1368  027b               L164:
1369                     ; 601   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
1371  027b ae0102        	ldw	x,#258
1372  027e cd0000        	call	_CLK_GetFlagStatus
1374  0281 4d            	tnz	a
1375  0282 27f7          	jreq	L164
1376                     ; 603   CLK_ClockSwitchCmd(ENABLE);
1378  0284 a601          	ld	a,#1
1379  0286 cd0000        	call	_CLK_ClockSwitchCmd
1381                     ; 604   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1383  0289 4f            	clr	a
1384  028a cd0000        	call	_CLK_HSIPrescalerConfig
1386                     ; 605   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
1388  028d a680          	ld	a,#128
1389  028f cd0000        	call	_CLK_SYSCLKConfig
1391                     ; 607   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
1393  0292 4b01          	push	#1
1394  0294 4b00          	push	#0
1395  0296 ae01e1        	ldw	x,#481
1396  0299 cd0000        	call	_CLK_ClockSwitchConfig
1398  029c 85            	popw	x
1399                     ; 609   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
1401  029d 5f            	clrw	x
1402  029e cd0000        	call	_CLK_PeripheralClockConfig
1404                     ; 610   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
1406  02a1 ae0101        	ldw	x,#257
1407  02a4 cd0000        	call	_CLK_PeripheralClockConfig
1409                     ; 611   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
1411  02a7 ae0300        	ldw	x,#768
1412  02aa cd0000        	call	_CLK_PeripheralClockConfig
1414                     ; 612   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
1416  02ad ae1200        	ldw	x,#4608
1417  02b0 cd0000        	call	_CLK_PeripheralClockConfig
1419                     ; 613   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
1421  02b3 ae1301        	ldw	x,#4865
1422  02b6 cd0000        	call	_CLK_PeripheralClockConfig
1424                     ; 614   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
1426  02b9 ae0700        	ldw	x,#1792
1427  02bc cd0000        	call	_CLK_PeripheralClockConfig
1429                     ; 615   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
1431  02bf ae0501        	ldw	x,#1281
1432  02c2 cd0000        	call	_CLK_PeripheralClockConfig
1434                     ; 616   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
1436  02c5 ae0400        	ldw	x,#1024
1438                     ; 618 }
1441  02c8 cc0000        	jp	_CLK_PeripheralClockConfig
1466                     ; 620 void GPIO_setup(void)
1466                     ; 621 {
1467                     	switch	.text
1468  02cb               _GPIO_setup:
1472                     ; 622   GPIO_DeInit(GPIOC);
1474  02cb ae500a        	ldw	x,#20490
1475  02ce cd0000        	call	_GPIO_DeInit
1477                     ; 627     GPIO_DeInit(ADC_port);
1479  02d1 ae5005        	ldw	x,#20485
1480  02d4 cd0000        	call	_GPIO_DeInit
1482                     ; 633     GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
1484  02d7 4b00          	push	#0
1485  02d9 4b0f          	push	#15
1486  02db ae5005        	ldw	x,#20485
1487  02de cd0000        	call	_GPIO_Init
1489  02e1 85            	popw	x
1490                     ; 638     GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ),
1490                     ; 639                GPIO_MODE_OUT_PP_HIGH_FAST);
1492  02e2 4bf0          	push	#240
1493  02e4 4b60          	push	#96
1494  02e6 ae500a        	ldw	x,#20490
1495  02e9 cd0000        	call	_GPIO_Init
1497  02ec 85            	popw	x
1498                     ; 640 }
1501  02ed 81            	ret	
1529                     ; 668 void ADC1_setup(void)
1529                     ; 669 {
1530                     	switch	.text
1531  02ee               _ADC1_setup:
1535                     ; 670   ADC1_DeInit();
1537  02ee cd0000        	call	_ADC1_DeInit
1539                     ; 672   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
1539                     ; 673   ADC1_CHANNEL_0,\
1539                     ; 674   ADC1_PRESSEL_FCPU_D18, \
1539                     ; 675   ADC1_EXTTRIG_GPIO, \
1539                     ; 676   DISABLE, \
1539                     ; 677   ADC1_ALIGN_RIGHT, \
1539                     ; 678   ADC1_SCHMITTTRIG_CHANNEL0, \
1539                     ; 679   DISABLE);
1541  02f1 4b00          	push	#0
1542  02f3 4b00          	push	#0
1543  02f5 4b08          	push	#8
1544  02f7 4b00          	push	#0
1545  02f9 4b10          	push	#16
1546  02fb 4b70          	push	#112
1547  02fd 5f            	clrw	x
1548  02fe cd0000        	call	_ADC1_Init
1550  0301 5b06          	addw	sp,#6
1551                     ; 681   ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
1551                     ; 682   ADC1_CHANNEL_1,\
1551                     ; 683   ADC1_PRESSEL_FCPU_D18, \
1551                     ; 684   ADC1_EXTTRIG_GPIO, \
1551                     ; 685   DISABLE, \
1551                     ; 686   ADC1_ALIGN_RIGHT, \
1551                     ; 687   ADC1_SCHMITTTRIG_CHANNEL1, \
1551                     ; 688   DISABLE);
1553  0303 4b00          	push	#0
1554  0305 4b01          	push	#1
1555  0307 4b08          	push	#8
1556  0309 4b00          	push	#0
1557  030b 4b10          	push	#16
1558  030d 4b70          	push	#112
1559  030f ae0001        	ldw	x,#1
1560  0312 cd0000        	call	_ADC1_Init
1562  0315 5b06          	addw	sp,#6
1563                     ; 690   ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);
1565  0317 4b08          	push	#8
1566  0319 ae0001        	ldw	x,#1
1567  031c cd0000        	call	_ADC1_ConversionConfig
1569  031f 84            	pop	a
1570                     ; 692   ADC1_DataBufferCmd(ENABLE);
1572  0320 a601          	ld	a,#1
1573  0322 cd0000        	call	_ADC1_DataBufferCmd
1575                     ; 693   ADC1_Cmd(ENABLE);
1577  0325 a601          	ld	a,#1
1579                     ; 695 }
1582  0327 cc0000        	jp	_ADC1_Cmd
1605                     ; 700 void TIM2_setup(void)
1605                     ; 701 {
1606                     	switch	.text
1607  032a               _TIM2_setup:
1611                     ; 713 }
1614  032a 81            	ret	
1640                     ; 718 void SPI_setup(void)
1640                     ; 719 {
1641                     	switch	.text
1642  032b               _SPI_setup:
1646                     ; 720   SPI_DeInit();
1648  032b cd0000        	call	_SPI_DeInit
1650                     ; 725   SPI_Init(SPI_FIRSTBIT_MSB, \
1650                     ; 726     SPI_BAUDRATEPRESCALER_16, \
1650                     ; 727     SPI_MODE_MASTER, \
1650                     ; 728     SPI_CLOCKPOLARITY_LOW, \
1650                     ; 729     SPI_CLOCKPHASE_1EDGE, \
1650                     ; 730     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
1650                     ; 731     SPI_NSS_SOFT, \
1650                     ; 732     0x0);
1652  032e 4b00          	push	#0
1653  0330 4b02          	push	#2
1654  0332 4b00          	push	#0
1655  0334 4b00          	push	#0
1656  0336 4b00          	push	#0
1657  0338 4b04          	push	#4
1658  033a ae0018        	ldw	x,#24
1659  033d cd0000        	call	_SPI_Init
1661  0340 5b06          	addw	sp,#6
1662                     ; 734   SPI_Cmd(ENABLE);
1664  0342 a601          	ld	a,#1
1666                     ; 735 }
1669  0344 cc0000        	jp	_SPI_Cmd
1694                     ; 737 void MCP_23K256_init()
1694                     ; 738 {
1695                     	switch	.text
1696  0347               _MCP_23K256_init:
1700                     ; 739     GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
1702  0347 4bf0          	push	#240
1703  0349 4b02          	push	#2
1704  034b ae5000        	ldw	x,#20480
1705  034e cd0000        	call	_GPIO_Init
1707  0351 85            	popw	x
1708                     ; 740   delay_ms(10);
1710  0352 ae000a        	ldw	x,#10
1712                     ; 741 }
1715  0355 cc0000        	jp	_delay_ms
1757                     ; 746 void MCP_23K256_read_status_register(uint8_t *data)
1757                     ; 747 {
1758                     	switch	.text
1759  0358               _MCP_23K256_read_status_register:
1761  0358 89            	pushw	x
1762       00000000      OFST:	set	0
1765  0359               L555:
1766                     ; 749   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1768  0359 a680          	ld	a,#128
1769  035b cd0000        	call	_SPI_GetFlagStatus
1771  035e 4d            	tnz	a
1772  035f 26f8          	jrne	L555
1773                     ; 751   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1775  0361 4b02          	push	#2
1776  0363 ae5000        	ldw	x,#20480
1777  0366 cd0000        	call	_GPIO_WriteLow
1779  0369 84            	pop	a
1780                     ; 753   SPI_SendData(RDSR); // read ststus reg
1782  036a a605          	ld	a,#5
1783  036c cd0000        	call	_SPI_SendData
1786  036f               L365:
1787                     ; 755   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1789  036f a602          	ld	a,#2
1790  0371 cd0000        	call	_SPI_GetFlagStatus
1792  0374 4d            	tnz	a
1793  0375 27f8          	jreq	L365
1795  0377               L175:
1796                     ; 758 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
1798  0377 a601          	ld	a,#1
1799  0379 cd0000        	call	_SPI_GetFlagStatus
1801  037c 4d            	tnz	a
1802  037d 27f8          	jreq	L175
1803                     ; 759 SPI_SendData( 255 );
1805  037f a6ff          	ld	a,#255
1806  0381 cd0000        	call	_SPI_SendData
1809  0384               L775:
1810                     ; 760 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1812  0384 a602          	ld	a,#2
1813  0386 cd0000        	call	_SPI_GetFlagStatus
1815  0389 4d            	tnz	a
1816  038a 27f8          	jreq	L775
1817                     ; 762   *data = SPI_ReceiveData();
1819  038c cd0000        	call	_SPI_ReceiveData
1821  038f 1e01          	ldw	x,(OFST+1,sp)
1822  0391 f7            	ld	(x),a
1824  0392               L706:
1825                     ; 764   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
1827  0392 a601          	ld	a,#1
1828  0394 cd0000        	call	_SPI_GetFlagStatus
1830  0397 4d            	tnz	a
1831  0398 27f8          	jreq	L706
1832                     ; 768     delay_us(1);
1834  039a ae0001        	ldw	x,#1
1835  039d cd0000        	call	_delay_us
1837                     ; 770   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1839  03a0 4b02          	push	#2
1840  03a2 ae5000        	ldw	x,#20480
1841  03a5 cd0000        	call	_GPIO_WriteHigh
1843                     ; 771 }
1846  03a8 5b03          	addw	sp,#3
1847  03aa 81            	ret	
1887                     ; 780 void MCP_23K256_write_status_register(uint8_t data)
1887                     ; 781 {
1888                     	switch	.text
1889  03ab               _MCP_23K256_write_status_register:
1891  03ab 88            	push	a
1892       00000000      OFST:	set	0
1895  03ac               L336:
1896                     ; 783   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1898  03ac a680          	ld	a,#128
1899  03ae cd0000        	call	_SPI_GetFlagStatus
1901  03b1 4d            	tnz	a
1902  03b2 26f8          	jrne	L336
1903                     ; 785   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1905  03b4 4b02          	push	#2
1906  03b6 ae5000        	ldw	x,#20480
1907  03b9 cd0000        	call	_GPIO_WriteLow
1909  03bc 84            	pop	a
1910                     ; 788   SPI_SendData(WRSR);
1912  03bd a601          	ld	a,#1
1913  03bf cd0000        	call	_SPI_SendData
1916  03c2               L146:
1917                     ; 789   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1919  03c2 a602          	ld	a,#2
1920  03c4 cd0000        	call	_SPI_GetFlagStatus
1922  03c7 4d            	tnz	a
1923  03c8 27f8          	jreq	L146
1924                     ; 792   SPI_SendData(data);
1926  03ca 7b01          	ld	a,(OFST+1,sp)
1927  03cc cd0000        	call	_SPI_SendData
1930  03cf               L746:
1931                     ; 793   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1933  03cf a602          	ld	a,#2
1934  03d1 cd0000        	call	_SPI_GetFlagStatus
1936  03d4 4d            	tnz	a
1937  03d5 27f8          	jreq	L746
1938                     ; 797     delay_us(1);
1940  03d7 ae0001        	ldw	x,#1
1941  03da cd0000        	call	_delay_us
1943                     ; 799   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1945  03dd 4b02          	push	#2
1946  03df ae5000        	ldw	x,#20480
1947  03e2 cd0000        	call	_GPIO_WriteHigh
1949                     ; 801 }
1952  03e5 5b02          	addw	sp,#2
1953  03e7 81            	ret	
2011                     ; 810 void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
2011                     ; 811 {
2012                     	switch	.text
2013  03e8               _MCP_23K256_RAM_write_byte:
2015  03e8 89            	pushw	x
2016  03e9 88            	push	a
2017       00000001      OFST:	set	1
2020                     ; 812     uint8_t addr = 0;
2023  03ea               L307:
2024                     ; 814   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2026  03ea a680          	ld	a,#128
2027  03ec cd0000        	call	_SPI_GetFlagStatus
2029  03ef 4d            	tnz	a
2030  03f0 26f8          	jrne	L307
2031                     ; 816   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2033  03f2 4b02          	push	#2
2034  03f4 ae5000        	ldw	x,#20480
2035  03f7 cd0000        	call	_GPIO_WriteLow
2037  03fa 84            	pop	a
2038                     ; 819   SPI_SendData(WRITE); // instruction 2 write
2040  03fb a602          	ld	a,#2
2041  03fd cd0000        	call	_SPI_SendData
2044  0400               L117:
2045                     ; 820   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2047  0400 a602          	ld	a,#2
2048  0402 cd0000        	call	_SPI_GetFlagStatus
2050  0405 4d            	tnz	a
2051  0406 27f8          	jreq	L117
2052                     ; 823     addr = address>>8;
2054  0408 7b02          	ld	a,(OFST+1,sp)
2055  040a 6b01          	ld	(OFST+0,sp),a
2057                     ; 824   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2059  040c cd0000        	call	_SPI_SendData
2062  040f               L717:
2063                     ; 825   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2065  040f a602          	ld	a,#2
2066  0411 cd0000        	call	_SPI_GetFlagStatus
2068  0414 4d            	tnz	a
2069  0415 27f8          	jreq	L717
2070                     ; 828     addr = (address&255);
2072  0417 7b03          	ld	a,(OFST+2,sp)
2073  0419 6b01          	ld	(OFST+0,sp),a
2075                     ; 829   SPI_SendData( addr );
2077  041b cd0000        	call	_SPI_SendData
2080  041e               L527:
2081                     ; 830   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2083  041e a602          	ld	a,#2
2084  0420 cd0000        	call	_SPI_GetFlagStatus
2086  0423 4d            	tnz	a
2087  0424 27f8          	jreq	L527
2088                     ; 832   SPI_SendData(value);
2090  0426 7b06          	ld	a,(OFST+5,sp)
2091  0428 cd0000        	call	_SPI_SendData
2094  042b               L337:
2095                     ; 834   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2097  042b a602          	ld	a,#2
2098  042d cd0000        	call	_SPI_GetFlagStatus
2100  0430 4d            	tnz	a
2101  0431 27f8          	jreq	L337
2102                     ; 838     delay_us(1);
2104  0433 ae0001        	ldw	x,#1
2105  0436 cd0000        	call	_delay_us
2107                     ; 840   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2109  0439 4b02          	push	#2
2110  043b ae5000        	ldw	x,#20480
2111  043e cd0000        	call	_GPIO_WriteHigh
2113  0441 84            	pop	a
2114                     ; 843 }
2117  0442 5b03          	addw	sp,#3
2118  0444 81            	ret	
2178                     ; 850 void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
2178                     ; 851 {
2179                     	switch	.text
2180  0445               _MCP_23K256_RAM_read_byte:
2182  0445 89            	pushw	x
2183  0446 88            	push	a
2184       00000001      OFST:	set	1
2187                     ; 852     uint8_t addr = 0;
2190  0447               L767:
2191                     ; 854   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2193  0447 a680          	ld	a,#128
2194  0449 cd0000        	call	_SPI_GetFlagStatus
2196  044c 4d            	tnz	a
2197  044d 26f8          	jrne	L767
2198                     ; 856   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2200  044f 4b02          	push	#2
2201  0451 ae5000        	ldw	x,#20480
2202  0454 cd0000        	call	_GPIO_WriteLow
2204  0457 84            	pop	a
2205                     ; 858   SPI_SendData(READ); // instruction 3 read
2207  0458 a603          	ld	a,#3
2208  045a cd0000        	call	_SPI_SendData
2211  045d               L577:
2212                     ; 860   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2214  045d a602          	ld	a,#2
2215  045f cd0000        	call	_SPI_GetFlagStatus
2217  0462 4d            	tnz	a
2218  0463 27f8          	jreq	L577
2219                     ; 863     addr = address>>8;
2221  0465 7b02          	ld	a,(OFST+1,sp)
2222  0467 6b01          	ld	(OFST+0,sp),a
2224                     ; 864   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2226  0469 cd0000        	call	_SPI_SendData
2229  046c               L3001:
2230                     ; 865   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2232  046c a602          	ld	a,#2
2233  046e cd0000        	call	_SPI_GetFlagStatus
2235  0471 4d            	tnz	a
2236  0472 27f8          	jreq	L3001
2237                     ; 868     addr = (address&255);
2239  0474 7b03          	ld	a,(OFST+2,sp)
2240  0476 6b01          	ld	(OFST+0,sp),a
2242                     ; 869   SPI_SendData( addr );
2244  0478 cd0000        	call	_SPI_SendData
2247  047b               L1101:
2248                     ; 870   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2250  047b a602          	ld	a,#2
2251  047d cd0000        	call	_SPI_GetFlagStatus
2253  0480 4d            	tnz	a
2254  0481 27f8          	jreq	L1101
2256  0483               L7101:
2257                     ; 874 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2259  0483 a601          	ld	a,#1
2260  0485 cd0000        	call	_SPI_GetFlagStatus
2262  0488 4d            	tnz	a
2263  0489 27f8          	jreq	L7101
2264                     ; 875 SPI_SendData( 255 );
2266  048b a6ff          	ld	a,#255
2267  048d cd0000        	call	_SPI_SendData
2270  0490               L5201:
2271                     ; 876 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2273  0490 a602          	ld	a,#2
2274  0492 cd0000        	call	_SPI_GetFlagStatus
2276  0495 4d            	tnz	a
2277  0496 27f8          	jreq	L5201
2279  0498               L3301:
2280                     ; 877 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
2282  0498 a601          	ld	a,#1
2283  049a cd0000        	call	_SPI_GetFlagStatus
2285  049d 4d            	tnz	a
2286  049e 27f8          	jreq	L3301
2287                     ; 880   *value = SPI_ReceiveData();
2289  04a0 cd0000        	call	_SPI_ReceiveData
2291  04a3 1e06          	ldw	x,(OFST+5,sp)
2292  04a5 f7            	ld	(x),a
2293                     ; 887     delay_us(1);
2295  04a6 ae0001        	ldw	x,#1
2296  04a9 cd0000        	call	_delay_us
2298                     ; 889   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2300  04ac 4b02          	push	#2
2301  04ae ae5000        	ldw	x,#20480
2302  04b1 cd0000        	call	_GPIO_WriteHigh
2304  04b4 84            	pop	a
2305                     ; 890 }
2308  04b5 5b03          	addw	sp,#3
2309  04b7 81            	ret	
2334                     ; 895 void MCP4901_DAC_init(void)
2334                     ; 896 {
2335                     	switch	.text
2336  04b8               _MCP4901_DAC_init:
2340                     ; 897   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
2342  04b8 4bf0          	push	#240
2343  04ba 4b10          	push	#16
2344  04bc ae500a        	ldw	x,#20490
2345  04bf cd0000        	call	_GPIO_Init
2347  04c2 85            	popw	x
2348                     ; 898   delay_ms(10);
2350  04c3 ae000a        	ldw	x,#10
2352                     ; 899 }
2355  04c6 cc0000        	jp	_delay_ms
2403                     ; 905 void MCP4901_DAC_write( unsigned char value)
2403                     ; 906 {
2404                     	switch	.text
2405  04c9               _MCP4901_DAC_write:
2407  04c9 88            	push	a
2408  04ca 88            	push	a
2409       00000001      OFST:	set	1
2412                     ; 934     unsigned char address = 0x30; // 00,11,00,00
2414  04cb a630          	ld	a,#48
2415  04cd 6b01          	ld	(OFST+0,sp),a
2417                     ; 935     address |= ( value>>4); // assume 0's shoved in the left
2419  04cf 7b02          	ld	a,(OFST+1,sp)
2420  04d1 4e            	swap	a
2421  04d2 a40f          	and	a,#15
2422  04d4 1a01          	or	a,(OFST+0,sp)
2423  04d6 6b01          	ld	(OFST+0,sp),a
2425                     ; 937     value = ( value<<4 ); // assume 0 shoved in from the right
2427  04d8 7b02          	ld	a,(OFST+1,sp)
2428  04da 4e            	swap	a
2429  04db a4f0          	and	a,#240
2430  04dd 6b02          	ld	(OFST+1,sp),a
2432  04df               L3701:
2433                     ; 940   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2435  04df a680          	ld	a,#128
2436  04e1 cd0000        	call	_SPI_GetFlagStatus
2438  04e4 4d            	tnz	a
2439  04e5 26f8          	jrne	L3701
2440                     ; 942   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
2442  04e7 4b10          	push	#16
2443  04e9 ae500a        	ldw	x,#20490
2444  04ec cd0000        	call	_GPIO_WriteLow
2446  04ef 84            	pop	a
2447                     ; 944   SPI_SendData(address);
2449  04f0 7b01          	ld	a,(OFST+0,sp)
2450  04f2 cd0000        	call	_SPI_SendData
2453  04f5               L1011:
2454                     ; 946   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2456  04f5 a602          	ld	a,#2
2457  04f7 cd0000        	call	_SPI_GetFlagStatus
2459  04fa 4d            	tnz	a
2460  04fb 27f8          	jreq	L1011
2461                     ; 948   SPI_SendData(value);
2463  04fd 7b02          	ld	a,(OFST+1,sp)
2464  04ff cd0000        	call	_SPI_SendData
2467  0502               L7011:
2468                     ; 950   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2470  0502 a602          	ld	a,#2
2471  0504 cd0000        	call	_SPI_GetFlagStatus
2473  0507 4d            	tnz	a
2474  0508 27f8          	jreq	L7011
2475                     ; 954     delay_us(1);
2477  050a ae0001        	ldw	x,#1
2478  050d cd0000        	call	_delay_us
2480                     ; 961   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
2482  0510 4b10          	push	#16
2483  0512 ae500a        	ldw	x,#20490
2484  0515 cd0000        	call	_GPIO_WriteHigh
2486                     ; 963 }
2489  0518 5b03          	addw	sp,#3
2490  051a 81            	ret	
2503                     	xdef	_TIM2_setup
2504                     	xdef	_main
2505                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
2506                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
2507                     	xdef	_TEST_adc_to_ram_to_dac
2508                     	xdef	_TEST_adc_to_dac
2509                     	xdef	_TEST_rampfunc_in_ram_to_dac
2510                     	xdef	_TEST_ram_test_001
2511                     	xdef	_MCP_23K256_write_status_register
2512                     	xdef	_MCP_23K256_read_status_register
2513                     	xdef	_MCP_23K256_RAM_write_byte
2514                     	xdef	_MCP_23K256_RAM_read_byte
2515                     	xdef	_MCP_23K256_init
2516                     	xdef	_MCP4901_DAC_init
2517                     	xdef	_MCP4901_DAC_write
2518                     	xdef	_ADC1_setup
2519                     	xdef	_SPI_setup
2520                     	xdef	_GPIO_setup
2521                     	xdef	_clock_setup
2522                     	xref	_delay_ms
2523                     	xref	_delay_us
2524                     	xref	_SPI_GetFlagStatus
2525                     	xref	_SPI_ReceiveData
2526                     	xref	_SPI_SendData
2527                     	xref	_SPI_Cmd
2528                     	xref	_SPI_Init
2529                     	xref	_SPI_DeInit
2530                     	xref	_GPIO_WriteLow
2531                     	xref	_GPIO_WriteHigh
2532                     	xref	_GPIO_Init
2533                     	xref	_GPIO_DeInit
2534                     	xref	_CLK_GetFlagStatus
2535                     	xref	_CLK_SYSCLKConfig
2536                     	xref	_CLK_HSIPrescalerConfig
2537                     	xref	_CLK_ClockSwitchConfig
2538                     	xref	_CLK_PeripheralClockConfig
2539                     	xref	_CLK_ClockSwitchCmd
2540                     	xref	_CLK_LSICmd
2541                     	xref	_CLK_HSICmd
2542                     	xref	_CLK_HSECmd
2543                     	xref	_CLK_DeInit
2544                     	xref	_ADC1_ClearFlag
2545                     	xref	_ADC1_GetFlagStatus
2546                     	xref	_ADC1_GetBufferValue
2547                     	xref	_ADC1_GetConversionValue
2548                     	xref	_ADC1_StartConversion
2549                     	xref	_ADC1_ConversionConfig
2550                     	xref	_ADC1_DataBufferCmd
2551                     	xref	_ADC1_ScanModeCmd
2552                     	xref	_ADC1_Cmd
2553                     	xref	_ADC1_Init
2554                     	xref	_ADC1_DeInit
2555                     .const:	section	.text
2556  0000               L772:
2557  0000 3e800000      	dc.w	16000,0
2558                     	xref.b	c_lreg
2559                     	xref.b	c_x
2579                     	xref	c_ftol
2580                     	xref	c_fmul
2581                     	xref	c_uitof
2582                     	end
