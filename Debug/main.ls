   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
 159                     ; 114 void main(void)
 159                     ; 115 {
 161                     	switch	.text
 162  0000               _main:
 164  0000 5211          	subw	sp,#17
 165       00000011      OFST:	set	17
 168                     ; 120 	uint16_t adc_val = 0;	
 170                     ; 121 	uint16_t adc_delay = 0;	// length of delay in samples
 172                     ; 122 	uint16_t adc_fb = 0;	// feedback dial
 174                     ; 124 	uint8_t mapd_audio_value = 0; // mapped adc value of audio input
 176                     ; 125 	uint16_t mapd_delay_dial = 0;
 178                     ; 126 	uint16_t mapd_fb_dial = 0;
 180                     ; 128 	uint16_t audio_signal = 0;
 182                     ; 130 	uint8_t read_val = 0;	//read val from ram
 184  0002 0f09          	clr	(OFST-8,sp)
 186                     ; 131 	uint16_t write_addr = 0;	//write addr in ram
 188  0004 5f            	clrw	x
 189  0005 1f0e          	ldw	(OFST-3,sp),x
 191                     ; 132 	uint16_t read_addr = 0;	// read addr in val
 193                     ; 134 	uint8_t res = 0;
 195                     ; 136 	clock_setup();
 197  0007 cd0328        	call	_clock_setup
 199                     ; 137 	GPIO_setup();
 201  000a cd0389        	call	_GPIO_setup
 203                     ; 138 	ADC1_setup_scan_mode();
 205  000d cd03c9        	call	_ADC1_setup_scan_mode
 207                     ; 139 	SPI_setup();	
 209  0010 cd043d        	call	_SPI_setup
 211                     ; 140 	MCP_23K256_init();
 213  0013 cd045a        	call	_MCP_23K256_init
 215                     ; 141 	MCP4901_DAC_init();
 217  0016 cd05d7        	call	_MCP4901_DAC_init
 219  0019               L77:
 220                     ; 169 		ADC1_ScanModeCmd(ENABLE);
 222  0019 a601          	ld	a,#1
 223  001b cd0000        	call	_ADC1_ScanModeCmd
 225                     ; 170 		ADC1_StartConversion();
 227  001e cd0000        	call	_ADC1_StartConversion
 230  0021               L501:
 231                     ; 171 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 233  0021 a680          	ld	a,#128
 234  0023 cd0000        	call	_ADC1_GetFlagStatus
 236  0026 4d            	tnz	a
 237  0027 27f8          	jreq	L501
 238                     ; 172 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 240  0029 a680          	ld	a,#128
 241  002b cd0000        	call	_ADC1_ClearFlag
 243                     ; 173 		adc_val = ADC1_GetBufferValue(0);
 245  002e 4f            	clr	a
 246  002f cd0000        	call	_ADC1_GetBufferValue
 248  0032 1f06          	ldw	(OFST-11,sp),x
 250                     ; 174 		adc_delay = ADC1_GetBufferValue(1);
 252  0034 a601          	ld	a,#1
 253  0036 cd0000        	call	_ADC1_GetBufferValue
 255  0039 1f0c          	ldw	(OFST-5,sp),x
 257                     ; 175 		adc_fb = ADC1_GetBufferValue(2);
 259  003b a602          	ld	a,#2
 260  003d cd0000        	call	_ADC1_GetBufferValue
 262  0040 1f0a          	ldw	(OFST-7,sp),x
 264                     ; 181 		mapd_fb_dial = adc_fb;
 267                     ; 185 		mapd_delay_dial = (adc_delay/4); // * 11; // adc_delay*(11000) /(1023) // juist do /2 to remove glitching
 269  0042 1e0c          	ldw	x,(OFST-5,sp)
 270  0044 54            	srlw	x
 271  0045 54            	srlw	x
 272  0046 1f10          	ldw	(OFST-1,sp),x
 274                     ; 192 		mapd_audio_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 276  0048 1e06          	ldw	x,(OFST-11,sp)
 277  004a cd0000        	call	c_uitof
 279  004d ae0008        	ldw	x,#L511
 280  0050 cd0000        	call	c_fmul
 282  0053 cd0000        	call	c_ftol
 284  0056 b603          	ld	a,c_lreg+3
 285  0058 6b08          	ld	(OFST-9,sp),a
 287                     ; 199 		audio_signal =  (uint16_t)( ((FB_ADC_RANGE-mapd_fb_dial)/(float)FB_ADC_RANGE) * (float)mapd_audio_value);
 289  005a 7b08          	ld	a,(OFST-9,sp)
 290  005c 5f            	clrw	x
 291  005d 97            	ld	xl,a
 292  005e cd0000        	call	c_itof
 294  0061 96            	ldw	x,sp
 295  0062 1c0001        	addw	x,#OFST-16
 296  0065 cd0000        	call	c_rtol
 299  0068 ae03ff        	ldw	x,#1023
 300  006b 72f00a        	subw	x,(OFST-7,sp)
 301  006e cd0000        	call	c_uitof
 303  0071 ae0004        	ldw	x,#L521
 304  0074 cd0000        	call	c_fdiv
 306  0077 96            	ldw	x,sp
 307  0078 1c0001        	addw	x,#OFST-16
 308  007b cd0000        	call	c_fmul
 310  007e cd0000        	call	c_ftoi
 312  0081 1f0c          	ldw	(OFST-5,sp),x
 314                     ; 200 		audio_signal += (uint16_t )( (mapd_fb_dial/(float)FB_ADC_RANGE) * (float)read_val);
 316  0083 7b09          	ld	a,(OFST-8,sp)
 317  0085 5f            	clrw	x
 318  0086 97            	ld	xl,a
 319  0087 cd0000        	call	c_itof
 321  008a 96            	ldw	x,sp
 322  008b 1c0001        	addw	x,#OFST-16
 323  008e cd0000        	call	c_rtol
 326  0091 1e0a          	ldw	x,(OFST-7,sp)
 327  0093 cd0000        	call	c_uitof
 329  0096 ae0004        	ldw	x,#L521
 330  0099 cd0000        	call	c_fdiv
 332  009c 96            	ldw	x,sp
 333  009d 1c0001        	addw	x,#OFST-16
 334  00a0 cd0000        	call	c_fmul
 336  00a3 cd0000        	call	c_ftoi
 338  00a6 72fb0c        	addw	x,(OFST-5,sp)
 339  00a9 1f0c          	ldw	(OFST-5,sp),x
 341                     ; 203 		if( (int16_t)(write_addr - mapd_delay_dial) >= 0)
 343  00ab 9c            	rvf
 344  00ac 1e0e          	ldw	x,(OFST-3,sp)
 345  00ae 72f010        	subw	x,(OFST-1,sp)
 346  00b1 2f09          	jrslt	L131
 347                     ; 205 			read_addr = write_addr - mapd_delay_dial;
 349  00b3 1e0e          	ldw	x,(OFST-3,sp)
 350  00b5 72f010        	subw	x,(OFST-1,sp)
 351  00b8 1f10          	ldw	(OFST-1,sp),x
 354  00ba 200b          	jra	L331
 355  00bc               L131:
 356                     ; 210 			read_addr = SRAM_SIZE - mapd_delay_dial + write_addr;
 358  00bc ae7d00        	ldw	x,#32000
 359  00bf 72f010        	subw	x,(OFST-1,sp)
 360  00c2 72fb0e        	addw	x,(OFST-3,sp)
 361  00c5 1f10          	ldw	(OFST-1,sp),x
 363  00c7               L331:
 364                     ; 217 	MCP_23K256_RAM_write_byte(write_addr, audio_signal);
 366  00c7 7b0d          	ld	a,(OFST-4,sp)
 367  00c9 88            	push	a
 368  00ca 1e0f          	ldw	x,(OFST-2,sp)
 369  00cc cd04fc        	call	_MCP_23K256_RAM_write_byte
 371  00cf 84            	pop	a
 372                     ; 220 		MCP_23K256_RAM_read_byte(read_addr, &read_val);
 374  00d0 96            	ldw	x,sp
 375  00d1 1c0009        	addw	x,#OFST-8
 376  00d4 89            	pushw	x
 377  00d5 1e12          	ldw	x,(OFST+1,sp)
 378  00d7 cd055f        	call	_MCP_23K256_RAM_read_byte
 380  00da 85            	popw	x
 381                     ; 223 		MCP4901_DAC_write(read_val);
 383  00db 7b09          	ld	a,(OFST-8,sp)
 384  00dd cd05e8        	call	_MCP4901_DAC_write
 386                     ; 226 		write_addr++;
 388  00e0 1e0e          	ldw	x,(OFST-3,sp)
 389  00e2 1c0001        	addw	x,#1
 390  00e5 1f0e          	ldw	(OFST-3,sp),x
 392                     ; 229 		if(write_addr > SRAM_SIZE)
 394  00e7 1e0e          	ldw	x,(OFST-3,sp)
 395  00e9 a37d01        	cpw	x,#32001
 396  00ec 2503          	jrult	L531
 397                     ; 231 			write_addr = 0;
 399  00ee 5f            	clrw	x
 400  00ef 1f0e          	ldw	(OFST-3,sp),x
 402  00f1               L531:
 403                     ; 235 		delay_us(90);
 405  00f1 ae005a        	ldw	x,#90
 406  00f4 cd0639        	call	_delay_us
 409  00f7 ac190019      	jpf	L77
 474                     ; 250 uint8_t TEST_ram_test_001(void)
 474                     ; 251 {
 475                     	switch	.text
 476  00fb               _TEST_ram_test_001:
 478  00fb 5205          	subw	sp,#5
 479       00000005      OFST:	set	5
 482                     ; 252 	uint8_t cnt = 0;
 484                     ; 253 	uint8_t data = 0;
 486  00fd 0f03          	clr	(OFST-2,sp)
 488                     ; 254 	uint8_t wdata = 0;
 490                     ; 255 	uint16_t addr = 0;
 492                     ; 258 	data = BYTE_MODE;
 494  00ff 0f03          	clr	(OFST-2,sp)
 496                     ; 259 	MCP_23K256_write_status_register(data);
 498  0101 4f            	clr	a
 499  0102 cd04bf        	call	_MCP_23K256_write_status_register
 501                     ; 262 	MCP_23K256_read_status_register(&data);
 503  0105 96            	ldw	x,sp
 504  0106 1c0003        	addw	x,#OFST-2
 505  0109 cd046c        	call	_MCP_23K256_read_status_register
 507                     ; 306 wdata = 2;
 509  010c a602          	ld	a,#2
 510  010e 6b02          	ld	(OFST-3,sp),a
 512                     ; 307 addr =0;
 514  0110 5f            	clrw	x
 515  0111 1f04          	ldw	(OFST-1,sp),x
 517                     ; 309 	MCP_23K256_RAM_write_byte(addr, wdata);
 519  0113 4b02          	push	#2
 520  0115 5f            	clrw	x
 521  0116 cd04fc        	call	_MCP_23K256_RAM_write_byte
 523  0119 84            	pop	a
 524                     ; 312 	MCP_23K256_RAM_read_byte(addr, &data);
 526  011a 96            	ldw	x,sp
 527  011b 1c0003        	addw	x,#OFST-2
 528  011e 89            	pushw	x
 529  011f 1e06          	ldw	x,(OFST+1,sp)
 530  0121 cd055f        	call	_MCP_23K256_RAM_read_byte
 532  0124 85            	popw	x
 533                     ; 314 	if (wdata != data)
 535  0125 7b02          	ld	a,(OFST-3,sp)
 536  0127 1103          	cp	a,(OFST-2,sp)
 537                     ; 319 wdata = 250;
 539  0129 a6fa          	ld	a,#250
 540  012b 6b02          	ld	(OFST-3,sp),a
 542                     ; 320 addr =1;
 544  012d ae0001        	ldw	x,#1
 545  0130 1f04          	ldw	(OFST-1,sp),x
 547                     ; 322 	MCP_23K256_RAM_write_byte(addr, wdata);
 549  0132 4bfa          	push	#250
 550  0134 ae0001        	ldw	x,#1
 551  0137 cd04fc        	call	_MCP_23K256_RAM_write_byte
 553  013a 84            	pop	a
 554                     ; 325 	MCP_23K256_RAM_read_byte(addr, &data);
 556  013b 96            	ldw	x,sp
 557  013c 1c0003        	addw	x,#OFST-2
 558  013f 89            	pushw	x
 559  0140 1e06          	ldw	x,(OFST+1,sp)
 560  0142 cd055f        	call	_MCP_23K256_RAM_read_byte
 562  0145 85            	popw	x
 563                     ; 327 	if (wdata != data)
 565  0146 7b02          	ld	a,(OFST-3,sp)
 566  0148 1103          	cp	a,(OFST-2,sp)
 567                     ; 332 wdata = 4;
 569  014a a604          	ld	a,#4
 570  014c 6b02          	ld	(OFST-3,sp),a
 572                     ; 333 addr =2;
 574  014e ae0002        	ldw	x,#2
 575  0151 1f04          	ldw	(OFST-1,sp),x
 577                     ; 335 	MCP_23K256_RAM_write_byte(addr, wdata);
 579  0153 4b04          	push	#4
 580  0155 ae0002        	ldw	x,#2
 581  0158 cd04fc        	call	_MCP_23K256_RAM_write_byte
 583  015b 84            	pop	a
 584                     ; 338 	MCP_23K256_RAM_read_byte(addr, &data);
 586  015c 96            	ldw	x,sp
 587  015d 1c0003        	addw	x,#OFST-2
 588  0160 89            	pushw	x
 589  0161 1e06          	ldw	x,(OFST+1,sp)
 590  0163 cd055f        	call	_MCP_23K256_RAM_read_byte
 592  0166 85            	popw	x
 593                     ; 340 	if (wdata != data)
 595  0167 7b02          	ld	a,(OFST-3,sp)
 596  0169 1103          	cp	a,(OFST-2,sp)
 597                     ; 346 	for(addr = 0; addr<3; addr++)
 599  016b 5f            	clrw	x
 600  016c 1f04          	ldw	(OFST-1,sp),x
 602  016e               L771:
 603                     ; 348 		MCP_23K256_RAM_read_byte(addr, &data);
 605  016e 96            	ldw	x,sp
 606  016f 1c0003        	addw	x,#OFST-2
 607  0172 89            	pushw	x
 608  0173 1e06          	ldw	x,(OFST+1,sp)
 609  0175 cd055f        	call	_MCP_23K256_RAM_read_byte
 611  0178 85            	popw	x
 612                     ; 346 	for(addr = 0; addr<3; addr++)
 614  0179 1e04          	ldw	x,(OFST-1,sp)
 615  017b 1c0001        	addw	x,#1
 616  017e 1f04          	ldw	(OFST-1,sp),x
 620  0180 1e04          	ldw	x,(OFST-1,sp)
 621  0182 a30003        	cpw	x,#3
 622  0185 25e7          	jrult	L771
 623                     ; 350 	return 0;
 625  0187 4f            	clr	a
 628  0188 5b05          	addw	sp,#5
 629  018a 81            	ret
 686                     ; 357 uint8_t TEST_rampfunc_in_ram_to_dac(void)
 686                     ; 358 {
 687                     	switch	.text
 688  018b               _TEST_rampfunc_in_ram_to_dac:
 690  018b 5204          	subw	sp,#4
 691       00000004      OFST:	set	4
 694                     ; 359 	uint8_t data = 0;
 696  018d 0f02          	clr	(OFST-2,sp)
 698                     ; 360 	uint8_t wdata = 0;
 700  018f 0f01          	clr	(OFST-3,sp)
 702                     ; 361 	uint16_t addr = 0;	
 704                     ; 364 	for(addr = 0, wdata; addr<255; addr++, wdata++)
 706  0191 5f            	clrw	x
 707  0192 1f03          	ldw	(OFST-1,sp),x
 709  0194               L332:
 710                     ; 366 		MCP_23K256_RAM_write_byte(addr, wdata);
 712  0194 7b01          	ld	a,(OFST-3,sp)
 713  0196 88            	push	a
 714  0197 1e04          	ldw	x,(OFST+0,sp)
 715  0199 cd04fc        	call	_MCP_23K256_RAM_write_byte
 717  019c 84            	pop	a
 718                     ; 364 	for(addr = 0, wdata; addr<255; addr++, wdata++)
 720  019d 1e03          	ldw	x,(OFST-1,sp)
 721  019f 1c0001        	addw	x,#1
 722  01a2 1f03          	ldw	(OFST-1,sp),x
 724  01a4 0c01          	inc	(OFST-3,sp)
 728  01a6 1e03          	ldw	x,(OFST-1,sp)
 729  01a8 a300ff        	cpw	x,#255
 730  01ab 25e7          	jrult	L332
 731  01ad               L142:
 732                     ; 372 		for(addr = 0; addr<255; addr++)
 734  01ad 5f            	clrw	x
 735  01ae 1f03          	ldw	(OFST-1,sp),x
 737  01b0               L542:
 738                     ; 374 			MCP_23K256_RAM_read_byte(addr, &data);
 740  01b0 96            	ldw	x,sp
 741  01b1 1c0002        	addw	x,#OFST-2
 742  01b4 89            	pushw	x
 743  01b5 1e05          	ldw	x,(OFST+1,sp)
 744  01b7 cd055f        	call	_MCP_23K256_RAM_read_byte
 746  01ba 85            	popw	x
 747                     ; 375 			MCP4901_DAC_write(data);
 749  01bb 7b02          	ld	a,(OFST-2,sp)
 750  01bd cd05e8        	call	_MCP4901_DAC_write
 752                     ; 376 			delay_us(90);	//11kHz sample rate
 754  01c0 ae005a        	ldw	x,#90
 755  01c3 cd0639        	call	_delay_us
 757                     ; 372 		for(addr = 0; addr<255; addr++)
 759  01c6 1e03          	ldw	x,(OFST-1,sp)
 760  01c8 1c0001        	addw	x,#1
 761  01cb 1f03          	ldw	(OFST-1,sp),x
 765  01cd 1e03          	ldw	x,(OFST-1,sp)
 766  01cf a300ff        	cpw	x,#255
 767  01d2 25dc          	jrult	L542
 769  01d4 20d7          	jra	L142
 804                     ; 384 void TEST_adc_to_dac(uint8_t *x)
 804                     ; 385 {
 805                     	switch	.text
 806  01d6               _TEST_adc_to_dac:
 810                     ; 409 }
 813  01d6 81            	ret
 874                     ; 412 void TEST_adc_to_ram_to_dac(void)
 874                     ; 413 {
 875                     	switch	.text
 876  01d7               _TEST_adc_to_ram_to_dac:
 878  01d7 5205          	subw	sp,#5
 879       00000005      OFST:	set	5
 882                     ; 414 	uint16_t adc_val = 0;
 884                     ; 415 	uint16_t addr = 0;
 886  01d9 5f            	clrw	x
 887  01da 1f03          	ldw	(OFST-2,sp),x
 889                     ; 416 	uint8_t mapd_value = 0; 
 891  01dc 0f05          	clr	(OFST+0,sp)
 893  01de               L713:
 894                     ; 421 		ADC1_StartConversion();
 896  01de cd0000        	call	_ADC1_StartConversion
 899  01e1               L523:
 900                     ; 422 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 902  01e1 a680          	ld	a,#128
 903  01e3 cd0000        	call	_ADC1_GetFlagStatus
 905  01e6 4d            	tnz	a
 906  01e7 27f8          	jreq	L523
 907                     ; 424 		adc_val = ADC1_GetConversionValue(); // for led knob
 909  01e9 cd0000        	call	_ADC1_GetConversionValue
 911  01ec 1f01          	ldw	(OFST-4,sp),x
 913                     ; 425 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 915  01ee a680          	ld	a,#128
 916  01f0 cd0000        	call	_ADC1_ClearFlag
 918                     ; 432 		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 920  01f3 1e01          	ldw	x,(OFST-4,sp)
 921  01f5 cd0000        	call	c_uitof
 923  01f8 ae0008        	ldw	x,#L511
 924  01fb cd0000        	call	c_fmul
 926  01fe cd0000        	call	c_ftol
 928  0201 b603          	ld	a,c_lreg+3
 929  0203 6b05          	ld	(OFST+0,sp),a
 931                     ; 435 		MCP_23K256_RAM_write_byte(addr, mapd_value);
 933  0205 7b05          	ld	a,(OFST+0,sp)
 934  0207 88            	push	a
 935  0208 1e04          	ldw	x,(OFST-1,sp)
 936  020a cd04fc        	call	_MCP_23K256_RAM_write_byte
 938  020d 84            	pop	a
 939                     ; 438 		mapd_value = 0; // check value
 941  020e 0f05          	clr	(OFST+0,sp)
 943                     ; 439 		MCP_23K256_RAM_read_byte(addr, &mapd_value);
 945  0210 96            	ldw	x,sp
 946  0211 1c0005        	addw	x,#OFST+0
 947  0214 89            	pushw	x
 948  0215 1e05          	ldw	x,(OFST+0,sp)
 949  0217 cd055f        	call	_MCP_23K256_RAM_read_byte
 951  021a 85            	popw	x
 952                     ; 442 		addr++;
 954  021b 1e03          	ldw	x,(OFST-2,sp)
 955  021d 1c0001        	addw	x,#1
 956  0220 1f03          	ldw	(OFST-2,sp),x
 958                     ; 444 		MCP4901_DAC_write(mapd_value);
 960  0222 7b05          	ld	a,(OFST+0,sp)
 961  0224 cd05e8        	call	_MCP4901_DAC_write
 963                     ; 447 		delay_us(90);
 965  0227 ae005a        	ldw	x,#90
 966  022a cd0639        	call	_delay_us
 969  022d 20af          	jra	L713
1066                     ; 454 void TEST_adc_to_ram_to_dac_with_delay(void)
1066                     ; 455 {
1067                     	switch	.text
1068  022f               _TEST_adc_to_ram_to_dac_with_delay:
1070  022f 520b          	subw	sp,#11
1071       0000000b      OFST:	set	11
1074                     ; 456 	uint16_t adc_val = 0;	
1076                     ; 457 	uint8_t mapd_value = 0; // mapped adc valu
1078                     ; 458 	uint8_t read_val = 0;	//read val from ram
1080  0231 0f05          	clr	(OFST-6,sp)
1082                     ; 459 	uint16_t write_addr = 0;	//write addr in ram
1084  0233 5f            	clrw	x
1085  0234 1f0a          	ldw	(OFST-1,sp),x
1087                     ; 460 	uint16_t read_addr = 0;	// read addr in val
1089  0236 5f            	clrw	x
1090  0237 1f06          	ldw	(OFST-5,sp),x
1092                     ; 461 	uint16_t delay = 110; // length of delay in samples
1094  0239 ae006e        	ldw	x,#110
1095  023c 1f08          	ldw	(OFST-3,sp),x
1097                     ; 462 	uint8_t res = 0;
1099  023e               L773:
1100                     ; 468 		ADC1_StartConversion();
1102  023e cd0000        	call	_ADC1_StartConversion
1105  0241               L504:
1106                     ; 469 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1108  0241 a680          	ld	a,#128
1109  0243 cd0000        	call	_ADC1_GetFlagStatus
1111  0246 4d            	tnz	a
1112  0247 27f8          	jreq	L504
1113                     ; 471 		adc_val = ADC1_GetConversionValue(); // for led knob
1115  0249 cd0000        	call	_ADC1_GetConversionValue
1117  024c 1f02          	ldw	(OFST-9,sp),x
1119                     ; 472 		ADC1_ClearFlag(ADC1_FLAG_EOC);
1121  024e a680          	ld	a,#128
1122  0250 cd0000        	call	_ADC1_ClearFlag
1124                     ; 479 		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
1126  0253 1e02          	ldw	x,(OFST-9,sp)
1127  0255 cd0000        	call	c_uitof
1129  0258 ae0008        	ldw	x,#L511
1130  025b cd0000        	call	c_fmul
1132  025e cd0000        	call	c_ftol
1134  0261 b603          	ld	a,c_lreg+3
1135  0263 6b04          	ld	(OFST-7,sp),a
1137                     ; 490 			read_addr = write_addr - delay;
1139  0265 1e0a          	ldw	x,(OFST-1,sp)
1140  0267 72f008        	subw	x,(OFST-3,sp)
1141  026a 1f06          	ldw	(OFST-5,sp),x
1143                     ; 494 		MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1145  026c 7b04          	ld	a,(OFST-7,sp)
1146  026e 88            	push	a
1147  026f 1e0b          	ldw	x,(OFST+0,sp)
1148  0271 cd04fc        	call	_MCP_23K256_RAM_write_byte
1150  0274 84            	pop	a
1151                     ; 497 		MCP_23K256_RAM_read_byte(read_addr, &read_val);
1153  0275 96            	ldw	x,sp
1154  0276 1c0005        	addw	x,#OFST-6
1155  0279 89            	pushw	x
1156  027a 1e08          	ldw	x,(OFST-3,sp)
1157  027c cd055f        	call	_MCP_23K256_RAM_read_byte
1159  027f 85            	popw	x
1160                     ; 500 		MCP4901_DAC_write(read_val);
1162  0280 7b05          	ld	a,(OFST-6,sp)
1163  0282 cd05e8        	call	_MCP4901_DAC_write
1165                     ; 503 		write_addr++;
1167  0285 1e0a          	ldw	x,(OFST-1,sp)
1168  0287 1c0001        	addw	x,#1
1169  028a 1f0a          	ldw	(OFST-1,sp),x
1171                     ; 506 		delay_us(90);
1173  028c ae005a        	ldw	x,#90
1174  028f cd0639        	call	_delay_us
1177  0292 20aa          	jra	L773
1275                     ; 513 void TEST_adc_to_ram_to_dac_with_with_fback(void)
1275                     ; 514 {
1276                     	switch	.text
1277  0294               _TEST_adc_to_ram_to_dac_with_with_fback:
1279  0294 520d          	subw	sp,#13
1280       0000000d      OFST:	set	13
1283                     ; 516 	uint16_t adc_val = 0;	
1285                     ; 517 	uint8_t mapd_value = 0; // mapped adc valu
1287                     ; 518 	uint8_t read_val = 0;	//read val from ram
1289  0296 0f06          	clr	(OFST-7,sp)
1291                     ; 519 	int16_t write_addr = 0;	//write addr in ram
1293  0298 5f            	clrw	x
1294  0299 1f0c          	ldw	(OFST-1,sp),x
1296                     ; 520 	uint16_t read_addr = 0;	// read addr in val
1298  029b 5f            	clrw	x
1299  029c 1f07          	ldw	(OFST-6,sp),x
1301                     ; 521 	int16_t delay = 110; // length of delay in samples
1303  029e ae006e        	ldw	x,#110
1304  02a1 1f0a          	ldw	(OFST-3,sp),x
1306                     ; 522 	uint8_t res = 0;
1308  02a3               L754:
1309                     ; 528 		ADC1_StartConversion();
1311  02a3 cd0000        	call	_ADC1_StartConversion
1314  02a6               L564:
1315                     ; 529 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1317  02a6 a680          	ld	a,#128
1318  02a8 cd0000        	call	_ADC1_GetFlagStatus
1320  02ab 4d            	tnz	a
1321  02ac 27f8          	jreq	L564
1322                     ; 531 		adc_val = ADC1_GetConversionValue(); // for led knob
1324  02ae cd0000        	call	_ADC1_GetConversionValue
1326  02b1 1f04          	ldw	(OFST-9,sp),x
1328                     ; 532 		ADC1_ClearFlag(ADC1_FLAG_EOC);
1330  02b3 a680          	ld	a,#128
1331  02b5 cd0000        	call	_ADC1_ClearFlag
1333                     ; 539 		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
1335  02b8 1e04          	ldw	x,(OFST-9,sp)
1336  02ba cd0000        	call	c_uitof
1338  02bd ae0008        	ldw	x,#L511
1339  02c0 cd0000        	call	c_fmul
1341  02c3 cd0000        	call	c_ftol
1343  02c6 b603          	ld	a,c_lreg+3
1344  02c8 6b09          	ld	(OFST-4,sp),a
1346                     ; 542 		mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
1348  02ca 7b06          	ld	a,(OFST-7,sp)
1349  02cc 5f            	clrw	x
1350  02cd 97            	ld	xl,a
1351  02ce 57            	sraw	x
1352  02cf 1f01          	ldw	(OFST-12,sp),x
1354  02d1 7b09          	ld	a,(OFST-4,sp)
1355  02d3 5f            	clrw	x
1356  02d4 97            	ld	xl,a
1357  02d5 57            	sraw	x
1358  02d6 72fb01        	addw	x,(OFST-12,sp)
1359  02d9 01            	rrwa	x,a
1360  02da 6b09          	ld	(OFST-4,sp),a
1361  02dc 02            	rlwa	x,a
1363                     ; 545 		if( (write_addr - delay) < 0)
1365  02dd 9c            	rvf
1366  02de 1e0c          	ldw	x,(OFST-1,sp)
1367  02e0 72f00a        	subw	x,(OFST-3,sp)
1368  02e3 2e0b          	jrsge	L174
1369                     ; 548 			read_addr = SRAM_SIZE - delay + write_addr;
1371  02e5 ae7d00        	ldw	x,#32000
1372  02e8 72f00a        	subw	x,(OFST-3,sp)
1373  02eb 72fb0c        	addw	x,(OFST-1,sp)
1374  02ee 1f07          	ldw	(OFST-6,sp),x
1376  02f0               L174:
1377                     ; 551 		if( (write_addr - delay) >= 0)
1379  02f0 9c            	rvf
1380  02f1 1e0c          	ldw	x,(OFST-1,sp)
1381  02f3 72f00a        	subw	x,(OFST-3,sp)
1382  02f6 2f07          	jrslt	L374
1383                     ; 553 			read_addr = write_addr - delay;
1385  02f8 1e0c          	ldw	x,(OFST-1,sp)
1386  02fa 72f00a        	subw	x,(OFST-3,sp)
1387  02fd 1f07          	ldw	(OFST-6,sp),x
1389  02ff               L374:
1390                     ; 557 		MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1392  02ff 7b09          	ld	a,(OFST-4,sp)
1393  0301 88            	push	a
1394  0302 1e0d          	ldw	x,(OFST+0,sp)
1395  0304 cd04fc        	call	_MCP_23K256_RAM_write_byte
1397  0307 84            	pop	a
1398                     ; 560 		MCP_23K256_RAM_read_byte(read_addr, &read_val);
1400  0308 96            	ldw	x,sp
1401  0309 1c0006        	addw	x,#OFST-7
1402  030c 89            	pushw	x
1403  030d 1e09          	ldw	x,(OFST-4,sp)
1404  030f cd055f        	call	_MCP_23K256_RAM_read_byte
1406  0312 85            	popw	x
1407                     ; 563 		MCP4901_DAC_write(read_val);
1409  0313 7b06          	ld	a,(OFST-7,sp)
1410  0315 cd05e8        	call	_MCP4901_DAC_write
1412                     ; 566 		write_addr++;
1414  0318 1e0c          	ldw	x,(OFST-1,sp)
1415  031a 1c0001        	addw	x,#1
1416  031d 1f0c          	ldw	(OFST-1,sp),x
1418                     ; 569 		delay_us(90);
1420  031f ae005a        	ldw	x,#90
1421  0322 cd0639        	call	_delay_us
1424  0325 cc02a3        	jra	L754
1457                     ; 575 void clock_setup(void)
1457                     ; 576 {
1458                     	switch	.text
1459  0328               _clock_setup:
1463                     ; 577   CLK_DeInit();
1465  0328 cd0000        	call	_CLK_DeInit
1467                     ; 579   CLK_HSECmd(DISABLE);
1469  032b 4f            	clr	a
1470  032c cd0000        	call	_CLK_HSECmd
1472                     ; 580   CLK_LSICmd(DISABLE);
1474  032f 4f            	clr	a
1475  0330 cd0000        	call	_CLK_LSICmd
1477                     ; 581   CLK_HSICmd(ENABLE);
1479  0333 a601          	ld	a,#1
1480  0335 cd0000        	call	_CLK_HSICmd
1483  0338               L705:
1484                     ; 582   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
1486  0338 ae0102        	ldw	x,#258
1487  033b cd0000        	call	_CLK_GetFlagStatus
1489  033e 4d            	tnz	a
1490  033f 27f7          	jreq	L705
1491                     ; 584   CLK_ClockSwitchCmd(ENABLE);
1493  0341 a601          	ld	a,#1
1494  0343 cd0000        	call	_CLK_ClockSwitchCmd
1496                     ; 585   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1498  0346 4f            	clr	a
1499  0347 cd0000        	call	_CLK_HSIPrescalerConfig
1501                     ; 586   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
1503  034a a680          	ld	a,#128
1504  034c cd0000        	call	_CLK_SYSCLKConfig
1506                     ; 588   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
1508  034f 4b01          	push	#1
1509  0351 4b00          	push	#0
1510  0353 ae01e1        	ldw	x,#481
1511  0356 cd0000        	call	_CLK_ClockSwitchConfig
1513  0359 85            	popw	x
1514                     ; 590   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
1516  035a 5f            	clrw	x
1517  035b cd0000        	call	_CLK_PeripheralClockConfig
1519                     ; 591   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
1521  035e ae0101        	ldw	x,#257
1522  0361 cd0000        	call	_CLK_PeripheralClockConfig
1524                     ; 592   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
1526  0364 ae0300        	ldw	x,#768
1527  0367 cd0000        	call	_CLK_PeripheralClockConfig
1529                     ; 593   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
1531  036a ae1200        	ldw	x,#4608
1532  036d cd0000        	call	_CLK_PeripheralClockConfig
1534                     ; 594   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
1536  0370 ae1301        	ldw	x,#4865
1537  0373 cd0000        	call	_CLK_PeripheralClockConfig
1539                     ; 595   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
1541  0376 ae0700        	ldw	x,#1792
1542  0379 cd0000        	call	_CLK_PeripheralClockConfig
1544                     ; 596   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
1546  037c ae0500        	ldw	x,#1280
1547  037f cd0000        	call	_CLK_PeripheralClockConfig
1549                     ; 597   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
1551  0382 ae0400        	ldw	x,#1024
1552  0385 cd0000        	call	_CLK_PeripheralClockConfig
1554                     ; 599 }
1557  0388 81            	ret
1582                     ; 601 void GPIO_setup(void)
1582                     ; 602 {   
1583                     	switch	.text
1584  0389               _GPIO_setup:
1588                     ; 604   GPIO_DeInit(GPIOC);
1590  0389 ae500a        	ldw	x,#20490
1591  038c cd0000        	call	_GPIO_DeInit
1593                     ; 605 	GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ), 
1593                     ; 606                GPIO_MODE_OUT_PP_HIGH_FAST);
1595  038f 4bf0          	push	#240
1596  0391 4b60          	push	#96
1597  0393 ae500a        	ldw	x,#20490
1598  0396 cd0000        	call	_GPIO_Init
1600  0399 85            	popw	x
1601                     ; 609 	GPIO_DeInit(GPIOB);
1603  039a ae5005        	ldw	x,#20485
1604  039d cd0000        	call	_GPIO_DeInit
1606                     ; 610   GPIO_Init(GPIOB, ((GPIO_Pin_TypeDef)(GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_2)), GPIO_MODE_IN_FL_NO_IT); // 
1608  03a0 4b00          	push	#0
1609  03a2 4b07          	push	#7
1610  03a4 ae5005        	ldw	x,#20485
1611  03a7 cd0000        	call	_GPIO_Init
1613  03aa 85            	popw	x
1614                     ; 615 }
1617  03ab 81            	ret
1643                     ; 617 void ADC1_setup(void)
1643                     ; 618 {
1644                     	switch	.text
1645  03ac               _ADC1_setup:
1649                     ; 619   ADC1_DeInit();         
1651  03ac cd0000        	call	_ADC1_DeInit
1653                     ; 621   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1653                     ; 622   ADC1_CHANNEL_0,\
1653                     ; 623   ADC1_PRESSEL_FCPU_D18, \
1653                     ; 624   ADC1_EXTTRIG_GPIO, \
1653                     ; 625   DISABLE, \
1653                     ; 626   ADC1_ALIGN_RIGHT, \
1653                     ; 627   ADC1_SCHMITTTRIG_CHANNEL0, \
1653                     ; 628   DISABLE);
1655  03af 4b00          	push	#0
1656  03b1 4b00          	push	#0
1657  03b3 4b08          	push	#8
1658  03b5 4b00          	push	#0
1659  03b7 4b10          	push	#16
1660  03b9 4b70          	push	#112
1661  03bb ae0100        	ldw	x,#256
1662  03be cd0000        	call	_ADC1_Init
1664  03c1 5b06          	addw	sp,#6
1665                     ; 630   ADC1_Cmd(ENABLE);
1667  03c3 a601          	ld	a,#1
1668  03c5 cd0000        	call	_ADC1_Cmd
1670                     ; 632 }
1673  03c8 81            	ret
1702                     ; 634 void ADC1_setup_scan_mode(void)
1702                     ; 635 {
1703                     	switch	.text
1704  03c9               _ADC1_setup_scan_mode:
1708                     ; 636   ADC1_DeInit();         
1710  03c9 cd0000        	call	_ADC1_DeInit
1712                     ; 638   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1712                     ; 639   ADC1_CHANNEL_0,\
1712                     ; 640   ADC1_PRESSEL_FCPU_D18, \
1712                     ; 641   ADC1_EXTTRIG_GPIO, \
1712                     ; 642   DISABLE, \
1712                     ; 643   ADC1_ALIGN_RIGHT, \
1712                     ; 644   ADC1_SCHMITTTRIG_CHANNEL0, \
1712                     ; 645   DISABLE);
1714  03cc 4b00          	push	#0
1715  03ce 4b00          	push	#0
1716  03d0 4b08          	push	#8
1717  03d2 4b00          	push	#0
1718  03d4 4b10          	push	#16
1719  03d6 4b70          	push	#112
1720  03d8 ae0100        	ldw	x,#256
1721  03db cd0000        	call	_ADC1_Init
1723  03de 5b06          	addw	sp,#6
1724                     ; 647 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1724                     ; 648   ADC1_CHANNEL_1,\
1724                     ; 649   ADC1_PRESSEL_FCPU_D18, \
1724                     ; 650   ADC1_EXTTRIG_GPIO, \
1724                     ; 651   DISABLE, \
1724                     ; 652   ADC1_ALIGN_RIGHT, \
1724                     ; 653   ADC1_SCHMITTTRIG_CHANNEL1, \
1724                     ; 654   DISABLE);
1726  03e0 4b00          	push	#0
1727  03e2 4b01          	push	#1
1728  03e4 4b08          	push	#8
1729  03e6 4b00          	push	#0
1730  03e8 4b10          	push	#16
1731  03ea 4b70          	push	#112
1732  03ec ae0101        	ldw	x,#257
1733  03ef cd0000        	call	_ADC1_Init
1735  03f2 5b06          	addw	sp,#6
1736                     ; 656 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1736                     ; 657   ADC1_CHANNEL_2,\
1736                     ; 658   ADC1_PRESSEL_FCPU_D18, \
1736                     ; 659   ADC1_EXTTRIG_GPIO, \
1736                     ; 660   DISABLE, \
1736                     ; 661   ADC1_ALIGN_RIGHT, \
1736                     ; 662   ADC1_SCHMITTTRIG_CHANNEL2, \
1736                     ; 663   DISABLE);
1738  03f4 4b00          	push	#0
1739  03f6 4b02          	push	#2
1740  03f8 4b08          	push	#8
1741  03fa 4b00          	push	#0
1742  03fc 4b10          	push	#16
1743  03fe 4b70          	push	#112
1744  0400 ae0102        	ldw	x,#258
1745  0403 cd0000        	call	_ADC1_Init
1747  0406 5b06          	addw	sp,#6
1748                     ; 665 	ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, \
1748                     ; 666 	((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1 | ADC1_CHANNEL_2)), \
1748                     ; 667 	ADC1_ALIGN_RIGHT);
1750  0408 4b08          	push	#8
1751  040a ae0003        	ldw	x,#3
1752  040d cd0000        	call	_ADC1_ConversionConfig
1754  0410 84            	pop	a
1755                     ; 669 	ADC1_DataBufferCmd(ENABLE);
1757  0411 a601          	ld	a,#1
1758  0413 cd0000        	call	_ADC1_DataBufferCmd
1760                     ; 671   ADC1_Cmd(ENABLE);
1762  0416 a601          	ld	a,#1
1763  0418 cd0000        	call	_ADC1_Cmd
1765                     ; 673 }
1768  041b 81            	ret
1795                     ; 676 void TIM2_setup(void)
1795                     ; 677 {
1796                     	switch	.text
1797  041c               _TIM2_setup:
1801                     ; 678   TIM2_DeInit();
1803  041c cd0000        	call	_TIM2_DeInit
1805                     ; 679   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
1807  041f ae03e8        	ldw	x,#1000
1808  0422 89            	pushw	x
1809  0423 a605          	ld	a,#5
1810  0425 cd0000        	call	_TIM2_TimeBaseInit
1812  0428 85            	popw	x
1813                     ; 680   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
1815  0429 4b00          	push	#0
1816  042b ae03e8        	ldw	x,#1000
1817  042e 89            	pushw	x
1818  042f ae6011        	ldw	x,#24593
1819  0432 cd0000        	call	_TIM2_OC1Init
1821  0435 5b03          	addw	sp,#3
1822                     ; 681   TIM2_Cmd(ENABLE);
1824  0437 a601          	ld	a,#1
1825  0439 cd0000        	call	_TIM2_Cmd
1827                     ; 683 }
1830  043c 81            	ret
1856                     ; 686 void SPI_setup(void)
1856                     ; 687 {
1857                     	switch	.text
1858  043d               _SPI_setup:
1862                     ; 688   SPI_DeInit();
1864  043d cd0000        	call	_SPI_DeInit
1866                     ; 693   SPI_Init(SPI_FIRSTBIT_MSB, \
1866                     ; 694 	SPI_BAUDRATEPRESCALER_16, \
1866                     ; 695 	SPI_MODE_MASTER, \
1866                     ; 696 	SPI_CLOCKPOLARITY_LOW, \
1866                     ; 697 	SPI_CLOCKPHASE_1EDGE, \
1866                     ; 698 	SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
1866                     ; 699 	SPI_NSS_SOFT, \
1866                     ; 700 	0x0);
1868  0440 4b00          	push	#0
1869  0442 4b02          	push	#2
1870  0444 4b00          	push	#0
1871  0446 4b00          	push	#0
1872  0448 4b00          	push	#0
1873  044a 4b04          	push	#4
1874  044c ae0018        	ldw	x,#24
1875  044f cd0000        	call	_SPI_Init
1877  0452 5b06          	addw	sp,#6
1878                     ; 702   SPI_Cmd(ENABLE);
1880  0454 a601          	ld	a,#1
1881  0456 cd0000        	call	_SPI_Cmd
1883                     ; 703 }
1886  0459 81            	ret
1911                     ; 705 void MCP_23K256_init()
1911                     ; 706 {
1912                     	switch	.text
1913  045a               _MCP_23K256_init:
1917                     ; 707 	GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
1919  045a 4bf0          	push	#240
1920  045c 4b02          	push	#2
1921  045e ae5000        	ldw	x,#20480
1922  0461 cd0000        	call	_GPIO_Init
1924  0464 85            	popw	x
1925                     ; 708   delay_ms(10);
1927  0465 ae000a        	ldw	x,#10
1928  0468 cd0658        	call	_delay_ms
1930                     ; 709 }
1933  046b 81            	ret
1975                     ; 714 void MCP_23K256_read_status_register(uint8_t *data)
1975                     ; 715 {
1976                     	switch	.text
1977  046c               _MCP_23K256_read_status_register:
1979  046c 89            	pushw	x
1980       00000000      OFST:	set	0
1983  046d               L316:
1984                     ; 717   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1986  046d a680          	ld	a,#128
1987  046f cd0000        	call	_SPI_GetFlagStatus
1989  0472 4d            	tnz	a
1990  0473 26f8          	jrne	L316
1991                     ; 719   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1993  0475 4b02          	push	#2
1994  0477 ae5000        	ldw	x,#20480
1995  047a cd0000        	call	_GPIO_WriteLow
1997  047d 84            	pop	a
1998                     ; 721   SPI_SendData(RDSR); // read ststus reg
2000  047e a605          	ld	a,#5
2001  0480 cd0000        	call	_SPI_SendData
2004  0483               L126:
2005                     ; 723   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2007  0483 a602          	ld	a,#2
2008  0485 cd0000        	call	_SPI_GetFlagStatus
2010  0488 4d            	tnz	a
2011  0489 27f8          	jreq	L126
2013  048b               L726:
2014                     ; 726 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2016  048b a601          	ld	a,#1
2017  048d cd0000        	call	_SPI_GetFlagStatus
2019  0490 4d            	tnz	a
2020  0491 27f8          	jreq	L726
2021                     ; 727 SPI_SendData( 255 );
2023  0493 a6ff          	ld	a,#255
2024  0495 cd0000        	call	_SPI_SendData
2027  0498               L536:
2028                     ; 728 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2030  0498 a602          	ld	a,#2
2031  049a cd0000        	call	_SPI_GetFlagStatus
2033  049d 4d            	tnz	a
2034  049e 27f8          	jreq	L536
2035                     ; 730   *data = SPI_ReceiveData(); 
2037  04a0 cd0000        	call	_SPI_ReceiveData
2039  04a3 1e01          	ldw	x,(OFST+1,sp)
2040  04a5 f7            	ld	(x),a
2042  04a6               L546:
2043                     ; 732   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
2045  04a6 a601          	ld	a,#1
2046  04a8 cd0000        	call	_SPI_GetFlagStatus
2048  04ab 4d            	tnz	a
2049  04ac 27f8          	jreq	L546
2050                     ; 736 	delay_us(1);
2052  04ae ae0001        	ldw	x,#1
2053  04b1 cd0639        	call	_delay_us
2055                     ; 738   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2057  04b4 4b02          	push	#2
2058  04b6 ae5000        	ldw	x,#20480
2059  04b9 cd0000        	call	_GPIO_WriteHigh
2061  04bc 84            	pop	a
2062                     ; 739 }
2065  04bd 85            	popw	x
2066  04be 81            	ret
2106                     ; 748 void MCP_23K256_write_status_register(uint8_t data)
2106                     ; 749 {
2107                     	switch	.text
2108  04bf               _MCP_23K256_write_status_register:
2110  04bf 88            	push	a
2111       00000000      OFST:	set	0
2114  04c0               L176:
2115                     ; 751   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2117  04c0 a680          	ld	a,#128
2118  04c2 cd0000        	call	_SPI_GetFlagStatus
2120  04c5 4d            	tnz	a
2121  04c6 26f8          	jrne	L176
2122                     ; 753   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2124  04c8 4b02          	push	#2
2125  04ca ae5000        	ldw	x,#20480
2126  04cd cd0000        	call	_GPIO_WriteLow
2128  04d0 84            	pop	a
2129                     ; 756   SPI_SendData(WRSR); 
2131  04d1 a601          	ld	a,#1
2132  04d3 cd0000        	call	_SPI_SendData
2135  04d6               L776:
2136                     ; 757   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2138  04d6 a602          	ld	a,#2
2139  04d8 cd0000        	call	_SPI_GetFlagStatus
2141  04db 4d            	tnz	a
2142  04dc 27f8          	jreq	L776
2143                     ; 760   SPI_SendData(data); 
2145  04de 7b01          	ld	a,(OFST+1,sp)
2146  04e0 cd0000        	call	_SPI_SendData
2149  04e3               L507:
2150                     ; 761   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2152  04e3 a602          	ld	a,#2
2153  04e5 cd0000        	call	_SPI_GetFlagStatus
2155  04e8 4d            	tnz	a
2156  04e9 27f8          	jreq	L507
2157                     ; 765 	delay_us(1);
2159  04eb ae0001        	ldw	x,#1
2160  04ee cd0639        	call	_delay_us
2162                     ; 767   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2164  04f1 4b02          	push	#2
2165  04f3 ae5000        	ldw	x,#20480
2166  04f6 cd0000        	call	_GPIO_WriteHigh
2168  04f9 84            	pop	a
2169                     ; 769 }
2172  04fa 84            	pop	a
2173  04fb 81            	ret
2231                     ; 778 void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
2231                     ; 779 {
2232                     	switch	.text
2233  04fc               _MCP_23K256_RAM_write_byte:
2235  04fc 89            	pushw	x
2236  04fd 88            	push	a
2237       00000001      OFST:	set	1
2240                     ; 780 	uint8_t addr = 0;
2243  04fe               L147:
2244                     ; 782   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2246  04fe a680          	ld	a,#128
2247  0500 cd0000        	call	_SPI_GetFlagStatus
2249  0503 4d            	tnz	a
2250  0504 26f8          	jrne	L147
2251                     ; 784   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2253  0506 4b02          	push	#2
2254  0508 ae5000        	ldw	x,#20480
2255  050b cd0000        	call	_GPIO_WriteLow
2257  050e 84            	pop	a
2258                     ; 787   SPI_SendData(WRITE); // instruction 2 write
2260  050f a602          	ld	a,#2
2261  0511 cd0000        	call	_SPI_SendData
2264  0514               L747:
2265                     ; 788   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2267  0514 a602          	ld	a,#2
2268  0516 cd0000        	call	_SPI_GetFlagStatus
2270  0519 4d            	tnz	a
2271  051a 27f8          	jreq	L747
2272                     ; 791 	addr = address>>8;
2274  051c 7b02          	ld	a,(OFST+1,sp)
2275  051e 6b01          	ld	(OFST+0,sp),a
2277                     ; 792   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2279  0520 7b01          	ld	a,(OFST+0,sp)
2280  0522 cd0000        	call	_SPI_SendData
2283  0525               L557:
2284                     ; 793   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2286  0525 a602          	ld	a,#2
2287  0527 cd0000        	call	_SPI_GetFlagStatus
2289  052a 4d            	tnz	a
2290  052b 27f8          	jreq	L557
2291                     ; 796 	addr = (address&255);
2293  052d 7b03          	ld	a,(OFST+2,sp)
2294  052f a4ff          	and	a,#255
2295  0531 6b01          	ld	(OFST+0,sp),a
2297                     ; 797   SPI_SendData( addr );
2299  0533 7b01          	ld	a,(OFST+0,sp)
2300  0535 cd0000        	call	_SPI_SendData
2303  0538               L367:
2304                     ; 798   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2306  0538 a602          	ld	a,#2
2307  053a cd0000        	call	_SPI_GetFlagStatus
2309  053d 4d            	tnz	a
2310  053e 27f8          	jreq	L367
2311                     ; 800   SPI_SendData(value); 
2313  0540 7b06          	ld	a,(OFST+5,sp)
2314  0542 cd0000        	call	_SPI_SendData
2317  0545               L177:
2318                     ; 802   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2320  0545 a602          	ld	a,#2
2321  0547 cd0000        	call	_SPI_GetFlagStatus
2323  054a 4d            	tnz	a
2324  054b 27f8          	jreq	L177
2325                     ; 806 	delay_us(1);
2327  054d ae0001        	ldw	x,#1
2328  0550 cd0639        	call	_delay_us
2330                     ; 808   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2332  0553 4b02          	push	#2
2333  0555 ae5000        	ldw	x,#20480
2334  0558 cd0000        	call	_GPIO_WriteHigh
2336  055b 84            	pop	a
2337                     ; 811 }
2340  055c 5b03          	addw	sp,#3
2341  055e 81            	ret
2401                     ; 818 void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
2401                     ; 819 {		
2402                     	switch	.text
2403  055f               _MCP_23K256_RAM_read_byte:
2405  055f 89            	pushw	x
2406  0560 88            	push	a
2407       00000001      OFST:	set	1
2410                     ; 820 	uint8_t addr = 0;
2413  0561               L5201:
2414                     ; 822   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2416  0561 a680          	ld	a,#128
2417  0563 cd0000        	call	_SPI_GetFlagStatus
2419  0566 4d            	tnz	a
2420  0567 26f8          	jrne	L5201
2421                     ; 824   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2423  0569 4b02          	push	#2
2424  056b ae5000        	ldw	x,#20480
2425  056e cd0000        	call	_GPIO_WriteLow
2427  0571 84            	pop	a
2428                     ; 826   SPI_SendData(READ); // instruction 3 read
2430  0572 a603          	ld	a,#3
2431  0574 cd0000        	call	_SPI_SendData
2434  0577               L3301:
2435                     ; 828   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2437  0577 a602          	ld	a,#2
2438  0579 cd0000        	call	_SPI_GetFlagStatus
2440  057c 4d            	tnz	a
2441  057d 27f8          	jreq	L3301
2442                     ; 831 	addr = address>>8;
2444  057f 7b02          	ld	a,(OFST+1,sp)
2445  0581 6b01          	ld	(OFST+0,sp),a
2447                     ; 832   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2449  0583 7b01          	ld	a,(OFST+0,sp)
2450  0585 cd0000        	call	_SPI_SendData
2453  0588               L1401:
2454                     ; 833   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2456  0588 a602          	ld	a,#2
2457  058a cd0000        	call	_SPI_GetFlagStatus
2459  058d 4d            	tnz	a
2460  058e 27f8          	jreq	L1401
2461                     ; 836 	addr = (address&255);
2463  0590 7b03          	ld	a,(OFST+2,sp)
2464  0592 a4ff          	and	a,#255
2465  0594 6b01          	ld	(OFST+0,sp),a
2467                     ; 837   SPI_SendData( addr );
2469  0596 7b01          	ld	a,(OFST+0,sp)
2470  0598 cd0000        	call	_SPI_SendData
2473  059b               L7401:
2474                     ; 838   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2476  059b a602          	ld	a,#2
2477  059d cd0000        	call	_SPI_GetFlagStatus
2479  05a0 4d            	tnz	a
2480  05a1 27f8          	jreq	L7401
2482  05a3               L5501:
2483                     ; 842 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2485  05a3 a601          	ld	a,#1
2486  05a5 cd0000        	call	_SPI_GetFlagStatus
2488  05a8 4d            	tnz	a
2489  05a9 27f8          	jreq	L5501
2490                     ; 843 SPI_SendData( 255 );
2492  05ab a6ff          	ld	a,#255
2493  05ad cd0000        	call	_SPI_SendData
2496  05b0               L3601:
2497                     ; 844 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2499  05b0 a602          	ld	a,#2
2500  05b2 cd0000        	call	_SPI_GetFlagStatus
2502  05b5 4d            	tnz	a
2503  05b6 27f8          	jreq	L3601
2505  05b8               L1701:
2506                     ; 845 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));	
2508  05b8 a601          	ld	a,#1
2509  05ba cd0000        	call	_SPI_GetFlagStatus
2511  05bd 4d            	tnz	a
2512  05be 27f8          	jreq	L1701
2513                     ; 848   *value = SPI_ReceiveData();  
2515  05c0 cd0000        	call	_SPI_ReceiveData
2517  05c3 1e06          	ldw	x,(OFST+5,sp)
2518  05c5 f7            	ld	(x),a
2519                     ; 855 	delay_us(1);
2521  05c6 ae0001        	ldw	x,#1
2522  05c9 ad6e          	call	_delay_us
2524                     ; 857   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2526  05cb 4b02          	push	#2
2527  05cd ae5000        	ldw	x,#20480
2528  05d0 cd0000        	call	_GPIO_WriteHigh
2530  05d3 84            	pop	a
2531                     ; 858 }
2534  05d4 5b03          	addw	sp,#3
2535  05d6 81            	ret
2560                     ; 863 void MCP4901_DAC_init(void)
2560                     ; 864 {
2561                     	switch	.text
2562  05d7               _MCP4901_DAC_init:
2566                     ; 865   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
2568  05d7 4bf0          	push	#240
2569  05d9 4b10          	push	#16
2570  05db ae500a        	ldw	x,#20490
2571  05de cd0000        	call	_GPIO_Init
2573  05e1 85            	popw	x
2574                     ; 866   delay_ms(10);
2576  05e2 ae000a        	ldw	x,#10
2577  05e5 ad71          	call	_delay_ms
2579                     ; 867 }
2582  05e7 81            	ret
2630                     ; 873 void MCP4901_DAC_write( unsigned char value)
2630                     ; 874 {
2631                     	switch	.text
2632  05e8               _MCP4901_DAC_write:
2634  05e8 88            	push	a
2635  05e9 88            	push	a
2636       00000001      OFST:	set	1
2639                     ; 902 	unsigned char address = 0x30; // 00,11,00,00
2641  05ea a630          	ld	a,#48
2642  05ec 6b01          	ld	(OFST+0,sp),a
2644                     ; 903 	address |= ( value>>4); // assume 0's shoved in the left
2646  05ee 7b02          	ld	a,(OFST+1,sp)
2647  05f0 4e            	swap	a
2648  05f1 a40f          	and	a,#15
2649  05f3 1a01          	or	a,(OFST+0,sp)
2650  05f5 6b01          	ld	(OFST+0,sp),a
2652                     ; 905 	value = ( value<<4 ); // assume 0 shoved in from the right
2654  05f7 7b02          	ld	a,(OFST+1,sp)
2655  05f9 4e            	swap	a
2656  05fa a4f0          	and	a,#240
2657  05fc 6b02          	ld	(OFST+1,sp),a
2659  05fe               L1311:
2660                     ; 908   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2662  05fe a680          	ld	a,#128
2663  0600 cd0000        	call	_SPI_GetFlagStatus
2665  0603 4d            	tnz	a
2666  0604 26f8          	jrne	L1311
2667                     ; 910   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
2669  0606 4b10          	push	#16
2670  0608 ae500a        	ldw	x,#20490
2671  060b cd0000        	call	_GPIO_WriteLow
2673  060e 84            	pop	a
2674                     ; 912   SPI_SendData(address);
2676  060f 7b01          	ld	a,(OFST+0,sp)
2677  0611 cd0000        	call	_SPI_SendData
2680  0614               L7311:
2681                     ; 914   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2683  0614 a602          	ld	a,#2
2684  0616 cd0000        	call	_SPI_GetFlagStatus
2686  0619 4d            	tnz	a
2687  061a 27f8          	jreq	L7311
2688                     ; 916   SPI_SendData(value); 
2690  061c 7b02          	ld	a,(OFST+1,sp)
2691  061e cd0000        	call	_SPI_SendData
2694  0621               L5411:
2695                     ; 918   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2697  0621 a602          	ld	a,#2
2698  0623 cd0000        	call	_SPI_GetFlagStatus
2700  0626 4d            	tnz	a
2701  0627 27f8          	jreq	L5411
2702                     ; 922 	delay_us(1);
2704  0629 ae0001        	ldw	x,#1
2705  062c ad0b          	call	_delay_us
2707                     ; 929   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
2709  062e 4b10          	push	#16
2710  0630 ae500a        	ldw	x,#20490
2711  0633 cd0000        	call	_GPIO_WriteHigh
2713  0636 84            	pop	a
2714                     ; 931 }
2717  0637 85            	popw	x
2718  0638 81            	ret
2762                     ; 940 void delay_us(unsigned int  value)
2762                     ; 941 {
2763                     	switch	.text
2764  0639               _delay_us:
2766  0639 89            	pushw	x
2767       00000002      OFST:	set	2
2770                     ; 942 	register unsigned int loops =  (dly_const * value) ;
2772  063a cd0000        	call	c_uitof
2774  063d ae0000        	ldw	x,#L7711
2775  0640 cd0000        	call	c_fmul
2777  0643 cd0000        	call	c_ftoi
2779  0646 1f01          	ldw	(OFST-1,sp),x
2782  0648 2008          	jra	L7021
2783  064a               L3021:
2784                     ; 946 		_asm ("nop");
2787  064a 9d            nop
2789                     ; 947 		loops--;
2791  064b 1e01          	ldw	x,(OFST-1,sp)
2792  064d 1d0001        	subw	x,#1
2793  0650 1f01          	ldw	(OFST-1,sp),x
2795  0652               L7021:
2796                     ; 944 	while(loops)
2798  0652 1e01          	ldw	x,(OFST-1,sp)
2799  0654 26f4          	jrne	L3021
2800                     ; 949 }
2804  0656 85            	popw	x
2805  0657 81            	ret
2840                     ; 951 void delay_ms(unsigned int  value)
2840                     ; 952 {
2841                     	switch	.text
2842  0658               _delay_ms:
2844  0658 89            	pushw	x
2845       00000000      OFST:	set	0
2848  0659 200c          	jra	L3321
2849  065b               L1321:
2850                     ; 955 		delay_us(1000);
2852  065b ae03e8        	ldw	x,#1000
2853  065e add9          	call	_delay_us
2855                     ; 956 		value--;
2857  0660 1e01          	ldw	x,(OFST+1,sp)
2858  0662 1d0001        	subw	x,#1
2859  0665 1f01          	ldw	(OFST+1,sp),x
2860  0667               L3321:
2861                     ; 953 	while(value)
2863  0667 1e01          	ldw	x,(OFST+1,sp)
2864  0669 26f0          	jrne	L1321
2865                     ; 958 }
2869  066b 85            	popw	x
2870  066c 81            	ret
2883                     	xdef	_main
2884                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
2885                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
2886                     	xdef	_TEST_adc_to_ram_to_dac
2887                     	xdef	_TEST_adc_to_dac
2888                     	xdef	_TEST_rampfunc_in_ram_to_dac
2889                     	xdef	_TEST_ram_test_001
2890                     	xdef	_delay_ms
2891                     	xdef	_delay_us
2892                     	xdef	_MCP_23K256_write_status_register
2893                     	xdef	_MCP_23K256_read_status_register
2894                     	xdef	_MCP_23K256_RAM_write_byte
2895                     	xdef	_MCP_23K256_RAM_read_byte
2896                     	xdef	_MCP_23K256_init
2897                     	xdef	_MCP4901_DAC_init
2898                     	xdef	_MCP4901_DAC_write
2899                     	xdef	_TIM2_setup
2900                     	xdef	_ADC1_setup_scan_mode
2901                     	xdef	_ADC1_setup
2902                     	xdef	_SPI_setup
2903                     	xdef	_GPIO_setup
2904                     	xdef	_clock_setup
2905                     	xref	_TIM2_Cmd
2906                     	xref	_TIM2_OC1Init
2907                     	xref	_TIM2_TimeBaseInit
2908                     	xref	_TIM2_DeInit
2909                     	xref	_SPI_GetFlagStatus
2910                     	xref	_SPI_ReceiveData
2911                     	xref	_SPI_SendData
2912                     	xref	_SPI_Cmd
2913                     	xref	_SPI_Init
2914                     	xref	_SPI_DeInit
2915                     	xref	_GPIO_WriteLow
2916                     	xref	_GPIO_WriteHigh
2917                     	xref	_GPIO_Init
2918                     	xref	_GPIO_DeInit
2919                     	xref	_CLK_GetFlagStatus
2920                     	xref	_CLK_SYSCLKConfig
2921                     	xref	_CLK_HSIPrescalerConfig
2922                     	xref	_CLK_ClockSwitchConfig
2923                     	xref	_CLK_PeripheralClockConfig
2924                     	xref	_CLK_ClockSwitchCmd
2925                     	xref	_CLK_LSICmd
2926                     	xref	_CLK_HSICmd
2927                     	xref	_CLK_HSECmd
2928                     	xref	_CLK_DeInit
2929                     	xref	_ADC1_ClearFlag
2930                     	xref	_ADC1_GetFlagStatus
2931                     	xref	_ADC1_GetBufferValue
2932                     	xref	_ADC1_GetConversionValue
2933                     	xref	_ADC1_StartConversion
2934                     	xref	_ADC1_ConversionConfig
2935                     	xref	_ADC1_DataBufferCmd
2936                     	xref	_ADC1_ScanModeCmd
2937                     	xref	_ADC1_Cmd
2938                     	xref	_ADC1_Init
2939                     	xref	_ADC1_DeInit
2940                     .const:	section	.text
2941  0000               L7711:
2942  0000 3e000000      	dc.w	15872,0
2943  0004               L521:
2944  0004 447fc000      	dc.w	17535,-16384
2945  0008               L511:
2946  0008 3e800000      	dc.w	16000,0
2947                     	xref.b	c_lreg
2948                     	xref.b	c_x
2968                     	xref	c_ftoi
2969                     	xref	c_rtol
2970                     	xref	c_itof
2971                     	xref	c_fdiv
2972                     	xref	c_ftol
2973                     	xref	c_fmul
2974                     	xref	c_uitof
2975                     	end
