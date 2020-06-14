   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 145                     ; 134 void main(void)
 145                     ; 135 {
 147                     	switch	.text
 148  0000               _main:
 150  0000 520f          	subw	sp,#15
 151       0000000f      OFST:	set	15
 154                     ; 136     uint16_t adc_leftChannel = 0;
 156                     ; 137     uint16_t adc_feedback    = 0;
 158                     ; 138     uint16_t adc_delay       = 0;
 160                     ; 139     uint8_t  mapd_value = 0;    // mapped adc valu
 162                     ; 140     uint8_t  read_val   = 0;    // read val from ram
 164  0002 0f08          	clr	(OFST-7,sp)
 166                     ; 141     uint16_t write_addr = 0;    // write addr in ram
 168  0004 5f            	clrw	x
 169  0005 1f0c          	ldw	(OFST-3,sp),x
 171                     ; 142     uint16_t read_addr  = 0;    // read addr in val
 173  0007 1f09          	ldw	(OFST-6,sp),x
 175                     ; 143     uint16_t delay      = 110;  // length of delay in samples
 177                     ; 144     uint8_t  res        = 0;
 179                     ; 146     clock_setup();
 181  0009 cd0272        	call	_clock_setup
 183                     ; 147     GPIO_setup();
 185  000c cd02d2        	call	_GPIO_setup
 187                     ; 148     ADC1_setup();
 189  000f cd02f5        	call	_ADC1_setup
 191                     ; 149     SPI_setup();    
 193  0012 cd0353        	call	_SPI_setup
 195                     ; 150     MCP_23K256_init();
 197  0015 cd036f        	call	_MCP_23K256_init
 199                     ; 151     MCP4901_DAC_init();
 201  0018 cd04df        	call	_MCP4901_DAC_init
 203                     ; 175     TEST_rampfunc_in_ram_to_dac();
 205  001b cd0101        	call	_TEST_rampfunc_in_ram_to_dac
 207  001e               L76:
 208                     ; 185         ADC1_ScanModeCmd(ENABLE);
 210  001e a601          	ld	a,#1
 211  0020 cd0000        	call	_ADC1_ScanModeCmd
 213                     ; 186         ADC1_StartConversion();
 215  0023 cd0000        	call	_ADC1_StartConversion
 218  0026               L57:
 219                     ; 187         while( ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE );
 221  0026 a680          	ld	a,#128
 222  0028 cd0000        	call	_ADC1_GetFlagStatus
 224  002b 4d            	tnz	a
 225  002c 27f8          	jreq	L57
 226                     ; 189         adc_leftChannel = ADC1_GetBufferValue( ADC_LEFTCAHANNEL );
 228  002e 4f            	clr	a
 229  002f cd0000        	call	_ADC1_GetBufferValue
 231  0032 1f06          	ldw	(OFST-9,sp),x
 233                     ; 190         adc_delay       = ADC1_GetBufferValue( ADC_DELAY_LENGTH );
 235  0034 a602          	ld	a,#2
 236  0036 cd0000        	call	_ADC1_GetBufferValue
 238  0039 1f0e          	ldw	(OFST-1,sp),x
 240                     ; 191         ADC1_ClearFlag( ADC1_FLAG_EOC );
 242  003b a680          	ld	a,#128
 243  003d cd0000        	call	_ADC1_ClearFlag
 245                     ; 194         delay = (adc_delay >> 2);
 247  0040 1e0e          	ldw	x,(OFST-1,sp)
 248  0042 54            	srlw	x
 249  0043 54            	srlw	x
 250  0044 1f0e          	ldw	(OFST-1,sp),x
 252                     ; 204         mapd_value = (adc_leftChannel >> 2) ; // do i need the float or not ??? -No use a lft shift
 254  0046 1e06          	ldw	x,(OFST-9,sp)
 255  0048 54            	srlw	x
 256  0049 54            	srlw	x
 257  004a 01            	rrwa	x,a
 258  004b 6b0b          	ld	(OFST-4,sp),a
 260                     ; 207         mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
 262  004d 5f            	clrw	x
 263  004e 7b08          	ld	a,(OFST-7,sp)
 264  0050 97            	ld	xl,a
 265  0051 57            	sraw	x
 266  0052 1f01          	ldw	(OFST-14,sp),x
 268  0054 5f            	clrw	x
 269  0055 7b0b          	ld	a,(OFST-4,sp)
 270  0057 97            	ld	xl,a
 271  0058 57            	sraw	x
 272  0059 72fb01        	addw	x,(OFST-14,sp)
 273  005c 01            	rrwa	x,a
 274  005d 6b0b          	ld	(OFST-4,sp),a
 276                     ; 218             read_addr = write_addr - delay;
 278  005f 1e0c          	ldw	x,(OFST-3,sp)
 279  0061 72f00e        	subw	x,(OFST-1,sp)
 280  0064 1f09          	ldw	(OFST-6,sp),x
 282                     ; 222         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 284  0066 88            	push	a
 285  0067 1e0d          	ldw	x,(OFST-2,sp)
 286  0069 cd0410        	call	_MCP_23K256_RAM_write_byte
 288  006c 84            	pop	a
 289                     ; 225         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 291  006d 96            	ldw	x,sp
 292  006e 1c0008        	addw	x,#OFST-7
 293  0071 89            	pushw	x
 294  0072 1e0b          	ldw	x,(OFST-4,sp)
 295  0074 cd046d        	call	_MCP_23K256_RAM_read_byte
 297  0077 85            	popw	x
 298                     ; 228         MCP4901_DAC_write(read_val);
 300  0078 7b08          	ld	a,(OFST-7,sp)
 301  007a cd04ef        	call	_MCP4901_DAC_write
 303                     ; 231         write_addr++;
 305  007d 1e0c          	ldw	x,(OFST-3,sp)
 306  007f 5c            	incw	x
 307  0080 1f0c          	ldw	(OFST-3,sp),x
 309                     ; 234         delay_us(90);
 311  0082 ae005a        	ldw	x,#90
 312  0085 cd0540        	call	_delay_us
 315  0088 2094          	jra	L76
 380                     ; 249 uint8_t TEST_ram_test_001(void)
 380                     ; 250 {
 381                     	switch	.text
 382  008a               _TEST_ram_test_001:
 384  008a 5205          	subw	sp,#5
 385       00000005      OFST:	set	5
 388                     ; 251     uint8_t cnt = 0;
 390                     ; 252     uint8_t data = 0;
 393                     ; 253     uint8_t wdata = 0;
 395                     ; 254     uint16_t addr = 0;
 397                     ; 257     data = BYTE_MODE;
 399  008c 0f03          	clr	(OFST-2,sp)
 401                     ; 258     MCP_23K256_write_status_register(data);
 403  008e 4f            	clr	a
 404  008f cd03d3        	call	_MCP_23K256_write_status_register
 406                     ; 261     MCP_23K256_read_status_register(&data);
 408  0092 96            	ldw	x,sp
 409  0093 1c0003        	addw	x,#OFST-2
 410  0096 cd0380        	call	_MCP_23K256_read_status_register
 412                     ; 305 wdata = 2;
 414  0099 a602          	ld	a,#2
 415  009b 6b02          	ld	(OFST-3,sp),a
 417                     ; 306 addr =0;
 419  009d 5f            	clrw	x
 420  009e 1f04          	ldw	(OFST-1,sp),x
 422                     ; 308     MCP_23K256_RAM_write_byte(addr, wdata);
 424  00a0 4b02          	push	#2
 425  00a2 cd0410        	call	_MCP_23K256_RAM_write_byte
 427  00a5 84            	pop	a
 428                     ; 311     MCP_23K256_RAM_read_byte(addr, &data);
 430  00a6 96            	ldw	x,sp
 431  00a7 1c0003        	addw	x,#OFST-2
 432  00aa 89            	pushw	x
 433  00ab 1e06          	ldw	x,(OFST+1,sp)
 434  00ad cd046d        	call	_MCP_23K256_RAM_read_byte
 436  00b0 a6fa          	ld	a,#250
 437  00b2 85            	popw	x
 438                     ; 313     if (wdata != data)
 440                     ; 318 wdata = 250;
 442  00b3 6b02          	ld	(OFST-3,sp),a
 444                     ; 319 addr =1;
 446  00b5 ae0001        	ldw	x,#1
 447  00b8 1f04          	ldw	(OFST-1,sp),x
 449                     ; 321     MCP_23K256_RAM_write_byte(addr, wdata);
 451  00ba 4bfa          	push	#250
 452  00bc cd0410        	call	_MCP_23K256_RAM_write_byte
 454  00bf 84            	pop	a
 455                     ; 324     MCP_23K256_RAM_read_byte(addr, &data);
 457  00c0 96            	ldw	x,sp
 458  00c1 1c0003        	addw	x,#OFST-2
 459  00c4 89            	pushw	x
 460  00c5 1e06          	ldw	x,(OFST+1,sp)
 461  00c7 cd046d        	call	_MCP_23K256_RAM_read_byte
 463  00ca a604          	ld	a,#4
 464  00cc 85            	popw	x
 465                     ; 326     if (wdata != data)
 467                     ; 331 wdata = 4;
 469  00cd 6b02          	ld	(OFST-3,sp),a
 471                     ; 332 addr =2;
 473  00cf ae0002        	ldw	x,#2
 474  00d2 1f04          	ldw	(OFST-1,sp),x
 476                     ; 334     MCP_23K256_RAM_write_byte(addr, wdata);
 478  00d4 4b04          	push	#4
 479  00d6 cd0410        	call	_MCP_23K256_RAM_write_byte
 481  00d9 84            	pop	a
 482                     ; 337     MCP_23K256_RAM_read_byte(addr, &data);
 484  00da 96            	ldw	x,sp
 485  00db 1c0003        	addw	x,#OFST-2
 486  00de 89            	pushw	x
 487  00df 1e06          	ldw	x,(OFST+1,sp)
 488  00e1 cd046d        	call	_MCP_23K256_RAM_read_byte
 490  00e4 85            	popw	x
 491                     ; 339     if (wdata != data)
 493                     ; 345     for(addr = 0; addr<3; addr++)
 495  00e5 5f            	clrw	x
 496  00e6 1f04          	ldw	(OFST-1,sp),x
 498  00e8               L141:
 499                     ; 347         MCP_23K256_RAM_read_byte(addr, &data);
 501  00e8 96            	ldw	x,sp
 502  00e9 1c0003        	addw	x,#OFST-2
 503  00ec 89            	pushw	x
 504  00ed 1e06          	ldw	x,(OFST+1,sp)
 505  00ef cd046d        	call	_MCP_23K256_RAM_read_byte
 507  00f2 85            	popw	x
 508                     ; 345     for(addr = 0; addr<3; addr++)
 510  00f3 1e04          	ldw	x,(OFST-1,sp)
 511  00f5 5c            	incw	x
 512  00f6 1f04          	ldw	(OFST-1,sp),x
 516  00f8 a30003        	cpw	x,#3
 517  00fb 25eb          	jrult	L141
 518                     ; 349     return 0;
 520  00fd 4f            	clr	a
 523  00fe 5b05          	addw	sp,#5
 524  0100 81            	ret	
 581                     ; 356 uint8_t TEST_rampfunc_in_ram_to_dac(void)
 581                     ; 357 {
 582                     	switch	.text
 583  0101               _TEST_rampfunc_in_ram_to_dac:
 585  0101 5204          	subw	sp,#4
 586       00000004      OFST:	set	4
 589                     ; 358     uint8_t data = 0;
 591  0103 0f02          	clr	(OFST-2,sp)
 593                     ; 359     uint8_t wdata = 0;
 595  0105 0f01          	clr	(OFST-3,sp)
 597                     ; 360     uint16_t addr = 0;  
 599                     ; 363     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 601  0107 5f            	clrw	x
 602  0108 1f03          	ldw	(OFST-1,sp),x
 604  010a 7b01          	ld	a,(OFST-3,sp)
 605  010c               L571:
 606                     ; 365         MCP_23K256_RAM_write_byte(addr, wdata);
 608  010c 88            	push	a
 609  010d 1e04          	ldw	x,(OFST+0,sp)
 610  010f cd0410        	call	_MCP_23K256_RAM_write_byte
 612  0112 84            	pop	a
 613                     ; 363     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 615  0113 1e03          	ldw	x,(OFST-1,sp)
 616  0115 5c            	incw	x
 617  0116 1f03          	ldw	(OFST-1,sp),x
 619  0118 7b01          	ld	a,(OFST-3,sp)
 620  011a ab04          	add	a,#4
 621  011c 6b01          	ld	(OFST-3,sp),a
 625  011e a300ff        	cpw	x,#255
 626  0121 25e9          	jrult	L571
 627  0123               L302:
 628                     ; 371         for(addr = 0; addr<255; addr++)
 630  0123 5f            	clrw	x
 631  0124 1f03          	ldw	(OFST-1,sp),x
 633  0126               L702:
 634                     ; 373             MCP_23K256_RAM_read_byte(addr, &data);
 636  0126 96            	ldw	x,sp
 637  0127 1c0002        	addw	x,#OFST-2
 638  012a 89            	pushw	x
 639  012b 1e05          	ldw	x,(OFST+1,sp)
 640  012d cd046d        	call	_MCP_23K256_RAM_read_byte
 642  0130 85            	popw	x
 643                     ; 374             MCP4901_DAC_write(data);
 645  0131 7b02          	ld	a,(OFST-2,sp)
 646  0133 cd04ef        	call	_MCP4901_DAC_write
 648                     ; 375             delay_us(90);   //11kHz sample rate // phasor == frequ
 650  0136 ae005a        	ldw	x,#90
 651  0139 cd0540        	call	_delay_us
 653                     ; 371         for(addr = 0; addr<255; addr++)
 655  013c 1e03          	ldw	x,(OFST-1,sp)
 656  013e 5c            	incw	x
 657  013f 1f03          	ldw	(OFST-1,sp),x
 661  0141 a300ff        	cpw	x,#255
 662  0144 25e0          	jrult	L702
 664  0146 20db          	jra	L302
 699                     ; 383 void TEST_adc_to_dac(uint8_t *x)
 699                     ; 384 {
 700                     	switch	.text
 701  0148               _TEST_adc_to_dac:
 705                     ; 408 }
 708  0148 81            	ret	
 769                     ; 411 void TEST_adc_to_ram_to_dac(void)
 769                     ; 412 {
 770                     	switch	.text
 771  0149               _TEST_adc_to_ram_to_dac:
 773  0149 5205          	subw	sp,#5
 774       00000005      OFST:	set	5
 777                     ; 413     uint16_t adc_val = 0;
 779                     ; 414     uint16_t addr = 0;
 781  014b 5f            	clrw	x
 782  014c 1f03          	ldw	(OFST-2,sp),x
 784                     ; 415     uint8_t mapd_value = 0; 
 786  014e 0f05          	clr	(OFST+0,sp)
 788  0150               L162:
 789                     ; 420         ADC1_StartConversion();
 791  0150 cd0000        	call	_ADC1_StartConversion
 794  0153               L762:
 795                     ; 421         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 797  0153 a680          	ld	a,#128
 798  0155 cd0000        	call	_ADC1_GetFlagStatus
 800  0158 4d            	tnz	a
 801  0159 27f8          	jreq	L762
 802                     ; 423         adc_val = ADC1_GetConversionValue(); // for led knob
 804  015b cd0000        	call	_ADC1_GetConversionValue
 806  015e 1f01          	ldw	(OFST-4,sp),x
 808                     ; 424         ADC1_ClearFlag(ADC1_FLAG_EOC);
 810  0160 a680          	ld	a,#128
 811  0162 cd0000        	call	_ADC1_ClearFlag
 813                     ; 431         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 815  0165 1e01          	ldw	x,(OFST-4,sp)
 816  0167 cd0000        	call	c_uitof
 818  016a ae0004        	ldw	x,#L772
 819  016d cd0000        	call	c_fmul
 821  0170 cd0000        	call	c_ftol
 823  0173 b603          	ld	a,c_lreg+3
 824  0175 6b05          	ld	(OFST+0,sp),a
 826                     ; 434         MCP_23K256_RAM_write_byte(addr, mapd_value);
 828  0177 88            	push	a
 829  0178 1e04          	ldw	x,(OFST-1,sp)
 830  017a cd0410        	call	_MCP_23K256_RAM_write_byte
 832  017d 84            	pop	a
 833                     ; 437         mapd_value = 0; // check value
 835  017e 0f05          	clr	(OFST+0,sp)
 837                     ; 438         MCP_23K256_RAM_read_byte(addr, &mapd_value);
 839  0180 96            	ldw	x,sp
 840  0181 1c0005        	addw	x,#OFST+0
 841  0184 89            	pushw	x
 842  0185 1e05          	ldw	x,(OFST+0,sp)
 843  0187 cd046d        	call	_MCP_23K256_RAM_read_byte
 845  018a 85            	popw	x
 846                     ; 441         addr++;
 848  018b 1e03          	ldw	x,(OFST-2,sp)
 849  018d 5c            	incw	x
 850  018e 1f03          	ldw	(OFST-2,sp),x
 852                     ; 443         MCP4901_DAC_write(mapd_value);
 854  0190 7b05          	ld	a,(OFST+0,sp)
 855  0192 cd04ef        	call	_MCP4901_DAC_write
 857                     ; 446         delay_us(90);
 859  0195 ae005a        	ldw	x,#90
 860  0198 cd0540        	call	_delay_us
 863  019b 20b3          	jra	L162
 960                     ; 453 void TEST_adc_to_ram_to_dac_with_delay(void)
 960                     ; 454 {
 961                     	switch	.text
 962  019d               _TEST_adc_to_ram_to_dac_with_delay:
 964  019d 520b          	subw	sp,#11
 965       0000000b      OFST:	set	11
 968                     ; 455     uint16_t adc_val = 0;   
 970                     ; 456     uint8_t mapd_value = 0; // mapped adc valu
 972                     ; 457     uint8_t read_val = 0;   //read val from ram
 974  019f 0f05          	clr	(OFST-6,sp)
 976                     ; 458     uint16_t write_addr = 0;    //write addr in ram
 978  01a1 5f            	clrw	x
 979  01a2 1f0a          	ldw	(OFST-1,sp),x
 981                     ; 459     uint16_t read_addr = 0; // read addr in val
 983  01a4 1f06          	ldw	(OFST-5,sp),x
 985                     ; 460     uint16_t delay = 110; // length of delay in samples
 987  01a6 ae006e        	ldw	x,#110
 988  01a9 1f08          	ldw	(OFST-3,sp),x
 990                     ; 461     uint8_t res = 0;
 992  01ab               L153:
 993                     ; 467         ADC1_StartConversion();
 995  01ab cd0000        	call	_ADC1_StartConversion
 998  01ae               L753:
 999                     ; 468         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1001  01ae a680          	ld	a,#128
1002  01b0 cd0000        	call	_ADC1_GetFlagStatus
1004  01b3 4d            	tnz	a
1005  01b4 27f8          	jreq	L753
1006                     ; 470         adc_val = ADC1_GetConversionValue(); // for led knob
1008  01b6 cd0000        	call	_ADC1_GetConversionValue
1010  01b9 1f02          	ldw	(OFST-9,sp),x
1012                     ; 471         ADC1_ClearFlag(ADC1_FLAG_EOC);
1014  01bb a680          	ld	a,#128
1015  01bd cd0000        	call	_ADC1_ClearFlag
1017                     ; 478         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
1019  01c0 1e02          	ldw	x,(OFST-9,sp)
1020  01c2 cd0000        	call	c_uitof
1022  01c5 ae0004        	ldw	x,#L772
1023  01c8 cd0000        	call	c_fmul
1025  01cb cd0000        	call	c_ftol
1027  01ce b603          	ld	a,c_lreg+3
1028  01d0 6b04          	ld	(OFST-7,sp),a
1030                     ; 489             read_addr = write_addr - delay;
1032  01d2 1e0a          	ldw	x,(OFST-1,sp)
1033  01d4 72f008        	subw	x,(OFST-3,sp)
1034  01d7 1f06          	ldw	(OFST-5,sp),x
1036                     ; 493         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1038  01d9 88            	push	a
1039  01da 1e0b          	ldw	x,(OFST+0,sp)
1040  01dc cd0410        	call	_MCP_23K256_RAM_write_byte
1042  01df 84            	pop	a
1043                     ; 496         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1045  01e0 96            	ldw	x,sp
1046  01e1 1c0005        	addw	x,#OFST-6
1047  01e4 89            	pushw	x
1048  01e5 1e08          	ldw	x,(OFST-3,sp)
1049  01e7 cd046d        	call	_MCP_23K256_RAM_read_byte
1051  01ea 85            	popw	x
1052                     ; 499         MCP4901_DAC_write(read_val);
1054  01eb 7b05          	ld	a,(OFST-6,sp)
1055  01ed cd04ef        	call	_MCP4901_DAC_write
1057                     ; 502         write_addr++;
1059  01f0 1e0a          	ldw	x,(OFST-1,sp)
1060  01f2 5c            	incw	x
1061  01f3 1f0a          	ldw	(OFST-1,sp),x
1063                     ; 505         delay_us(90);
1065  01f5 ae005a        	ldw	x,#90
1066  01f8 cd0540        	call	_delay_us
1069  01fb 20ae          	jra	L153
1177                     ; 513 void TEST_adc_to_ram_to_dac_with_with_fback(void)
1177                     ; 514 {
1178                     	switch	.text
1179  01fd               _TEST_adc_to_ram_to_dac_with_with_fback:
1181  01fd 520d          	subw	sp,#13
1182       0000000d      OFST:	set	13
1185                     ; 516     uint16_t adc0_val = 0;  //er are these 8 or 16 big?
1187                     ; 517     uint16_t adc1_val = 0;  
1189                     ; 518     uint8_t mapd_value = 0; // mapped adc valu
1191                     ; 519     uint8_t read_val = 0;   //read val from ram
1193  01ff 0f06          	clr	(OFST-7,sp)
1195                     ; 520     uint16_t write_addr = 0;    //write addr in ram
1197  0201 5f            	clrw	x
1198  0202 1f0a          	ldw	(OFST-3,sp),x
1200                     ; 521     uint16_t read_addr = 0; // read addr in val
1202  0204 1f07          	ldw	(OFST-6,sp),x
1204                     ; 522     uint16_t delay = 110; // length of delay in samples
1206                     ; 523     uint8_t res = 0;
1208  0206               L534:
1209                     ; 538     ADC1_ScanModeCmd(ENABLE);
1211  0206 a601          	ld	a,#1
1212  0208 cd0000        	call	_ADC1_ScanModeCmd
1214                     ; 539     ADC1_StartConversion();
1216  020b cd0000        	call	_ADC1_StartConversion
1219  020e               L344:
1220                     ; 540     while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1222  020e a680          	ld	a,#128
1223  0210 cd0000        	call	_ADC1_GetFlagStatus
1225  0213 4d            	tnz	a
1226  0214 27f8          	jreq	L344
1227                     ; 542     adc0_val = ADC1_GetBufferValue(0);
1229  0216 4f            	clr	a
1230  0217 cd0000        	call	_ADC1_GetBufferValue
1232  021a 1f04          	ldw	(OFST-9,sp),x
1234                     ; 543     adc1_val = ADC1_GetBufferValue(1);
1236  021c a601          	ld	a,#1
1237  021e cd0000        	call	_ADC1_GetBufferValue
1239  0221 1f0c          	ldw	(OFST-1,sp),x
1241                     ; 544     ADC1_ClearFlag(ADC1_FLAG_EOC);
1243  0223 a680          	ld	a,#128
1244  0225 cd0000        	call	_ADC1_ClearFlag
1246                     ; 547     delay = (adc1_val>>2);
1248  0228 1e0c          	ldw	x,(OFST-1,sp)
1249  022a 54            	srlw	x
1250  022b 54            	srlw	x
1251  022c 1f0c          	ldw	(OFST-1,sp),x
1253                     ; 557         mapd_value = (adc0_val>>2) ; // do i need the float or not ??? -No use a lft shift
1255  022e 1e04          	ldw	x,(OFST-9,sp)
1256  0230 54            	srlw	x
1257  0231 54            	srlw	x
1258  0232 01            	rrwa	x,a
1259  0233 6b09          	ld	(OFST-4,sp),a
1261                     ; 562         mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
1263  0235 5f            	clrw	x
1264  0236 7b06          	ld	a,(OFST-7,sp)
1265  0238 97            	ld	xl,a
1266  0239 57            	sraw	x
1267  023a 1f01          	ldw	(OFST-12,sp),x
1269  023c 5f            	clrw	x
1270  023d 7b09          	ld	a,(OFST-4,sp)
1271  023f 97            	ld	xl,a
1272  0240 57            	sraw	x
1273  0241 72fb01        	addw	x,(OFST-12,sp)
1274  0244 01            	rrwa	x,a
1275  0245 6b09          	ld	(OFST-4,sp),a
1277                     ; 573             read_addr = write_addr - delay;
1279  0247 1e0a          	ldw	x,(OFST-3,sp)
1280  0249 72f00c        	subw	x,(OFST-1,sp)
1281  024c 1f07          	ldw	(OFST-6,sp),x
1283                     ; 577         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1285  024e 88            	push	a
1286  024f 1e0b          	ldw	x,(OFST-2,sp)
1287  0251 cd0410        	call	_MCP_23K256_RAM_write_byte
1289  0254 84            	pop	a
1290                     ; 580         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1292  0255 96            	ldw	x,sp
1293  0256 1c0006        	addw	x,#OFST-7
1294  0259 89            	pushw	x
1295  025a 1e09          	ldw	x,(OFST-4,sp)
1296  025c cd046d        	call	_MCP_23K256_RAM_read_byte
1298  025f 85            	popw	x
1299                     ; 583         MCP4901_DAC_write(read_val);
1301  0260 7b06          	ld	a,(OFST-7,sp)
1302  0262 cd04ef        	call	_MCP4901_DAC_write
1304                     ; 586         write_addr++;
1306  0265 1e0a          	ldw	x,(OFST-3,sp)
1307  0267 5c            	incw	x
1308  0268 1f0a          	ldw	(OFST-3,sp),x
1310                     ; 589         delay_us(90);
1312  026a ae005a        	ldw	x,#90
1313  026d cd0540        	call	_delay_us
1316  0270 2094          	jra	L534
1349                     ; 595 void clock_setup(void)
1349                     ; 596 {
1350                     	switch	.text
1351  0272               _clock_setup:
1355                     ; 597   CLK_DeInit();
1357  0272 cd0000        	call	_CLK_DeInit
1359                     ; 599   CLK_HSECmd(DISABLE);
1361  0275 4f            	clr	a
1362  0276 cd0000        	call	_CLK_HSECmd
1364                     ; 600   CLK_LSICmd(DISABLE);
1366  0279 4f            	clr	a
1367  027a cd0000        	call	_CLK_LSICmd
1369                     ; 601   CLK_HSICmd(ENABLE);
1371  027d a601          	ld	a,#1
1372  027f cd0000        	call	_CLK_HSICmd
1375  0282               L164:
1376                     ; 602   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
1378  0282 ae0102        	ldw	x,#258
1379  0285 cd0000        	call	_CLK_GetFlagStatus
1381  0288 4d            	tnz	a
1382  0289 27f7          	jreq	L164
1383                     ; 604   CLK_ClockSwitchCmd(ENABLE);
1385  028b a601          	ld	a,#1
1386  028d cd0000        	call	_CLK_ClockSwitchCmd
1388                     ; 605   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1390  0290 4f            	clr	a
1391  0291 cd0000        	call	_CLK_HSIPrescalerConfig
1393                     ; 606   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
1395  0294 a680          	ld	a,#128
1396  0296 cd0000        	call	_CLK_SYSCLKConfig
1398                     ; 608   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
1400  0299 4b01          	push	#1
1401  029b 4b00          	push	#0
1402  029d ae01e1        	ldw	x,#481
1403  02a0 cd0000        	call	_CLK_ClockSwitchConfig
1405  02a3 85            	popw	x
1406                     ; 610   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
1408  02a4 5f            	clrw	x
1409  02a5 cd0000        	call	_CLK_PeripheralClockConfig
1411                     ; 611   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
1413  02a8 ae0101        	ldw	x,#257
1414  02ab cd0000        	call	_CLK_PeripheralClockConfig
1416                     ; 612   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
1418  02ae ae0300        	ldw	x,#768
1419  02b1 cd0000        	call	_CLK_PeripheralClockConfig
1421                     ; 613   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
1423  02b4 ae1200        	ldw	x,#4608
1424  02b7 cd0000        	call	_CLK_PeripheralClockConfig
1426                     ; 614   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
1428  02ba ae1301        	ldw	x,#4865
1429  02bd cd0000        	call	_CLK_PeripheralClockConfig
1431                     ; 615   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
1433  02c0 ae0700        	ldw	x,#1792
1434  02c3 cd0000        	call	_CLK_PeripheralClockConfig
1436                     ; 616   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
1438  02c6 ae0501        	ldw	x,#1281
1439  02c9 cd0000        	call	_CLK_PeripheralClockConfig
1441                     ; 617   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
1443  02cc ae0400        	ldw	x,#1024
1445                     ; 619 }
1448  02cf cc0000        	jp	_CLK_PeripheralClockConfig
1473                     ; 621 void GPIO_setup(void)
1473                     ; 622 {                               
1474                     	switch	.text
1475  02d2               _GPIO_setup:
1479                     ; 623   GPIO_DeInit(GPIOC);
1481  02d2 ae500a        	ldw	x,#20490
1482  02d5 cd0000        	call	_GPIO_DeInit
1484                     ; 627     GPIO_DeInit(ADC_port);
1486  02d8 ae5005        	ldw	x,#20485
1487  02db cd0000        	call	_GPIO_DeInit
1489                     ; 633     GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);
1491  02de 4b00          	push	#0
1492  02e0 4b0e          	push	#14
1493  02e2 ae5005        	ldw	x,#20485
1494  02e5 cd0000        	call	_GPIO_Init
1496  02e8 85            	popw	x
1497                     ; 638     GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ), 
1497                     ; 639                GPIO_MODE_OUT_PP_HIGH_FAST);
1499  02e9 4bf0          	push	#240
1500  02eb 4b60          	push	#96
1501  02ed ae500a        	ldw	x,#20490
1502  02f0 cd0000        	call	_GPIO_Init
1504  02f3 85            	popw	x
1505                     ; 640 }
1508  02f4 81            	ret	
1536                     ; 642 void ADC1_setup(void)
1536                     ; 643 {
1537                     	switch	.text
1538  02f5               _ADC1_setup:
1542                     ; 644   ADC1_DeInit();         
1544  02f5 cd0000        	call	_ADC1_DeInit
1546                     ; 646   ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1546                     ; 647   ADC1_CHANNEL_0,\
1546                     ; 648   ADC1_PRESSEL_FCPU_D18, \
1546                     ; 649   ADC1_EXTTRIG_GPIO, \
1546                     ; 650   DISABLE, \
1546                     ; 651   ADC1_ALIGN_RIGHT, \
1546                     ; 652   ADC1_SCHMITTTRIG_CHANNEL0, \
1546                     ; 653   DISABLE);
1548  02f8 4b00          	push	#0
1549  02fa 4b00          	push	#0
1550  02fc 4b08          	push	#8
1551  02fe 4b00          	push	#0
1552  0300 4b10          	push	#16
1553  0302 4b70          	push	#112
1554  0304 ae0100        	ldw	x,#256
1555  0307 cd0000        	call	_ADC1_Init
1557  030a 5b06          	addw	sp,#6
1558                     ; 655     ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
1558                     ; 656   ADC1_CHANNEL_1,\
1558                     ; 657   ADC1_PRESSEL_FCPU_D18, \
1558                     ; 658   ADC1_EXTTRIG_GPIO, \
1558                     ; 659   DISABLE, \
1558                     ; 660   ADC1_ALIGN_RIGHT, \
1558                     ; 661   ADC1_SCHMITTTRIG_CHANNEL1, \
1558                     ; 662   DISABLE);
1560  030c 4b00          	push	#0
1561  030e 4b01          	push	#1
1562  0310 4b08          	push	#8
1563  0312 4b00          	push	#0
1564  0314 4b10          	push	#16
1565  0316 4b70          	push	#112
1566  0318 ae0101        	ldw	x,#257
1567  031b cd0000        	call	_ADC1_Init
1569  031e 5b06          	addw	sp,#6
1570                     ; 664     ADC1_ConversionConfig(ADC1_CONVERSIONMODE_CONTINUOUS,
1570                     ; 665     ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)),
1570                     ; 666     ADC1_ALIGN_RIGHT);
1572  0320 4b08          	push	#8
1573  0322 ae0101        	ldw	x,#257
1574  0325 cd0000        	call	_ADC1_ConversionConfig
1576  0328 84            	pop	a
1577                     ; 668     ADC1_DataBufferCmd(ENABLE);
1579  0329 a601          	ld	a,#1
1580  032b cd0000        	call	_ADC1_DataBufferCmd
1582                     ; 669     ADC1_Cmd(ENABLE);
1584  032e a601          	ld	a,#1
1586                     ; 671 }
1589  0330 cc0000        	jp	_ADC1_Cmd
1616                     ; 676 void TIM2_setup(void)
1616                     ; 677 {
1617                     	switch	.text
1618  0333               _TIM2_setup:
1622                     ; 678   TIM2_DeInit();
1624  0333 cd0000        	call	_TIM2_DeInit
1626                     ; 679   TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
1628  0336 ae03e8        	ldw	x,#1000
1629  0339 89            	pushw	x
1630  033a a605          	ld	a,#5
1631  033c cd0000        	call	_TIM2_TimeBaseInit
1633  033f 85            	popw	x
1634                     ; 680   TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
1636  0340 4b00          	push	#0
1637  0342 ae03e8        	ldw	x,#1000
1638  0345 89            	pushw	x
1639  0346 ae6011        	ldw	x,#24593
1640  0349 cd0000        	call	_TIM2_OC1Init
1642  034c 5b03          	addw	sp,#3
1643                     ; 681   TIM2_Cmd(ENABLE);
1645  034e a601          	ld	a,#1
1647                     ; 683 }
1650  0350 cc0000        	jp	_TIM2_Cmd
1676                     ; 686 void SPI_setup(void)
1676                     ; 687 {
1677                     	switch	.text
1678  0353               _SPI_setup:
1682                     ; 688   SPI_DeInit();
1684  0353 cd0000        	call	_SPI_DeInit
1686                     ; 693   SPI_Init(SPI_FIRSTBIT_MSB, \
1686                     ; 694     SPI_BAUDRATEPRESCALER_16, \
1686                     ; 695     SPI_MODE_MASTER, \
1686                     ; 696     SPI_CLOCKPOLARITY_LOW, \
1686                     ; 697     SPI_CLOCKPHASE_1EDGE, \
1686                     ; 698     SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
1686                     ; 699     SPI_NSS_SOFT, \
1686                     ; 700     0x0);
1688  0356 4b00          	push	#0
1689  0358 4b02          	push	#2
1690  035a 4b00          	push	#0
1691  035c 4b00          	push	#0
1692  035e 4b00          	push	#0
1693  0360 4b04          	push	#4
1694  0362 ae0018        	ldw	x,#24
1695  0365 cd0000        	call	_SPI_Init
1697  0368 5b06          	addw	sp,#6
1698                     ; 702   SPI_Cmd(ENABLE);
1700  036a a601          	ld	a,#1
1702                     ; 703 }
1705  036c cc0000        	jp	_SPI_Cmd
1730                     ; 705 void MCP_23K256_init()
1730                     ; 706 {
1731                     	switch	.text
1732  036f               _MCP_23K256_init:
1736                     ; 707     GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
1738  036f 4bf0          	push	#240
1739  0371 4b02          	push	#2
1740  0373 ae5000        	ldw	x,#20480
1741  0376 cd0000        	call	_GPIO_Init
1743  0379 85            	popw	x
1744                     ; 708   delay_ms(10);
1746  037a ae000a        	ldw	x,#10
1748                     ; 709 }
1751  037d cc0557        	jp	_delay_ms
1793                     ; 714 void MCP_23K256_read_status_register(uint8_t *data)
1793                     ; 715 {
1794                     	switch	.text
1795  0380               _MCP_23K256_read_status_register:
1797  0380 89            	pushw	x
1798       00000000      OFST:	set	0
1801  0381               L555:
1802                     ; 717   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1804  0381 a680          	ld	a,#128
1805  0383 cd0000        	call	_SPI_GetFlagStatus
1807  0386 4d            	tnz	a
1808  0387 26f8          	jrne	L555
1809                     ; 719   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1811  0389 4b02          	push	#2
1812  038b ae5000        	ldw	x,#20480
1813  038e cd0000        	call	_GPIO_WriteLow
1815  0391 84            	pop	a
1816                     ; 721   SPI_SendData(RDSR); // read ststus reg
1818  0392 a605          	ld	a,#5
1819  0394 cd0000        	call	_SPI_SendData
1822  0397               L365:
1823                     ; 723   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1825  0397 a602          	ld	a,#2
1826  0399 cd0000        	call	_SPI_GetFlagStatus
1828  039c 4d            	tnz	a
1829  039d 27f8          	jreq	L365
1831  039f               L175:
1832                     ; 726 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
1834  039f a601          	ld	a,#1
1835  03a1 cd0000        	call	_SPI_GetFlagStatus
1837  03a4 4d            	tnz	a
1838  03a5 27f8          	jreq	L175
1839                     ; 727 SPI_SendData( 255 );
1841  03a7 a6ff          	ld	a,#255
1842  03a9 cd0000        	call	_SPI_SendData
1845  03ac               L775:
1846                     ; 728 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1848  03ac a602          	ld	a,#2
1849  03ae cd0000        	call	_SPI_GetFlagStatus
1851  03b1 4d            	tnz	a
1852  03b2 27f8          	jreq	L775
1853                     ; 730   *data = SPI_ReceiveData(); 
1855  03b4 cd0000        	call	_SPI_ReceiveData
1857  03b7 1e01          	ldw	x,(OFST+1,sp)
1858  03b9 f7            	ld	(x),a
1860  03ba               L706:
1861                     ; 732   while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
1863  03ba a601          	ld	a,#1
1864  03bc cd0000        	call	_SPI_GetFlagStatus
1866  03bf 4d            	tnz	a
1867  03c0 27f8          	jreq	L706
1868                     ; 736     delay_us(1);
1870  03c2 ae0001        	ldw	x,#1
1871  03c5 cd0540        	call	_delay_us
1873                     ; 738   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1875  03c8 4b02          	push	#2
1876  03ca ae5000        	ldw	x,#20480
1877  03cd cd0000        	call	_GPIO_WriteHigh
1879                     ; 739 }
1882  03d0 5b03          	addw	sp,#3
1883  03d2 81            	ret	
1923                     ; 748 void MCP_23K256_write_status_register(uint8_t data)
1923                     ; 749 {
1924                     	switch	.text
1925  03d3               _MCP_23K256_write_status_register:
1927  03d3 88            	push	a
1928       00000000      OFST:	set	0
1931  03d4               L336:
1932                     ; 751   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
1934  03d4 a680          	ld	a,#128
1935  03d6 cd0000        	call	_SPI_GetFlagStatus
1937  03d9 4d            	tnz	a
1938  03da 26f8          	jrne	L336
1939                     ; 753   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
1941  03dc 4b02          	push	#2
1942  03de ae5000        	ldw	x,#20480
1943  03e1 cd0000        	call	_GPIO_WriteLow
1945  03e4 84            	pop	a
1946                     ; 756   SPI_SendData(WRSR); 
1948  03e5 a601          	ld	a,#1
1949  03e7 cd0000        	call	_SPI_SendData
1952  03ea               L146:
1953                     ; 757   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1955  03ea a602          	ld	a,#2
1956  03ec cd0000        	call	_SPI_GetFlagStatus
1958  03ef 4d            	tnz	a
1959  03f0 27f8          	jreq	L146
1960                     ; 760   SPI_SendData(data); 
1962  03f2 7b01          	ld	a,(OFST+1,sp)
1963  03f4 cd0000        	call	_SPI_SendData
1966  03f7               L746:
1967                     ; 761   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
1969  03f7 a602          	ld	a,#2
1970  03f9 cd0000        	call	_SPI_GetFlagStatus
1972  03fc 4d            	tnz	a
1973  03fd 27f8          	jreq	L746
1974                     ; 765     delay_us(1);
1976  03ff ae0001        	ldw	x,#1
1977  0402 cd0540        	call	_delay_us
1979                     ; 767   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
1981  0405 4b02          	push	#2
1982  0407 ae5000        	ldw	x,#20480
1983  040a cd0000        	call	_GPIO_WriteHigh
1985                     ; 769 }
1988  040d 5b02          	addw	sp,#2
1989  040f 81            	ret	
2047                     ; 778 void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
2047                     ; 779 {
2048                     	switch	.text
2049  0410               _MCP_23K256_RAM_write_byte:
2051  0410 89            	pushw	x
2052  0411 88            	push	a
2053       00000001      OFST:	set	1
2056                     ; 780     uint8_t addr = 0;
2059  0412               L307:
2060                     ; 782   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2062  0412 a680          	ld	a,#128
2063  0414 cd0000        	call	_SPI_GetFlagStatus
2065  0417 4d            	tnz	a
2066  0418 26f8          	jrne	L307
2067                     ; 784   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2069  041a 4b02          	push	#2
2070  041c ae5000        	ldw	x,#20480
2071  041f cd0000        	call	_GPIO_WriteLow
2073  0422 84            	pop	a
2074                     ; 787   SPI_SendData(WRITE); // instruction 2 write
2076  0423 a602          	ld	a,#2
2077  0425 cd0000        	call	_SPI_SendData
2080  0428               L117:
2081                     ; 788   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2083  0428 a602          	ld	a,#2
2084  042a cd0000        	call	_SPI_GetFlagStatus
2086  042d 4d            	tnz	a
2087  042e 27f8          	jreq	L117
2088                     ; 791     addr = address>>8;
2090  0430 7b02          	ld	a,(OFST+1,sp)
2091  0432 6b01          	ld	(OFST+0,sp),a
2093                     ; 792   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2095  0434 cd0000        	call	_SPI_SendData
2098  0437               L717:
2099                     ; 793   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2101  0437 a602          	ld	a,#2
2102  0439 cd0000        	call	_SPI_GetFlagStatus
2104  043c 4d            	tnz	a
2105  043d 27f8          	jreq	L717
2106                     ; 796     addr = (address&255);
2108  043f 7b03          	ld	a,(OFST+2,sp)
2109  0441 6b01          	ld	(OFST+0,sp),a
2111                     ; 797   SPI_SendData( addr );
2113  0443 cd0000        	call	_SPI_SendData
2116  0446               L527:
2117                     ; 798   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2119  0446 a602          	ld	a,#2
2120  0448 cd0000        	call	_SPI_GetFlagStatus
2122  044b 4d            	tnz	a
2123  044c 27f8          	jreq	L527
2124                     ; 800   SPI_SendData(value); 
2126  044e 7b06          	ld	a,(OFST+5,sp)
2127  0450 cd0000        	call	_SPI_SendData
2130  0453               L337:
2131                     ; 802   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2133  0453 a602          	ld	a,#2
2134  0455 cd0000        	call	_SPI_GetFlagStatus
2136  0458 4d            	tnz	a
2137  0459 27f8          	jreq	L337
2138                     ; 806     delay_us(1);
2140  045b ae0001        	ldw	x,#1
2141  045e cd0540        	call	_delay_us
2143                     ; 808   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2145  0461 4b02          	push	#2
2146  0463 ae5000        	ldw	x,#20480
2147  0466 cd0000        	call	_GPIO_WriteHigh
2149  0469 84            	pop	a
2150                     ; 811 }
2153  046a 5b03          	addw	sp,#3
2154  046c 81            	ret	
2214                     ; 818 void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
2214                     ; 819 {       
2215                     	switch	.text
2216  046d               _MCP_23K256_RAM_read_byte:
2218  046d 89            	pushw	x
2219  046e 88            	push	a
2220       00000001      OFST:	set	1
2223                     ; 820     uint8_t addr = 0;
2226  046f               L767:
2227                     ; 822   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2229  046f a680          	ld	a,#128
2230  0471 cd0000        	call	_SPI_GetFlagStatus
2232  0474 4d            	tnz	a
2233  0475 26f8          	jrne	L767
2234                     ; 824   GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
2236  0477 4b02          	push	#2
2237  0479 ae5000        	ldw	x,#20480
2238  047c cd0000        	call	_GPIO_WriteLow
2240  047f 84            	pop	a
2241                     ; 826   SPI_SendData(READ); // instruction 3 read
2243  0480 a603          	ld	a,#3
2244  0482 cd0000        	call	_SPI_SendData
2247  0485               L577:
2248                     ; 828   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2250  0485 a602          	ld	a,#2
2251  0487 cd0000        	call	_SPI_GetFlagStatus
2253  048a 4d            	tnz	a
2254  048b 27f8          	jreq	L577
2255                     ; 831     addr = address>>8;
2257  048d 7b02          	ld	a,(OFST+1,sp)
2258  048f 6b01          	ld	(OFST+0,sp),a
2260                     ; 832   SPI_SendData(addr); // send 16 bit address // MSB is don't care
2262  0491 cd0000        	call	_SPI_SendData
2265  0494               L3001:
2266                     ; 833   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2268  0494 a602          	ld	a,#2
2269  0496 cd0000        	call	_SPI_GetFlagStatus
2271  0499 4d            	tnz	a
2272  049a 27f8          	jreq	L3001
2273                     ; 836     addr = (address&255);
2275  049c 7b03          	ld	a,(OFST+2,sp)
2276  049e 6b01          	ld	(OFST+0,sp),a
2278                     ; 837   SPI_SendData( addr );
2280  04a0 cd0000        	call	_SPI_SendData
2283  04a3               L1101:
2284                     ; 838   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2286  04a3 a602          	ld	a,#2
2287  04a5 cd0000        	call	_SPI_GetFlagStatus
2289  04a8 4d            	tnz	a
2290  04a9 27f8          	jreq	L1101
2292  04ab               L7101:
2293                     ; 842 while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
2295  04ab a601          	ld	a,#1
2296  04ad cd0000        	call	_SPI_GetFlagStatus
2298  04b0 4d            	tnz	a
2299  04b1 27f8          	jreq	L7101
2300                     ; 843 SPI_SendData( 255 );
2302  04b3 a6ff          	ld	a,#255
2303  04b5 cd0000        	call	_SPI_SendData
2306  04b8               L5201:
2307                     ; 844 while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2309  04b8 a602          	ld	a,#2
2310  04ba cd0000        	call	_SPI_GetFlagStatus
2312  04bd 4d            	tnz	a
2313  04be 27f8          	jreq	L5201
2315  04c0               L3301:
2316                     ; 845 while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));   
2318  04c0 a601          	ld	a,#1
2319  04c2 cd0000        	call	_SPI_GetFlagStatus
2321  04c5 4d            	tnz	a
2322  04c6 27f8          	jreq	L3301
2323                     ; 848   *value = SPI_ReceiveData();  
2325  04c8 cd0000        	call	_SPI_ReceiveData
2327  04cb 1e06          	ldw	x,(OFST+5,sp)
2328  04cd f7            	ld	(x),a
2329                     ; 855     delay_us(1);
2331  04ce ae0001        	ldw	x,#1
2332  04d1 ad6d          	call	_delay_us
2334                     ; 857   GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
2336  04d3 4b02          	push	#2
2337  04d5 ae5000        	ldw	x,#20480
2338  04d8 cd0000        	call	_GPIO_WriteHigh
2340  04db 84            	pop	a
2341                     ; 858 }
2344  04dc 5b03          	addw	sp,#3
2345  04de 81            	ret	
2370                     ; 863 void MCP4901_DAC_init(void)
2370                     ; 864 {
2371                     	switch	.text
2372  04df               _MCP4901_DAC_init:
2376                     ; 865   GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
2378  04df 4bf0          	push	#240
2379  04e1 4b10          	push	#16
2380  04e3 ae500a        	ldw	x,#20490
2381  04e6 cd0000        	call	_GPIO_Init
2383  04e9 85            	popw	x
2384                     ; 866   delay_ms(10);
2386  04ea ae000a        	ldw	x,#10
2388                     ; 867 }
2391  04ed 2068          	jp	_delay_ms
2439                     ; 873 void MCP4901_DAC_write( unsigned char value)
2439                     ; 874 {
2440                     	switch	.text
2441  04ef               _MCP4901_DAC_write:
2443  04ef 88            	push	a
2444  04f0 88            	push	a
2445       00000001      OFST:	set	1
2448                     ; 902     unsigned char address = 0x30; // 00,11,00,00
2450  04f1 a630          	ld	a,#48
2451  04f3 6b01          	ld	(OFST+0,sp),a
2453                     ; 903     address |= ( value>>4); // assume 0's shoved in the left
2455  04f5 7b02          	ld	a,(OFST+1,sp)
2456  04f7 4e            	swap	a
2457  04f8 a40f          	and	a,#15
2458  04fa 1a01          	or	a,(OFST+0,sp)
2459  04fc 6b01          	ld	(OFST+0,sp),a
2461                     ; 905     value = ( value<<4 ); // assume 0 shoved in from the right
2463  04fe 7b02          	ld	a,(OFST+1,sp)
2464  0500 4e            	swap	a
2465  0501 a4f0          	and	a,#240
2466  0503 6b02          	ld	(OFST+1,sp),a
2468  0505               L3701:
2469                     ; 908   while(SPI_GetFlagStatus(SPI_FLAG_BSY));
2471  0505 a680          	ld	a,#128
2472  0507 cd0000        	call	_SPI_GetFlagStatus
2474  050a 4d            	tnz	a
2475  050b 26f8          	jrne	L3701
2476                     ; 910   GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
2478  050d 4b10          	push	#16
2479  050f ae500a        	ldw	x,#20490
2480  0512 cd0000        	call	_GPIO_WriteLow
2482  0515 84            	pop	a
2483                     ; 912   SPI_SendData(address);
2485  0516 7b01          	ld	a,(OFST+0,sp)
2486  0518 cd0000        	call	_SPI_SendData
2489  051b               L1011:
2490                     ; 914   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2492  051b a602          	ld	a,#2
2493  051d cd0000        	call	_SPI_GetFlagStatus
2495  0520 4d            	tnz	a
2496  0521 27f8          	jreq	L1011
2497                     ; 916   SPI_SendData(value); 
2499  0523 7b02          	ld	a,(OFST+1,sp)
2500  0525 cd0000        	call	_SPI_SendData
2503  0528               L7011:
2504                     ; 918   while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
2506  0528 a602          	ld	a,#2
2507  052a cd0000        	call	_SPI_GetFlagStatus
2509  052d 4d            	tnz	a
2510  052e 27f8          	jreq	L7011
2511                     ; 922     delay_us(1);
2513  0530 ae0001        	ldw	x,#1
2514  0533 ad0b          	call	_delay_us
2516                     ; 929   GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
2518  0535 4b10          	push	#16
2519  0537 ae500a        	ldw	x,#20490
2520  053a cd0000        	call	_GPIO_WriteHigh
2522                     ; 931 }
2525  053d 5b03          	addw	sp,#3
2526  053f 81            	ret	
2570                     ; 940 void delay_us(unsigned int  value)
2570                     ; 941 {
2571                     	switch	.text
2572  0540               _delay_us:
2574  0540 89            	pushw	x
2575       00000002      OFST:	set	2
2578                     ; 942     register unsigned int loops =  (dly_const * value) ;
2580  0541 cd0000        	call	c_uitof
2582  0544 ae0000        	ldw	x,#L1411
2583  0547 cd0000        	call	c_fmul
2585  054a cd0000        	call	c_ftoi
2588  054d 2002          	jra	L1511
2589  054f               L5411:
2590                     ; 946         _asm ("nop");
2593  054f 9d            	nop	
2595                     ; 947         loops--;
2597  0550 5a            	decw	x
2598  0551               L1511:
2599  0551 1f01          	ldw	(OFST-1,sp),x
2601                     ; 944     while(loops)
2603  0553 26fa          	jrne	L5411
2604                     ; 949 }
2608  0555 85            	popw	x
2609  0556 81            	ret	
2644                     ; 951 void delay_ms(unsigned int  value)
2644                     ; 952 {
2645                     	switch	.text
2646  0557               _delay_ms:
2648  0557 89            	pushw	x
2649       00000000      OFST:	set	0
2652  0558 200a          	jra	L5711
2653  055a               L3711:
2654                     ; 955         delay_us(1000);
2656  055a ae03e8        	ldw	x,#1000
2657  055d ade1          	call	_delay_us
2659                     ; 956         value--;
2661  055f 1e01          	ldw	x,(OFST+1,sp)
2662  0561 5a            	decw	x
2663  0562 1f01          	ldw	(OFST+1,sp),x
2664  0564               L5711:
2665                     ; 953     while(value)
2667  0564 1e01          	ldw	x,(OFST+1,sp)
2668  0566 26f2          	jrne	L3711
2669                     ; 958 }
2673  0568 85            	popw	x
2674  0569 81            	ret	
2687                     	xdef	_main
2688                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
2689                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
2690                     	xdef	_TEST_adc_to_ram_to_dac
2691                     	xdef	_TEST_adc_to_dac
2692                     	xdef	_TEST_rampfunc_in_ram_to_dac
2693                     	xdef	_TEST_ram_test_001
2694                     	xdef	_delay_ms
2695                     	xdef	_delay_us
2696                     	xdef	_MCP_23K256_write_status_register
2697                     	xdef	_MCP_23K256_read_status_register
2698                     	xdef	_MCP_23K256_RAM_write_byte
2699                     	xdef	_MCP_23K256_RAM_read_byte
2700                     	xdef	_MCP_23K256_init
2701                     	xdef	_MCP4901_DAC_init
2702                     	xdef	_MCP4901_DAC_write
2703                     	xdef	_TIM2_setup
2704                     	xdef	_ADC1_setup
2705                     	xdef	_SPI_setup
2706                     	xdef	_GPIO_setup
2707                     	xdef	_clock_setup
2708                     	xref	_TIM2_Cmd
2709                     	xref	_TIM2_OC1Init
2710                     	xref	_TIM2_TimeBaseInit
2711                     	xref	_TIM2_DeInit
2712                     	xref	_SPI_GetFlagStatus
2713                     	xref	_SPI_ReceiveData
2714                     	xref	_SPI_SendData
2715                     	xref	_SPI_Cmd
2716                     	xref	_SPI_Init
2717                     	xref	_SPI_DeInit
2718                     	xref	_GPIO_WriteLow
2719                     	xref	_GPIO_WriteHigh
2720                     	xref	_GPIO_Init
2721                     	xref	_GPIO_DeInit
2722                     	xref	_CLK_GetFlagStatus
2723                     	xref	_CLK_SYSCLKConfig
2724                     	xref	_CLK_HSIPrescalerConfig
2725                     	xref	_CLK_ClockSwitchConfig
2726                     	xref	_CLK_PeripheralClockConfig
2727                     	xref	_CLK_ClockSwitchCmd
2728                     	xref	_CLK_LSICmd
2729                     	xref	_CLK_HSICmd
2730                     	xref	_CLK_HSECmd
2731                     	xref	_CLK_DeInit
2732                     	xref	_ADC1_ClearFlag
2733                     	xref	_ADC1_GetFlagStatus
2734                     	xref	_ADC1_GetBufferValue
2735                     	xref	_ADC1_GetConversionValue
2736                     	xref	_ADC1_StartConversion
2737                     	xref	_ADC1_ConversionConfig
2738                     	xref	_ADC1_DataBufferCmd
2739                     	xref	_ADC1_ScanModeCmd
2740                     	xref	_ADC1_Cmd
2741                     	xref	_ADC1_Init
2742                     	xref	_ADC1_DeInit
2743                     .const:	section	.text
2744  0000               L1411:
2745  0000 3e000000      	dc.w	15872,0
2746  0004               L772:
2747  0004 3e800000      	dc.w	16000,0
2748                     	xref.b	c_lreg
2749                     	xref.b	c_x
2769                     	xref	c_ftoi
2770                     	xref	c_ftol
2771                     	xref	c_fmul
2772                     	xref	c_uitof
2773                     	end
