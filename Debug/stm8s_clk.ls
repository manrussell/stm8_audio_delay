   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  18                     .const:	section	.text
  19  0000               _HSIDivFactor:
  20  0000 01            	dc.b	1
  21  0001 02            	dc.b	2
  22  0002 04            	dc.b	4
  23  0003 08            	dc.b	8
  24  0004               _CLKPrescTable:
  25  0004 01            	dc.b	1
  26  0005 02            	dc.b	2
  27  0006 04            	dc.b	4
  28  0007 08            	dc.b	8
  29  0008 0a            	dc.b	10
  30  0009 10            	dc.b	16
  31  000a 14            	dc.b	20
  32  000b 28            	dc.b	40
  61                     ; 72 void CLK_DeInit(void)
  61                     ; 73 {
  63                     	switch	.text
  64  0000               _CLK_DeInit:
  68                     ; 74   CLK->ICKR = CLK_ICKR_RESET_VALUE;
  70  0000 350150c0      	mov	20672,#1
  71                     ; 75   CLK->ECKR = CLK_ECKR_RESET_VALUE;
  73  0004 725f50c1      	clr	20673
  74                     ; 76   CLK->SWR  = CLK_SWR_RESET_VALUE;
  76  0008 35e150c4      	mov	20676,#225
  77                     ; 77   CLK->SWCR = CLK_SWCR_RESET_VALUE;
  79  000c 725f50c5      	clr	20677
  80                     ; 78   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  82  0010 351850c6      	mov	20678,#24
  83                     ; 79   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  85  0014 35ff50c7      	mov	20679,#255
  86                     ; 80   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  88  0018 35ff50ca      	mov	20682,#255
  89                     ; 81   CLK->CSSR = CLK_CSSR_RESET_VALUE;
  91  001c 725f50c8      	clr	20680
  92                     ; 82   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  94  0020 725f50c9      	clr	20681
  96  0024               L52:
  97                     ; 83   while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  99  0024 720050c9fb    	btjt	20681,#0,L52
 100                     ; 85   CLK->CCOR = CLK_CCOR_RESET_VALUE;
 102  0029 725f50c9      	clr	20681
 103                     ; 86   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 105  002d 725f50cc      	clr	20684
 106                     ; 87   CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 108  0031 725f50cd      	clr	20685
 109                     ; 88 }
 112  0035 81            	ret	
 168                     ; 99 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 168                     ; 100 {
 169                     	switch	.text
 170  0036               _CLK_FastHaltWakeUpCmd:
 174                     ; 102   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 176                     ; 104   if (NewState != DISABLE)
 178  0036 4d            	tnz	a
 179  0037 2705          	jreq	L75
 180                     ; 107     CLK->ICKR |= CLK_ICKR_FHWU;
 182  0039 721450c0      	bset	20672,#2
 185  003d 81            	ret	
 186  003e               L75:
 187                     ; 112     CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 189  003e 721550c0      	bres	20672,#2
 190                     ; 114 }
 193  0042 81            	ret	
 228                     ; 121 void CLK_HSECmd(FunctionalState NewState)
 228                     ; 122 {
 229                     	switch	.text
 230  0043               _CLK_HSECmd:
 234                     ; 124   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 236                     ; 126   if (NewState != DISABLE)
 238  0043 4d            	tnz	a
 239  0044 2705          	jreq	L101
 240                     ; 129     CLK->ECKR |= CLK_ECKR_HSEEN;
 242  0046 721050c1      	bset	20673,#0
 245  004a 81            	ret	
 246  004b               L101:
 247                     ; 134     CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 249  004b 721150c1      	bres	20673,#0
 250                     ; 136 }
 253  004f 81            	ret	
 288                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 288                     ; 144 {
 289                     	switch	.text
 290  0050               _CLK_HSICmd:
 294                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 296                     ; 148   if (NewState != DISABLE)
 298  0050 4d            	tnz	a
 299  0051 2705          	jreq	L321
 300                     ; 151     CLK->ICKR |= CLK_ICKR_HSIEN;
 302  0053 721050c0      	bset	20672,#0
 305  0057 81            	ret	
 306  0058               L321:
 307                     ; 156     CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 309  0058 721150c0      	bres	20672,#0
 310                     ; 158 }
 313  005c 81            	ret	
 348                     ; 166 void CLK_LSICmd(FunctionalState NewState)
 348                     ; 167 {
 349                     	switch	.text
 350  005d               _CLK_LSICmd:
 354                     ; 169   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 356                     ; 171   if (NewState != DISABLE)
 358  005d 4d            	tnz	a
 359  005e 2705          	jreq	L541
 360                     ; 174     CLK->ICKR |= CLK_ICKR_LSIEN;
 362  0060 721650c0      	bset	20672,#3
 365  0064 81            	ret	
 366  0065               L541:
 367                     ; 179     CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 369  0065 721750c0      	bres	20672,#3
 370                     ; 181 }
 373  0069 81            	ret	
 408                     ; 189 void CLK_CCOCmd(FunctionalState NewState)
 408                     ; 190 {
 409                     	switch	.text
 410  006a               _CLK_CCOCmd:
 414                     ; 192   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 416                     ; 194   if (NewState != DISABLE)
 418  006a 4d            	tnz	a
 419  006b 2705          	jreq	L761
 420                     ; 197     CLK->CCOR |= CLK_CCOR_CCOEN;
 422  006d 721050c9      	bset	20681,#0
 425  0071 81            	ret	
 426  0072               L761:
 427                     ; 202     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 429  0072 721150c9      	bres	20681,#0
 430                     ; 204 }
 433  0076 81            	ret	
 468                     ; 213 void CLK_ClockSwitchCmd(FunctionalState NewState)
 468                     ; 214 {
 469                     	switch	.text
 470  0077               _CLK_ClockSwitchCmd:
 474                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 476                     ; 218   if (NewState != DISABLE )
 478  0077 4d            	tnz	a
 479  0078 2705          	jreq	L112
 480                     ; 221     CLK->SWCR |= CLK_SWCR_SWEN;
 482  007a 721250c5      	bset	20677,#1
 485  007e 81            	ret	
 486  007f               L112:
 487                     ; 226     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 489  007f 721350c5      	bres	20677,#1
 490                     ; 228 }
 493  0083 81            	ret	
 529                     ; 238 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 529                     ; 239 {
 530                     	switch	.text
 531  0084               _CLK_SlowActiveHaltWakeUpCmd:
 535                     ; 241   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 537                     ; 243   if (NewState != DISABLE)
 539  0084 4d            	tnz	a
 540  0085 2705          	jreq	L332
 541                     ; 246     CLK->ICKR |= CLK_ICKR_SWUAH;
 543  0087 721a50c0      	bset	20672,#5
 546  008b 81            	ret	
 547  008c               L332:
 548                     ; 251     CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 550  008c 721b50c0      	bres	20672,#5
 551                     ; 253 }
 554  0090 81            	ret	
 713                     ; 263 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 713                     ; 264 {
 714                     	switch	.text
 715  0091               _CLK_PeripheralClockConfig:
 717  0091 89            	pushw	x
 718       00000000      OFST:	set	0
 721                     ; 266   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 723                     ; 267   assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 725                     ; 269   if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 727  0092 9e            	ld	a,xh
 728  0093 a510          	bcp	a,#16
 729  0095 2630          	jrne	L123
 730                     ; 271     if (NewState != DISABLE)
 732  0097 7b02          	ld	a,(OFST+2,sp)
 733  0099 2714          	jreq	L323
 734                     ; 274       CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 736  009b 7b01          	ld	a,(OFST+1,sp)
 737  009d a40f          	and	a,#15
 738  009f 5f            	clrw	x
 739  00a0 97            	ld	xl,a
 740  00a1 a601          	ld	a,#1
 741  00a3 5d            	tnzw	x
 742  00a4 2704          	jreq	L62
 743  00a6               L03:
 744  00a6 48            	sll	a
 745  00a7 5a            	decw	x
 746  00a8 26fc          	jrne	L03
 747  00aa               L62:
 748  00aa ca50c7        	or	a,20679
 750  00ad 2013          	jp	LC002
 751  00af               L323:
 752                     ; 279       CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 754  00af 7b01          	ld	a,(OFST+1,sp)
 755  00b1 a40f          	and	a,#15
 756  00b3 5f            	clrw	x
 757  00b4 97            	ld	xl,a
 758  00b5 a601          	ld	a,#1
 759  00b7 5d            	tnzw	x
 760  00b8 2704          	jreq	L23
 761  00ba               L43:
 762  00ba 48            	sll	a
 763  00bb 5a            	decw	x
 764  00bc 26fc          	jrne	L43
 765  00be               L23:
 766  00be 43            	cpl	a
 767  00bf c450c7        	and	a,20679
 768  00c2               LC002:
 769  00c2 c750c7        	ld	20679,a
 770  00c5 202e          	jra	L723
 771  00c7               L123:
 772                     ; 284     if (NewState != DISABLE)
 774  00c7 7b02          	ld	a,(OFST+2,sp)
 775  00c9 2714          	jreq	L133
 776                     ; 287       CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 778  00cb 7b01          	ld	a,(OFST+1,sp)
 779  00cd a40f          	and	a,#15
 780  00cf 5f            	clrw	x
 781  00d0 97            	ld	xl,a
 782  00d1 a601          	ld	a,#1
 783  00d3 5d            	tnzw	x
 784  00d4 2704          	jreq	L63
 785  00d6               L04:
 786  00d6 48            	sll	a
 787  00d7 5a            	decw	x
 788  00d8 26fc          	jrne	L04
 789  00da               L63:
 790  00da ca50ca        	or	a,20682
 792  00dd 2013          	jp	LC001
 793  00df               L133:
 794                     ; 292       CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 796  00df 7b01          	ld	a,(OFST+1,sp)
 797  00e1 a40f          	and	a,#15
 798  00e3 5f            	clrw	x
 799  00e4 97            	ld	xl,a
 800  00e5 a601          	ld	a,#1
 801  00e7 5d            	tnzw	x
 802  00e8 2704          	jreq	L24
 803  00ea               L44:
 804  00ea 48            	sll	a
 805  00eb 5a            	decw	x
 806  00ec 26fc          	jrne	L44
 807  00ee               L24:
 808  00ee 43            	cpl	a
 809  00ef c450ca        	and	a,20682
 810  00f2               LC001:
 811  00f2 c750ca        	ld	20682,a
 812  00f5               L723:
 813                     ; 295 }
 816  00f5 85            	popw	x
 817  00f6 81            	ret	
