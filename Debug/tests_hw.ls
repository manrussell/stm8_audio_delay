   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  88                     ; 57 uint8_t TEST_ram_test_001( void )
  88                     ; 58 {
  90                     	switch	.text
  91  0000               _TEST_ram_test_001:
  93  0000 5205          	subw	sp,#5
  94       00000005      OFST:	set	5
  97                     ; 59     uint8_t cnt = 0;
  99                     ; 60     uint8_t data = 0;
 102                     ; 61     uint8_t wdata = 0;
 104                     ; 62     uint16_t addr = 0;
 106                     ; 65     data = BYTE_MODE;
 108  0002 0f03          	clr	(OFST-2,sp)
 110                     ; 66     MCP_23K256_RAM_write_status_register(data);
 112  0004 4f            	clr	a
 113  0005 cd0000        	call	_MCP_23K256_RAM_write_status_register
 115                     ; 69     MCP_23K256_RAM_read_status_register(&data);
 117  0008 96            	ldw	x,sp
 118  0009 1c0003        	addw	x,#OFST-2
 119  000c cd0000        	call	_MCP_23K256_RAM_read_status_register
 121                     ; 113 wdata = 2;
 123  000f a602          	ld	a,#2
 124  0011 6b02          	ld	(OFST-3,sp),a
 126                     ; 114 addr =0;
 128  0013 5f            	clrw	x
 129  0014 1f04          	ldw	(OFST-1,sp),x
 131                     ; 116     MCP_23K256_RAM_write_byte(addr, wdata);
 133  0016 4b02          	push	#2
 134  0018 cd0000        	call	_MCP_23K256_RAM_write_byte
 136  001b 84            	pop	a
 137                     ; 119     MCP_23K256_RAM_read_byte(addr, &data);
 139  001c 96            	ldw	x,sp
 140  001d 1c0003        	addw	x,#OFST-2
 141  0020 89            	pushw	x
 142  0021 1e06          	ldw	x,(OFST+1,sp)
 143  0023 cd0000        	call	_MCP_23K256_RAM_read_byte
 145  0026 a6fa          	ld	a,#250
 146  0028 85            	popw	x
 147                     ; 121     if (wdata != data)
 149                     ; 126 wdata = 250;
 151  0029 6b02          	ld	(OFST-3,sp),a
 153                     ; 127 addr =1;
 155  002b ae0001        	ldw	x,#1
 156  002e 1f04          	ldw	(OFST-1,sp),x
 158                     ; 129     MCP_23K256_RAM_write_byte(addr, wdata);
 160  0030 4bfa          	push	#250
 161  0032 cd0000        	call	_MCP_23K256_RAM_write_byte
 163  0035 84            	pop	a
 164                     ; 132     MCP_23K256_RAM_read_byte(addr, &data);
 166  0036 96            	ldw	x,sp
 167  0037 1c0003        	addw	x,#OFST-2
 168  003a 89            	pushw	x
 169  003b 1e06          	ldw	x,(OFST+1,sp)
 170  003d cd0000        	call	_MCP_23K256_RAM_read_byte
 172  0040 a604          	ld	a,#4
 173  0042 85            	popw	x
 174                     ; 134     if (wdata != data)
 176                     ; 139 wdata = 4;
 178  0043 6b02          	ld	(OFST-3,sp),a
 180                     ; 140 addr =2;
 182  0045 ae0002        	ldw	x,#2
 183  0048 1f04          	ldw	(OFST-1,sp),x
 185                     ; 142     MCP_23K256_RAM_write_byte(addr, wdata);
 187  004a 4b04          	push	#4
 188  004c cd0000        	call	_MCP_23K256_RAM_write_byte
 190  004f 84            	pop	a
 191                     ; 145     MCP_23K256_RAM_read_byte(addr, &data);
 193  0050 96            	ldw	x,sp
 194  0051 1c0003        	addw	x,#OFST-2
 195  0054 89            	pushw	x
 196  0055 1e06          	ldw	x,(OFST+1,sp)
 197  0057 cd0000        	call	_MCP_23K256_RAM_read_byte
 199  005a 85            	popw	x
 200                     ; 147     if (wdata != data)
 202                     ; 153     for(addr = 0; addr<3; addr++)
 204  005b 5f            	clrw	x
 205  005c 1f04          	ldw	(OFST-1,sp),x
 207  005e               L15:
 208                     ; 155         MCP_23K256_RAM_read_byte(addr, &data);
 210  005e 96            	ldw	x,sp
 211  005f 1c0003        	addw	x,#OFST-2
 212  0062 89            	pushw	x
 213  0063 1e06          	ldw	x,(OFST+1,sp)
 214  0065 cd0000        	call	_MCP_23K256_RAM_read_byte
 216  0068 85            	popw	x
 217                     ; 153     for(addr = 0; addr<3; addr++)
 219  0069 1e04          	ldw	x,(OFST-1,sp)
 220  006b 5c            	incw	x
 221  006c 1f04          	ldw	(OFST-1,sp),x
 225  006e a30003        	cpw	x,#3
 226  0071 25eb          	jrult	L15
 227                     ; 157     return 0;
 229  0073 4f            	clr	a
 232  0074 5b05          	addw	sp,#5
 233  0076 81            	ret	
 290                     ; 164 uint8_t TEST_rampfunc_in_ram_to_dac( void )
 290                     ; 165 {
 291                     	switch	.text
 292  0077               _TEST_rampfunc_in_ram_to_dac:
 294  0077 5204          	subw	sp,#4
 295       00000004      OFST:	set	4
 298                     ; 166     uint8_t data = 0;
 300  0079 0f02          	clr	(OFST-2,sp)
 302                     ; 167     uint8_t wdata = 0;
 304  007b 0f01          	clr	(OFST-3,sp)
 306                     ; 168     uint16_t addr = 0;
 308                     ; 171     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 310  007d 5f            	clrw	x
 311  007e 1f03          	ldw	(OFST-1,sp),x
 313  0080 7b01          	ld	a,(OFST-3,sp)
 314  0082               L501:
 315                     ; 173         MCP_23K256_RAM_write_byte(addr, wdata);
 317  0082 88            	push	a
 318  0083 1e04          	ldw	x,(OFST+0,sp)
 319  0085 cd0000        	call	_MCP_23K256_RAM_write_byte
 321  0088 84            	pop	a
 322                     ; 171     for(addr = 0, wdata; addr<255; addr++, wdata+=4)
 324  0089 1e03          	ldw	x,(OFST-1,sp)
 325  008b 5c            	incw	x
 326  008c 1f03          	ldw	(OFST-1,sp),x
 328  008e 7b01          	ld	a,(OFST-3,sp)
 329  0090 ab04          	add	a,#4
 330  0092 6b01          	ld	(OFST-3,sp),a
 334  0094 a300ff        	cpw	x,#255
 335  0097 25e9          	jrult	L501
 336  0099               L311:
 337                     ; 179         for(addr = 0; addr<255; addr++)
 339  0099 5f            	clrw	x
 340  009a 1f03          	ldw	(OFST-1,sp),x
 342  009c               L711:
 343                     ; 181             MCP_23K256_RAM_read_byte(addr, &data);
 345  009c 96            	ldw	x,sp
 346  009d 1c0002        	addw	x,#OFST-2
 347  00a0 89            	pushw	x
 348  00a1 1e05          	ldw	x,(OFST+1,sp)
 349  00a3 cd0000        	call	_MCP_23K256_RAM_read_byte
 351  00a6 85            	popw	x
 352                     ; 182             MCP4901_DAC_write(data);
 354  00a7 7b02          	ld	a,(OFST-2,sp)
 355  00a9 cd0000        	call	_MCP4901_DAC_write
 357                     ; 183             delay_us(90);   //11kHz sample rate // phasor == frequ
 359  00ac ae005a        	ldw	x,#90
 360  00af cd0000        	call	_delay_us
 362                     ; 179         for(addr = 0; addr<255; addr++)
 364  00b2 1e03          	ldw	x,(OFST-1,sp)
 365  00b4 5c            	incw	x
 366  00b5 1f03          	ldw	(OFST-1,sp),x
 370  00b7 a300ff        	cpw	x,#255
 371  00ba 25e0          	jrult	L711
 373  00bc 20db          	jra	L311
 408                     ; 191 void TEST_adc_to_dac( uint8_t *x )
 408                     ; 192 {
 409                     	switch	.text
 410  00be               _TEST_adc_to_dac:
 414                     ; 216 }
 417  00be 81            	ret	
 478                     ; 219 void TEST_adc_to_ram_to_dac( void )
 478                     ; 220 {
 479                     	switch	.text
 480  00bf               _TEST_adc_to_ram_to_dac:
 482  00bf 5205          	subw	sp,#5
 483       00000005      OFST:	set	5
 486                     ; 221     uint16_t adc_val = 0;
 488                     ; 222     uint16_t addr = 0;
 490  00c1 5f            	clrw	x
 491  00c2 1f03          	ldw	(OFST-2,sp),x
 493                     ; 223     uint8_t mapd_value = 0;
 495  00c4 0f05          	clr	(OFST+0,sp)
 497  00c6               L171:
 498                     ; 228         ADC1_StartConversion();
 500  00c6 cd0000        	call	_ADC1_StartConversion
 503  00c9               L771:
 504                     ; 229         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 506  00c9 a680          	ld	a,#128
 507  00cb cd0000        	call	_ADC1_GetFlagStatus
 509  00ce 4d            	tnz	a
 510  00cf 27f8          	jreq	L771
 511                     ; 231         adc_val = ADC1_GetConversionValue(); // for led knob
 513  00d1 cd0000        	call	_ADC1_GetConversionValue
 515  00d4 1f01          	ldw	(OFST-4,sp),x
 517                     ; 232         ADC1_ClearFlag(ADC1_FLAG_EOC);
 519  00d6 a680          	ld	a,#128
 520  00d8 cd0000        	call	_ADC1_ClearFlag
 522                     ; 239         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 524  00db 1e01          	ldw	x,(OFST-4,sp)
 525  00dd cd0000        	call	c_uitof
 527  00e0 ae0000        	ldw	x,#L702
 528  00e3 cd0000        	call	c_fmul
 530  00e6 cd0000        	call	c_ftol
 532  00e9 b603          	ld	a,c_lreg+3
 533  00eb 6b05          	ld	(OFST+0,sp),a
 535                     ; 242         MCP_23K256_RAM_write_byte(addr, mapd_value);
 537  00ed 88            	push	a
 538  00ee 1e04          	ldw	x,(OFST-1,sp)
 539  00f0 cd0000        	call	_MCP_23K256_RAM_write_byte
 541  00f3 84            	pop	a
 542                     ; 245         mapd_value = 0; // check value
 544  00f4 0f05          	clr	(OFST+0,sp)
 546                     ; 246         MCP_23K256_RAM_read_byte(addr, &mapd_value);
 548  00f6 96            	ldw	x,sp
 549  00f7 1c0005        	addw	x,#OFST+0
 550  00fa 89            	pushw	x
 551  00fb 1e05          	ldw	x,(OFST+0,sp)
 552  00fd cd0000        	call	_MCP_23K256_RAM_read_byte
 554  0100 85            	popw	x
 555                     ; 249         addr++;
 557  0101 1e03          	ldw	x,(OFST-2,sp)
 558  0103 5c            	incw	x
 559  0104 1f03          	ldw	(OFST-2,sp),x
 561                     ; 251         MCP4901_DAC_write(mapd_value);
 563  0106 7b05          	ld	a,(OFST+0,sp)
 564  0108 cd0000        	call	_MCP4901_DAC_write
 566                     ; 254         delay_us(90);
 568  010b ae005a        	ldw	x,#90
 569  010e cd0000        	call	_delay_us
 572  0111 20b3          	jra	L171
 669                     ; 261 void TEST_adc_to_ram_to_dac_with_delay( void )
 669                     ; 262 {
 670                     	switch	.text
 671  0113               _TEST_adc_to_ram_to_dac_with_delay:
 673  0113 520b          	subw	sp,#11
 674       0000000b      OFST:	set	11
 677                     ; 263     uint16_t adc_val = 0;
 679                     ; 264     uint8_t mapd_value = 0; // mapped adc valu
 681                     ; 265     uint8_t read_val = 0;   //read val from ram
 683  0115 0f05          	clr	(OFST-6,sp)
 685                     ; 266     uint16_t write_addr = 0;    //write addr in ram
 687  0117 5f            	clrw	x
 688  0118 1f0a          	ldw	(OFST-1,sp),x
 690                     ; 267     uint16_t read_addr = 0; // read addr in val
 692  011a 1f06          	ldw	(OFST-5,sp),x
 694                     ; 268     uint16_t delay = 110; // length of delay in samples
 696  011c ae006e        	ldw	x,#110
 697  011f 1f08          	ldw	(OFST-3,sp),x
 699                     ; 269     uint8_t res = 0;
 701  0121               L162:
 702                     ; 275         ADC1_StartConversion();
 704  0121 cd0000        	call	_ADC1_StartConversion
 707  0124               L762:
 708                     ; 276         while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 710  0124 a680          	ld	a,#128
 711  0126 cd0000        	call	_ADC1_GetFlagStatus
 713  0129 4d            	tnz	a
 714  012a 27f8          	jreq	L762
 715                     ; 278         adc_val = ADC1_GetConversionValue(); // for led knob
 717  012c cd0000        	call	_ADC1_GetConversionValue
 719  012f 1f02          	ldw	(OFST-9,sp),x
 721                     ; 279         ADC1_ClearFlag(ADC1_FLAG_EOC);
 723  0131 a680          	ld	a,#128
 724  0133 cd0000        	call	_ADC1_ClearFlag
 726                     ; 286         mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
 728  0136 1e02          	ldw	x,(OFST-9,sp)
 729  0138 cd0000        	call	c_uitof
 731  013b ae0000        	ldw	x,#L702
 732  013e cd0000        	call	c_fmul
 734  0141 cd0000        	call	c_ftol
 736  0144 b603          	ld	a,c_lreg+3
 737  0146 6b04          	ld	(OFST-7,sp),a
 739                     ; 297             read_addr = write_addr - delay;
 741  0148 1e0a          	ldw	x,(OFST-1,sp)
 742  014a 72f008        	subw	x,(OFST-3,sp)
 743  014d 1f06          	ldw	(OFST-5,sp),x
 745                     ; 301         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 747  014f 88            	push	a
 748  0150 1e0b          	ldw	x,(OFST+0,sp)
 749  0152 cd0000        	call	_MCP_23K256_RAM_write_byte
 751  0155 84            	pop	a
 752                     ; 304         MCP_23K256_RAM_read_byte(read_addr, &read_val);
 754  0156 96            	ldw	x,sp
 755  0157 1c0005        	addw	x,#OFST-6
 756  015a 89            	pushw	x
 757  015b 1e08          	ldw	x,(OFST-3,sp)
 758  015d cd0000        	call	_MCP_23K256_RAM_read_byte
 760  0160 85            	popw	x
 761                     ; 307         MCP4901_DAC_write(read_val);
 763  0161 7b05          	ld	a,(OFST-6,sp)
 764  0163 cd0000        	call	_MCP4901_DAC_write
 766                     ; 310         write_addr++;
 768  0166 1e0a          	ldw	x,(OFST-1,sp)
 769  0168 5c            	incw	x
 770  0169 1f0a          	ldw	(OFST-1,sp),x
 772                     ; 313         delay_us(90);
 774  016b ae005a        	ldw	x,#90
 775  016e cd0000        	call	_delay_us
 778  0171 20ae          	jra	L162
 886                     ; 321 void TEST_adc_to_ram_to_dac_with_with_fback( void )
 886                     ; 322 {
 887                     	switch	.text
 888  0173               _TEST_adc_to_ram_to_dac_with_with_fback:
 890  0173 520d          	subw	sp,#13
 891       0000000d      OFST:	set	13
 894                     ; 324     uint16_t adc0_val = 0;  //er are these 8 or 16 big?
 896                     ; 325     uint16_t adc1_val = 0;
 898                     ; 326     uint8_t mapd_value = 0; // mapped adc valu
 900                     ; 327     uint8_t read_val = 0;   //read val from ram
 902  0175 0f06          	clr	(OFST-7,sp)
 904                     ; 328     uint16_t write_addr = 0;    //write addr in ram
 906  0177 5f            	clrw	x
 907  0178 1f0a          	ldw	(OFST-3,sp),x
 909                     ; 329     uint16_t read_addr = 0; // read addr in val
 911  017a 1f07          	ldw	(OFST-6,sp),x
 913                     ; 330     uint16_t delay = 110; // length of delay in samples
 915                     ; 331     uint8_t res = 0;
 917  017c               L543:
 918                     ; 346     ADC1_ScanModeCmd(ENABLE);
 920  017c a601          	ld	a,#1
 921  017e cd0000        	call	_ADC1_ScanModeCmd
 923                     ; 347     ADC1_StartConversion();
 925  0181 cd0000        	call	_ADC1_StartConversion
 928  0184               L353:
 929                     ; 348     while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 931  0184 a680          	ld	a,#128
 932  0186 cd0000        	call	_ADC1_GetFlagStatus
 934  0189 4d            	tnz	a
 935  018a 27f8          	jreq	L353
 936                     ; 350     adc0_val = ADC1_GetBufferValue(0);
 938  018c 4f            	clr	a
 939  018d cd0000        	call	_ADC1_GetBufferValue
 941  0190 1f04          	ldw	(OFST-9,sp),x
 943                     ; 351     adc1_val = ADC1_GetBufferValue(1);
 945  0192 a601          	ld	a,#1
 946  0194 cd0000        	call	_ADC1_GetBufferValue
 948  0197 1f0c          	ldw	(OFST-1,sp),x
 950                     ; 352     ADC1_ClearFlag(ADC1_FLAG_EOC);
 952  0199 a680          	ld	a,#128
 953  019b cd0000        	call	_ADC1_ClearFlag
 955                     ; 355     delay = (adc1_val>>2);
 957  019e 1e0c          	ldw	x,(OFST-1,sp)
 958  01a0 54            	srlw	x
 959  01a1 54            	srlw	x
 960  01a2 1f0c          	ldw	(OFST-1,sp),x
 962                     ; 365         mapd_value = (adc0_val>>2) ; // do i need the float or not ??? -No use a lft shift
 964  01a4 1e04          	ldw	x,(OFST-9,sp)
 965  01a6 54            	srlw	x
 966  01a7 54            	srlw	x
 967  01a8 01            	rrwa	x,a
 968  01a9 6b09          	ld	(OFST-4,sp),a
 970                     ; 370         mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
 972  01ab 5f            	clrw	x
 973  01ac 7b06          	ld	a,(OFST-7,sp)
 974  01ae 97            	ld	xl,a
 975  01af 57            	sraw	x
 976  01b0 1f01          	ldw	(OFST-12,sp),x
 978  01b2 5f            	clrw	x
 979  01b3 7b09          	ld	a,(OFST-4,sp)
 980  01b5 97            	ld	xl,a
 981  01b6 57            	sraw	x
 982  01b7 72fb01        	addw	x,(OFST-12,sp)
 983  01ba 01            	rrwa	x,a
 984  01bb 6b09          	ld	(OFST-4,sp),a
 986                     ; 381             read_addr = write_addr - delay;
 988  01bd 1e0a          	ldw	x,(OFST-3,sp)
 989  01bf 72f00c        	subw	x,(OFST-1,sp)
 990  01c2 1f07          	ldw	(OFST-6,sp),x
 992                     ; 385         MCP_23K256_RAM_write_byte(write_addr, mapd_value);
 994  01c4 88            	push	a
 995  01c5 1e0b          	ldw	x,(OFST-2,sp)
 996  01c7 cd0000        	call	_MCP_23K256_RAM_write_byte
 998  01ca 84            	pop	a
 999                     ; 388         MCP_23K256_RAM_read_byte(read_addr, &read_val);
1001  01cb 96            	ldw	x,sp
1002  01cc 1c0006        	addw	x,#OFST-7
1003  01cf 89            	pushw	x
1004  01d0 1e09          	ldw	x,(OFST-4,sp)
1005  01d2 cd0000        	call	_MCP_23K256_RAM_read_byte
1007  01d5 85            	popw	x
1008                     ; 391         MCP4901_DAC_write(read_val);
1010  01d6 7b06          	ld	a,(OFST-7,sp)
1011  01d8 cd0000        	call	_MCP4901_DAC_write
1013                     ; 394         write_addr++;
1015  01db 1e0a          	ldw	x,(OFST-3,sp)
1016  01dd 5c            	incw	x
1017  01de 1f0a          	ldw	(OFST-3,sp),x
1019                     ; 397         delay_us(90);
1021  01e0 ae005a        	ldw	x,#90
1022  01e3 cd0000        	call	_delay_us
1025  01e6 2094          	jra	L543
1051                     ; 409 void TEST_clock_speed( void )
1051                     ; 410 {
1052                     	switch	.text
1053  01e8               _TEST_clock_speed:
1057                     ; 411     GPIO_Init( LED_port, LED_pin, GPIO_MODE_OUT_PP_HIGH_FAST );
1059  01e8 4bf0          	push	#240
1060  01ea 4b10          	push	#16
1061  01ec ae500f        	ldw	x,#20495
1062  01ef cd0000        	call	_GPIO_Init
1064  01f2 85            	popw	x
1065  01f3               L763:
1066                     ; 415         delay_ms( 1 );
1068  01f3 ae0001        	ldw	x,#1
1069  01f6 cd0000        	call	_delay_ms
1071                     ; 417         GPIO_WriteReverse(LED_port, LED_pin);
1073  01f9 4b10          	push	#16
1074  01fb ae500f        	ldw	x,#20495
1075  01fe cd0000        	call	_GPIO_WriteReverse
1077  0201 84            	pop	a
1079  0202 20ef          	jra	L763
1092                     	xdef	_TEST_clock_speed
1093                     	xdef	_TEST_adc_to_ram_to_dac_with_with_fback
1094                     	xdef	_TEST_adc_to_ram_to_dac_with_delay
1095                     	xdef	_TEST_adc_to_ram_to_dac
1096                     	xdef	_TEST_adc_to_dac
1097                     	xdef	_TEST_rampfunc_in_ram_to_dac
1098                     	xdef	_TEST_ram_test_001
1099                     	xref	_MCP_23K256_RAM_read_byte
1100                     	xref	_MCP_23K256_RAM_write_byte
1101                     	xref	_MCP_23K256_RAM_write_status_register
1102                     	xref	_MCP_23K256_RAM_read_status_register
1103                     	xref	_MCP4901_DAC_write
1104                     	xref	_delay_ms
1105                     	xref	_delay_us
1106                     	xref	_GPIO_WriteReverse
1107                     	xref	_GPIO_Init
1108                     	xref	_ADC1_ClearFlag
1109                     	xref	_ADC1_GetFlagStatus
1110                     	xref	_ADC1_GetBufferValue
1111                     	xref	_ADC1_GetConversionValue
1112                     	xref	_ADC1_StartConversion
1113                     	xref	_ADC1_ScanModeCmd
1114                     .const:	section	.text
1115  0000               L702:
1116  0000 3e800000      	dc.w	16000,0
1117                     	xref.b	c_lreg
1118                     	xref.b	c_x
1138                     	xref	c_ftol
1139                     	xref	c_fmul
1140                     	xref	c_uitof
1141                     	end
