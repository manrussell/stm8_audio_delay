   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  46                     ; 53 void UART2_DeInit(void)
  46                     ; 54 {
  48                     	switch	.text
  49  0000               _UART2_DeInit:
  53                     ; 57   (void) UART2->SR;
  55  0000 c65240        	ld	a,21056
  56                     ; 58   (void)UART2->DR;
  58  0003 c65241        	ld	a,21057
  59                     ; 60   UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  61  0006 725f5243      	clr	21059
  62                     ; 61   UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  64  000a 725f5242      	clr	21058
  65                     ; 63   UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  67  000e 725f5244      	clr	21060
  68                     ; 64   UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  70  0012 725f5245      	clr	21061
  71                     ; 65   UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  73  0016 725f5246      	clr	21062
  74                     ; 66   UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  76  001a 725f5247      	clr	21063
  77                     ; 67   UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  79  001e 725f5248      	clr	21064
  80                     ; 68   UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  82  0022 725f5249      	clr	21065
  83                     ; 69 }
  86  0026 81            	ret	
 407                     .const:	section	.text
 408  0000               L41:
 409  0000 00000064      	dc.l	100
 410                     ; 85 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 410                     ; 86 {
 411                     	switch	.text
 412  0027               _UART2_Init:
 414  0027 520e          	subw	sp,#14
 415       0000000e      OFST:	set	14
 418                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 422                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 426                     ; 91   assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 428                     ; 92   assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 430                     ; 93   assert_param(IS_UART2_STOPBITS_OK(StopBits));
 432                     ; 94   assert_param(IS_UART2_PARITY_OK(Parity));
 434                     ; 95   assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 436                     ; 96   assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 438                     ; 99   UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 440  0029 72195244      	bres	21060,#4
 441                     ; 101   UART2->CR1 |= (uint8_t)WordLength; 
 443  002d c65244        	ld	a,21060
 444  0030 1a15          	or	a,(OFST+7,sp)
 445  0032 c75244        	ld	21060,a
 446                     ; 104   UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 448  0035 c65246        	ld	a,21062
 449  0038 a4cf          	and	a,#207
 450  003a c75246        	ld	21062,a
 451                     ; 106   UART2->CR3 |= (uint8_t)StopBits; 
 453  003d c65246        	ld	a,21062
 454  0040 1a16          	or	a,(OFST+8,sp)
 455  0042 c75246        	ld	21062,a
 456                     ; 109   UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 458  0045 c65244        	ld	a,21060
 459  0048 a4f9          	and	a,#249
 460  004a c75244        	ld	21060,a
 461                     ; 111   UART2->CR1 |= (uint8_t)Parity;
 463  004d c65244        	ld	a,21060
 464  0050 1a17          	or	a,(OFST+9,sp)
 465  0052 c75244        	ld	21060,a
 466                     ; 114   UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 468  0055 725f5242      	clr	21058
 469                     ; 116   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 471  0059 c65243        	ld	a,21059
 472  005c a40f          	and	a,#15
 473  005e c75243        	ld	21059,a
 474                     ; 118   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 476  0061 c65243        	ld	a,21059
 477  0064 a4f0          	and	a,#240
 478  0066 c75243        	ld	21059,a
 479                     ; 121   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 481  0069 96            	ldw	x,sp
 482  006a 1c0011        	addw	x,#OFST+3
 483  006d cd0000        	call	c_ltor
 485  0070 a604          	ld	a,#4
 486  0072 cd0000        	call	c_llsh
 488  0075 96            	ldw	x,sp
 489  0076 5c            	incw	x
 490  0077 cd0000        	call	c_rtol
 493  007a cd0000        	call	_CLK_GetClockFreq
 495  007d 96            	ldw	x,sp
 496  007e 5c            	incw	x
 497  007f cd0000        	call	c_ludv
 499  0082 96            	ldw	x,sp
 500  0083 1c000b        	addw	x,#OFST-3
 501  0086 cd0000        	call	c_rtol
 504                     ; 122   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 506  0089 96            	ldw	x,sp
 507  008a 1c0011        	addw	x,#OFST+3
 508  008d cd0000        	call	c_ltor
 510  0090 a604          	ld	a,#4
 511  0092 cd0000        	call	c_llsh
 513  0095 96            	ldw	x,sp
 514  0096 5c            	incw	x
 515  0097 cd0000        	call	c_rtol
 518  009a cd0000        	call	_CLK_GetClockFreq
 520  009d a664          	ld	a,#100
 521  009f cd0000        	call	c_smul
 523  00a2 96            	ldw	x,sp
 524  00a3 5c            	incw	x
 525  00a4 cd0000        	call	c_ludv
 527  00a7 96            	ldw	x,sp
 528  00a8 1c0007        	addw	x,#OFST-7
 529  00ab cd0000        	call	c_rtol
 532                     ; 126   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 532                     ; 127                                 << 4) / 100) & (uint8_t)0x0F); 
 534  00ae 96            	ldw	x,sp
 535  00af 1c000b        	addw	x,#OFST-3
 536  00b2 cd0000        	call	c_ltor
 538  00b5 a664          	ld	a,#100
 539  00b7 cd0000        	call	c_smul
 541  00ba 96            	ldw	x,sp
 542  00bb 5c            	incw	x
 543  00bc cd0000        	call	c_rtol
 546  00bf 96            	ldw	x,sp
 547  00c0 1c0007        	addw	x,#OFST-7
 548  00c3 cd0000        	call	c_ltor
 550  00c6 96            	ldw	x,sp
 551  00c7 5c            	incw	x
 552  00c8 cd0000        	call	c_lsub
 554  00cb a604          	ld	a,#4
 555  00cd cd0000        	call	c_llsh
 557  00d0 ae0000        	ldw	x,#L41
 558  00d3 cd0000        	call	c_ludv
 560  00d6 b603          	ld	a,c_lreg+3
 561  00d8 a40f          	and	a,#15
 562  00da 6b05          	ld	(OFST-9,sp),a
 564                     ; 128   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 566  00dc 96            	ldw	x,sp
 567  00dd 1c000b        	addw	x,#OFST-3
 568  00e0 cd0000        	call	c_ltor
 570  00e3 a604          	ld	a,#4
 571  00e5 cd0000        	call	c_lursh
 573  00e8 b603          	ld	a,c_lreg+3
 574  00ea a4f0          	and	a,#240
 575  00ec b703          	ld	c_lreg+3,a
 576  00ee 3f02          	clr	c_lreg+2
 577  00f0 3f01          	clr	c_lreg+1
 578  00f2 3f00          	clr	c_lreg
 579  00f4 6b06          	ld	(OFST-8,sp),a
 581                     ; 130   UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 583  00f6 1a05          	or	a,(OFST-9,sp)
 584  00f8 c75243        	ld	21059,a
 585                     ; 132   UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 587  00fb 7b0e          	ld	a,(OFST+0,sp)
 588  00fd c75242        	ld	21058,a
 589                     ; 135   UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 591  0100 c65245        	ld	a,21061
 592  0103 a4f3          	and	a,#243
 593  0105 c75245        	ld	21061,a
 594                     ; 137   UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 596  0108 c65246        	ld	a,21062
 597  010b a4f8          	and	a,#248
 598  010d c75246        	ld	21062,a
 599                     ; 139   UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 599                     ; 140     UART2_CR3_CPHA | UART2_CR3_LBCL));
 601  0110 7b18          	ld	a,(OFST+10,sp)
 602  0112 a407          	and	a,#7
 603  0114 ca5246        	or	a,21062
 604  0117 c75246        	ld	21062,a
 605                     ; 142   if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 607  011a 7b19          	ld	a,(OFST+11,sp)
 608  011c a504          	bcp	a,#4
 609  011e 2706          	jreq	L302
 610                     ; 145     UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 612  0120 72165245      	bset	21061,#3
 614  0124 2004          	jra	L502
 615  0126               L302:
 616                     ; 150     UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 618  0126 72175245      	bres	21061,#3
 619  012a               L502:
 620                     ; 152   if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 622  012a a508          	bcp	a,#8
 623  012c 2706          	jreq	L702
 624                     ; 155     UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 626  012e 72145245      	bset	21061,#2
 628  0132 2004          	jra	L112
 629  0134               L702:
 630                     ; 160     UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 632  0134 72155245      	bres	21061,#2
 633  0138               L112:
 634                     ; 164   if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 636  0138 7b18          	ld	a,(OFST+10,sp)
 637  013a 2a06          	jrpl	L312
 638                     ; 167     UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 640  013c 72175246      	bres	21062,#3
 642  0140 2008          	jra	L512
 643  0142               L312:
 644                     ; 171     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 646  0142 a408          	and	a,#8
 647  0144 ca5246        	or	a,21062
 648  0147 c75246        	ld	21062,a
 649  014a               L512:
 650                     ; 173 }
 653  014a 5b0e          	addw	sp,#14
 654  014c 81            	ret	
 709                     ; 181 void UART2_Cmd(FunctionalState NewState)
 709                     ; 182 {
 710                     	switch	.text
 711  014d               _UART2_Cmd:
 715                     ; 183   if (NewState != DISABLE)
 717  014d 4d            	tnz	a
 718  014e 2705          	jreq	L542
 719                     ; 186     UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 721  0150 721b5244      	bres	21060,#5
 724  0154 81            	ret	
 725  0155               L542:
 726                     ; 191     UART2->CR1 |= UART2_CR1_UARTD; 
 728  0155 721a5244      	bset	21060,#5
 729                     ; 193 }
 732  0159 81            	ret	
 864                     ; 210 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 864                     ; 211 {
 865                     	switch	.text
 866  015a               _UART2_ITConfig:
 868  015a 89            	pushw	x
 869  015b 89            	pushw	x
 870       00000002      OFST:	set	2
 873                     ; 212   uint8_t uartreg = 0, itpos = 0x00;
 877                     ; 215   assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 879                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 881                     ; 219   uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 883  015c 9e            	ld	a,xh
 884  015d 6b01          	ld	(OFST-1,sp),a
 886                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 888  015f 9f            	ld	a,xl
 889  0160 a40f          	and	a,#15
 890  0162 5f            	clrw	x
 891  0163 97            	ld	xl,a
 892  0164 a601          	ld	a,#1
 893  0166 5d            	tnzw	x
 894  0167 2704          	jreq	L22
 895  0169               L42:
 896  0169 48            	sll	a
 897  016a 5a            	decw	x
 898  016b 26fc          	jrne	L42
 899  016d               L22:
 900  016d 6b02          	ld	(OFST+0,sp),a
 902                     ; 224   if (NewState != DISABLE)
 904  016f 7b07          	ld	a,(OFST+5,sp)
 905  0171 272a          	jreq	L133
 906                     ; 227     if (uartreg == 0x01)
 908  0173 7b01          	ld	a,(OFST-1,sp)
 909  0175 a101          	cp	a,#1
 910  0177 2607          	jrne	L333
 911                     ; 229       UART2->CR1 |= itpos;
 913  0179 c65244        	ld	a,21060
 914  017c 1a02          	or	a,(OFST+0,sp)
 916  017e 2029          	jp	LC003
 917  0180               L333:
 918                     ; 231     else if (uartreg == 0x02)
 920  0180 a102          	cp	a,#2
 921  0182 2607          	jrne	L733
 922                     ; 233       UART2->CR2 |= itpos;
 924  0184 c65245        	ld	a,21061
 925  0187 1a02          	or	a,(OFST+0,sp)
 927  0189 202d          	jp	LC002
 928  018b               L733:
 929                     ; 235     else if (uartreg == 0x03)
 931  018b a103          	cp	a,#3
 932  018d 2607          	jrne	L343
 933                     ; 237       UART2->CR4 |= itpos;
 935  018f c65247        	ld	a,21063
 936  0192 1a02          	or	a,(OFST+0,sp)
 938  0194 2031          	jp	LC004
 939  0196               L343:
 940                     ; 241       UART2->CR6 |= itpos;
 942  0196 c65249        	ld	a,21065
 943  0199 1a02          	or	a,(OFST+0,sp)
 944  019b 2035          	jp	LC001
 945  019d               L133:
 946                     ; 247     if (uartreg == 0x01)
 948  019d 7b01          	ld	a,(OFST-1,sp)
 949  019f a101          	cp	a,#1
 950  01a1 260b          	jrne	L153
 951                     ; 249       UART2->CR1 &= (uint8_t)(~itpos);
 953  01a3 7b02          	ld	a,(OFST+0,sp)
 954  01a5 43            	cpl	a
 955  01a6 c45244        	and	a,21060
 956  01a9               LC003:
 957  01a9 c75244        	ld	21060,a
 959  01ac 2027          	jra	L743
 960  01ae               L153:
 961                     ; 251     else if (uartreg == 0x02)
 963  01ae a102          	cp	a,#2
 964  01b0 260b          	jrne	L553
 965                     ; 253       UART2->CR2 &= (uint8_t)(~itpos);
 967  01b2 7b02          	ld	a,(OFST+0,sp)
 968  01b4 43            	cpl	a
 969  01b5 c45245        	and	a,21061
 970  01b8               LC002:
 971  01b8 c75245        	ld	21061,a
 973  01bb 2018          	jra	L743
 974  01bd               L553:
 975                     ; 255     else if (uartreg == 0x03)
 977  01bd a103          	cp	a,#3
 978  01bf 260b          	jrne	L163
 979                     ; 257       UART2->CR4 &= (uint8_t)(~itpos);
 981  01c1 7b02          	ld	a,(OFST+0,sp)
 982  01c3 43            	cpl	a
 983  01c4 c45247        	and	a,21063
 984  01c7               LC004:
 985  01c7 c75247        	ld	21063,a
 987  01ca 2009          	jra	L743
 988  01cc               L163:
 989                     ; 261       UART2->CR6 &= (uint8_t)(~itpos);
 991  01cc 7b02          	ld	a,(OFST+0,sp)
 992  01ce 43            	cpl	a
 993  01cf c45249        	and	a,21065
 994  01d2               LC001:
 995  01d2 c75249        	ld	21065,a
 996  01d5               L743:
 997                     ; 264 }
