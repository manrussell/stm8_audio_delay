   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  46                     ; 18 void TEST_run_all_tests( void )
  46                     ; 19 {
  48                     	switch	.text
  49  0000               _TEST_run_all_tests:
  53                     ; 57 }
  56  0000 81            	ret	
 121                     ; 59 uint8_t TEST_ram_test_001( void )
 121                     ; 60 {
 122                     	switch	.text
 123  0001               _TEST_ram_test_001:
 125  0001 5205          	subw	sp,#5
 126       00000005      OFST:	set	5
 129                     ; 61     uint8_t cnt = 0;
 131                     ; 62     uint8_t data = 0;
 134                     ; 63     uint8_t wdata = 0;
 136                     ; 64     uint16_t addr = 0;
 138                     ; 67     data = BYTE_MODE;
 140  0003 0f03          	clr	(OFST-2,sp)
 142                     ; 68     MCP_23K256_RAM_write_status_register(data);
 144  0005 4f            	clr	a
 145  0006 cd0000        	call	_MCP_23K256_RAM_write_status_register
 147                     ; 71     MCP_23K256_RAM_read_status_register(&data);
 149  0009 96            	ldw	x,sp
 150  000a 1c0003        	addw	x,#OFST-2
 151  000d cd0000        	call	_MCP_23K256_RAM_read_status_register
 153                     ; 115 wdata = 2;
 155  0010 a602          	ld	a,#2
 156  0012 6b02          	ld	(OFST-3,sp),a
 158                     ; 116 addr =0;
 160  0014 5f            	clrw	x
 161  0015 1f04          	ldw	(OFST-1,sp),x
 163                     ; 118     MCP_23K256_RAM_write_byte(addr, wdata);
 165  0017 4b02          	push	#2
 166  0019 cd0000        	call	_MCP_23K256_RAM_write_byte
 168  001c 84            	pop	a
 169                     ; 121     MCP_23K256_RAM_read_byte(addr, &data);
 171  001d 96            	ldw	x,sp
 172  001e 1c0003        	addw	x,#OFST-2
 173  0021 89            	pushw	x
 174  0022 1e06          	ldw	x,(OFST+1,sp)
 175  0024 cd0000        	call	_MCP_23K256_RAM_read_byte
 177  0027 a6fa          	ld	a,#250
 178  0029 85            	popw	x
 179                     ; 123     if (wdata != data)
 181                     ; 128 wdata = 250;
 183  002a 6b02          	ld	(OFST-3,sp),a
 185                     ; 129 addr =1;
 187  002c ae0001        	ldw	x,#1
 188  002f 1f04          	ldw	(OFST-1,sp),x
 190                     ; 131     MCP_23K256_RAM_write_byte(addr, wdata);
 192  0031 4bfa          	push	#250
 193  0033 cd0000        	call	_MCP_23K256_RAM_write_byte
 195  0036 84            	pop	a
 196                     ; 134     MCP_23K256_RAM_read_byte(addr, &data);
 198  0037 96            	ldw	x,sp
 199  0038 1c0003        	addw	x,#OFST-2
 200  003b 89            	pushw	x
 201  003c 1e06          	ldw	x,(OFST+1,sp)
 202  003e cd0000        	call	_MCP_23K256_RAM_read_byte
 204  0041 a604          	ld	a,#4
 205  0043 85            	popw	x
 206                     ; 136     if (wdata != data)
 208                     ; 141 wdata = 4;
 210  0044 6b02          	ld	(OFST-3,sp),a
 212                     ; 142 addr =2;
 214  0046 ae0002        	ldw	x,#2
 215  0049 1f04          	ldw	(OFST-1,sp),x
 217                     ; 144     MCP_23K256_RAM_write_byte(addr, wdata);
 219  004b 4b04          	push	#4
 220  004d cd0000        	call	_MCP_23K256_RAM_write_byte
 222  0050 84            	pop	a
 223                     ; 147     MCP_23K256_RAM_read_byte(addr, &data);
 225  0051 96            	ldw	x,sp
 226  0052 1c0003        	addw	x,#OFST-2
 227  0055 89            	pushw	x
 228  0056 1e06          	ldw	x,(OFST+1,sp)
 229  0058 cd0000        	call	_MCP_23K256_RAM_read_byte
 231  005b 85            	popw	x
 232                     ; 149     if (wdata != data)
 234                     ; 155     for(addr = 0; addr<3; addr++)
 236  005c 5f            	clrw	x
 237  005d 1f04          	ldw	(OFST-1,sp),x
 239  005f               L16:
 240                     ; 157         MCP_23K256_RAM_read_byte(addr, &data);
 242  005f 96            	ldw	x,sp
 243  0060 1c0003        	addw	x,#OFST-2
 244  0063 89            	pushw	x
 245  0064 1e06          	ldw	x,(OFST+1,sp)
 246  0066 cd0000        	call	_MCP_23K256_RAM_read_byte
 248  0069 85            	popw	x
 249                     ; 155     for(addr = 0; addr<3; addr++)
 251  006a 1e04          	ldw	x,(OFST-1,sp)
 252  006c 5c            	incw	x
 253  006d 1f04          	ldw	(OFST-1,sp),x
 257  006f a30003        	cpw	x,#3
 258  0072 25eb          	jrult	L16
 259                     ; 159     return 0;
 261  0074 4f            	clr	a
 264  0075 5b05          	addw	sp,#5
 265  0077 81            	ret	
 322                     ; 166 uint8_t TEST_rampfunc_in_ram_to_dac( void )
 322                     ; 167 {
 323                     	switch	.text
 324  0078               _TEST_rampfunc_in_ram_to_dac:
 326  0078 5204          	subw	sp,#4
 327       00000004      OFST:	set	4
 330                     ; 168     uint8_t data = 0;
 332  007a 0f02          	clr	(OFST-2,sp)
 334                     ; 169     uint8_t wdata = 0;
 336  007c 0f01          	clr	(OFST-3,sp)
 338                     ; 170     uint16_t addr = 0;
 340                     ; 173     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 342  007e 5f            	clrw	x
 343  007f 1f03          	ldw	(OFST-1,sp),x
 345  0081 7b01          	ld	a,(OFST-3,sp)
 346  0083               L511:
 347                     ; 175         MCP_23K256_RAM_write_byte(addr, wdata);
 349  0083 88            	push	a
 350  0084 1e04          	ldw	x,(OFST+0,sp)
 351  0086 cd0000        	call	_MCP_23K256_RAM_write_byte
 353  0089 84            	pop	a
 354                     ; 173     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 356  008a 1e03          	ldw	x,(OFST-1,sp)
 357  008c 5c            	incw	x
 358  008d 1f03          	ldw	(OFST-1,sp),x
 360  008f 7b01          	ld	a,(OFST-3,sp)
 361  0091 ab04          	add	a,#4
 362  0093 6b01          	ld	(OFST-3,sp),a
 366  0095 a300ff        	cpw	x,#255
 367  0098 25e9          	jrult	L511
 368  009a               L321:
 369                     ; 181         for(addr = 0; addr<255; addr++)
 371  009a 5f            	clrw	x
 372  009b 1f03          	ldw	(OFST-1,sp),x
 374  009d               L721:
 375                     ; 183             MCP_23K256_RAM_read_byte(addr, &data);
 377  009d 96            	ldw	x,sp
 378  009e 1c0002        	addw	x,#OFST-2
 379  00a1 89            	pushw	x
 380  00a2 1e05          	ldw	x,(OFST+1,sp)
 381  00a4 cd0000        	call	_MCP_23K256_RAM_read_byte
 383  00a7 85            	popw	x
 384                     ; 184             MCP4901_DAC_write(data);
 386  00a8 7b02          	ld	a,(OFST-2,sp)
 387  00aa cd0000        	call	_MCP4901_DAC_write
 389                     ; 185             delay_us(90);   //11kHz sample rate // phasor == frequ
 391  00ad ae005a        	ldw	x,#90
 392  00b0 cd0000        	call	_delay_us
 394                     ; 181         for(addr = 0; addr<255; addr++)
 396  00b3 1e03          	ldw	x,(OFST-1,sp)
 397  00b5 5c            	incw	x
 398  00b6 1f03          	ldw	(OFST-1,sp),x
 402  00b8 a300ff        	cpw	x,#255
 403  00bb 25e0          	jrult	L721
 405  00bd 20db          	jra	L321
 440                     ; 193 void TEST_adc_to_dac( uint8_t *x )
 440                     ; 194 {
 441                     	switch	.text
 442  00bf               _TEST_adc_to_dac:
 446                     ; 218 }
 449  00bf 81            	ret	
 510                     ; 221 void TEST_adc_to_ram_to_dac( void )
 510                     ; 222 {
 511                     	switch	.text
 512  00c0               _TEST_adc_to_ram_to_dac:
 514  00c0 5205          	subw	sp,#5
 515       00000005      OFST:	set	5
 518                     ; 223     uint16_t adc_val = 0;
 520                     ; 224     uint16_t addr = 0;
 522  00c2 5f            	clrw	x
 523  00c3 1f03          	ldw	(OFST-2,sp),x
 525                     ; 225     uint8_t mapd_value = 0;
 527  00c5 0f05          	clr	(OFST+0,sp)
 529  00c7               L102:
 530                     ; 230         ADC1_StartConversion();
 532  00c7 cd0000        	call	_ADC1_StartConversion
 535  00ca               L702:
 536                     ; 231         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 538  00ca a680          	ld	a,#128
 539  00cc cd0000        	call	_ADC1_GetFlagStatus
 541  00cf 4d            	tnz	a
 542  00d0 27f8          	jreq	L702
 543                     ; 233         adc_val = ADC1_GetConversionValue(); // for led knob
 545  00d2 cd0000        	call	_ADC1_GetConversionValue
 547  00d5 1f01          	ldw	(OFST-4,sp),x
 549                     ; 234         ADC1_ClearFlag(ADC1_FLAG_EOC);
 551  00d7 a680          	ld	a,#128
 552  00d9 cd0000        	call	_ADC1_ClearFlag
 554                     ; 241         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 556  00dc 1e01          	ldw	x,(OFST-4,sp)
 557  00de cd0000        	call	c_uitof
 559  00e1 ae0000        	ldw	x,#L712
 560  00e4 cd0000        	call	c_fmul
 562  00e7 cd0000        	call	c_ftol
 564  00ea b603          	ld	a,c_lreg+3
 565  00ec 6b05          	ld	(OFST+0,sp),a
 567                     ; 244         MCP_23K256_RAM_write_byte(addr, mapd_value);
 569  00ee 88            	push	a
 570  00ef 1e04          	ldw	x,(OFST-1,sp)
 571  00f1 cd0000        	call	_MCP_23K256_RAM_write_byte
 573  00f4 84            	pop	a
 574                     ; 247         mapd_value = 0; // check value
 576  00f5 0f05          	clr	(OFST+0,sp)
 578                     ; 248         MCP_23K256_RAM_read_byte(addr, &mapd_value);
 580  00f7 96            	ldw	x,sp
 581  00f8 1c0005        	addw	x,#OFST+0
 582  00fb 89            	pushw	x
 583  00fc 1e05          	ldw	x,(OFST+0,sp)
 584  00fe cd0000        	call	_MCP_23K256_RAM_read_byte
 586  0101 85            	popw	x
 587                     ; 251         addr++;
 589  0102 1e03          	ldw	x,(OFST-2,sp)
 590  0104 5c            	incw	x
 591  0105 1f03          	ldw	(OFST-2,sp),x
 593                     ; 253         MCP4901_DAC_write(mapd_value);
 595  0107 7b05          	ld	a,(OFST+0,sp)
 596  0109 cd0000        	call	_MCP4901_DAC_write
 598                     ; 256         delay_us(90);
 600  010c ae005a        	ldw	x,#90
 601  010f cd0000        	call	_delay_us
 604  0112 20b3          	jra	L102
 701                     ; 263 void TEST_adc_to_ram_to_dac_with_delay( void )
 701                     ; 264 {
 702                     	switch	.text
 703  0114               _TEST_adc_to_ram_to_dac_with_delay:
 705  0114 520b          	subw	sp,#11
 706       0000000b      OFST:	set	11
 709                     ; 265     uint16_t adc_val = 0;
 711                     ; 266     uint8_t mapd_value = 0; // mapped adc valu
 713                     ; 267     uint8_t read_val = 0;   //read val from ram
 715  0116 0f05          	clr	(OFST-6,sp)
 717                     ; 268     uint16_t write_addr = 0;    //write addr in ram
 719  0118 5f            	clrw	x
 720  0119 1f0a          	ldw	(OFST-1,sp),x
 722                     ; 269     uint16_t read_addr = 0; // read addr in val
 724  011b 1f06          	ldw	(OFST-5,sp),x
 726                     ; 270     uint16_t delay = 110; // length of delay in samples
 728  011d ae006e        	ldw	x,#110
 729  0120 1f08          	ldw	(OFST-3,sp),x
 731                     ; 271     uint8_t res = 0;
 733  0122               L172:
 734                     ; 277         ADC1_StartConversion();
 736  0122 cd0000        	call	_ADC1_StartConversion
 739  0125               L772:
 740                     ; 278         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 742  0125 a680          	ld	a,#128
 743  0127 cd0000        	call	_ADC1_GetFlagStatus
 745  012a 4d            	tnz	a
 746  012b 27f8          	jreq	L772
 747                     ; 280         adc_val = ADC1_GetConversionValue(); // for led knob
 749  012d cd0000        	call	_ADC1_GetConversionValue
 751  0130 1f02          	ldw	(OFST-9,sp),x
 753                     ; 281         ADC1_ClearFlag(ADC1_FLAG_EOC);
 755  0132 a680          	ld	a,#128
 756  0134 cd0000        	call	_ADC1_ClearFlag
 758                     ; 288         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 760  0137 1e02          	ldw	x,(OFST-9,sp)
 761  0139 cd0000        	call	c_uitof
 763  013c ae0000        	ldw	x,#L712
 764  013f cd0000        	call	c_fmul
 766  0142 cd0000        	call	c_ftol
 768  0145 b603          	ld	a,c_lreg+3
 769  0147 6b04          	ld	(OFST-7,sp),a
 771                     ; 299             read_addr = write_addr - delay;
 773  0149 1e0a          	ldw	x,(OFST-1,sp)
 774  014b 72f008        	subw	x,(OFST-3,sp)
 775  014e 1f06          	ldw	(OFST-5,sp),x
 777                     ; 303         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 779  0150 88            	push	a
 780  0151 1e0b          	ldw	x,(OFST+0,sp)
 781  0153 cd0000        	call	_MCP_23K256_RAM_write_byte
 783  0156 84            	pop	a
 784                     ; 306         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 786  0157 96            	ldw	x,sp
 787  0158 1c0005        	addw	x,#OFST-6
 788  015b 89            	pushw	x
 789  015c 1e08          	ldw	x,(OFST-3,sp)
 790  015e cd0000        	call	_MCP_23K256_RAM_read_byte
 792  0161 85            	popw	x
 793                     ; 309         MCP4901_DAC_write(read_val);
 795  0162 7b05          	ld	a,(OFST-6,sp)
 796  0164 cd0000        	call	_MCP4901_DAC_write
 798                     ; 312         write_addr++;
 800  0167 1e0a          	ldw	x,(OFST-1,sp)
 801  0169 5c            	incw	x
 802  016a 1f0a          	ldw	(OFST-1,sp),x
 804                     ; 315         delay_us(90);
 806  016c ae005a        	ldw	x,#90
 807  016f cd0000        	call	_delay_us
 810  0172 20ae          	jra	L172
 918                     ; 323 void TEST_adc_to_ram_to_dac_with_with_fback( void )
 918                     ; 324 {
 919                     	switch	.text
 920  0174               _TEST_adc_to_ram_to_dac_with_with_fback:
 922  0174 520d          	subw	sp,#13
 923       0000000d      OFST:	set	13
 926                     ; 326     uint16_t adc0_val = 0;  //er are these 8 or 16 big?
 928                     ; 327     uint16_t adc1_val = 0;
 930                     ; 328     uint8_t mapd_value = 0; // mapped adc valu
 932                     ; 329     uint8_t read_val = 0;   //read val from ram
 934  0176 0f06          	clr	(OFST-7,sp)
 936                     ; 330     uint16_t write_addr = 0;    //write addr in ram
 938  0178 5f            	clrw	x
 939  0179 1f0a          	ldw	(OFST-3,sp),x
 941                     ; 331     uint16_t read_addr = 0; // read addr in val
 943  017b 1f07          	ldw	(OFST-6,sp),x
 945                     ; 332     uint16_t delay = 110; // length of delay in samples
 947                     ; 333     uint8_t res = 0;
 949  017d               L553:
 950                     ; 348     ADC1_ScanModeCmd(ENABLE);
 952  017d a601          	ld	a,#1
 953  017f cd0000        	call	_ADC1_ScanModeCmd
 955                     ; 349     ADC1_StartConversion();
 957  0182 cd0000        	call	_ADC1_StartConversion
 960  0185               L363:
 961                     ; 350     while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 963  0185 a680          	ld	a,#128
 964  0187 cd0000        	call	_ADC1_GetFlagStatus
 966  018a 4d            	tnz	a
 967  018b 27f8          	jreq	L363
 968                     ; 352     adc0_val = ADC1_GetBufferValue(0);
 970  018d 4f            	clr	a
 971  018e cd0000        	call	_ADC1_GetBufferValue
 973  0191 1f04          	ldw	(OFST-9,sp),x
 975                     ; 353     adc1_val = ADC1_GetBufferValue(1);
 977  0193 a601          	ld	a,#1
 978  0195 cd0000        	call	_ADC1_GetBufferValue
 980  0198 1f0c          	ldw	(OFST-1,sp),x
 982                     ; 354     ADC1_ClearFlag(ADC1_FLAG_EOC);
 984  019a a680          	ld	a,#128
 985  019c cd0000        	call	_ADC1_ClearFlag
 987                     ; 357     delay = (adc1_val>>2);
 989  019f 1e0c          	ldw	x,(OFST-1,sp)
 990  01a1 54            	srlw	x
 991  01a2 54            	srlw	x
 992  01a3 1f0c          	ldw	(OFST-1,sp),x
 994                     ; 367         mapd_value = (adc0_val>>2) ; // do i need the float or not ??? -No use a lft shift
 996  01a5 1e04          	ldw	x,(OFST-9,sp)
 997  01a7 54            	srlw	x
 998  01a8 54            	srlw	x
 999  01a9 01            	rrwa	x,a
1000  01aa 6b09          	ld	(OFST-4,sp),a
1002                     ; 372         mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
1004  01ac 5f            	clrw	x
1005  01ad 7b06          	ld	a,(OFST-7,sp)
1006  01af 97            	ld	xl,a
1007  01b0 57            	sraw	x
1008  01b1 1f01          	ldw	(OFST-12,sp),x
1010  01b3 5f            	clrw	x
1011  01b4 7b09          	ld	a,(OFST-4,sp)
1012  01b6 97            	ld	xl,a
1013  01b7 57            	sraw	x
1014  01b8 72fb01        	addw	x,(OFST-12,sp)
1015  01bb 01            	rrwa	x,a
1016  01bc 6b09          	ld	(OFST-4,sp),a
1018                     ; 383             read_addr = write_addr - delay;
1020  01be 1e0a          	ldw	x,(OFST-3,sp)
1021  01c0 72f00c        	subw	x,(OFST-1,sp)
1022  01c3 1f07          	ldw	(OFST-6,sp),x
1024                     ; 387         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
1026  01c5 88            	push	a
1027  01c6 1e0b          	ldw	x,(OFST-2,sp)
1028  01c8 cd0000        	call	_MCP_23K256_RAM_write_byte
1030  01cb 84            	pop	a
1031                     ; 390         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1033  01cc 96            	ldw	x,sp
1034  01cd 1c0006        	addw	x,#OFST-7
1035  01d0 89            	pushw	x
1036  01d1 1e09          	ldw	x,(OFST-4,sp)
1037  01d3 cd0000        	call	_MCP_23K256_RAM_read_byte
1039  01d6 85            	popw	x
1040                     ; 393         MCP4901_DAC_write(read_val);
1042  01d7 7b06          	ld	a,(OFST-7,sp)
1043  01d9 cd0000        	call	_MCP4901_DAC_write
1045                     ; 396         write_addr++;
1047  01dc 1e0a          	ldw	x,(OFST-3,sp)
1048  01de 5c            	incw	x
1049  01df 1f0a          	ldw	(OFST-3,sp),x
1051                     ; 399         delay_us(90);
1053  01e1 ae005a        	ldw	x,#90
1054  01e4 cd0000        	call	_delay_us
1057  01e7 2094          	jra	L553
1083                     ; 411 void TEST_clock_speed( void )
1083                     ; 412 {
1084                     	switch	.text
1085  01e9               _TEST_clock_speed:
1089                     ; 413     GPIO_Init( LED_port, LED_pin, GPIO_MODE_OUT_PP_HIGH_FAST );
1091  01e9 4bf0          	push	#240
1092  01eb 4b10          	push	#16
1093  01ed ae500f        	ldw	x,#20495
1094  01f0 cd0000        	call	_GPIO_Init
1096  01f3 85            	popw	x
1097  01f4               L773:
1098                     ; 417         delay_ms( 1 );
1100  01f4 ae0001        	ldw	x,#1
1101  01f7 cd0000        	call	_delay_ms
1103                     ; 419         GPIO_WriteReverse(LED_port, LED_pin);
1105  01fa 4b10          	push	#16
1106  01fc ae500f        	ldw	x,#20495
1107  01ff cd0000        	call	_GPIO_WriteReverse
1109  0202 84            	pop	a
1111  0203 20ef          	jra	L773
1124                     	xdef	_TEST_run_all_tests
1125                     	xdef	_TEST_clock_speed
1126                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
1127                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
1128                     	xdef	_TEST_adc_to_ram_to_dac
1129                     	xdef	_TEST_adc_to_dac
1130                     	xdef	_TEST_rampfunc_in_ram_to_dac
1131                     	xdef	_TEST_ram_test_001
1132                     	xref	_MCP_23K256_RAM_read_byte
1133                     	xref	_MCP_23K256_RAM_write_byte
1134                     	xref	_MCP_23K256_RAM_write_status_register
1135                     	xref	_MCP_23K256_RAM_read_status_register
1136                     	xref	_MCP4901_DAC_write
1137                     	xref	_delay_ms
1138                     	xref	_delay_us
1139                     	xref	_GPIO_WriteReverse
1140                     	xref	_GPIO_Init
1141                     	xref	_ADC1_ClearFlag
1142                     	xref	_ADC1_GetFlagStatus
1143                     	xref	_ADC1_GetBufferValue
1144                     	xref	_ADC1_GetConversionValue
1145                     	xref	_ADC1_StartConversion
1146                     	xref	_ADC1_ScanModeCmd
1147                     .const:	section	.text
1148  0000               L712:
1149  0000 3e800000      	dc.w	16000,0
1150                     	xref.b	c_lreg
1151                     	xref.b	c_x
1171                     	xref	c_ftol
1172                     	xref	c_fmul
1173                     	xref	c_uitof
1174                     	end