1005                     ; 309 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1005                     ; 310 {
1006                     	switch	.text
1007  00f7               _CLK_ClockSwitchConfig:
1009  00f7 89            	pushw	x
1010  00f8 5204          	subw	sp,#4
1011       00000004      OFST:	set	4
1014                     ; 312   uint16_t DownCounter = CLK_TIMEOUT;
1016  00fa aeffff        	ldw	x,#65535
1017  00fd 1f03          	ldw	(OFST-1,sp),x
1019                     ; 313   ErrorStatus Swif = ERROR;
1021                     ; 316   assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1023                     ; 317   assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1025                     ; 318   assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1027                     ; 319   assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1029                     ; 322   clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1031  00ff c650c3        	ld	a,20675
1032  0102 6b01          	ld	(OFST-3,sp),a
1034                     ; 325   if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1036  0104 7b05          	ld	a,(OFST+1,sp)
1037  0106 4a            	dec	a
1038  0107 263d          	jrne	L544
1039                     ; 328     CLK->SWCR |= CLK_SWCR_SWEN;
1041  0109 721250c5      	bset	20677,#1
1042                     ; 331     if (ITState != DISABLE)
1044  010d 7b09          	ld	a,(OFST+5,sp)
1045  010f 2706          	jreq	L744
1046                     ; 333       CLK->SWCR |= CLK_SWCR_SWIEN;
1048  0111 721450c5      	bset	20677,#2
1050  0115 2004          	jra	L154
1051  0117               L744:
1052                     ; 337       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1054  0117 721550c5      	bres	20677,#2
1055  011b               L154:
1056                     ; 341     CLK->SWR = (uint8_t)CLK_NewClock;
1058  011b 7b06          	ld	a,(OFST+2,sp)
1059  011d c750c4        	ld	20676,a
1061  0120 2003          	jra	L754
1062  0122               L354:
1063                     ; 346       DownCounter--;
1065  0122 5a            	decw	x
1066  0123 1f03          	ldw	(OFST-1,sp),x
1068  0125               L754:
1069                     ; 344     while((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1071  0125 720150c504    	btjf	20677,#0,L364
1073  012a 1e03          	ldw	x,(OFST-1,sp)
1074  012c 26f4          	jrne	L354
1075  012e               L364:
1076                     ; 349     if(DownCounter != 0)
1078  012e 1e03          	ldw	x,(OFST-1,sp)
1079                     ; 351       Swif = SUCCESS;
1081  0130 263d          	jrne	LC004
1082  0132               L564:
1083                     ; 355       Swif = ERROR;
1086  0132 0f02          	clr	(OFST-2,sp)
1088  0134               L174:
1089                     ; 390   if(Swif != ERROR)
1091  0134 275d          	jreq	L515
1092                     ; 393     if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1094  0136 7b0a          	ld	a,(OFST+6,sp)
1095  0138 263b          	jrne	L715
1097  013a 7b01          	ld	a,(OFST-3,sp)
1098  013c a1e1          	cp	a,#225
1099  013e 2635          	jrne	L715
1100                     ; 395       CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1102  0140 721150c0      	bres	20672,#0
1104  0144 204d          	jra	L515
1105  0146               L544:
1106                     ; 361     if (ITState != DISABLE)
1108  0146 7b09          	ld	a,(OFST+5,sp)
1109  0148 2706          	jreq	L374
1110                     ; 363       CLK->SWCR |= CLK_SWCR_SWIEN;
1112  014a 721450c5      	bset	20677,#2
1114  014e 2004          	jra	L574
1115  0150               L374:
1116                     ; 367       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1118  0150 721550c5      	bres	20677,#2
1119  0154               L574:
1120                     ; 371     CLK->SWR = (uint8_t)CLK_NewClock;
1122  0154 7b06          	ld	a,(OFST+2,sp)
1123  0156 c750c4        	ld	20676,a
1125  0159 2003          	jra	L305
1126  015b               L774:
1127                     ; 376       DownCounter--;
1129  015b 5a            	decw	x
1130  015c 1f03          	ldw	(OFST-1,sp),x
1132  015e               L305:
1133                     ; 374     while((((CLK->SWCR & CLK_SWCR_SWIF) != 0 ) && (DownCounter != 0)))
1135  015e 720750c504    	btjf	20677,#3,L705
1137  0163 1e03          	ldw	x,(OFST-1,sp)
1138  0165 26f4          	jrne	L774
1139  0167               L705:
1140                     ; 379     if(DownCounter != 0)
1142  0167 1e03          	ldw	x,(OFST-1,sp)
1143  0169 27c7          	jreq	L564
1144                     ; 382       CLK->SWCR |= CLK_SWCR_SWEN;
1146  016b 721250c5      	bset	20677,#1
1147                     ; 383       Swif = SUCCESS;
1149  016f               LC004:
1151  016f a601          	ld	a,#1
1152  0171 6b02          	ld	(OFST-2,sp),a
1155  0173 20bf          	jra	L174
1156                     ; 387       Swif = ERROR;
1157  0175               L715:
1158                     ; 397     else if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1160  0175 7b0a          	ld	a,(OFST+6,sp)
1161  0177 260c          	jrne	L325
1163  0179 7b01          	ld	a,(OFST-3,sp)
1164  017b a1d2          	cp	a,#210
1165  017d 2606          	jrne	L325
1166                     ; 399       CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1168  017f 721750c0      	bres	20672,#3
1170  0183 200e          	jra	L515
1171  0185               L325:
1172                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1174  0185 7b0a          	ld	a,(OFST+6,sp)
1175  0187 260a          	jrne	L515
1177  0189 7b01          	ld	a,(OFST-3,sp)
1178  018b a1b4          	cp	a,#180
1179  018d 2604          	jrne	L515
1180                     ; 403       CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1182  018f 721150c1      	bres	20673,#0
1183  0193               L515:
1184                     ; 406   return(Swif);
1186  0193 7b02          	ld	a,(OFST-2,sp)
1189  0195 5b06          	addw	sp,#6
1190  0197 81            	ret	
1328                     ; 415 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1328                     ; 416 {
1329                     	switch	.text
1330  0198               _CLK_HSIPrescalerConfig:
1332  0198 88            	push	a
1333       00000000      OFST:	set	0
1336                     ; 418   assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1338                     ; 421   CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1340  0199 c650c6        	ld	a,20678
1341  019c a4e7          	and	a,#231
1342  019e c750c6        	ld	20678,a
1343                     ; 424   CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1345  01a1 c650c6        	ld	a,20678
1346  01a4 1a01          	or	a,(OFST+1,sp)
1347  01a6 c750c6        	ld	20678,a
1348                     ; 425 }
1351  01a9 84            	pop	a
1352  01aa 81            	ret	
1487                     ; 436 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1487                     ; 437 {
1488                     	switch	.text
1489  01ab               _CLK_CCOConfig:
1491  01ab 88            	push	a
1492       00000000      OFST:	set	0
1495                     ; 439   assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1497                     ; 442   CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1499  01ac c650c9        	ld	a,20681
1500  01af a4e1          	and	a,#225
1501  01b1 c750c9        	ld	20681,a
1502                     ; 445   CLK->CCOR |= (uint8_t)CLK_CCO;
1504  01b4 c650c9        	ld	a,20681
1505  01b7 1a01          	or	a,(OFST+1,sp)
1506  01b9 c750c9        	ld	20681,a
1507                     ; 448   CLK->CCOR |= CLK_CCOR_CCOEN;
1509  01bc 721050c9      	bset	20681,#0
1510                     ; 449 }
1513  01c0 84            	pop	a
1514  01c1 81            	ret	
1579                     ; 459 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1579                     ; 460 {
1580                     	switch	.text
1581  01c2               _CLK_ITConfig:
1583  01c2 89            	pushw	x
1584       00000000      OFST:	set	0
1587                     ; 462   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1589                     ; 463   assert_param(IS_CLK_IT_OK(CLK_IT));
1591                     ; 465   if (NewState != DISABLE)
1593  01c3 9f            	ld	a,xl
1594  01c4 4d            	tnz	a
1595  01c5 2715          	jreq	L527
1596                     ; 467     switch (CLK_IT)
1598  01c7 9e            	ld	a,xh
1600                     ; 475     default:
1600                     ; 476       break;
1601  01c8 a00c          	sub	a,#12
1602  01ca 270a          	jreq	L166
1603  01cc a010          	sub	a,#16
1604  01ce 2620          	jrne	L337
1605                     ; 469     case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1605                     ; 470       CLK->SWCR |= CLK_SWCR_SWIEN;
1607  01d0 721450c5      	bset	20677,#2
1608                     ; 471       break;
1610  01d4 201a          	jra	L337
1611  01d6               L166:
1612                     ; 472     case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1612                     ; 473       CLK->CSSR |= CLK_CSSR_CSSDIE;
1614  01d6 721450c8      	bset	20680,#2
1615                     ; 474       break;
1617  01da 2014          	jra	L337
1618                     ; 475     default:
1618                     ; 476       break;
1621  01dc               L527:
1622                     ; 481     switch (CLK_IT)
1624  01dc 7b01          	ld	a,(OFST+1,sp)
1626                     ; 489     default:
1626                     ; 490       break;
1627  01de a00c          	sub	a,#12
1628  01e0 270a          	jreq	L766
1629  01e2 a010          	sub	a,#16
1630  01e4 260a          	jrne	L337
1631                     ; 483     case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1631                     ; 484       CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1633  01e6 721550c5      	bres	20677,#2
1634                     ; 485       break;
1636  01ea 2004          	jra	L337
1637  01ec               L766:
1638                     ; 486     case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1638                     ; 487       CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1640  01ec 721550c8      	bres	20680,#2
1641                     ; 488       break;
1642  01f0               L337:
1643                     ; 493 }
1646  01f0 85            	popw	x
1647  01f1 81            	ret	
1648                     ; 489     default:
1648                     ; 490       break;
1684                     ; 500 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1684                     ; 501 {
1685                     	switch	.text
1686  01f2               _CLK_SYSCLKConfig:
1688  01f2 88            	push	a
1689       00000000      OFST:	set	0
1692                     ; 503   assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1694                     ; 505   if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1696  01f3 a580          	bcp	a,#128
1697  01f5 260e          	jrne	L757
1698                     ; 507     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1700  01f7 c650c6        	ld	a,20678
1701  01fa a4e7          	and	a,#231
1702  01fc c750c6        	ld	20678,a
1703                     ; 508     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1705  01ff 7b01          	ld	a,(OFST+1,sp)
1706  0201 a418          	and	a,#24
1708  0203 200c          	jra	L167
1709  0205               L757:
1710                     ; 512     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1712  0205 c650c6        	ld	a,20678
1713  0208 a4f8          	and	a,#248
1714  020a c750c6        	ld	20678,a
1715                     ; 513     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1717  020d 7b01          	ld	a,(OFST+1,sp)
1718  020f a407          	and	a,#7
1719  0211               L167:
1720  0211 ca50c6        	or	a,20678
1721  0214 c750c6        	ld	20678,a
1722                     ; 515 }
1725  0217 84            	pop	a
1726  0218 81            	ret	
1782                     ; 523 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1782                     ; 524 {
1783                     	switch	.text
1784  0219               _CLK_SWIMConfig:
1788                     ; 526   assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1790                     ; 528   if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1792  0219 4d            	tnz	a
1793  021a 2705          	jreq	L1101
1794                     ; 531     CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1796  021c 721050cd      	bset	20685,#0
1799  0220 81            	ret	
1800  0221               L1101:
1801                     ; 536     CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1803  0221 721150cd      	bres	20685,#0
1804                     ; 538 }
1807  0225 81            	ret	
1831                     ; 547 void CLK_ClockSecuritySystemEnable(void)
1831                     ; 548 {
1832                     	switch	.text
1833  0226               _CLK_ClockSecuritySystemEnable:
1837                     ; 550   CLK->CSSR |= CLK_CSSR_CSSEN;
1839  0226 721050c8      	bset	20680,#0
1840                     ; 551 }
1843  022a 81            	ret	
1868                     ; 559 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1868                     ; 560 {
1869                     	switch	.text
1870  022b               _CLK_GetSYSCLKSource:
1874                     ; 561   return((CLK_Source_TypeDef)CLK->CMSR);
1876  022b c650c3        	ld	a,20675
1879  022e 81            	ret	
1942                     ; 569 uint32_t CLK_GetClockFreq(void)
1942                     ; 570 {
1943                     	switch	.text
1944  022f               _CLK_GetClockFreq:
1946  022f 5209          	subw	sp,#9
1947       00000009      OFST:	set	9
1950                     ; 571   uint32_t clockfrequency = 0;
1952                     ; 572   CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1954                     ; 573   uint8_t tmp = 0, presc = 0;
1958                     ; 576   clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1960  0231 c650c3        	ld	a,20675
1961  0234 6b09          	ld	(OFST+0,sp),a
1963                     ; 578   if (clocksource == CLK_SOURCE_HSI)
1965  0236 a1e1          	cp	a,#225
1966  0238 2634          	jrne	L7601
1967                     ; 580     tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1969  023a c650c6        	ld	a,20678
1970  023d a418          	and	a,#24
1971  023f 44            	srl	a
1972  0240 44            	srl	a
1973  0241 44            	srl	a
1975                     ; 581     tmp = (uint8_t)(tmp >> 3);
1978                     ; 582     presc = HSIDivFactor[tmp];
1980  0242 5f            	clrw	x
1981  0243 97            	ld	xl,a
1982  0244 d60000        	ld	a,(_HSIDivFactor,x)
1983  0247 6b09          	ld	(OFST+0,sp),a
1985                     ; 583     clockfrequency = HSI_VALUE / presc;
1987  0249 b703          	ld	c_lreg+3,a
1988  024b 3f02          	clr	c_lreg+2
1989  024d 3f01          	clr	c_lreg+1
1990  024f 3f00          	clr	c_lreg
1991  0251 96            	ldw	x,sp
1992  0252 5c            	incw	x
1993  0253 cd0000        	call	c_rtol
1996  0256 ae2400        	ldw	x,#9216
1997  0259 bf02          	ldw	c_lreg+2,x
1998  025b ae00f4        	ldw	x,#244
1999  025e bf00          	ldw	c_lreg,x
2000  0260 96            	ldw	x,sp
2001  0261 5c            	incw	x
2002  0262 cd0000        	call	c_ludv
2004  0265 96            	ldw	x,sp
2005  0266 1c0005        	addw	x,#OFST-4
2006  0269 cd0000        	call	c_rtol
2010  026c 2018          	jra	L1701
2011  026e               L7601:
2012                     ; 585   else if ( clocksource == CLK_SOURCE_LSI)
2014  026e a1d2          	cp	a,#210
2015  0270 260a          	jrne	L3701
2016                     ; 587     clockfrequency = LSI_VALUE;
2018  0272 aef400        	ldw	x,#62464
2019  0275 1f07          	ldw	(OFST-2,sp),x
2020  0277 ae0001        	ldw	x,#1
2022  027a 2008          	jp	LC005
2023  027c               L3701:
2024                     ; 591     clockfrequency = HSE_VALUE;
2026  027c ae2400        	ldw	x,#9216
2027  027f 1f07          	ldw	(OFST-2,sp),x
2028  0281 ae00f4        	ldw	x,#244
2029  0284               LC005:
2030  0284 1f05          	ldw	(OFST-4,sp),x
2032  0286               L1701:
2033                     ; 594   return((uint32_t)clockfrequency);
2035  0286 96            	ldw	x,sp
2036  0287 1c0005        	addw	x,#OFST-4
2037  028a cd0000        	call	c_ltor
2041  028d 5b09          	addw	sp,#9
2042  028f 81            	ret	
2141                     ; 604 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2141                     ; 605 {
2142                     	switch	.text
2143  0290               _CLK_AdjustHSICalibrationValue:
2145  0290 88            	push	a
2146       00000000      OFST:	set	0
2149                     ; 607   assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2151                     ; 610   CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2153  0291 c650cc        	ld	a,20684
2154  0294 a4f8          	and	a,#248
2155  0296 1a01          	or	a,(OFST+1,sp)
2156  0298 c750cc        	ld	20684,a
2157                     ; 611 }
2160  029b 84            	pop	a
2161  029c 81            	ret	
2185                     ; 622 void CLK_SYSCLKEmergencyClear(void)
2185                     ; 623 {
2186                     	switch	.text
2187  029d               _CLK_SYSCLKEmergencyClear:
2191                     ; 624   CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2193  029d 721150c5      	bres	20677,#0
2194                     ; 625 }
2197  02a1 81            	ret	
2350                     ; 634 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2350                     ; 635 {
2351                     	switch	.text
2352  02a2               _CLK_GetFlagStatus:
2354  02a2 89            	pushw	x
2355  02a3 5203          	subw	sp,#3
2356       00000003      OFST:	set	3
2359                     ; 636   uint16_t statusreg = 0;
2361                     ; 637   uint8_t tmpreg = 0;
2363                     ; 638   FlagStatus bitstatus = RESET;
2365                     ; 641   assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2367                     ; 644   statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2369  02a5 01            	rrwa	x,a
2370  02a6 4f            	clr	a
2371  02a7 02            	rlwa	x,a
2372  02a8 1f01          	ldw	(OFST-2,sp),x
2374                     ; 647   if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2376  02aa a30100        	cpw	x,#256
2377  02ad 2605          	jrne	L1421
2378                     ; 649     tmpreg = CLK->ICKR;
2380  02af c650c0        	ld	a,20672
2382  02b2 2021          	jra	L3421
2383  02b4               L1421:
2384                     ; 651   else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2386  02b4 a30200        	cpw	x,#512
2387  02b7 2605          	jrne	L5421
2388                     ; 653     tmpreg = CLK->ECKR;
2390  02b9 c650c1        	ld	a,20673
2392  02bc 2017          	jra	L3421
2393  02be               L5421:
2394                     ; 655   else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2396  02be a30300        	cpw	x,#768
2397  02c1 2605          	jrne	L1521
2398                     ; 657     tmpreg = CLK->SWCR;
2400  02c3 c650c5        	ld	a,20677
2402  02c6 200d          	jra	L3421
2403  02c8               L1521:
2404                     ; 659   else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2406  02c8 a30400        	cpw	x,#1024
2407  02cb 2605          	jrne	L5521
2408                     ; 661     tmpreg = CLK->CSSR;
2410  02cd c650c8        	ld	a,20680
2412  02d0 2003          	jra	L3421
2413  02d2               L5521:
2414                     ; 665     tmpreg = CLK->CCOR;
2416  02d2 c650c9        	ld	a,20681
2417  02d5               L3421:
2418  02d5 6b03          	ld	(OFST+0,sp),a
2420                     ; 668   if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2422  02d7 7b05          	ld	a,(OFST+2,sp)
2423  02d9 1503          	bcp	a,(OFST+0,sp)
2424  02db 2704          	jreq	L1621
2425                     ; 670     bitstatus = SET;
2427  02dd a601          	ld	a,#1
2430  02df 2001          	jra	L3621
2431  02e1               L1621:
2432                     ; 674     bitstatus = RESET;
2434  02e1 4f            	clr	a
2436  02e2               L3621:
2437                     ; 678   return((FlagStatus)bitstatus);
2441  02e2 5b05          	addw	sp,#5
2442  02e4 81            	ret	
2488                     ; 687 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2488                     ; 688 {
2489                     	switch	.text
2490  02e5               _CLK_GetITStatus:
2492  02e5 88            	push	a
2493  02e6 88            	push	a
2494       00000001      OFST:	set	1
2497                     ; 689   ITStatus bitstatus = RESET;
2499                     ; 692   assert_param(IS_CLK_IT_OK(CLK_IT));
2501                     ; 694   if (CLK_IT == CLK_IT_SWIF)
2503  02e7 a11c          	cp	a,#28
2504  02e9 2609          	jrne	L7031
2505                     ; 697     if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2507  02eb c450c5        	and	a,20677
2508  02ee a10c          	cp	a,#12
2509  02f0 260f          	jrne	L7131
2510                     ; 699       bitstatus = SET;
2512  02f2 2009          	jp	LC007
2513                     ; 703       bitstatus = RESET;
2514  02f4               L7031:
2515                     ; 709     if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2517  02f4 c650c8        	ld	a,20680
2518  02f7 1402          	and	a,(OFST+1,sp)
2519  02f9 a10c          	cp	a,#12
2520  02fb 2604          	jrne	L7131
2521                     ; 711       bitstatus = SET;
2523  02fd               LC007:
2525  02fd a601          	ld	a,#1
2528  02ff 2001          	jra	L5131
2529  0301               L7131:
2530                     ; 715       bitstatus = RESET;
2533  0301 4f            	clr	a
2535  0302               L5131:
2536                     ; 720   return bitstatus;
2540  0302 85            	popw	x
2541  0303 81            	ret	
2577                     ; 729 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2577                     ; 730 {
2578                     	switch	.text
2579  0304               _CLK_ClearITPendingBit:
2583                     ; 732   assert_param(IS_CLK_IT_OK(CLK_IT));
2585                     ; 734   if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2587  0304 a10c          	cp	a,#12
2588  0306 2605          	jrne	L1431
2589                     ; 737     CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2591  0308 721750c8      	bres	20680,#3
2594  030c 81            	ret	
2595  030d               L1431:
2596                     ; 742     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2598  030d 721750c5      	bres	20677,#3
2599                     ; 745 }
2602  0311 81            	ret	
2637                     	xdef	_CLKPrescTable
2638                     	xdef	_HSIDivFactor
2639                     	xdef	_CLK_ClearITPendingBit
2640                     	xdef	_CLK_GetITStatus
2641                     	xdef	_CLK_GetFlagStatus
2642                     	xdef	_CLK_GetSYSCLKSource
2643                     	xdef	_CLK_GetClockFreq
2644                     	xdef	_CLK_AdjustHSICalibrationValue
2645                     	xdef	_CLK_SYSCLKEmergencyClear
2646                     	xdef	_CLK_ClockSecuritySystemEnable
2647                     	xdef	_CLK_SWIMConfig
2648                     	xdef	_CLK_SYSCLKConfig
2649                     	xdef	_CLK_ITConfig
2650                     	xdef	_CLK_CCOConfig
2651                     	xdef	_CLK_HSIPrescalerConfig
2652                     	xdef	_CLK_ClockSwitchConfig
2653                     	xdef	_CLK_PeripheralClockConfig
2654                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
2655                     	xdef	_CLK_FastHaltWakeUpCmd
2656                     	xdef	_CLK_ClockSwitchCmd
2657                     	xdef	_CLK_CCOCmd
2658                     	xdef	_CLK_LSICmd
2659                     	xdef	_CLK_HSICmd
2660                     	xdef	_CLK_HSECmd
2661                     	xdef	_CLK_DeInit
2662                     	xref.b	c_lreg
2663                     	xref.b	c_x
2682                     	xref	c_ltor
2683                     	xref	c_ludv
2684                     	xref	c_rtol
2685                     	end