1000  01d5 5b04          	addw	sp,#4
1001  01d7 81            	ret	
1058                     ; 272 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1058                     ; 273 {
1059                     	switch	.text
1060  01d8               _UART2_IrDAConfig:
1064                     ; 274   assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1066                     ; 276   if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1068  01d8 4d            	tnz	a
1069  01d9 2705          	jreq	L314
1070                     ; 278     UART2->CR5 |= UART2_CR5_IRLP;
1072  01db 72145248      	bset	21064,#2
1075  01df 81            	ret	
1076  01e0               L314:
1077                     ; 282     UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1079  01e0 72155248      	bres	21064,#2
1080                     ; 284 }
1083  01e4 81            	ret	
1118                     ; 292 void UART2_IrDACmd(FunctionalState NewState)
1118                     ; 293 {
1119                     	switch	.text
1120  01e5               _UART2_IrDACmd:
1124                     ; 295   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1126                     ; 297   if (NewState != DISABLE)
1128  01e5 4d            	tnz	a
1129  01e6 2705          	jreq	L534
1130                     ; 300     UART2->CR5 |= UART2_CR5_IREN;
1132  01e8 72125248      	bset	21064,#1
1135  01ec 81            	ret	
1136  01ed               L534:
1137                     ; 305     UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1139  01ed 72135248      	bres	21064,#1
1140                     ; 307 }
1143  01f1 81            	ret	
1202                     ; 316 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1202                     ; 317 {
1203                     	switch	.text
1204  01f2               _UART2_LINBreakDetectionConfig:
1208                     ; 319   assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1210                     ; 321   if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1212  01f2 4d            	tnz	a
1213  01f3 2705          	jreq	L764
1214                     ; 323     UART2->CR4 |= UART2_CR4_LBDL;
1216  01f5 721a5247      	bset	21063,#5
1219  01f9 81            	ret	
1220  01fa               L764:
1221                     ; 327     UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1223  01fa 721b5247      	bres	21063,#5
1224                     ; 329 }
1227  01fe 81            	ret	
1348                     ; 341 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1348                     ; 342                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1348                     ; 343                      UART2_LinDivUp_TypeDef UART2_DivUp)
1348                     ; 344 {
1349                     	switch	.text
1350  01ff               _UART2_LINConfig:
1352  01ff 89            	pushw	x
1353       00000000      OFST:	set	0
1356                     ; 346   assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1358                     ; 347   assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1360                     ; 348   assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1362                     ; 350   if (UART2_Mode != UART2_LIN_MODE_MASTER)
1364  0200 9e            	ld	a,xh
1365  0201 4d            	tnz	a
1366  0202 2706          	jreq	L155
1367                     ; 352     UART2->CR6 |=  UART2_CR6_LSLV;
1369  0204 721a5249      	bset	21065,#5
1371  0208 2004          	jra	L355
1372  020a               L155:
1373                     ; 356     UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1375  020a 721b5249      	bres	21065,#5
1376  020e               L355:
1377                     ; 359   if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1379  020e 7b02          	ld	a,(OFST+2,sp)
1380  0210 2706          	jreq	L555
1381                     ; 361     UART2->CR6 |=  UART2_CR6_LASE ;
1383  0212 72185249      	bset	21065,#4
1385  0216 2004          	jra	L755
1386  0218               L555:
1387                     ; 365     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1389  0218 72195249      	bres	21065,#4
1390  021c               L755:
1391                     ; 368   if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1393  021c 7b05          	ld	a,(OFST+5,sp)
1394  021e 2706          	jreq	L165
1395                     ; 370     UART2->CR6 |=  UART2_CR6_LDUM;
1397  0220 721e5249      	bset	21065,#7
1399  0224 2004          	jra	L365
1400  0226               L165:
1401                     ; 374     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1403  0226 721f5249      	bres	21065,#7
1404  022a               L365:
1405                     ; 376 }
1408  022a 85            	popw	x
1409  022b 81            	ret	
1444                     ; 384 void UART2_LINCmd(FunctionalState NewState)
1444                     ; 385 {
1445                     	switch	.text
1446  022c               _UART2_LINCmd:
1450                     ; 386   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1452                     ; 388   if (NewState != DISABLE)
1454  022c 4d            	tnz	a
1455  022d 2705          	jreq	L306
1456                     ; 391     UART2->CR3 |= UART2_CR3_LINEN;
1458  022f 721c5246      	bset	21062,#6
1461  0233 81            	ret	
1462  0234               L306:
1463                     ; 396     UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1465  0234 721d5246      	bres	21062,#6
1466                     ; 398 }
1469  0238 81            	ret	
1504                     ; 406 void UART2_SmartCardCmd(FunctionalState NewState)
1504                     ; 407 {
1505                     	switch	.text
1506  0239               _UART2_SmartCardCmd:
1510                     ; 409   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1512                     ; 411   if (NewState != DISABLE)
1514  0239 4d            	tnz	a
1515  023a 2705          	jreq	L526
1516                     ; 414     UART2->CR5 |= UART2_CR5_SCEN;
1518  023c 721a5248      	bset	21064,#5
1521  0240 81            	ret	
1522  0241               L526:
1523                     ; 419     UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1525  0241 721b5248      	bres	21064,#5
1526                     ; 421 }
1529  0245 81            	ret	
1565                     ; 429 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1565                     ; 430 {
1566                     	switch	.text
1567  0246               _UART2_SmartCardNACKCmd:
1571                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1573                     ; 434   if (NewState != DISABLE)
1575  0246 4d            	tnz	a
1576  0247 2705          	jreq	L746
1577                     ; 437     UART2->CR5 |= UART2_CR5_NACK;
1579  0249 72185248      	bset	21064,#4
1582  024d 81            	ret	
1583  024e               L746:
1584                     ; 442     UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1586  024e 72195248      	bres	21064,#4
1587                     ; 444 }
1590  0252 81            	ret	
1647                     ; 452 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1647                     ; 453 {
1648                     	switch	.text
1649  0253               _UART2_WakeUpConfig:
1653                     ; 454   assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1655                     ; 456   UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1657  0253 72175244      	bres	21060,#3
1658                     ; 457   UART2->CR1 |= (uint8_t)UART2_WakeUp;
1660  0257 ca5244        	or	a,21060
1661  025a c75244        	ld	21060,a
1662                     ; 458 }
1665  025d 81            	ret	
1701                     ; 466 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1701                     ; 467 {
1702                     	switch	.text
1703  025e               _UART2_ReceiverWakeUpCmd:
1707                     ; 468   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1709                     ; 470   if (NewState != DISABLE)
1711  025e 4d            	tnz	a
1712  025f 2705          	jreq	L717
1713                     ; 473     UART2->CR2 |= UART2_CR2_RWU;
1715  0261 72125245      	bset	21061,#1
1718  0265 81            	ret	
1719  0266               L717:
1720                     ; 478     UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
1722  0266 72135245      	bres	21061,#1
1723                     ; 480 }
1726  026a 81            	ret	
1749                     ; 487 uint8_t UART2_ReceiveData8(void)
1749                     ; 488 {
1750                     	switch	.text
1751  026b               _UART2_ReceiveData8:
1755                     ; 489   return ((uint8_t)UART2->DR);
1757  026b c65241        	ld	a,21057
1760  026e 81            	ret	
1794                     ; 497 uint16_t UART2_ReceiveData9(void)
1794                     ; 498 {
1795                     	switch	.text
1796  026f               _UART2_ReceiveData9:
1798  026f 89            	pushw	x
1799       00000002      OFST:	set	2
1802                     ; 499   uint16_t temp = 0;
1804                     ; 501   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
1806  0270 c65244        	ld	a,21060
1807  0273 a480          	and	a,#128
1808  0275 5f            	clrw	x
1809  0276 02            	rlwa	x,a
1810  0277 58            	sllw	x
1811  0278 1f01          	ldw	(OFST-1,sp),x
1813                     ; 503   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
1815  027a c65241        	ld	a,21057
1816  027d 5f            	clrw	x
1817  027e 97            	ld	xl,a
1818  027f 01            	rrwa	x,a
1819  0280 1a02          	or	a,(OFST+0,sp)
1820  0282 01            	rrwa	x,a
1821  0283 1a01          	or	a,(OFST-1,sp)
1822  0285 a401          	and	a,#1
1823  0287 01            	rrwa	x,a
1826  0288 5b02          	addw	sp,#2
1827  028a 81            	ret	
1861                     ; 511 void UART2_SendData8(uint8_t Data)
1861                     ; 512 {
1862                     	switch	.text
1863  028b               _UART2_SendData8:
1867                     ; 514   UART2->DR = Data;
1869  028b c75241        	ld	21057,a
1870                     ; 515 }
1873  028e 81            	ret	
1907                     ; 522 void UART2_SendData9(uint16_t Data)
1907                     ; 523 {
1908                     	switch	.text
1909  028f               _UART2_SendData9:
1911  028f 89            	pushw	x
1912       00000000      OFST:	set	0
1915                     ; 525   UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
1917  0290 721d5244      	bres	21060,#6
1918                     ; 528   UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
1920  0294 54            	srlw	x
1921  0295 54            	srlw	x
1922  0296 9f            	ld	a,xl
1923  0297 a440          	and	a,#64
1924  0299 ca5244        	or	a,21060
1925  029c c75244        	ld	21060,a
1926                     ; 531   UART2->DR   = (uint8_t)(Data);                    
1928  029f 7b02          	ld	a,(OFST+2,sp)
1929  02a1 c75241        	ld	21057,a
1930                     ; 532 }
1933  02a4 85            	popw	x
1934  02a5 81            	ret	
1957                     ; 539 void UART2_SendBreak(void)
1957                     ; 540 {
1958                     	switch	.text
1959  02a6               _UART2_SendBreak:
1963                     ; 541   UART2->CR2 |= UART2_CR2_SBK;
1965  02a6 72105245      	bset	21061,#0
1966                     ; 542 }
1969  02aa 81            	ret	
2003                     ; 549 void UART2_SetAddress(uint8_t UART2_Address)
2003                     ; 550 {
2004                     	switch	.text
2005  02ab               _UART2_SetAddress:
2007  02ab 88            	push	a
2008       00000000      OFST:	set	0
2011                     ; 552   assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2013                     ; 555   UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2015  02ac c65247        	ld	a,21063
2016  02af a4f0          	and	a,#240
2017  02b1 c75247        	ld	21063,a
2018                     ; 557   UART2->CR4 |= UART2_Address;
2020  02b4 c65247        	ld	a,21063
2021  02b7 1a01          	or	a,(OFST+1,sp)
2022  02b9 c75247        	ld	21063,a
2023                     ; 558 }
2026  02bc 84            	pop	a
2027  02bd 81            	ret	
2061                     ; 566 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2061                     ; 567 {
2062                     	switch	.text
2063  02be               _UART2_SetGuardTime:
2067                     ; 569   UART2->GTR = UART2_GuardTime;
2069  02be c7524a        	ld	21066,a
2070                     ; 570 }
2073  02c1 81            	ret	
2107                     ; 594 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2107                     ; 595 {
2108                     	switch	.text
2109  02c2               _UART2_SetPrescaler:
2113                     ; 597   UART2->PSCR = UART2_Prescaler;
2115  02c2 c7524b        	ld	21067,a
2116                     ; 598 }
2119  02c5 81            	ret	
2276                     ; 606 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2276                     ; 607 {
2277                     	switch	.text
2278  02c6               _UART2_GetFlagStatus:
2280  02c6 89            	pushw	x
2281  02c7 88            	push	a
2282       00000001      OFST:	set	1
2285                     ; 608   FlagStatus status = RESET;
2287                     ; 611   assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2289                     ; 614   if (UART2_FLAG == UART2_FLAG_LBDF)
2291  02c8 a30210        	cpw	x,#528
2292  02cb 2608          	jrne	L5511
2293                     ; 616     if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2295  02cd 9f            	ld	a,xl
2296  02ce c45247        	and	a,21063
2297  02d1 2726          	jreq	L3611
2298                     ; 619       status = SET;
2300  02d3 201f          	jp	LC007
2301                     ; 624       status = RESET;
2302  02d5               L5511:
2303                     ; 627   else if (UART2_FLAG == UART2_FLAG_SBK)
2305  02d5 a30101        	cpw	x,#257
2306  02d8 2609          	jrne	L5611
2307                     ; 629     if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2309  02da c65245        	ld	a,21061
2310  02dd 1503          	bcp	a,(OFST+2,sp)
2311  02df 2717          	jreq	L1021
2312                     ; 632       status = SET;
2314  02e1 2011          	jp	LC007
2315                     ; 637       status = RESET;
2316  02e3               L5611:
2317                     ; 640   else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2319  02e3 a30302        	cpw	x,#770
2320  02e6 2705          	jreq	L7711
2322  02e8 a30301        	cpw	x,#769
2323  02eb 260f          	jrne	L5711
2324  02ed               L7711:
2325                     ; 642     if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2327  02ed c65249        	ld	a,21065
2328  02f0 1503          	bcp	a,(OFST+2,sp)
2329  02f2 2704          	jreq	L1021
2330                     ; 645       status = SET;
2332  02f4               LC007:
2336  02f4 a601          	ld	a,#1
2340  02f6 2001          	jra	L3611
2341  02f8               L1021:
2342                     ; 650       status = RESET;
2346  02f8 4f            	clr	a
2348  02f9               L3611:
2349                     ; 668   return  status;
2353  02f9 5b03          	addw	sp,#3
2354  02fb 81            	ret	
2355  02fc               L5711:
2356                     ; 655     if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2358  02fc c65240        	ld	a,21056
2359  02ff 1503          	bcp	a,(OFST+2,sp)
2360  0301 27f5          	jreq	L1021
2361                     ; 658       status = SET;
2363  0303 20ef          	jp	LC007
2364                     ; 663       status = RESET;
2399                     ; 699 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2399                     ; 700 {
2400                     	switch	.text
2401  0305               _UART2_ClearFlag:
2403       00000000      OFST:	set	0
2406                     ; 701   assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2408                     ; 704   if (UART2_FLAG == UART2_FLAG_RXNE)
2410  0305 a30020        	cpw	x,#32
2411  0308 2605          	jrne	L1321
2412                     ; 706     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2414  030a 35df5240      	mov	21056,#223
2417  030e 81            	ret	
2418  030f               L1321:
2419                     ; 709   else if (UART2_FLAG == UART2_FLAG_LBDF)
2421  030f a30210        	cpw	x,#528
2422  0312 2605          	jrne	L5321
2423                     ; 711     UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2425  0314 72195247      	bres	21063,#4
2428  0318 81            	ret	
2429  0319               L5321:
2430                     ; 714   else if (UART2_FLAG == UART2_FLAG_LHDF)
2432  0319 a30302        	cpw	x,#770
2433  031c 2605          	jrne	L1421
2434                     ; 716     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2436  031e 72135249      	bres	21065,#1
2439  0322 81            	ret	
2440  0323               L1421:
2441                     ; 721     UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2443  0323 72115249      	bres	21065,#0
2444                     ; 723 }
2447  0327 81            	ret	
2529                     ; 738 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2529                     ; 739 {
2530                     	switch	.text
2531  0328               _UART2_GetITStatus:
2533  0328 89            	pushw	x
2534  0329 89            	pushw	x
2535       00000002      OFST:	set	2
2538                     ; 740   ITStatus pendingbitstatus = RESET;
2540                     ; 741   uint8_t itpos = 0;
2542                     ; 742   uint8_t itmask1 = 0;
2544                     ; 743   uint8_t itmask2 = 0;
2546                     ; 744   uint8_t enablestatus = 0;
2548                     ; 747   assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2550                     ; 750   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2552  032a 9f            	ld	a,xl
2553  032b a40f          	and	a,#15
2554  032d 5f            	clrw	x
2555  032e 97            	ld	xl,a
2556  032f a601          	ld	a,#1
2557  0331 5d            	tnzw	x
2558  0332 2704          	jreq	L67
2559  0334               L001:
2560  0334 48            	sll	a
2561  0335 5a            	decw	x
2562  0336 26fc          	jrne	L001
2563  0338               L67:
2564  0338 6b01          	ld	(OFST-1,sp),a
2566                     ; 752   itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2568  033a 7b04          	ld	a,(OFST+2,sp)
2569  033c 4e            	swap	a
2570  033d a40f          	and	a,#15
2571  033f 6b02          	ld	(OFST+0,sp),a
2573                     ; 754   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2575  0341 5f            	clrw	x
2576  0342 97            	ld	xl,a
2577  0343 a601          	ld	a,#1
2578  0345 5d            	tnzw	x
2579  0346 2704          	jreq	L201
2580  0348               L401:
2581  0348 48            	sll	a
2582  0349 5a            	decw	x
2583  034a 26fc          	jrne	L401
2584  034c               L201:
2585  034c 6b02          	ld	(OFST+0,sp),a
2587                     ; 757   if (UART2_IT == UART2_IT_PE)
2589  034e 1e03          	ldw	x,(OFST+1,sp)
2590  0350 a30100        	cpw	x,#256
2591  0353 260c          	jrne	L7031
2592                     ; 760     enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2594  0355 c65244        	ld	a,21060
2595  0358 1402          	and	a,(OFST+0,sp)
2596  035a 6b02          	ld	(OFST+0,sp),a
2598                     ; 763     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2600  035c c65240        	ld	a,21056
2602                     ; 766       pendingbitstatus = SET;
2604  035f 2020          	jp	LC010
2605                     ; 771       pendingbitstatus = RESET;
2606  0361               L7031:
2607                     ; 774   else if (UART2_IT == UART2_IT_LBDF)
2609  0361 a30346        	cpw	x,#838
2610  0364 260c          	jrne	L7131
2611                     ; 777     enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2613  0366 c65247        	ld	a,21063
2614  0369 1402          	and	a,(OFST+0,sp)
2615  036b 6b02          	ld	(OFST+0,sp),a
2617                     ; 779     if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2619  036d c65247        	ld	a,21063
2621                     ; 782       pendingbitstatus = SET;
2623  0370 200f          	jp	LC010
2624                     ; 787       pendingbitstatus = RESET;
2625  0372               L7131:
2626                     ; 790   else if (UART2_IT == UART2_IT_LHDF)
2628  0372 a30412        	cpw	x,#1042
2629  0375 2616          	jrne	L7231
2630                     ; 793     enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
2632  0377 c65249        	ld	a,21065
2633  037a 1402          	and	a,(OFST+0,sp)
2634  037c 6b02          	ld	(OFST+0,sp),a
2636                     ; 795     if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2638  037e c65249        	ld	a,21065
2640  0381               LC010:
2641  0381 1501          	bcp	a,(OFST-1,sp)
2642  0383 271a          	jreq	L7331
2643  0385 7b02          	ld	a,(OFST+0,sp)
2644  0387 2716          	jreq	L7331
2645                     ; 798       pendingbitstatus = SET;
2647  0389               LC009:
2651  0389 a601          	ld	a,#1
2654  038b 2013          	jra	L5131
2655                     ; 803       pendingbitstatus = RESET;
2656  038d               L7231:
2657                     ; 809     enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
2659  038d c65245        	ld	a,21061
2660  0390 1402          	and	a,(OFST+0,sp)
2661  0392 6b02          	ld	(OFST+0,sp),a
2663                     ; 811     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2665  0394 c65240        	ld	a,21056
2666  0397 1501          	bcp	a,(OFST-1,sp)
2667  0399 2704          	jreq	L7331
2669  039b 7b02          	ld	a,(OFST+0,sp)
2670                     ; 814       pendingbitstatus = SET;
2672  039d 26ea          	jrne	LC009
2673  039f               L7331:
2674                     ; 819       pendingbitstatus = RESET;
2679  039f 4f            	clr	a
2681  03a0               L5131:
2682                     ; 823   return  pendingbitstatus;
2686  03a0 5b04          	addw	sp,#4
2687  03a2 81            	ret	
2723                     ; 852 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2723                     ; 853 {
2724                     	switch	.text
2725  03a3               _UART2_ClearITPendingBit:
2727       00000000      OFST:	set	0
2730                     ; 854   assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2732                     ; 857   if (UART2_IT == UART2_IT_RXNE)
2734  03a3 a30255        	cpw	x,#597
2735  03a6 2605          	jrne	L1631
2736                     ; 859     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2738  03a8 35df5240      	mov	21056,#223
2741  03ac 81            	ret	
2742  03ad               L1631:
2743                     ; 862   else if (UART2_IT == UART2_IT_LBDF)
2745  03ad a30346        	cpw	x,#838
2746  03b0 2605          	jrne	L5631
2747                     ; 864     UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
2749  03b2 72195247      	bres	21063,#4
2752  03b6 81            	ret	
2753  03b7               L5631:
2754                     ; 869     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2756  03b7 72135249      	bres	21065,#1
2757                     ; 871 }
2760  03bb 81            	ret	
2773                     	xdef	_UART2_ClearITPendingBit
2774                     	xdef	_UART2_GetITStatus
2775                     	xdef	_UART2_ClearFlag
2776                     	xdef	_UART2_GetFlagStatus
2777                     	xdef	_UART2_SetPrescaler
2778                     	xdef	_UART2_SetGuardTime
2779                     	xdef	_UART2_SetAddress
2780                     	xdef	_UART2_SendBreak
2781                     	xdef	_UART2_SendData9
2782                     	xdef	_UART2_SendData8
2783                     	xdef	_UART2_ReceiveData9
2784                     	xdef	_UART2_ReceiveData8
2785                     	xdef	_UART2_ReceiverWakeUpCmd
2786                     	xdef	_UART2_WakeUpConfig
2787                     	xdef	_UART2_SmartCardNACKCmd
2788                     	xdef	_UART2_SmartCardCmd
2789                     	xdef	_UART2_LINCmd
2790                     	xdef	_UART2_LINConfig
2791                     	xdef	_UART2_LINBreakDetectionConfig
2792                     	xdef	_UART2_IrDACmd
2793                     	xdef	_UART2_IrDAConfig
2794                     	xdef	_UART2_ITConfig
2795                     	xdef	_UART2_Cmd
2796                     	xdef	_UART2_Init
2797                     	xdef	_UART2_DeInit
2798                     	xref	_CLK_GetClockFreq
2799                     	xref.b	c_lreg
2800                     	xref.b	c_x
2819                     	xref	c_lursh
2820                     	xref	c_lsub
2821                     	xref	c_smul
2822                     	xref	c_ludv
2823                     	xref	c_rtol
2824                     	xref	c_llsh
2825                     	xref	c_ltor
2826                     	end
