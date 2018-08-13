   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
 125                     ; 103 void main(void)
 125                     ; 104 {
 127                     	switch	.text
 128  0000               _main:
 130  0000 520d          	subw	sp,#13
 131       0000000d      OFST:	set	13
 134                     ; 108 	uint16_t adc_val = 0;	
 136                     ; 109 	uint8_t mapd_value = 0; // mapped adc valu
 138                     ; 110 	uint8_t read_val = 0;	//read val from ram
 140  0002 0f06          	clr	(OFST-7,sp)
 142                     ; 111 	uint16_t write_addr = 0;	//write addr in ram
 144  0004 5f            	clrw	x
 145  0005 1f0c          	ldw	(OFST-1,sp),x
 147                     ; 112 	uint16_t read_addr = 0;	// read addr in val
 149  0007 1f07          	ldw	(OFST-6,sp),x
 151                     ; 113 	uint16_t delay = 110; // length of delay in samples
 153  0009 ae006e        	ldw	x,#110
 154  000c 1f09          	ldw	(OFST-4,sp),x
 156                     ; 114 	uint8_t res = 0;
 158                     ; 116 	clock_setup();
 160  000e cd01f3        	call	_clock_setup
 162                     ; 117 	GPIO_setup();
 164  0011 cd0253        	call	_GPIO_setup
 166                     ; 118 	ADC1_setup();
 168  0014 cd0276        	call	_ADC1_setup
 170                     ; 119 	SPI_setup();	
 172  0017 cd02b2        	call	_SPI_setup
 174                     ; 120 	MCP_23K256_init();
 176  001a cd02ce        	call	_MCP_23K256_init
 178                     ; 121 	MCP4901_DAC_init();
 180  001d cd043e        	call	_MCP4901_DAC_init
 182  0020               L75:
 183                     ; 147 		ADC1_StartConversion();
 185  0020 cd0000        	call	_ADC1_StartConversion
 188  0023               L56:
 189                     ; 148 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 191  0023 a680          	ld	a,#128
 192  0025 cd0000        	call	_ADC1_GetFlagStatus
 194  0028 4d            	tnz	a
 195  0029 27f8          	jreq	L56
 196                     ; 150 		adc_val = ADC1_GetConversionValue(); // for led knob
 198  002b cd0000        	call	_ADC1_GetConversionValue
 200  002e 1f04          	ldw	(OFST-9,sp),x
 202                     ; 151 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 204  0030 a680          	ld	a,#128
 205  0032 cd0000        	call	_ADC1_ClearFlag
 207                     ; 158 		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 209  0035 1e04          	ldw	x,(OFST-9,sp)
 210  0037 cd0000        	call	c_uitof
 212  003a ae0004        	ldw	x,#L57
 213  003d cd0000        	call	c_fmul
 215  0040 cd0000        	call	c_ftol
 217  0043 b603          	ld	a,c_lreg+3
 218  0045 6b0b          	ld	(OFST-2,sp),a
 220                     ; 161 		mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
 222  0047 5f            	clrw	x
 223  0048 7b06          	ld	a,(OFST-7,sp)
 224  004a 97            	ld	xl,a
 225  004b 57            	sraw	x
 226  004c 1f01          	ldw	(OFST-12,sp),x
 228  004e 5f            	clrw	x
 229  004f 7b0b          	ld	a,(OFST-2,sp)
 230  0051 97            	ld	xl,a
 231  0052 57            	sraw	x
 232  0053 72fb01        	addw	x,(OFST-12,sp)
 233  0056 01            	rrwa	x,a
 234  0057 6b0b          	ld	(OFST-2,sp),a
 236                     ; 172 			read_addr = write_addr - delay;
 238  0059 1e0c          	ldw	x,(OFST-1,sp)
 239  005b 72f009        	subw	x,(OFST-4,sp)
 240  005e 1f07          	ldw	(OFST-6,sp),x
 242                     ; 176 		MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 244  0060 88            	push	a
 245  0061 1e0d          	ldw	x,(OFST+0,sp)
 246  0063 cd036f        	call	_MCP_23K256_RAM_write_byte
 248  0066 84            	pop	a
 249                     ; 179 		mapd_value = 0; // check value
 251                     ; 180 		MCP_23K256_RAM_read_byte(read_addr, &read_val);
 253  0067 96            	ldw	x,sp
 254  0068 1c0006        	addw	x,#OFST-7
 255  006b 89            	pushw	x
 256  006c 1e09          	ldw	x,(OFST-4,sp)
 257  006e cd03cc        	call	_MCP_23K256_RAM_read_byte
 259  0071 85            	popw	x
 260                     ; 183 		MCP4901_DAC_write(read_val);
 262  0072 7b06          	ld	a,(OFST-7,sp)
 263  0074 cd044e        	call	_MCP4901_DAC_write
 265                     ; 186 		write_addr++;
 267  0077 1e0c          	ldw	x,(OFST-1,sp)
 268  0079 5c            	incw	x
 269  007a 1f0c          	ldw	(OFST-1,sp),x
 271                     ; 189 		delay_us(90);
 273  007c ae005a        	ldw	x,#90
 274  007f cd049f        	call	_delay_us
 277  0082 209c          	jra	L75
 342                     ; 205 uint8_t TEST_ram_test_001(void)
 342                     ; 206 {
 343                     	switch	.text
 344  0084               _TEST_ram_test_001:
 346  0084 5205          	subw	sp,#5
 347       00000005      OFST:	set	5
 350                     ; 207 	uint8_t cnt = 0;
 352                     ; 208 	uint8_t data = 0;
 355                     ; 209 	uint8_t wdata = 0;
 357                     ; 210 	uint16_t addr = 0;
 359                     ; 213 	data = BYTE_MODE;
 361  0086 0f03          	clr	(OFST-2,sp)
 363                     ; 214 	MCP_23K256_write_status_register(data);
 365  0088 4f            	clr	a
 366  0089 cd0332        	call	_MCP_23K256_write_status_register
 368                     ; 217 	MCP_23K256_read_status_register(&data);
 370  008c 96            	ldw	x,sp
 371  008d 1c0003        	addw	x,#OFST-2
 372  0090 cd02df        	call	_MCP_23K256_read_status_register
 374                     ; 261 wdata = 2;
 376  0093 a602          	ld	a,#2
 377  0095 6b02          	ld	(OFST-3,sp),a
 379                     ; 262 addr =0;
 381  0097 5f            	clrw	x
 382  0098 1f04          	ldw	(OFST-1,sp),x
 384                     ; 264 	MCP_23K256_RAM_write_byte(addr, wdata);
 386  009a 4b02          	push	#2
 387  009c cd036f        	call	_MCP_23K256_RAM_write_byte
 389  009f 84            	pop	a
 390                     ; 267 	MCP_23K256_RAM_read_byte(addr, &data);
 392  00a0 96            	ldw	x,sp
 393  00a1 1c0003        	addw	x,#OFST-2
 394  00a4 89            	pushw	x
 395  00a5 1e06          	ldw	x,(OFST+1,sp)
 396  00a7 cd03cc        	call	_MCP_23K256_RAM_read_byte
 398  00aa a6fa          	ld	a,#250
 399  00ac 85            	popw	x
 400                     ; 269 	if (wdata != data)
 402                     ; 274 wdata = 250;
 404  00ad 6b02          	ld	(OFST-3,sp),a
 406                     ; 275 addr =1;
 408  00af ae0001        	ldw	x,#1
 409  00b2 1f04          	ldw	(OFST-1,sp),x
 411                     ; 277 	MCP_23K256_RAM_write_byte(addr, wdata);
 413  00b4 4bfa          	push	#250
 414  00b6 cd036f        	call	_MCP_23K256_RAM_write_byte
 416  00b9 84            	pop	a
 417                     ; 280 	MCP_23K256_RAM_read_byte(addr, &data);
 419  00ba 96            	ldw	x,sp
 420  00bb 1c0003        	addw	x,#OFST-2
 421  00be 89            	pushw	x
 422  00bf 1e06          	ldw	x,(OFST+1,sp)
 423  00c1 cd03cc        	call	_MCP_23K256_RAM_read_byte
 425  00c4 a604          	ld	a,#4
 426  00c6 85            	popw	x
 427                     ; 282 	if (wdata != data)
 429                     ; 287 wdata = 4;
 431  00c7 6b02          	ld	(OFST-3,sp),a
 433                     ; 288 addr =2;
 435  00c9 ae0002        	ldw	x,#2
 436  00cc 1f04          	ldw	(OFST-1,sp),x
 438                     ; 290 	MCP_23K256_RAM_write_byte(addr, wdata);
 440  00ce 4b04          	push	#4
 441  00d0 cd036f        	call	_MCP_23K256_RAM_write_byte
 443  00d3 84            	pop	a
 444                     ; 293 	MCP_23K256_RAM_read_byte(addr, &data);
 446  00d4 96            	ldw	x,sp
 447  00d5 1c0003        	addw	x,#OFST-2
 448  00d8 89            	pushw	x
 449  00d9 1e06          	ldw	x,(OFST+1,sp)
 450  00db cd03cc        	call	_MCP_23K256_RAM_read_byte
 452  00de 85            	popw	x
 453                     ; 295 	if (wdata != data)
 455                     ; 301 	for(addr = 0; addr<3; addr++)
 457  00df 5f            	clrw	x
 458  00e0 1f04          	ldw	(OFST-1,sp),x
 460  00e2               L141:
 461                     ; 303 		MCP_23K256_RAM_read_byte(addr, &data);
 463  00e2 96            	ldw	x,sp
 464  00e3 1c0003        	addw	x,#OFST-2
 465  00e6 89            	pushw	x
 466  00e7 1e06          	ldw	x,(OFST+1,sp)
 467  00e9 cd03cc        	call	_MCP_23K256_RAM_read_byte
 469  00ec 85            	popw	x
 470                     ; 301 	for(addr = 0; addr<3; addr++)
 472  00ed 1e04          	ldw	x,(OFST-1,sp)
 473  00ef 5c            	incw	x
 474  00f0 1f04          	ldw	(OFST-1,sp),x
 478  00f2 a30003        	cpw	x,#3
 479  00f5 25eb          	jrult	L141
 480                     ; 305 	return 0;
 482  00f7 4f            	clr	a
 485  00f8 5b05          	addw	sp,#5
 486  00fa 81            	ret	
 543                     ; 312 uint8_t TEST_rampfunc_in_ram_to_dac(void)
 543                     ; 313 {
 544                     	switch	.text
 545  00fb               _TEST_rampfunc_in_ram_to_dac:
 547  00fb 5204          	subw	sp,#4
 548       00000004      OFST:	set	4
 551                     ; 314 	uint8_t data = 0;
 553  00fd 0f02          	clr	(OFST-2,sp)
 555                     ; 315 	uint8_t wdata = 0;
 557  00ff 0f01          	clr	(OFST-3,sp)
 559                     ; 316 	uint16_t addr = 0;	
 561                     ; 319 	for(addr = 0, wdata; addr<255; addr++, wdata++)
 563  0101 5f            	clrw	x
 564  0102 1f03          	ldw	(OFST-1,sp),x
 566  0104               L571:
 567                     ; 321 		MCP_23K256_RAM_write_byte(addr, wdata);
 569  0104 7b01          	ld	a,(OFST-3,sp)
 570  0106 88            	push	a
 571  0107 1e04          	ldw	x,(OFST+0,sp)
 572  0109 cd036f        	call	_MCP_23K256_RAM_write_byte
 574  010c 84            	pop	a
 575                     ; 319 	for(addr = 0, wdata; addr<255; addr++, wdata++)
 577  010d 1e03          	ldw	x,(OFST-1,sp)
 578  010f 5c            	incw	x
 579  0110 1f03          	ldw	(OFST-1,sp),x
 584  0112 a300ff        	cpw	x,#255
 585  0115 0c01          	inc	(OFST-3,sp)
 586  0117 25eb          	jrult	L571
 587  0119               L302:
 588                     ; 327 		for(addr = 0; addr<255; addr++)
 590  0119 5f            	clrw	x
 591  011a 1f03          	ldw	(OFST-1,sp),x
 593  011c               L702:
 594                     ; 329 			MCP_23K256_RAM_read_byte(addr, &data);
 596  011c 96            	ldw	x,sp
 597  011d 1c0002        	addw	x,#OFST-2
 598  0120 89            	pushw	x
 599  0121 1e05          	ldw	x,(OFST+1,sp)
 600  0123 cd03cc        	call	_MCP_23K256_RAM_read_byte
 602  0126 85            	popw	x
 603                     ; 330 			MCP4901_DAC_write(data);
 605  0127 7b02          	ld	a,(OFST-2,sp)
 606  0129 cd044e        	call	_MCP4901_DAC_write
 608                     ; 331 			delay_us(90);	//11kHz sample rate
 610  012c ae005a        	ldw	x,#90
 611  012f cd049f        	call	_delay_us
 613                     ; 327 		for(addr = 0; addr<255; addr++)
 615  0132 1e03          	ldw	x,(OFST-1,sp)
 616  0134 5c            	incw	x
 617  0135 1f03          	ldw	(OFST-1,sp),x
 621  0137 a300ff        	cpw	x,#255
 622  013a 25e0          	jrult	L702
 624  013c 20db          	jra	L302
 659                     ; 339 void TEST_adc_to_dac(uint8_t *x)
 659                     ; 340 {
 660                     	switch	.text
 661  013e               _TEST_adc_to_dac:
 665                     ; 364 }
 668  013e 81            	ret	
 729                     ; 367 void TEST_adc_to_ram_to_dac(void)
 729                     ; 368 {
 730                     	switch	.text
 731  013f               _TEST_adc_to_ram_to_dac:
 733  013f 5205          	subw	sp,#5
 734       00000005      OFST:	set	5
 737                     ; 369 	uint16_t adc_val = 0;
 739                     ; 370 	uint16_t addr = 0;
 741  0141 5f            	clrw	x
 742  0142 1f03          	ldw	(OFST-2,sp),x
 744                     ; 371 	uint8_t mapd_value = 0; 
 746  0144 0f05          	clr	(OFST+0,sp)
 748  0146               L162:
 749                     ; 376 		ADC1_StartConversion();
 751  0146 cd0000        	call	_ADC1_StartConversion
 754  0149               L762:
 755                     ; 377 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 757  0149 a680          	ld	a,#128
 758  014b cd0000        	call	_ADC1_GetFlagStatus
 760  014e 4d            	tnz	a
 761  014f 27f8          	jreq	L762
 762                     ; 379 		adc_val = ADC1_GetConversionValue(); // for led knob
 764  0151 cd0000        	call	_ADC1_GetConversionValue
 766  0154 1f01          	ldw	(OFST-4,sp),x
 768                     ; 380 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 770  0156 a680          	ld	a,#128
 771  0158 cd0000        	call	_ADC1_ClearFlag
 773                     ; 387 		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 775  015b 1e01          	ldw	x,(OFST-4,sp)
 776  015d cd0000        	call	c_uitof
 778  0160 ae0004        	ldw	x,#L57
 779  0163 cd0000        	call	c_fmul
 781  0166 cd0000        	call	c_ftol
 783  0169 b603          	ld	a,c_lreg+3
 784  016b 6b05          	ld	(OFST+0,sp),a
 786                     ; 390 		MCP_23K256_RAM_write_byte(addr, mapd_value);
 788  016d 88            	push	a
 789  016e 1e04          	ldw	x,(OFST-1,sp)
 790  0170 cd036f        	call	_MCP_23K256_RAM_write_byte
 792  0173 84            	pop	a
 793                     ; 393 		mapd_value = 0; // check value
 795  0174 0f05          	clr	(OFST+0,sp)
 797                     ; 394 		MCP_23K256_RAM_read_byte(addr, &mapd_value);
 799  0176 96            	ldw	x,sp
 800  0177 1c0005        	addw	x,#OFST+0
 801  017a 89            	pushw	x
 802  017b 1e05          	ldw	x,(OFST+0,sp)
 803  017d cd03cc        	call	_MCP_23K256_RAM_read_byte
 805  0180 85            	popw	x
 806                     ; 397 		addr++;
 808  0181 1e03          	ldw	x,(OFST-2,sp)
 809  0183 5c            	incw	x
 810  0184 1f03          	ldw	(OFST-2,sp),x
 812                     ; 399 		MCP4901_DAC_write(mapd_value);
 814  0186 7b05          	ld	a,(OFST+0,sp)
 815  0188 cd044e        	call	_MCP4901_DAC_write
 817                     ; 402 		delay_us(90);
 819  018b ae005a        	ldw	x,#90
 820  018e cd049f        	call	_delay_us
 823  0191 20b3          	jra	L162
 920                     ; 409 void TEST_adc_to_ram_to_dac_with_delay(void)
 920                     ; 410 {
 921                     	switch	.text
 922  0193               _TEST_adc_to_ram_to_dac_with_delay:
 924  0193 520b          	subw	sp,#11
 925       0000000b      OFST:	set	11
 928                     ; 411 	uint16_t adc_val = 0;	
 930                     ; 412 	uint8_t mapd_value = 0; // mapped adc valu
 932                     ; 413 	uint8_t read_val = 0;	//read val from ram
 934  0195 0f04          	clr	(OFST-7,sp)
 936                     ; 414 	uint16_t write_addr = 0;	//write addr in ram
 938  0197 5f            	clrw	x
 939  0198 1f0a          	ldw	(OFST-1,sp),x
 941                     ; 415 	uint16_t read_addr = 0;	// read addr in val
 943  019a 1f06          	ldw	(OFST-5,sp),x
 945                     ; 416 	uint16_t delay = 110; // length of delay in samples
 947  019c ae006e        	ldw	x,#110
 948  019f 1f08          	ldw	(OFST-3,sp),x
 950                     ; 417 	uint8_t res = 0;
 952  01a1               L143:
 953                     ; 423 		ADC1_StartConversion();
 955  01a1 cd0000        	call	_ADC1_StartConversion
 958  01a4               L743:
 959                     ; 424 		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 961  01a4 a680          	ld	a,#128
 962  01a6 cd0000        	call	_ADC1_GetFlagStatus
 964  01a9 4d            	tnz	a
 965  01aa 27f8          	jreq	L743
 966                     ; 426 		adc_val = ADC1_GetConversionValue(); // for led knob
 968  01ac cd0000        	call	_ADC1_GetConversionValue
 970  01af 1f02          	ldw	(OFST-9,sp),x
 972                     ; 427 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 974  01b1 a680          	ld	a,#128
 975  01b3 cd0000        	call	_ADC1_ClearFlag
 977                     ; 434 		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 979  01b6 1e02          	ldw	x,(OFST-9,sp)
 980  01b8 cd0000        	call	c_uitof
 982  01bb ae0004        	ldw	x,#L57
 983  01be cd0000        	call	c_fmul
 985  01c1 cd0000        	call	c_ftol
 987  01c4 b603          	ld	a,c_lreg+3
 988  01c6 6b05          	ld	(OFST-6,sp),a
 990                     ; 445 			read_addr = write_addr - delay;
 992  01c8 1e0a          	ldw	x,(OFST-1,sp)
 993  01ca 72f008        	subw	x,(OFST-3,sp)
 994  01cd 1f06          	ldw	(OFST-5,sp),x
 996                     ; 449 		MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 998  01cf 88            	push	a
 999  01d0 1e0b          	ldw	x,(OFST+0,sp)
1000  01d2 cd036f        	call	_MCP_23K256_RAM_write_byte
1002  01d5 84            	pop	a
1003                     ; 452 		mapd_value = 0; // check value
1005                     ; 453 		MCP_23K256_RAM_read_byte(read_addr, &read_val);
1007  01d6 96            	ldw	x,sp
1008  01d7 1c0004        	addw	x,#OFST-7
1009  01da 89            	pushw	x
1010  01db 1e08          	ldw	x,(OFST-3,sp)
1011  01dd cd03cc        	call	_MCP_23K256_RAM_read_byte
1013  01e0 85            	popw	x
1014                     ; 456 		MCP4901_DAC_write(read_val);
1016  01e1 7b04          	ld	a,(OFST-7,sp)
1017  01e3 cd044e        	call	_MCP4901_DAC_write
1019                     ; 459 		write_addr++;
1021  01e6 1e0a          	ldw	x,(OFST-1,sp)
1022  01e8 5c            	incw	x
1023  01e9 1f0a          	ldw	(OFST-1,sp),x
1025                     ; 462 		delay_us(90);
1027  01eb ae005a        	ldw	x,#90
1028  01ee cd049f        	call	_delay_us
1031  01f1 20ae          	jra	L143
1064                     ; 468 void clock_setup(void)
1064                     ; 469 {
1065                     	switch	.text
1066  01f3               _clock_setup:
1070                     ; 470   CLK_DeInit();
1072  01f3 cd0000        	call	_CLK_DeInit
1074                     ; 472   CLK_HSECmd(DISABLE);
1076  01f6 4f            	clr	a
1077  01f7 cd0000        	call	_CLK_HSECmd
1079                     ; 473   CLK_LSICmd(DISABLE);
1081  01fa 4f            	clr	a
1082  01fb cd0000        	call	_CLK_LSICmd
1084                     ; 474   CLK_HSICmd(ENABLE);
1086  01fe a601          	ld	a,#1
1087  0200 cd0000        	call	_CLK_HSICmd
1090  0203               L563:
1091                     ; 475   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
1093  0203 ae0102        	ldw	x,#258
1094  0206 cd0000        	call	_CLK_GetFlagStatus
1096  0209 4d            	tnz	a
1097  020a 27f7          	jreq	L563
1098                     ; 477   CLK_ClockSwitchCmd(ENABLE);
1100  020c a601          	ld	a,#1
1101  020e cd0000        	call	_CLK_ClockSwitchCmd
1103                     ; 478   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1105  0211 4f            	clr	a
1106  0212 cd0000        	call	_CLK_HSIPrescalerConfig
1108                     ; 479   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
1110  0215 a680          	ld	a,#128
1111  0217 cd0000        	call	_CLK_SYSCLKConfig
1113                     ; 481   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
1115  021a 4b01          	push	#1
1116  021c 4b00          	push	#0
1117  021e ae01e1        	ldw	x,#481
1118  0221 cd0000        	call	_CLK_ClockSwitchConfig
1120  0224 85            	popw	x
1121                     ; 483   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
1123  0225 5f            	clrw	x
1124  0226 cd0000        	call	_CLK_PeripheralClockConfig
1126                     ; 484   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
1128  0229 ae0101        	ldw	x,#257
1129  022c cd0000        	call	_CLK_PeripheralClockConfig
1131                     ; 485   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
1133  022f ae0300        	ldw	x,#768
1134  0232 cd0000        	call	_CLK_PeripheralClockConfig
1136                     ; 486   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
1138  0235 ae1200        	ldw	x,#4608
1139  0238 cd0000        	call	_CLK_PeripheralClockConfig
1141                     ; 487   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
1143  023b ae1301        	ldw	x,#4865
1144  023e cd0000        	call	_CLK_PeripheralClockConfig
1146                     ; 488   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
1148  0241 ae0700        	ldw	x,#1792
1149  0244 cd0000        	call	_CLK_PeripheralClockConfig
1151                     ; 489   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
1153  0247 ae0501        	ldw	x,#1281
1154  024a cd0000        	call	_CLK_PeripheralClockConfig
1156                     ; 490   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
1158  024d ae0400        	ldw	x,#1024
1160                     ; 492 }
1163  0250 cc0000        	jp	_CLK_PeripheralClockConfig
1188                     ; 494 void GPIO_setup(void)
1188                     ; 495 {                               
1189                     	switch	.text
1190  0253               _GPIO_setup:
1194                     ; 496   GPIO_DeInit(GPIOC);
1196  0253 ae500a        	ldw	x,#20490
1197  0256 cd0000        	call	_GPIO_DeInit
1199                     ; 500 	GPIO_DeInit(GPIOB);
1201  0259 ae5005        	ldw	x,#20485
1202  025c cd0000        	call	_GPIO_DeInit
1204                     ; 501   GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
1206  025f 4b00          	push	#0
1207  0261 4b01          	push	#1
1208  0263 ae5005        	ldw	x,#20485
1209  0266 cd0000        	call	_GPIO_Init
1211  0269 85            	popw	x
1212                     ; 506 	GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ), 
1212                     ; 507                GPIO_MODE_OUT_PP_HIGH_FAST);
1214  026a 4bf0          	push	#240
1215  026c 4b60          	push	#96
1216  026e ae500a        	ldw	x,#20490
1217  0271 cd0000        	call	_GPIO_Init
1219  0274 85            	popw	x
1220                     ; 508 }
1223  0275 81            	ret	
1249                     ; 510 void ADC1_setup(void)
1249                     ; 511 {
1250                     	switch	.text
1251  0276               _ADC1_setup:
1255                     ; 512   ADC1_DeInit();         
1257  0276 cd0000        	call	_ADC1_DeInit
1259                     ; 514   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1259                     ; 515   ADC1_CHANNEL_0,\
1259                     ; 516   ADC1_PRESSEL_FCPU_D18, \
1259                     ; 517   ADC1_EXTTRIG_GPIO, \
1259                     ; 518   DISABLE, \
1259                     ; 519   ADC1_ALIGN_RIGHT, \
1259                     ; 520   ADC1_SCHMITTTRIG_CHANNEL0, \
1259                     ; 521   DISABLE);
1261  0279 4b00          	push	#0
1262  027b 4b00          	push	#0
1263  027d 4b08          	push	#8
1264  027f 4b00          	push	#0
1265  0281 4b10          	push	#16
1266  0283 4b70          	push	#112
1267  0285 ae0100        	ldw	x,#256
1268  0288 cd0000        	call	_ADC1_Init
1270  028b 5b06          	addw	sp,#6
1271                     ; 523   ADC1_Cmd(ENABLE);
1273  028d a601          	ld	a,#1
1275                     ; 525 }
1278  028f cc0000        	jp	_ADC1_Cmd
1305                     ; 530 void TIM2_setup(void)
1305                     ; 531 {
1306                     	switch	.text
1307  0292               _TIM2_setup:
1311                     ; 532   TIM2_DeInit();
1313  0292 cd0000        	call	_TIM2_DeInit
1315                     ; 533   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
1317  0295 ae03e8        	ldw	x,#1000
1318  0298 89            	pushw	x
1319  0299 a605          	ld	a,#5
1320  029b cd0000        	call	_TIM2_TimeBaseInit
1322  029e 85            	popw	x
1323                     ; 534   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
1325  029f 4b00          	push	#0
1326  02a1 ae03e8        	ldw	x,#1000
1327  02a4 89            	pushw	x
1328  02a5 ae6011        	ldw	x,#24593
1329  02a8 cd0000        	call	_TIM2_OC1Init
1331  02ab 5b03          	addw	sp,#3
1332                     ; 535   TIM2_Cmd(ENABLE);
1334  02ad a601          	ld	a,#1
1336                     ; 537 }
1339  02af cc0000        	jp	_TIM2_Cmd
1365                     ; 540 void SPI_setup(void)
1365                     ; 541 {
1366                     	switch	.text
1367  02b2               _SPI_setup:
1371                     ; 542   SPI_DeInit();
1373  02b2 cd0000        	call	_SPI_DeInit
1375                     ; 547   SPI_Init(SPI_FIRSTBIT_MSB, \
1375                     ; 548 	SPI_BAUDRATEPRESCALER_16, \
1375                     ; 549 	SPI_MODE_MASTER, \
1375                     ; 550 	SPI_CLOCKPOLARITY_LOW, \
1375                     ; 551 	SPI_CLOCKPHASE_1EDGE, \
1375                     ; 552 	SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
1375                     ; 553 	SPI_NSS_SOFT, \
1375                     ; 554 	0x0);
1377  02b5 4b00          	push	#0
1378  02b7 4b02          	push	#2
1379  02b9 4b00          	push	#0
1380  02bb 4b00          	push	#0
1381  02bd 4b00          	push	#0
1382  02bf 4b04          	push	#4
1383  02c1 ae0018        	ldw	x,#24
1384  02c4 cd0000        	call	_SPI_Init
1386  02c7 5b06          	addw	sp,#6
1387                     ; 556   SPI_Cmd(ENABLE);
1389  02c9 a601          	ld	a,#1
1391                     ; 557 }
1394  02cb cc0000        	jp	_SPI_Cmd
1419                     ; 559 void MCP_23K256_init()
1419                     ; 560 {
1420                     	switch	.text
1421  02ce               _MCP_23K256_init:
1425                     ; 561 	GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
1427  02ce 4bf0          	push	#240
1428  02d0 4b02          	push	#2
1429  02d2 ae5000        	ldw	x,#20480
1430  02d5 cd0000        	call	_GPIO_Init
1432  02d8 85            	popw	x
1433                     ; 562   delay_ms(10);
1435  02d9 ae000a        	ldw	x,#10
1437                     ; 563 }
1440  02dc cc04b6        	jp	_delay_ms
1482                     ; 568 void MCP_23K256_read_status_register(uint8_t *data)
1482                     ; 569 {
1483                     	switch	.text
1484  02df               _MCP_23K256_read_status_register:
1486  02df 89            	pushw	x
1487       00000000      OFST:	set	0
1490  02e0               L164:
1491                     ; 571   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1493  02e0 a680          	ld	a,#128
1494  02e2 cd0000        	call	_SPI_GetFlagStatus
1496  02e5 4d            	tnz	a
1497  02e6 26f8          	jrne	L164
1498                     ; 573   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1500  02e8 4b02          	push	#2
1501  02ea ae5000        	ldw	x,#20480
1502  02ed cd0000        	call	_GPIO_WriteLow
1504  02f0 84            	pop	a
1505                     ; 575   SPI_SendData(RDSR); // read ststus reg
1507  02f1 a605          	ld	a,#5
1508  02f3 cd0000        	call	_SPI_SendData
1511  02f6               L764:
1512                     ; 577   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1514  02f6 a602          	ld	a,#2
1515  02f8 cd0000        	call	_SPI_GetFlagStatus
1517  02fb 4d            	tnz	a
1518  02fc 27f8          	jreq	L764
1520  02fe               L574:
1521                     ; 580 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
1523  02fe a601          	ld	a,#1
1524  0300 cd0000        	call	_SPI_GetFlagStatus
1526  0303 4d            	tnz	a
1527  0304 27f8          	jreq	L574
1528                     ; 581 SPI_SendData( 255 );
1530  0306 a6ff          	ld	a,#255
1531  0308 cd0000        	call	_SPI_SendData
1534  030b               L305:
1535                     ; 582 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1537  030b a602          	ld	a,#2
1538  030d cd0000        	call	_SPI_GetFlagStatus
1540  0310 4d            	tnz	a
1541  0311 27f8          	jreq	L305
1542                     ; 584   *data = SPI_ReceiveData(); 
1544  0313 cd0000        	call	_SPI_ReceiveData
1546  0316 1e01          	ldw	x,(OFST+1,sp)
1547  0318 f7            	ld	(x),a
1549  0319               L315:
1550                     ; 586   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
1552  0319 a601          	ld	a,#1
1553  031b cd0000        	call	_SPI_GetFlagStatus
1555  031e 4d            	tnz	a
1556  031f 27f8          	jreq	L315
1557                     ; 590 	delay_us(1);
1559  0321 ae0001        	ldw	x,#1
1560  0324 cd049f        	call	_delay_us
1562                     ; 592   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1564  0327 4b02          	push	#2
1565  0329 ae5000        	ldw	x,#20480
1566  032c cd0000        	call	_GPIO_WriteHigh
1568                     ; 593 }
1571  032f 5b03          	addw	sp,#3
1572  0331 81            	ret	
1612                     ; 602 void MCP_23K256_write_status_register(uint8_t data)
1612                     ; 603 {
1613                     	switch	.text
1614  0332               _MCP_23K256_write_status_register:
1616  0332 88            	push	a
1617       00000000      OFST:	set	0
1620  0333               L735:
1621                     ; 605   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1623  0333 a680          	ld	a,#128
1624  0335 cd0000        	call	_SPI_GetFlagStatus
1626  0338 4d            	tnz	a
1627  0339 26f8          	jrne	L735
1628                     ; 607   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1630  033b 4b02          	push	#2
1631  033d ae5000        	ldw	x,#20480
1632  0340 cd0000        	call	_GPIO_WriteLow
1634  0343 84            	pop	a
1635                     ; 610   SPI_SendData(WRSR); 
1637  0344 a601          	ld	a,#1
1638  0346 cd0000        	call	_SPI_SendData
1641  0349               L545:
1642                     ; 611   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1644  0349 a602          	ld	a,#2
1645  034b cd0000        	call	_SPI_GetFlagStatus
1647  034e 4d            	tnz	a
1648  034f 27f8          	jreq	L545
1649                     ; 614   SPI_SendData(data); 
1651  0351 7b01          	ld	a,(OFST+1,sp)
1652  0353 cd0000        	call	_SPI_SendData
1655  0356               L355:
1656                     ; 615   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1658  0356 a602          	ld	a,#2
1659  0358 cd0000        	call	_SPI_GetFlagStatus
1661  035b 4d            	tnz	a
1662  035c 27f8          	jreq	L355
1663                     ; 619 	delay_us(1);
1665  035e ae0001        	ldw	x,#1
1666  0361 cd049f        	call	_delay_us
1668                     ; 621   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1670  0364 4b02          	push	#2
1671  0366 ae5000        	ldw	x,#20480
1672  0369 cd0000        	call	_GPIO_WriteHigh
1674                     ; 623 }
1677  036c 5b02          	addw	sp,#2
1678  036e 81            	ret	
1736                     ; 632 void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
1736                     ; 633 {
1737                     	switch	.text
1738  036f               _MCP_23K256_RAM_write_byte:
1740  036f 89            	pushw	x
1741  0370 88            	push	a
1742       00000001      OFST:	set	1
1745                     ; 634 	uint8_t addr = 0;
1748  0371               L706:
1749                     ; 636   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1751  0371 a680          	ld	a,#128
1752  0373 cd0000        	call	_SPI_GetFlagStatus
1754  0376 4d            	tnz	a
1755  0377 26f8          	jrne	L706
1756                     ; 638   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1758  0379 4b02          	push	#2
1759  037b ae5000        	ldw	x,#20480
1760  037e cd0000        	call	_GPIO_WriteLow
1762  0381 84            	pop	a
1763                     ; 641   SPI_SendData(WRITE); // instruction 2 write
1765  0382 a602          	ld	a,#2
1766  0384 cd0000        	call	_SPI_SendData
1769  0387               L516:
1770                     ; 642   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1772  0387 a602          	ld	a,#2
1773  0389 cd0000        	call	_SPI_GetFlagStatus
1775  038c 4d            	tnz	a
1776  038d 27f8          	jreq	L516
1777                     ; 645 	addr = address>>8;
1779  038f 7b02          	ld	a,(OFST+1,sp)
1780  0391 6b01          	ld	(OFST+0,sp),a
1782                     ; 646   SPI_SendData(addr); // send 16 bit address // MSB is don't care
1784  0393 cd0000        	call	_SPI_SendData
1787  0396               L326:
1788                     ; 647   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1790  0396 a602          	ld	a,#2
1791  0398 cd0000        	call	_SPI_GetFlagStatus
1793  039b 4d            	tnz	a
1794  039c 27f8          	jreq	L326
1795                     ; 650 	addr = (address&255);
1797  039e 7b03          	ld	a,(OFST+2,sp)
1798  03a0 6b01          	ld	(OFST+0,sp),a
1800                     ; 651   SPI_SendData( addr );
1802  03a2 cd0000        	call	_SPI_SendData
1805  03a5               L136:
1806                     ; 652   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1808  03a5 a602          	ld	a,#2
1809  03a7 cd0000        	call	_SPI_GetFlagStatus
1811  03aa 4d            	tnz	a
1812  03ab 27f8          	jreq	L136
1813                     ; 654   SPI_SendData(value); 
1815  03ad 7b06          	ld	a,(OFST+5,sp)
1816  03af cd0000        	call	_SPI_SendData
1819  03b2               L736:
1820                     ; 656   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1822  03b2 a602          	ld	a,#2
1823  03b4 cd0000        	call	_SPI_GetFlagStatus
1825  03b7 4d            	tnz	a
1826  03b8 27f8          	jreq	L736
1827                     ; 660 	delay_us(1);
1829  03ba ae0001        	ldw	x,#1
1830  03bd cd049f        	call	_delay_us
1832                     ; 662   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1834  03c0 4b02          	push	#2
1835  03c2 ae5000        	ldw	x,#20480
1836  03c5 cd0000        	call	_GPIO_WriteHigh
1838  03c8 84            	pop	a
1839                     ; 665 }
1842  03c9 5b03          	addw	sp,#3
1843  03cb 81            	ret	
1903                     ; 672 void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
1903                     ; 673 {		
1904                     	switch	.text
1905  03cc               _MCP_23K256_RAM_read_byte:
1907  03cc 89            	pushw	x
1908  03cd 88            	push	a
1909       00000001      OFST:	set	1
1912                     ; 674 	uint8_t addr = 0;
1915  03ce               L376:
1916                     ; 676   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1918  03ce a680          	ld	a,#128
1919  03d0 cd0000        	call	_SPI_GetFlagStatus
1921  03d3 4d            	tnz	a
1922  03d4 26f8          	jrne	L376
1923                     ; 678   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1925  03d6 4b02          	push	#2
1926  03d8 ae5000        	ldw	x,#20480
1927  03db cd0000        	call	_GPIO_WriteLow
1929  03de 84            	pop	a
1930                     ; 680   SPI_SendData(READ); // instruction 3 read
1932  03df a603          	ld	a,#3
1933  03e1 cd0000        	call	_SPI_SendData
1936  03e4               L107:
1937                     ; 682   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1939  03e4 a602          	ld	a,#2
1940  03e6 cd0000        	call	_SPI_GetFlagStatus
1942  03e9 4d            	tnz	a
1943  03ea 27f8          	jreq	L107
1944                     ; 685 	addr = address>>8;
1946  03ec 7b02          	ld	a,(OFST+1,sp)
1947  03ee 6b01          	ld	(OFST+0,sp),a
1949                     ; 686   SPI_SendData(addr); // send 16 bit address // MSB is don't care
1951  03f0 cd0000        	call	_SPI_SendData
1954  03f3               L707:
1955                     ; 687   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1957  03f3 a602          	ld	a,#2
1958  03f5 cd0000        	call	_SPI_GetFlagStatus
1960  03f8 4d            	tnz	a
1961  03f9 27f8          	jreq	L707
1962                     ; 690 	addr = (address&255);
1964  03fb 7b03          	ld	a,(OFST+2,sp)
1965  03fd 6b01          	ld	(OFST+0,sp),a
1967                     ; 691   SPI_SendData( addr );
1969  03ff cd0000        	call	_SPI_SendData
1972  0402               L517:
1973                     ; 692   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1975  0402 a602          	ld	a,#2
1976  0404 cd0000        	call	_SPI_GetFlagStatus
1978  0407 4d            	tnz	a
1979  0408 27f8          	jreq	L517
1981  040a               L327:
1982                     ; 696 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
1984  040a a601          	ld	a,#1
1985  040c cd0000        	call	_SPI_GetFlagStatus
1987  040f 4d            	tnz	a
1988  0410 27f8          	jreq	L327
1989                     ; 697 SPI_SendData( 255 );
1991  0412 a6ff          	ld	a,#255
1992  0414 cd0000        	call	_SPI_SendData
1995  0417               L137:
1996                     ; 698 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1998  0417 a602          	ld	a,#2
1999  0419 cd0000        	call	_SPI_GetFlagStatus
2001  041c 4d            	tnz	a
2002  041d 27f8          	jreq	L137
2004  041f               L737:
2005                     ; 699 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));	
2007  041f a601          	ld	a,#1
2008  0421 cd0000        	call	_SPI_GetFlagStatus
2010  0424 4d            	tnz	a
2011  0425 27f8          	jreq	L737
2012                     ; 702   *value = SPI_ReceiveData();  
2014  0427 cd0000        	call	_SPI_ReceiveData
2016  042a 1e06          	ldw	x,(OFST+5,sp)
2017  042c f7            	ld	(x),a
2018                     ; 709 	delay_us(1);
2020  042d ae0001        	ldw	x,#1
2021  0430 ad6d          	call	_delay_us
2023                     ; 711   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2025  0432 4b02          	push	#2
2026  0434 ae5000        	ldw	x,#20480
2027  0437 cd0000        	call	_GPIO_WriteHigh
2029  043a 84            	pop	a
2030                     ; 712 }
2033  043b 5b03          	addw	sp,#3
2034  043d 81            	ret	
2059                     ; 717 void MCP4901_DAC_init(void)
2059                     ; 718 {
2060                     	switch	.text
2061  043e               _MCP4901_DAC_init:
2065                     ; 719   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
2067  043e 4bf0          	push	#240
2068  0440 4b10          	push	#16
2069  0442 ae500a        	ldw	x,#20490
2070  0445 cd0000        	call	_GPIO_Init
2072  0448 85            	popw	x
2073                     ; 720   delay_ms(10);
2075  0449 ae000a        	ldw	x,#10
2077                     ; 721 }
2080  044c 2068          	jp	_delay_ms
2128                     ; 727 void MCP4901_DAC_write( unsigned char value)
2128                     ; 728 {
2129                     	switch	.text
2130  044e               _MCP4901_DAC_write:
2132  044e 88            	push	a
2133  044f 88            	push	a
2134       00000001      OFST:	set	1
2137                     ; 756 	unsigned char address = 0x30; // 00,11,00,00
2139  0450 a630          	ld	a,#48
2140  0452 6b01          	ld	(OFST+0,sp),a
2142                     ; 757 	address |= ( value>>4); // assume 0's shoved in the left
2144  0454 7b02          	ld	a,(OFST+1,sp)
2145  0456 4e            	swap	a
2146  0457 a40f          	and	a,#15
2147  0459 1a01          	or	a,(OFST+0,sp)
2148  045b 6b01          	ld	(OFST+0,sp),a
2150                     ; 759 	value = ( value<<4 ); // assume 0 shoved in from the right
2152  045d 7b02          	ld	a,(OFST+1,sp)
2153  045f 4e            	swap	a
2154  0460 a4f0          	and	a,#240
2155  0462 6b02          	ld	(OFST+1,sp),a
2157  0464               L777:
2158                     ; 762   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2160  0464 a680          	ld	a,#128
2161  0466 cd0000        	call	_SPI_GetFlagStatus
2163  0469 4d            	tnz	a
2164  046a 26f8          	jrne	L777
2165                     ; 764   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
2167  046c 4b10          	push	#16
2168  046e ae500a        	ldw	x,#20490
2169  0471 cd0000        	call	_GPIO_WriteLow
2171  0474 84            	pop	a
2172                     ; 766   SPI_SendData(address);
2174  0475 7b01          	ld	a,(OFST+0,sp)
2175  0477 cd0000        	call	_SPI_SendData
2178  047a               L5001:
2179                     ; 768   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2181  047a a602          	ld	a,#2
2182  047c cd0000        	call	_SPI_GetFlagStatus
2184  047f 4d            	tnz	a
2185  0480 27f8          	jreq	L5001
2186                     ; 770   SPI_SendData(value); 
2188  0482 7b02          	ld	a,(OFST+1,sp)
2189  0484 cd0000        	call	_SPI_SendData
2192  0487               L3101:
2193                     ; 772   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2195  0487 a602          	ld	a,#2
2196  0489 cd0000        	call	_SPI_GetFlagStatus
2198  048c 4d            	tnz	a
2199  048d 27f8          	jreq	L3101
2200                     ; 776 	delay_us(1);
2202  048f ae0001        	ldw	x,#1
2203  0492 ad0b          	call	_delay_us
2205                     ; 783   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
2207  0494 4b10          	push	#16
2208  0496 ae500a        	ldw	x,#20490
2209  0499 cd0000        	call	_GPIO_WriteHigh
2211                     ; 785 }
2214  049c 5b03          	addw	sp,#3
2215  049e 81            	ret	
2259                     ; 794 void delay_us(unsigned int  value)
2259                     ; 795 {
2260                     	switch	.text
2261  049f               _delay_us:
2263  049f 89            	pushw	x
2264       00000002      OFST:	set	2
2267                     ; 796 	register unsigned int loops =  (dly_const * value) ;
2269  04a0 cd0000        	call	c_uitof
2271  04a3 ae0000        	ldw	x,#L5401
2272  04a6 cd0000        	call	c_fmul
2274  04a9 cd0000        	call	c_ftoi
2277  04ac 2002          	jra	L5501
2278  04ae               L1501:
2279                     ; 800 		_asm ("nop");
2282  04ae 9d            	nop	
2284                     ; 801 		loops--;
2286  04af 5a            	decw	x
2287  04b0               L5501:
2288  04b0 1f01          	ldw	(OFST-1,sp),x
2290                     ; 798 	while(loops)
2292  04b2 26fa          	jrne	L1501
2293                     ; 803 }
2297  04b4 85            	popw	x
2298  04b5 81            	ret	
2333                     ; 805 void delay_ms(unsigned int  value)
2333                     ; 806 {
2334                     	switch	.text
2335  04b6               _delay_ms:
2337  04b6 89            	pushw	x
2338       00000000      OFST:	set	0
2341  04b7 200a          	jra	L1011
2342  04b9               L7701:
2343                     ; 809 		delay_us(1000);
2345  04b9 ae03e8        	ldw	x,#1000
2346  04bc ade1          	call	_delay_us
2348                     ; 810 		value--;
2350  04be 1e01          	ldw	x,(OFST+1,sp)
2351  04c0 5a            	decw	x
2352  04c1 1f01          	ldw	(OFST+1,sp),x
2353  04c3               L1011:
2354                     ; 807 	while(value)
2356  04c3 1e01          	ldw	x,(OFST+1,sp)
2357  04c5 26f2          	jrne	L7701
2358                     ; 812 }
2362  04c7 85            	popw	x
2363  04c8 81            	ret	
2376                     	xdef	_main
2377                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
2378                     	xdef	_TEST_adc_to_ram_to_dac
2379                     	xdef	_TEST_adc_to_dac
2380                     	xdef	_TEST_rampfunc_in_ram_to_dac
2381                     	xdef	_TEST_ram_test_001
2382                     	xdef	_delay_ms
2383                     	xdef	_delay_us
2384                     	xdef	_MCP_23K256_write_status_register
2385                     	xdef	_MCP_23K256_read_status_register
2386                     	xdef	_MCP_23K256_RAM_write_byte
2387                     	xdef	_MCP_23K256_RAM_read_byte
2388                     	xdef	_MCP_23K256_init
2389                     	xdef	_MCP4901_DAC_init
2390                     	xdef	_MCP4901_DAC_write
2391                     	xdef	_TIM2_setup
2392                     	xdef	_ADC1_setup
2393                     	xdef	_SPI_setup
2394                     	xdef	_GPIO_setup
2395                     	xdef	_clock_setup
2396                     	xref	_TIM2_Cmd
2397                     	xref	_TIM2_OC1Init
2398                     	xref	_TIM2_TimeBaseInit
2399                     	xref	_TIM2_DeInit
2400                     	xref	_SPI_GetFlagStatus
2401                     	xref	_SPI_ReceiveData
2402                     	xref	_SPI_SendData
2403                     	xref	_SPI_Cmd
2404                     	xref	_SPI_Init
2405                     	xref	_SPI_DeInit
2406                     	xref	_GPIO_WriteLow
2407                     	xref	_GPIO_WriteHigh
2408                     	xref	_GPIO_Init
2409                     	xref	_GPIO_DeInit
2410                     	xref	_CLK_GetFlagStatus
2411                     	xref	_CLK_SYSCLKConfig
2412                     	xref	_CLK_HSIPrescalerConfig
2413                     	xref	_CLK_ClockSwitchConfig
2414                     	xref	_CLK_PeripheralClockConfig
2415                     	xref	_CLK_ClockSwitchCmd
2416                     	xref	_CLK_LSICmd
2417                     	xref	_CLK_HSICmd
2418                     	xref	_CLK_HSECmd
2419                     	xref	_CLK_DeInit
2420                     	xref	_ADC1_ClearFlag
2421                     	xref	_ADC1_GetFlagStatus
2422                     	xref	_ADC1_GetConversionValue
2423                     	xref	_ADC1_StartConversion
2424                     	xref	_ADC1_Cmd
2425                     	xref	_ADC1_Init
2426                     	xref	_ADC1_DeInit
2427                     .const:	section	.text
2428  0000               L5401:
2429  0000 3e000000      	dc.w	15872,0
2430  0004               L57:
2431  0004 3e800000      	dc.w	16000,0
2432                     	xref.b	c_lreg
2433                     	xref.b	c_x
2453                     	xref	c_ftoi
2454                     	xref	c_ftol
2455                     	xref	c_fmul
2456                     	xref	c_uitof
2457                     	end
