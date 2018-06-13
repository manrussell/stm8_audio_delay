   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  43                     ; 53 void UART2_DeInit(void)
  43                     ; 54 {
  45                     	switch	.text
  46  0000               _UART2_DeInit:
  50                     ; 57   (void) UART2->SR;
  52  0000 c65240        	ld	a,21056
  53                     ; 58   (void)UART2->DR;
  55  0003 c65241        	ld	a,21057
  56                     ; 60   UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  58  0006 725f5243      	clr	21059
  59                     ; 61   UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  61  000a 725f5242      	clr	21058
  62                     ; 63   UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  64  000e 725f5244      	clr	21060
  65                     ; 64   UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  67  0012 725f5245      	clr	21061
  68                     ; 65   UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  70  0016 725f5246      	clr	21062
  71                     ; 66   UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  73  001a 725f5247      	clr	21063
  74                     ; 67   UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  76  001e 725f5248      	clr	21064
  77                     ; 68   UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  79  0022 725f5249      	clr	21065
  80                     ; 69 }
  83  0026 81            	ret
 405                     .const:	section	.text
 406  0000               L21:
 407  0000 00098969      	dc.l	625001
 408  0004               L25:
 409  0004 00000064      	dc.l	100
 410                     ; 85 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 410                     ; 86 {
 411                     	switch	.text
 412  0027               _UART2_Init:
 414  0027 520e          	subw	sp,#14
 415       0000000e      OFST:	set	14
 418                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 422                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 426                     ; 91   assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 428  0029 96            	ldw	x,sp
 429  002a 1c0011        	addw	x,#OFST+3
 430  002d cd0000        	call	c_ltor
 432  0030 ae0000        	ldw	x,#L21
 433  0033 cd0000        	call	c_lcmp
 435  0036 2403          	jruge	L01
 436  0038 4f            	clr	a
 437  0039 2010          	jra	L41
 438  003b               L01:
 439  003b ae005b        	ldw	x,#91
 440  003e 89            	pushw	x
 441  003f ae0000        	ldw	x,#0
 442  0042 89            	pushw	x
 443  0043 ae0008        	ldw	x,#L302
 444  0046 cd0000        	call	_assert_failed
 446  0049 5b04          	addw	sp,#4
 447  004b               L41:
 448                     ; 92   assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 450  004b 0d15          	tnz	(OFST+7,sp)
 451  004d 2706          	jreq	L02
 452  004f 7b15          	ld	a,(OFST+7,sp)
 453  0051 a110          	cp	a,#16
 454  0053 2603          	jrne	L61
 455  0055               L02:
 456  0055 4f            	clr	a
 457  0056 2010          	jra	L22
 458  0058               L61:
 459  0058 ae005c        	ldw	x,#92
 460  005b 89            	pushw	x
 461  005c ae0000        	ldw	x,#0
 462  005f 89            	pushw	x
 463  0060 ae0008        	ldw	x,#L302
 464  0063 cd0000        	call	_assert_failed
 466  0066 5b04          	addw	sp,#4
 467  0068               L22:
 468                     ; 93   assert_param(IS_UART2_STOPBITS_OK(StopBits));
 470  0068 0d16          	tnz	(OFST+8,sp)
 471  006a 2712          	jreq	L62
 472  006c 7b16          	ld	a,(OFST+8,sp)
 473  006e a110          	cp	a,#16
 474  0070 270c          	jreq	L62
 475  0072 7b16          	ld	a,(OFST+8,sp)
 476  0074 a120          	cp	a,#32
 477  0076 2706          	jreq	L62
 478  0078 7b16          	ld	a,(OFST+8,sp)
 479  007a a130          	cp	a,#48
 480  007c 2603          	jrne	L42
 481  007e               L62:
 482  007e 4f            	clr	a
 483  007f 2010          	jra	L03
 484  0081               L42:
 485  0081 ae005d        	ldw	x,#93
 486  0084 89            	pushw	x
 487  0085 ae0000        	ldw	x,#0
 488  0088 89            	pushw	x
 489  0089 ae0008        	ldw	x,#L302
 490  008c cd0000        	call	_assert_failed
 492  008f 5b04          	addw	sp,#4
 493  0091               L03:
 494                     ; 94   assert_param(IS_UART2_PARITY_OK(Parity));
 496  0091 0d17          	tnz	(OFST+9,sp)
 497  0093 270c          	jreq	L43
 498  0095 7b17          	ld	a,(OFST+9,sp)
 499  0097 a104          	cp	a,#4
 500  0099 2706          	jreq	L43
 501  009b 7b17          	ld	a,(OFST+9,sp)
 502  009d a106          	cp	a,#6
 503  009f 2603          	jrne	L23
 504  00a1               L43:
 505  00a1 4f            	clr	a
 506  00a2 2010          	jra	L63
 507  00a4               L23:
 508  00a4 ae005e        	ldw	x,#94
 509  00a7 89            	pushw	x
 510  00a8 ae0000        	ldw	x,#0
 511  00ab 89            	pushw	x
 512  00ac ae0008        	ldw	x,#L302
 513  00af cd0000        	call	_assert_failed
 515  00b2 5b04          	addw	sp,#4
 516  00b4               L63:
 517                     ; 95   assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 519  00b4 7b19          	ld	a,(OFST+11,sp)
 520  00b6 a108          	cp	a,#8
 521  00b8 2730          	jreq	L24
 522  00ba 7b19          	ld	a,(OFST+11,sp)
 523  00bc a140          	cp	a,#64
 524  00be 272a          	jreq	L24
 525  00c0 7b19          	ld	a,(OFST+11,sp)
 526  00c2 a104          	cp	a,#4
 527  00c4 2724          	jreq	L24
 528  00c6 7b19          	ld	a,(OFST+11,sp)
 529  00c8 a180          	cp	a,#128
 530  00ca 271e          	jreq	L24
 531  00cc 7b19          	ld	a,(OFST+11,sp)
 532  00ce a10c          	cp	a,#12
 533  00d0 2718          	jreq	L24
 534  00d2 7b19          	ld	a,(OFST+11,sp)
 535  00d4 a10c          	cp	a,#12
 536  00d6 2712          	jreq	L24
 537  00d8 7b19          	ld	a,(OFST+11,sp)
 538  00da a144          	cp	a,#68
 539  00dc 270c          	jreq	L24
 540  00de 7b19          	ld	a,(OFST+11,sp)
 541  00e0 a1c0          	cp	a,#192
 542  00e2 2706          	jreq	L24
 543  00e4 7b19          	ld	a,(OFST+11,sp)
 544  00e6 a188          	cp	a,#136
 545  00e8 2603          	jrne	L04
 546  00ea               L24:
 547  00ea 4f            	clr	a
 548  00eb 2010          	jra	L44
 549  00ed               L04:
 550  00ed ae005f        	ldw	x,#95
 551  00f0 89            	pushw	x
 552  00f1 ae0000        	ldw	x,#0
 553  00f4 89            	pushw	x
 554  00f5 ae0008        	ldw	x,#L302
 555  00f8 cd0000        	call	_assert_failed
 557  00fb 5b04          	addw	sp,#4
 558  00fd               L44:
 559                     ; 96   assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 561  00fd 7b18          	ld	a,(OFST+10,sp)
 562  00ff a488          	and	a,#136
 563  0101 a188          	cp	a,#136
 564  0103 271b          	jreq	L64
 565  0105 7b18          	ld	a,(OFST+10,sp)
 566  0107 a444          	and	a,#68
 567  0109 a144          	cp	a,#68
 568  010b 2713          	jreq	L64
 569  010d 7b18          	ld	a,(OFST+10,sp)
 570  010f a422          	and	a,#34
 571  0111 a122          	cp	a,#34
 572  0113 270b          	jreq	L64
 573  0115 7b18          	ld	a,(OFST+10,sp)
 574  0117 a411          	and	a,#17
 575  0119 a111          	cp	a,#17
 576  011b 2703          	jreq	L64
 577  011d 4f            	clr	a
 578  011e 2010          	jra	L05
 579  0120               L64:
 580  0120 ae0060        	ldw	x,#96
 581  0123 89            	pushw	x
 582  0124 ae0000        	ldw	x,#0
 583  0127 89            	pushw	x
 584  0128 ae0008        	ldw	x,#L302
 585  012b cd0000        	call	_assert_failed
 587  012e 5b04          	addw	sp,#4
 588  0130               L05:
 589                     ; 99   UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 591  0130 72195244      	bres	21060,#4
 592                     ; 101   UART2->CR1 |= (uint8_t)WordLength; 
 594  0134 c65244        	ld	a,21060
 595  0137 1a15          	or	a,(OFST+7,sp)
 596  0139 c75244        	ld	21060,a
 597                     ; 104   UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 599  013c c65246        	ld	a,21062
 600  013f a4cf          	and	a,#207
 601  0141 c75246        	ld	21062,a
 602                     ; 106   UART2->CR3 |= (uint8_t)StopBits; 
 604  0144 c65246        	ld	a,21062
 605  0147 1a16          	or	a,(OFST+8,sp)
 606  0149 c75246        	ld	21062,a
 607                     ; 109   UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 609  014c c65244        	ld	a,21060
 610  014f a4f9          	and	a,#249
 611  0151 c75244        	ld	21060,a
 612                     ; 111   UART2->CR1 |= (uint8_t)Parity;
 614  0154 c65244        	ld	a,21060
 615  0157 1a17          	or	a,(OFST+9,sp)
 616  0159 c75244        	ld	21060,a
 617                     ; 114   UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 619  015c 725f5242      	clr	21058
 620                     ; 116   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 622  0160 c65243        	ld	a,21059
 623  0163 a40f          	and	a,#15
 624  0165 c75243        	ld	21059,a
 625                     ; 118   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 627  0168 c65243        	ld	a,21059
 628  016b a4f0          	and	a,#240
 629  016d c75243        	ld	21059,a
 630                     ; 121   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 632  0170 96            	ldw	x,sp
 633  0171 1c0011        	addw	x,#OFST+3
 634  0174 cd0000        	call	c_ltor
 636  0177 a604          	ld	a,#4
 637  0179 cd0000        	call	c_llsh
 639  017c 96            	ldw	x,sp
 640  017d 1c0001        	addw	x,#OFST-13
 641  0180 cd0000        	call	c_rtol
 644  0183 cd0000        	call	_CLK_GetClockFreq
 646  0186 96            	ldw	x,sp
 647  0187 1c0001        	addw	x,#OFST-13
 648  018a cd0000        	call	c_ludv
 650  018d 96            	ldw	x,sp
 651  018e 1c000b        	addw	x,#OFST-3
 652  0191 cd0000        	call	c_rtol
 655                     ; 122   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 657  0194 96            	ldw	x,sp
 658  0195 1c0011        	addw	x,#OFST+3
 659  0198 cd0000        	call	c_ltor
 661  019b a604          	ld	a,#4
 662  019d cd0000        	call	c_llsh
 664  01a0 96            	ldw	x,sp
 665  01a1 1c0001        	addw	x,#OFST-13
 666  01a4 cd0000        	call	c_rtol
 669  01a7 cd0000        	call	_CLK_GetClockFreq
 671  01aa a664          	ld	a,#100
 672  01ac cd0000        	call	c_smul
 674  01af 96            	ldw	x,sp
 675  01b0 1c0001        	addw	x,#OFST-13
 676  01b3 cd0000        	call	c_ludv
 678  01b6 96            	ldw	x,sp
 679  01b7 1c0007        	addw	x,#OFST-7
 680  01ba cd0000        	call	c_rtol
 683                     ; 126   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 683                     ; 127                                 << 4) / 100) & (uint8_t)0x0F); 
 685  01bd 96            	ldw	x,sp
 686  01be 1c000b        	addw	x,#OFST-3
 687  01c1 cd0000        	call	c_ltor
 689  01c4 a664          	ld	a,#100
 690  01c6 cd0000        	call	c_smul
 692  01c9 96            	ldw	x,sp
 693  01ca 1c0001        	addw	x,#OFST-13
 694  01cd cd0000        	call	c_rtol
 697  01d0 96            	ldw	x,sp
 698  01d1 1c0007        	addw	x,#OFST-7
 699  01d4 cd0000        	call	c_ltor
 701  01d7 96            	ldw	x,sp
 702  01d8 1c0001        	addw	x,#OFST-13
 703  01db cd0000        	call	c_lsub
 705  01de a604          	ld	a,#4
 706  01e0 cd0000        	call	c_llsh
 708  01e3 ae0004        	ldw	x,#L25
 709  01e6 cd0000        	call	c_ludv
 711  01e9 b603          	ld	a,c_lreg+3
 712  01eb a40f          	and	a,#15
 713  01ed 6b05          	ld	(OFST-9,sp),a
 715                     ; 128   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 717  01ef 96            	ldw	x,sp
 718  01f0 1c000b        	addw	x,#OFST-3
 719  01f3 cd0000        	call	c_ltor
 721  01f6 a604          	ld	a,#4
 722  01f8 cd0000        	call	c_lursh
 724  01fb b603          	ld	a,c_lreg+3
 725  01fd a4f0          	and	a,#240
 726  01ff b703          	ld	c_lreg+3,a
 727  0201 3f02          	clr	c_lreg+2
 728  0203 3f01          	clr	c_lreg+1
 729  0205 3f00          	clr	c_lreg
 730  0207 b603          	ld	a,c_lreg+3
 731  0209 6b06          	ld	(OFST-8,sp),a
 733                     ; 130   UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 735  020b 7b05          	ld	a,(OFST-9,sp)
 736  020d 1a06          	or	a,(OFST-8,sp)
 737  020f c75243        	ld	21059,a
 738                     ; 132   UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 740  0212 7b0e          	ld	a,(OFST+0,sp)
 741  0214 c75242        	ld	21058,a
 742                     ; 135   UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 744  0217 c65245        	ld	a,21061
 745  021a a4f3          	and	a,#243
 746  021c c75245        	ld	21061,a
 747                     ; 137   UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 749  021f c65246        	ld	a,21062
 750  0222 a4f8          	and	a,#248
 751  0224 c75246        	ld	21062,a
 752                     ; 139   UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 752                     ; 140     UART2_CR3_CPHA | UART2_CR3_LBCL));
 754  0227 7b18          	ld	a,(OFST+10,sp)
 755  0229 a407          	and	a,#7
 756  022b ca5246        	or	a,21062
 757  022e c75246        	ld	21062,a
 758                     ; 142   if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 760  0231 7b19          	ld	a,(OFST+11,sp)
 761  0233 a504          	bcp	a,#4
 762  0235 2706          	jreq	L502
 763                     ; 145     UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 765  0237 72165245      	bset	21061,#3
 767  023b 2004          	jra	L702
 768  023d               L502:
 769                     ; 150     UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 771  023d 72175245      	bres	21061,#3
 772  0241               L702:
 773                     ; 152   if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 775  0241 7b19          	ld	a,(OFST+11,sp)
 776  0243 a508          	bcp	a,#8
 777  0245 2706          	jreq	L112
 778                     ; 155     UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 780  0247 72145245      	bset	21061,#2
 782  024b 2004          	jra	L312
 783  024d               L112:
 784                     ; 160     UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 786  024d 72155245      	bres	21061,#2
 787  0251               L312:
 788                     ; 164   if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 790  0251 7b18          	ld	a,(OFST+10,sp)
 791  0253 a580          	bcp	a,#128
 792  0255 2706          	jreq	L512
 793                     ; 167     UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 795  0257 72175246      	bres	21062,#3
 797  025b 200a          	jra	L712
 798  025d               L512:
 799                     ; 171     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 801  025d 7b18          	ld	a,(OFST+10,sp)
 802  025f a408          	and	a,#8
 803  0261 ca5246        	or	a,21062
 804  0264 c75246        	ld	21062,a
 805  0267               L712:
 806                     ; 173 }
 809  0267 5b0e          	addw	sp,#14
 810  0269 81            	ret
 865                     ; 181 void UART2_Cmd(FunctionalState NewState)
 865                     ; 182 {
 866                     	switch	.text
 867  026a               _UART2_Cmd:
 871                     ; 183   if (NewState != DISABLE)
 873  026a 4d            	tnz	a
 874  026b 2706          	jreq	L742
 875                     ; 186     UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 877  026d 721b5244      	bres	21060,#5
 879  0271 2004          	jra	L152
 880  0273               L742:
 881                     ; 191     UART2->CR1 |= UART2_CR1_UARTD; 
 883  0273 721a5244      	bset	21060,#5
 884  0277               L152:
 885                     ; 193 }
 888  0277 81            	ret
1021                     ; 210 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
1021                     ; 211 {
1022                     	switch	.text
1023  0278               _UART2_ITConfig:
1025  0278 89            	pushw	x
1026  0279 89            	pushw	x
1027       00000002      OFST:	set	2
1030                     ; 212   uint8_t uartreg = 0, itpos = 0x00;
1034                     ; 215   assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
1036  027a a30100        	cpw	x,#256
1037  027d 271e          	jreq	L26
1038  027f a30277        	cpw	x,#631
1039  0282 2719          	jreq	L26
1040  0284 a30266        	cpw	x,#614
1041  0287 2714          	jreq	L26
1042  0289 a30205        	cpw	x,#517
1043  028c 270f          	jreq	L26
1044  028e a30244        	cpw	x,#580
1045  0291 270a          	jreq	L26
1046  0293 a30412        	cpw	x,#1042
1047  0296 2705          	jreq	L26
1048  0298 a30346        	cpw	x,#838
1049  029b 2603          	jrne	L06
1050  029d               L26:
1051  029d 4f            	clr	a
1052  029e 2010          	jra	L46
1053  02a0               L06:
1054  02a0 ae00d7        	ldw	x,#215
1055  02a3 89            	pushw	x
1056  02a4 ae0000        	ldw	x,#0
1057  02a7 89            	pushw	x
1058  02a8 ae0008        	ldw	x,#L302
1059  02ab cd0000        	call	_assert_failed
1061  02ae 5b04          	addw	sp,#4
1062  02b0               L46:
1063                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1065  02b0 0d07          	tnz	(OFST+5,sp)
1066  02b2 2706          	jreq	L07
1067  02b4 7b07          	ld	a,(OFST+5,sp)
1068  02b6 a101          	cp	a,#1
1069  02b8 2603          	jrne	L66
1070  02ba               L07:
1071  02ba 4f            	clr	a
1072  02bb 2010          	jra	L27
1073  02bd               L66:
1074  02bd ae00d8        	ldw	x,#216
1075  02c0 89            	pushw	x
1076  02c1 ae0000        	ldw	x,#0
1077  02c4 89            	pushw	x
1078  02c5 ae0008        	ldw	x,#L302
1079  02c8 cd0000        	call	_assert_failed
1081  02cb 5b04          	addw	sp,#4
1082  02cd               L27:
1083                     ; 219   uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
1085  02cd 7b03          	ld	a,(OFST+1,sp)
1086  02cf 6b01          	ld	(OFST-1,sp),a
1088                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
1090  02d1 7b04          	ld	a,(OFST+2,sp)
1091  02d3 a40f          	and	a,#15
1092  02d5 5f            	clrw	x
1093  02d6 97            	ld	xl,a
1094  02d7 a601          	ld	a,#1
1095  02d9 5d            	tnzw	x
1096  02da 2704          	jreq	L47
1097  02dc               L67:
1098  02dc 48            	sll	a
1099  02dd 5a            	decw	x
1100  02de 26fc          	jrne	L67
1101  02e0               L47:
1102  02e0 6b02          	ld	(OFST+0,sp),a
1104                     ; 224   if (NewState != DISABLE)
1106  02e2 0d07          	tnz	(OFST+5,sp)
1107  02e4 273a          	jreq	L333
1108                     ; 227     if (uartreg == 0x01)
1110  02e6 7b01          	ld	a,(OFST-1,sp)
1111  02e8 a101          	cp	a,#1
1112  02ea 260a          	jrne	L533
1113                     ; 229       UART2->CR1 |= itpos;
1115  02ec c65244        	ld	a,21060
1116  02ef 1a02          	or	a,(OFST+0,sp)
1117  02f1 c75244        	ld	21060,a
1119  02f4 2066          	jra	L153
1120  02f6               L533:
1121                     ; 231     else if (uartreg == 0x02)
1123  02f6 7b01          	ld	a,(OFST-1,sp)
1124  02f8 a102          	cp	a,#2
1125  02fa 260a          	jrne	L143
1126                     ; 233       UART2->CR2 |= itpos;
1128  02fc c65245        	ld	a,21061
1129  02ff 1a02          	or	a,(OFST+0,sp)
1130  0301 c75245        	ld	21061,a
1132  0304 2056          	jra	L153
1133  0306               L143:
1134                     ; 235     else if (uartreg == 0x03)
1136  0306 7b01          	ld	a,(OFST-1,sp)
1137  0308 a103          	cp	a,#3
1138  030a 260a          	jrne	L543
1139                     ; 237       UART2->CR4 |= itpos;
1141  030c c65247        	ld	a,21063
1142  030f 1a02          	or	a,(OFST+0,sp)
1143  0311 c75247        	ld	21063,a
1145  0314 2046          	jra	L153
1146  0316               L543:
1147                     ; 241       UART2->CR6 |= itpos;
1149  0316 c65249        	ld	a,21065
1150  0319 1a02          	or	a,(OFST+0,sp)
1151  031b c75249        	ld	21065,a
1152  031e 203c          	jra	L153
1153  0320               L333:
1154                     ; 247     if (uartreg == 0x01)
1156  0320 7b01          	ld	a,(OFST-1,sp)
1157  0322 a101          	cp	a,#1
1158  0324 260b          	jrne	L353
1159                     ; 249       UART2->CR1 &= (uint8_t)(~itpos);
1161  0326 7b02          	ld	a,(OFST+0,sp)
1162  0328 43            	cpl	a
1163  0329 c45244        	and	a,21060
1164  032c c75244        	ld	21060,a
1166  032f 202b          	jra	L153
1167  0331               L353:
1168                     ; 251     else if (uartreg == 0x02)
1170  0331 7b01          	ld	a,(OFST-1,sp)
1171  0333 a102          	cp	a,#2
1172  0335 260b          	jrne	L753
1173                     ; 253       UART2->CR2 &= (uint8_t)(~itpos);
1175  0337 7b02          	ld	a,(OFST+0,sp)
1176  0339 43            	cpl	a
1177  033a c45245        	and	a,21061
1178  033d c75245        	ld	21061,a
1180  0340 201a          	jra	L153
1181  0342               L753:
1182                     ; 255     else if (uartreg == 0x03)
1184  0342 7b01          	ld	a,(OFST-1,sp)
1185  0344 a103          	cp	a,#3
1186  0346 260b          	jrne	L363
1187                     ; 257       UART2->CR4 &= (uint8_t)(~itpos);
1189  0348 7b02          	ld	a,(OFST+0,sp)
1190  034a 43            	cpl	a
1191  034b c45247        	and	a,21063
1192  034e c75247        	ld	21063,a
1194  0351 2009          	jra	L153
1195  0353               L363:
1196                     ; 261       UART2->CR6 &= (uint8_t)(~itpos);
1198  0353 7b02          	ld	a,(OFST+0,sp)
1199  0355 43            	cpl	a
1200  0356 c45249        	and	a,21065
1201  0359 c75249        	ld	21065,a
1202  035c               L153:
1203                     ; 264 }
1206  035c 5b04          	addw	sp,#4
1207  035e 81            	ret
1265                     ; 272 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1265                     ; 273 {
1266                     	switch	.text
1267  035f               _UART2_IrDAConfig:
1269  035f 88            	push	a
1270       00000000      OFST:	set	0
1273                     ; 274   assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1275  0360 a101          	cp	a,#1
1276  0362 2703          	jreq	L401
1277  0364 4d            	tnz	a
1278  0365 2603          	jrne	L201
1279  0367               L401:
1280  0367 4f            	clr	a
1281  0368 2010          	jra	L601
1282  036a               L201:
1283  036a ae0112        	ldw	x,#274
1284  036d 89            	pushw	x
1285  036e ae0000        	ldw	x,#0
1286  0371 89            	pushw	x
1287  0372 ae0008        	ldw	x,#L302
1288  0375 cd0000        	call	_assert_failed
1290  0378 5b04          	addw	sp,#4
1291  037a               L601:
1292                     ; 276   if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1294  037a 0d01          	tnz	(OFST+1,sp)
1295  037c 2706          	jreq	L514
1296                     ; 278     UART2->CR5 |= UART2_CR5_IRLP;
1298  037e 72145248      	bset	21064,#2
1300  0382 2004          	jra	L714
1301  0384               L514:
1302                     ; 282     UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1304  0384 72155248      	bres	21064,#2
1305  0388               L714:
1306                     ; 284 }
1309  0388 84            	pop	a
1310  0389 81            	ret
1346                     ; 292 void UART2_IrDACmd(FunctionalState NewState)
1346                     ; 293 {
1347                     	switch	.text
1348  038a               _UART2_IrDACmd:
1350  038a 88            	push	a
1351       00000000      OFST:	set	0
1354                     ; 295   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1356  038b 4d            	tnz	a
1357  038c 2704          	jreq	L411
1358  038e a101          	cp	a,#1
1359  0390 2603          	jrne	L211
1360  0392               L411:
1361  0392 4f            	clr	a
1362  0393 2010          	jra	L611
1363  0395               L211:
1364  0395 ae0127        	ldw	x,#295
1365  0398 89            	pushw	x
1366  0399 ae0000        	ldw	x,#0
1367  039c 89            	pushw	x
1368  039d ae0008        	ldw	x,#L302
1369  03a0 cd0000        	call	_assert_failed
1371  03a3 5b04          	addw	sp,#4
1372  03a5               L611:
1373                     ; 297   if (NewState != DISABLE)
1375  03a5 0d01          	tnz	(OFST+1,sp)
1376  03a7 2706          	jreq	L734
1377                     ; 300     UART2->CR5 |= UART2_CR5_IREN;
1379  03a9 72125248      	bset	21064,#1
1381  03ad 2004          	jra	L144
1382  03af               L734:
1383                     ; 305     UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1385  03af 72135248      	bres	21064,#1
1386  03b3               L144:
1387                     ; 307 }
1390  03b3 84            	pop	a
1391  03b4 81            	ret
1451                     ; 316 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1451                     ; 317 {
1452                     	switch	.text
1453  03b5               _UART2_LINBreakDetectionConfig:
1455  03b5 88            	push	a
1456       00000000      OFST:	set	0
1459                     ; 319   assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1461  03b6 4d            	tnz	a
1462  03b7 2704          	jreq	L421
1463  03b9 a101          	cp	a,#1
1464  03bb 2603          	jrne	L221
1465  03bd               L421:
1466  03bd 4f            	clr	a
1467  03be 2010          	jra	L621
1468  03c0               L221:
1469  03c0 ae013f        	ldw	x,#319
1470  03c3 89            	pushw	x
1471  03c4 ae0000        	ldw	x,#0
1472  03c7 89            	pushw	x
1473  03c8 ae0008        	ldw	x,#L302
1474  03cb cd0000        	call	_assert_failed
1476  03ce 5b04          	addw	sp,#4
1477  03d0               L621:
1478                     ; 321   if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1480  03d0 0d01          	tnz	(OFST+1,sp)
1481  03d2 2706          	jreq	L174
1482                     ; 323     UART2->CR4 |= UART2_CR4_LBDL;
1484  03d4 721a5247      	bset	21063,#5
1486  03d8 2004          	jra	L374
1487  03da               L174:
1488                     ; 327     UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1490  03da 721b5247      	bres	21063,#5
1491  03de               L374:
1492                     ; 329 }
1495  03de 84            	pop	a
1496  03df 81            	ret
1618                     ; 341 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1618                     ; 342                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1618                     ; 343                      UART2_LinDivUp_TypeDef UART2_DivUp)
1618                     ; 344 {
1619                     	switch	.text
1620  03e0               _UART2_LINConfig:
1622  03e0 89            	pushw	x
1623       00000000      OFST:	set	0
1626                     ; 346   assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1628  03e1 9e            	ld	a,xh
1629  03e2 4d            	tnz	a
1630  03e3 2705          	jreq	L431
1631  03e5 9e            	ld	a,xh
1632  03e6 a101          	cp	a,#1
1633  03e8 2603          	jrne	L231
1634  03ea               L431:
1635  03ea 4f            	clr	a
1636  03eb 2010          	jra	L631
1637  03ed               L231:
1638  03ed ae015a        	ldw	x,#346
1639  03f0 89            	pushw	x
1640  03f1 ae0000        	ldw	x,#0
1641  03f4 89            	pushw	x
1642  03f5 ae0008        	ldw	x,#L302
1643  03f8 cd0000        	call	_assert_failed
1645  03fb 5b04          	addw	sp,#4
1646  03fd               L631:
1647                     ; 347   assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1649  03fd 7b02          	ld	a,(OFST+2,sp)
1650  03ff a101          	cp	a,#1
1651  0401 2704          	jreq	L241
1652  0403 0d02          	tnz	(OFST+2,sp)
1653  0405 2603          	jrne	L041
1654  0407               L241:
1655  0407 4f            	clr	a
1656  0408 2010          	jra	L441
1657  040a               L041:
1658  040a ae015b        	ldw	x,#347
1659  040d 89            	pushw	x
1660  040e ae0000        	ldw	x,#0
1661  0411 89            	pushw	x
1662  0412 ae0008        	ldw	x,#L302
1663  0415 cd0000        	call	_assert_failed
1665  0418 5b04          	addw	sp,#4
1666  041a               L441:
1667                     ; 348   assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1669  041a 0d05          	tnz	(OFST+5,sp)
1670  041c 2706          	jreq	L051
1671  041e 7b05          	ld	a,(OFST+5,sp)
1672  0420 a101          	cp	a,#1
1673  0422 2603          	jrne	L641
1674  0424               L051:
1675  0424 4f            	clr	a
1676  0425 2010          	jra	L251
1677  0427               L641:
1678  0427 ae015c        	ldw	x,#348
1679  042a 89            	pushw	x
1680  042b ae0000        	ldw	x,#0
1681  042e 89            	pushw	x
1682  042f ae0008        	ldw	x,#L302
1683  0432 cd0000        	call	_assert_failed
1685  0435 5b04          	addw	sp,#4
1686  0437               L251:
1687                     ; 350   if (UART2_Mode != UART2_LIN_MODE_MASTER)
1689  0437 0d01          	tnz	(OFST+1,sp)
1690  0439 2706          	jreq	L355
1691                     ; 352     UART2->CR6 |=  UART2_CR6_LSLV;
1693  043b 721a5249      	bset	21065,#5
1695  043f 2004          	jra	L555
1696  0441               L355:
1697                     ; 356     UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1699  0441 721b5249      	bres	21065,#5
1700  0445               L555:
1701                     ; 359   if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1703  0445 0d02          	tnz	(OFST+2,sp)
1704  0447 2706          	jreq	L755
1705                     ; 361     UART2->CR6 |=  UART2_CR6_LASE ;
1707  0449 72185249      	bset	21065,#4
1709  044d 2004          	jra	L165
1710  044f               L755:
1711                     ; 365     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1713  044f 72195249      	bres	21065,#4
1714  0453               L165:
1715                     ; 368   if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1717  0453 0d05          	tnz	(OFST+5,sp)
1718  0455 2706          	jreq	L365
1719                     ; 370     UART2->CR6 |=  UART2_CR6_LDUM;
1721  0457 721e5249      	bset	21065,#7
1723  045b 2004          	jra	L565
1724  045d               L365:
1725                     ; 374     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1727  045d 721f5249      	bres	21065,#7
1728  0461               L565:
1729                     ; 376 }
1732  0461 85            	popw	x
1733  0462 81            	ret
1769                     ; 384 void UART2_LINCmd(FunctionalState NewState)
1769                     ; 385 {
1770                     	switch	.text
1771  0463               _UART2_LINCmd:
1773  0463 88            	push	a
1774       00000000      OFST:	set	0
1777                     ; 386   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1779  0464 4d            	tnz	a
1780  0465 2704          	jreq	L061
1781  0467 a101          	cp	a,#1
1782  0469 2603          	jrne	L651
1783  046b               L061:
1784  046b 4f            	clr	a
1785  046c 2010          	jra	L261
1786  046e               L651:
1787  046e ae0182        	ldw	x,#386
1788  0471 89            	pushw	x
1789  0472 ae0000        	ldw	x,#0
1790  0475 89            	pushw	x
1791  0476 ae0008        	ldw	x,#L302
1792  0479 cd0000        	call	_assert_failed
1794  047c 5b04          	addw	sp,#4
1795  047e               L261:
1796                     ; 388   if (NewState != DISABLE)
1798  047e 0d01          	tnz	(OFST+1,sp)
1799  0480 2706          	jreq	L506
1800                     ; 391     UART2->CR3 |= UART2_CR3_LINEN;
1802  0482 721c5246      	bset	21062,#6
1804  0486 2004          	jra	L706
1805  0488               L506:
1806                     ; 396     UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1808  0488 721d5246      	bres	21062,#6
1809  048c               L706:
1810                     ; 398 }
1813  048c 84            	pop	a
1814  048d 81            	ret
1850                     ; 406 void UART2_SmartCardCmd(FunctionalState NewState)
1850                     ; 407 {
1851                     	switch	.text
1852  048e               _UART2_SmartCardCmd:
1854  048e 88            	push	a
1855       00000000      OFST:	set	0
1858                     ; 409   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1860  048f 4d            	tnz	a
1861  0490 2704          	jreq	L071
1862  0492 a101          	cp	a,#1
1863  0494 2603          	jrne	L661
1864  0496               L071:
1865  0496 4f            	clr	a
1866  0497 2010          	jra	L271
1867  0499               L661:
1868  0499 ae0199        	ldw	x,#409
1869  049c 89            	pushw	x
1870  049d ae0000        	ldw	x,#0
1871  04a0 89            	pushw	x
1872  04a1 ae0008        	ldw	x,#L302
1873  04a4 cd0000        	call	_assert_failed
1875  04a7 5b04          	addw	sp,#4
1876  04a9               L271:
1877                     ; 411   if (NewState != DISABLE)
1879  04a9 0d01          	tnz	(OFST+1,sp)
1880  04ab 2706          	jreq	L726
1881                     ; 414     UART2->CR5 |= UART2_CR5_SCEN;
1883  04ad 721a5248      	bset	21064,#5
1885  04b1 2004          	jra	L136
1886  04b3               L726:
1887                     ; 419     UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1889  04b3 721b5248      	bres	21064,#5
1890  04b7               L136:
1891                     ; 421 }
1894  04b7 84            	pop	a
1895  04b8 81            	ret
1932                     ; 429 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1932                     ; 430 {
1933                     	switch	.text
1934  04b9               _UART2_SmartCardNACKCmd:
1936  04b9 88            	push	a
1937       00000000      OFST:	set	0
1940                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1942  04ba 4d            	tnz	a
1943  04bb 2704          	jreq	L002
1944  04bd a101          	cp	a,#1
1945  04bf 2603          	jrne	L671
1946  04c1               L002:
1947  04c1 4f            	clr	a
1948  04c2 2010          	jra	L202
1949  04c4               L671:
1950  04c4 ae01b0        	ldw	x,#432
1951  04c7 89            	pushw	x
1952  04c8 ae0000        	ldw	x,#0
1953  04cb 89            	pushw	x
1954  04cc ae0008        	ldw	x,#L302
1955  04cf cd0000        	call	_assert_failed
1957  04d2 5b04          	addw	sp,#4
1958  04d4               L202:
1959                     ; 434   if (NewState != DISABLE)
1961  04d4 0d01          	tnz	(OFST+1,sp)
1962  04d6 2706          	jreq	L156
1963                     ; 437     UART2->CR5 |= UART2_CR5_NACK;
1965  04d8 72185248      	bset	21064,#4
1967  04dc 2004          	jra	L356
1968  04de               L156:
1969                     ; 442     UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1971  04de 72195248      	bres	21064,#4
1972  04e2               L356:
1973                     ; 444 }
1976  04e2 84            	pop	a
1977  04e3 81            	ret
2035                     ; 452 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
2035                     ; 453 {
2036                     	switch	.text
2037  04e4               _UART2_WakeUpConfig:
2039  04e4 88            	push	a
2040       00000000      OFST:	set	0
2043                     ; 454   assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
2045  04e5 4d            	tnz	a
2046  04e6 2704          	jreq	L012
2047  04e8 a108          	cp	a,#8
2048  04ea 2603          	jrne	L602
2049  04ec               L012:
2050  04ec 4f            	clr	a
2051  04ed 2010          	jra	L212
2052  04ef               L602:
2053  04ef ae01c6        	ldw	x,#454
2054  04f2 89            	pushw	x
2055  04f3 ae0000        	ldw	x,#0
2056  04f6 89            	pushw	x
2057  04f7 ae0008        	ldw	x,#L302
2058  04fa cd0000        	call	_assert_failed
2060  04fd 5b04          	addw	sp,#4
2061  04ff               L212:
2062                     ; 456   UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
2064  04ff 72175244      	bres	21060,#3
2065                     ; 457   UART2->CR1 |= (uint8_t)UART2_WakeUp;
2067  0503 c65244        	ld	a,21060
2068  0506 1a01          	or	a,(OFST+1,sp)
2069  0508 c75244        	ld	21060,a
2070                     ; 458 }
2073  050b 84            	pop	a
2074  050c 81            	ret
2111                     ; 466 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
2111                     ; 467 {
2112                     	switch	.text
2113  050d               _UART2_ReceiverWakeUpCmd:
2115  050d 88            	push	a
2116       00000000      OFST:	set	0
2119                     ; 468   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2121  050e 4d            	tnz	a
2122  050f 2704          	jreq	L022
2123  0511 a101          	cp	a,#1
2124  0513 2603          	jrne	L612
2125  0515               L022:
2126  0515 4f            	clr	a
2127  0516 2010          	jra	L222
2128  0518               L612:
2129  0518 ae01d4        	ldw	x,#468
2130  051b 89            	pushw	x
2131  051c ae0000        	ldw	x,#0
2132  051f 89            	pushw	x
2133  0520 ae0008        	ldw	x,#L302
2134  0523 cd0000        	call	_assert_failed
2136  0526 5b04          	addw	sp,#4
2137  0528               L222:
2138                     ; 470   if (NewState != DISABLE)
2140  0528 0d01          	tnz	(OFST+1,sp)
2141  052a 2706          	jreq	L127
2142                     ; 473     UART2->CR2 |= UART2_CR2_RWU;
2144  052c 72125245      	bset	21061,#1
2146  0530 2004          	jra	L327
2147  0532               L127:
2148                     ; 478     UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
2150  0532 72135245      	bres	21061,#1
2151  0536               L327:
2152                     ; 480 }
2155  0536 84            	pop	a
2156  0537 81            	ret
2179                     ; 487 uint8_t UART2_ReceiveData8(void)
2179                     ; 488 {
2180                     	switch	.text
2181  0538               _UART2_ReceiveData8:
2185                     ; 489   return ((uint8_t)UART2->DR);
2187  0538 c65241        	ld	a,21057
2190  053b 81            	ret
2224                     ; 497 uint16_t UART2_ReceiveData9(void)
2224                     ; 498 {
2225                     	switch	.text
2226  053c               _UART2_ReceiveData9:
2228  053c 89            	pushw	x
2229       00000002      OFST:	set	2
2232                     ; 499   uint16_t temp = 0;
2234                     ; 501   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
2236  053d c65244        	ld	a,21060
2237  0540 5f            	clrw	x
2238  0541 a480          	and	a,#128
2239  0543 5f            	clrw	x
2240  0544 02            	rlwa	x,a
2241  0545 58            	sllw	x
2242  0546 1f01          	ldw	(OFST-1,sp),x
2244                     ; 503   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
2246  0548 c65241        	ld	a,21057
2247  054b 5f            	clrw	x
2248  054c 97            	ld	xl,a
2249  054d 01            	rrwa	x,a
2250  054e 1a02          	or	a,(OFST+0,sp)
2251  0550 01            	rrwa	x,a
2252  0551 1a01          	or	a,(OFST-1,sp)
2253  0553 01            	rrwa	x,a
2254  0554 01            	rrwa	x,a
2255  0555 a4ff          	and	a,#255
2256  0557 01            	rrwa	x,a
2257  0558 a401          	and	a,#1
2258  055a 01            	rrwa	x,a
2261  055b 5b02          	addw	sp,#2
2262  055d 81            	ret
2296                     ; 511 void UART2_SendData8(uint8_t Data)
2296                     ; 512 {
2297                     	switch	.text
2298  055e               _UART2_SendData8:
2302                     ; 514   UART2->DR = Data;
2304  055e c75241        	ld	21057,a
2305                     ; 515 }
2308  0561 81            	ret
2342                     ; 522 void UART2_SendData9(uint16_t Data)
2342                     ; 523 {
2343                     	switch	.text
2344  0562               _UART2_SendData9:
2346  0562 89            	pushw	x
2347       00000000      OFST:	set	0
2350                     ; 525   UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
2352  0563 721d5244      	bres	21060,#6
2353                     ; 528   UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
2355  0567 54            	srlw	x
2356  0568 54            	srlw	x
2357  0569 9f            	ld	a,xl
2358  056a a440          	and	a,#64
2359  056c ca5244        	or	a,21060
2360  056f c75244        	ld	21060,a
2361                     ; 531   UART2->DR   = (uint8_t)(Data);                    
2363  0572 7b02          	ld	a,(OFST+2,sp)
2364  0574 c75241        	ld	21057,a
2365                     ; 532 }
2368  0577 85            	popw	x
2369  0578 81            	ret
2392                     ; 539 void UART2_SendBreak(void)
2392                     ; 540 {
2393                     	switch	.text
2394  0579               _UART2_SendBreak:
2398                     ; 541   UART2->CR2 |= UART2_CR2_SBK;
2400  0579 72105245      	bset	21061,#0
2401                     ; 542 }
2404  057d 81            	ret
2439                     ; 549 void UART2_SetAddress(uint8_t UART2_Address)
2439                     ; 550 {
2440                     	switch	.text
2441  057e               _UART2_SetAddress:
2443  057e 88            	push	a
2444       00000000      OFST:	set	0
2447                     ; 552   assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2449  057f a110          	cp	a,#16
2450  0581 2403          	jruge	L042
2451  0583 4f            	clr	a
2452  0584 2010          	jra	L242
2453  0586               L042:
2454  0586 ae0228        	ldw	x,#552
2455  0589 89            	pushw	x
2456  058a ae0000        	ldw	x,#0
2457  058d 89            	pushw	x
2458  058e ae0008        	ldw	x,#L302
2459  0591 cd0000        	call	_assert_failed
2461  0594 5b04          	addw	sp,#4
2462  0596               L242:
2463                     ; 555   UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2465  0596 c65247        	ld	a,21063
2466  0599 a4f0          	and	a,#240
2467  059b c75247        	ld	21063,a
2468                     ; 557   UART2->CR4 |= UART2_Address;
2470  059e c65247        	ld	a,21063
2471  05a1 1a01          	or	a,(OFST+1,sp)
2472  05a3 c75247        	ld	21063,a
2473                     ; 558 }
2476  05a6 84            	pop	a
2477  05a7 81            	ret
2511                     ; 566 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2511                     ; 567 {
2512                     	switch	.text
2513  05a8               _UART2_SetGuardTime:
2517                     ; 569   UART2->GTR = UART2_GuardTime;
2519  05a8 c7524a        	ld	21066,a
2520                     ; 570 }
2523  05ab 81            	ret
2557                     ; 594 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2557                     ; 595 {
2558                     	switch	.text
2559  05ac               _UART2_SetPrescaler:
2563                     ; 597   UART2->PSCR = UART2_Prescaler;
2565  05ac c7524b        	ld	21067,a
2566                     ; 598 }
2569  05af 81            	ret
2727                     ; 606 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2727                     ; 607 {
2728                     	switch	.text
2729  05b0               _UART2_GetFlagStatus:
2731  05b0 89            	pushw	x
2732  05b1 88            	push	a
2733       00000001      OFST:	set	1
2736                     ; 608   FlagStatus status = RESET;
2738                     ; 611   assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2740  05b2 a30080        	cpw	x,#128
2741  05b5 2737          	jreq	L452
2742  05b7 a30040        	cpw	x,#64
2743  05ba 2732          	jreq	L452
2744  05bc a30020        	cpw	x,#32
2745  05bf 272d          	jreq	L452
2746  05c1 a30010        	cpw	x,#16
2747  05c4 2728          	jreq	L452
2748  05c6 a30008        	cpw	x,#8
2749  05c9 2723          	jreq	L452
2750  05cb a30004        	cpw	x,#4
2751  05ce 271e          	jreq	L452
2752  05d0 a30002        	cpw	x,#2
2753  05d3 2719          	jreq	L452
2754  05d5 a30001        	cpw	x,#1
2755  05d8 2714          	jreq	L452
2756  05da a30101        	cpw	x,#257
2757  05dd 270f          	jreq	L452
2758  05df a30301        	cpw	x,#769
2759  05e2 270a          	jreq	L452
2760  05e4 a30302        	cpw	x,#770
2761  05e7 2705          	jreq	L452
2762  05e9 a30210        	cpw	x,#528
2763  05ec 2603          	jrne	L252
2764  05ee               L452:
2765  05ee 4f            	clr	a
2766  05ef 2010          	jra	L652
2767  05f1               L252:
2768  05f1 ae0263        	ldw	x,#611
2769  05f4 89            	pushw	x
2770  05f5 ae0000        	ldw	x,#0
2771  05f8 89            	pushw	x
2772  05f9 ae0008        	ldw	x,#L302
2773  05fc cd0000        	call	_assert_failed
2775  05ff 5b04          	addw	sp,#4
2776  0601               L652:
2777                     ; 614   if (UART2_FLAG == UART2_FLAG_LBDF)
2779  0601 1e02          	ldw	x,(OFST+1,sp)
2780  0603 a30210        	cpw	x,#528
2781  0606 2611          	jrne	L7511
2782                     ; 616     if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2784  0608 c65247        	ld	a,21063
2785  060b 1503          	bcp	a,(OFST+2,sp)
2786  060d 2706          	jreq	L1611
2787                     ; 619       status = SET;
2789  060f a601          	ld	a,#1
2790  0611 6b01          	ld	(OFST+0,sp),a
2793  0613 2039          	jra	L5611
2794  0615               L1611:
2795                     ; 624       status = RESET;
2797  0615 0f01          	clr	(OFST+0,sp)
2799  0617 2035          	jra	L5611
2800  0619               L7511:
2801                     ; 627   else if (UART2_FLAG == UART2_FLAG_SBK)
2803  0619 1e02          	ldw	x,(OFST+1,sp)
2804  061b a30101        	cpw	x,#257
2805  061e 2611          	jrne	L7611
2806                     ; 629     if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2808  0620 c65245        	ld	a,21061
2809  0623 1503          	bcp	a,(OFST+2,sp)
2810  0625 2706          	jreq	L1711
2811                     ; 632       status = SET;
2813  0627 a601          	ld	a,#1
2814  0629 6b01          	ld	(OFST+0,sp),a
2817  062b 2021          	jra	L5611
2818  062d               L1711:
2819                     ; 637       status = RESET;
2821  062d 0f01          	clr	(OFST+0,sp)
2823  062f 201d          	jra	L5611
2824  0631               L7611:
2825                     ; 640   else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2827  0631 1e02          	ldw	x,(OFST+1,sp)
2828  0633 a30302        	cpw	x,#770
2829  0636 2707          	jreq	L1021
2831  0638 1e02          	ldw	x,(OFST+1,sp)
2832  063a a30301        	cpw	x,#769
2833  063d 2614          	jrne	L7711
2834  063f               L1021:
2835                     ; 642     if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2837  063f c65249        	ld	a,21065
2838  0642 1503          	bcp	a,(OFST+2,sp)
2839  0644 2706          	jreq	L3021
2840                     ; 645       status = SET;
2842  0646 a601          	ld	a,#1
2843  0648 6b01          	ld	(OFST+0,sp),a
2846  064a 2002          	jra	L5611
2847  064c               L3021:
2848                     ; 650       status = RESET;
2850  064c 0f01          	clr	(OFST+0,sp)
2852  064e               L5611:
2853                     ; 668   return  status;
2855  064e 7b01          	ld	a,(OFST+0,sp)
2858  0650 5b03          	addw	sp,#3
2859  0652 81            	ret
2860  0653               L7711:
2861                     ; 655     if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2863  0653 c65240        	ld	a,21056
2864  0656 1503          	bcp	a,(OFST+2,sp)
2865  0658 2706          	jreq	L1121
2866                     ; 658       status = SET;
2868  065a a601          	ld	a,#1
2869  065c 6b01          	ld	(OFST+0,sp),a
2872  065e 20ee          	jra	L5611
2873  0660               L1121:
2874                     ; 663       status = RESET;
2876  0660 0f01          	clr	(OFST+0,sp)
2878  0662 20ea          	jra	L5611
2914                     ; 699 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2914                     ; 700 {
2915                     	switch	.text
2916  0664               _UART2_ClearFlag:
2918  0664 89            	pushw	x
2919       00000000      OFST:	set	0
2922                     ; 701   assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2924  0665 a30020        	cpw	x,#32
2925  0668 270f          	jreq	L462
2926  066a a30302        	cpw	x,#770
2927  066d 270a          	jreq	L462
2928  066f a30301        	cpw	x,#769
2929  0672 2705          	jreq	L462
2930  0674 a30210        	cpw	x,#528
2931  0677 2603          	jrne	L262
2932  0679               L462:
2933  0679 4f            	clr	a
2934  067a 2010          	jra	L662
2935  067c               L262:
2936  067c ae02bd        	ldw	x,#701
2937  067f 89            	pushw	x
2938  0680 ae0000        	ldw	x,#0
2939  0683 89            	pushw	x
2940  0684 ae0008        	ldw	x,#L302
2941  0687 cd0000        	call	_assert_failed
2943  068a 5b04          	addw	sp,#4
2944  068c               L662:
2945                     ; 704   if (UART2_FLAG == UART2_FLAG_RXNE)
2947  068c 1e01          	ldw	x,(OFST+1,sp)
2948  068e a30020        	cpw	x,#32
2949  0691 2606          	jrne	L3321
2950                     ; 706     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2952  0693 35df5240      	mov	21056,#223
2954  0697 201e          	jra	L5321
2955  0699               L3321:
2956                     ; 709   else if (UART2_FLAG == UART2_FLAG_LBDF)
2958  0699 1e01          	ldw	x,(OFST+1,sp)
2959  069b a30210        	cpw	x,#528
2960  069e 2606          	jrne	L7321
2961                     ; 711     UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2963  06a0 72195247      	bres	21063,#4
2965  06a4 2011          	jra	L5321
2966  06a6               L7321:
2967                     ; 714   else if (UART2_FLAG == UART2_FLAG_LHDF)
2969  06a6 1e01          	ldw	x,(OFST+1,sp)
2970  06a8 a30302        	cpw	x,#770
2971  06ab 2606          	jrne	L3421
2972                     ; 716     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2974  06ad 72135249      	bres	21065,#1
2976  06b1 2004          	jra	L5321
2977  06b3               L3421:
2978                     ; 721     UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2980  06b3 72115249      	bres	21065,#0
2981  06b7               L5321:
2982                     ; 723 }
2985  06b7 85            	popw	x
2986  06b8 81            	ret
3069                     ; 738 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
3069                     ; 739 {
3070                     	switch	.text
3071  06b9               _UART2_GetITStatus:
3073  06b9 89            	pushw	x
3074  06ba 89            	pushw	x
3075       00000002      OFST:	set	2
3078                     ; 740   ITStatus pendingbitstatus = RESET;
3080                     ; 741   uint8_t itpos = 0;
3082                     ; 742   uint8_t itmask1 = 0;
3084                     ; 743   uint8_t itmask2 = 0;
3086                     ; 744   uint8_t enablestatus = 0;
3088                     ; 747   assert_param(IS_UART2_GET_IT_OK(UART2_IT));
3090  06bb a30277        	cpw	x,#631
3091  06be 2723          	jreq	L472
3092  06c0 a30266        	cpw	x,#614
3093  06c3 271e          	jreq	L472
3094  06c5 a30255        	cpw	x,#597
3095  06c8 2719          	jreq	L472
3096  06ca a30244        	cpw	x,#580
3097  06cd 2714          	jreq	L472
3098  06cf a30235        	cpw	x,#565
3099  06d2 270f          	jreq	L472
3100  06d4 a30346        	cpw	x,#838
3101  06d7 270a          	jreq	L472
3102  06d9 a30412        	cpw	x,#1042
3103  06dc 2705          	jreq	L472
3104  06de a30100        	cpw	x,#256
3105  06e1 2603          	jrne	L272
3106  06e3               L472:
3107  06e3 4f            	clr	a
3108  06e4 2010          	jra	L672
3109  06e6               L272:
3110  06e6 ae02eb        	ldw	x,#747
3111  06e9 89            	pushw	x
3112  06ea ae0000        	ldw	x,#0
3113  06ed 89            	pushw	x
3114  06ee ae0008        	ldw	x,#L302
3115  06f1 cd0000        	call	_assert_failed
3117  06f4 5b04          	addw	sp,#4
3118  06f6               L672:
3119                     ; 750   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
3121  06f6 7b04          	ld	a,(OFST+2,sp)
3122  06f8 a40f          	and	a,#15
3123  06fa 5f            	clrw	x
3124  06fb 97            	ld	xl,a
3125  06fc a601          	ld	a,#1
3126  06fe 5d            	tnzw	x
3127  06ff 2704          	jreq	L003
3128  0701               L203:
3129  0701 48            	sll	a
3130  0702 5a            	decw	x
3131  0703 26fc          	jrne	L203
3132  0705               L003:
3133  0705 6b01          	ld	(OFST-1,sp),a
3135                     ; 752   itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
3137  0707 7b04          	ld	a,(OFST+2,sp)
3138  0709 4e            	swap	a
3139  070a a40f          	and	a,#15
3140  070c 6b02          	ld	(OFST+0,sp),a
3142                     ; 754   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
3144  070e 7b02          	ld	a,(OFST+0,sp)
3145  0710 5f            	clrw	x
3146  0711 97            	ld	xl,a
3147  0712 a601          	ld	a,#1
3148  0714 5d            	tnzw	x
3149  0715 2704          	jreq	L403
3150  0717               L603:
3151  0717 48            	sll	a
3152  0718 5a            	decw	x
3153  0719 26fc          	jrne	L603
3154  071b               L403:
3155  071b 6b02          	ld	(OFST+0,sp),a
3157                     ; 757   if (UART2_IT == UART2_IT_PE)
3159  071d 1e03          	ldw	x,(OFST+1,sp)
3160  071f a30100        	cpw	x,#256
3161  0722 261c          	jrne	L1131
3162                     ; 760     enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
3164  0724 c65244        	ld	a,21060
3165  0727 1402          	and	a,(OFST+0,sp)
3166  0729 6b02          	ld	(OFST+0,sp),a
3168                     ; 763     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
3170  072b c65240        	ld	a,21056
3171  072e 1501          	bcp	a,(OFST-1,sp)
3172  0730 270a          	jreq	L3131
3174  0732 0d02          	tnz	(OFST+0,sp)
3175  0734 2706          	jreq	L3131
3176                     ; 766       pendingbitstatus = SET;
3178  0736 a601          	ld	a,#1
3179  0738 6b02          	ld	(OFST+0,sp),a
3182  073a 2064          	jra	L7131
3183  073c               L3131:
3184                     ; 771       pendingbitstatus = RESET;
3186  073c 0f02          	clr	(OFST+0,sp)
3188  073e 2060          	jra	L7131
3189  0740               L1131:
3190                     ; 774   else if (UART2_IT == UART2_IT_LBDF)
3192  0740 1e03          	ldw	x,(OFST+1,sp)
3193  0742 a30346        	cpw	x,#838
3194  0745 261c          	jrne	L1231
3195                     ; 777     enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
3197  0747 c65247        	ld	a,21063
3198  074a 1402          	and	a,(OFST+0,sp)
3199  074c 6b02          	ld	(OFST+0,sp),a
3201                     ; 779     if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
3203  074e c65247        	ld	a,21063
3204  0751 1501          	bcp	a,(OFST-1,sp)
3205  0753 270a          	jreq	L3231
3207  0755 0d02          	tnz	(OFST+0,sp)
3208  0757 2706          	jreq	L3231
3209                     ; 782       pendingbitstatus = SET;
3211  0759 a601          	ld	a,#1
3212  075b 6b02          	ld	(OFST+0,sp),a
3215  075d 2041          	jra	L7131
3216  075f               L3231:
3217                     ; 787       pendingbitstatus = RESET;
3219  075f 0f02          	clr	(OFST+0,sp)
3221  0761 203d          	jra	L7131
3222  0763               L1231:
3223                     ; 790   else if (UART2_IT == UART2_IT_LHDF)
3225  0763 1e03          	ldw	x,(OFST+1,sp)
3226  0765 a30412        	cpw	x,#1042
3227  0768 261c          	jrne	L1331
3228                     ; 793     enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
3230  076a c65249        	ld	a,21065
3231  076d 1402          	and	a,(OFST+0,sp)
3232  076f 6b02          	ld	(OFST+0,sp),a
3234                     ; 795     if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
3236  0771 c65249        	ld	a,21065
3237  0774 1501          	bcp	a,(OFST-1,sp)
3238  0776 270a          	jreq	L3331
3240  0778 0d02          	tnz	(OFST+0,sp)
3241  077a 2706          	jreq	L3331
3242                     ; 798       pendingbitstatus = SET;
3244  077c a601          	ld	a,#1
3245  077e 6b02          	ld	(OFST+0,sp),a
3248  0780 201e          	jra	L7131
3249  0782               L3331:
3250                     ; 803       pendingbitstatus = RESET;
3252  0782 0f02          	clr	(OFST+0,sp)
3254  0784 201a          	jra	L7131
3255  0786               L1331:
3256                     ; 809     enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
3258  0786 c65245        	ld	a,21061
3259  0789 1402          	and	a,(OFST+0,sp)
3260  078b 6b02          	ld	(OFST+0,sp),a
3262                     ; 811     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
3264  078d c65240        	ld	a,21056
3265  0790 1501          	bcp	a,(OFST-1,sp)
3266  0792 270a          	jreq	L1431
3268  0794 0d02          	tnz	(OFST+0,sp)
3269  0796 2706          	jreq	L1431
3270                     ; 814       pendingbitstatus = SET;
3272  0798 a601          	ld	a,#1
3273  079a 6b02          	ld	(OFST+0,sp),a
3276  079c 2002          	jra	L7131
3277  079e               L1431:
3278                     ; 819       pendingbitstatus = RESET;
3280  079e 0f02          	clr	(OFST+0,sp)
3282  07a0               L7131:
3283                     ; 823   return  pendingbitstatus;
3285  07a0 7b02          	ld	a,(OFST+0,sp)
3288  07a2 5b04          	addw	sp,#4
3289  07a4 81            	ret
3326                     ; 852 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
3326                     ; 853 {
3327                     	switch	.text
3328  07a5               _UART2_ClearITPendingBit:
3330  07a5 89            	pushw	x
3331       00000000      OFST:	set	0
3334                     ; 854   assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
3336  07a6 a30255        	cpw	x,#597
3337  07a9 270a          	jreq	L413
3338  07ab a30412        	cpw	x,#1042
3339  07ae 2705          	jreq	L413
3340  07b0 a30346        	cpw	x,#838
3341  07b3 2603          	jrne	L213
3342  07b5               L413:
3343  07b5 4f            	clr	a
3344  07b6 2010          	jra	L613
3345  07b8               L213:
3346  07b8 ae0356        	ldw	x,#854
3347  07bb 89            	pushw	x
3348  07bc ae0000        	ldw	x,#0
3349  07bf 89            	pushw	x
3350  07c0 ae0008        	ldw	x,#L302
3351  07c3 cd0000        	call	_assert_failed
3353  07c6 5b04          	addw	sp,#4
3354  07c8               L613:
3355                     ; 857   if (UART2_IT == UART2_IT_RXNE)
3357  07c8 1e01          	ldw	x,(OFST+1,sp)
3358  07ca a30255        	cpw	x,#597
3359  07cd 2606          	jrne	L3631
3360                     ; 859     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
3362  07cf 35df5240      	mov	21056,#223
3364  07d3 2011          	jra	L5631
3365  07d5               L3631:
3366                     ; 862   else if (UART2_IT == UART2_IT_LBDF)
3368  07d5 1e01          	ldw	x,(OFST+1,sp)
3369  07d7 a30346        	cpw	x,#838
3370  07da 2606          	jrne	L7631
3371                     ; 864     UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
3373  07dc 72195247      	bres	21063,#4
3375  07e0 2004          	jra	L5631
3376  07e2               L7631:
3377                     ; 869     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
3379  07e2 72135249      	bres	21065,#1
3380  07e6               L5631:
3381                     ; 871 }
3384  07e6 85            	popw	x
3385  07e7 81            	ret
3398                     	xdef	_UART2_ClearITPendingBit
3399                     	xdef	_UART2_GetITStatus
3400                     	xdef	_UART2_ClearFlag
3401                     	xdef	_UART2_GetFlagStatus
3402                     	xdef	_UART2_SetPrescaler
3403                     	xdef	_UART2_SetGuardTime
3404                     	xdef	_UART2_SetAddress
3405                     	xdef	_UART2_SendBreak
3406                     	xdef	_UART2_SendData9
3407                     	xdef	_UART2_SendData8
3408                     	xdef	_UART2_ReceiveData9
3409                     	xdef	_UART2_ReceiveData8
3410                     	xdef	_UART2_ReceiverWakeUpCmd
3411                     	xdef	_UART2_WakeUpConfig
3412                     	xdef	_UART2_SmartCardNACKCmd
3413                     	xdef	_UART2_SmartCardCmd
3414                     	xdef	_UART2_LINCmd
3415                     	xdef	_UART2_LINConfig
3416                     	xdef	_UART2_LINBreakDetectionConfig
3417                     	xdef	_UART2_IrDACmd
3418                     	xdef	_UART2_IrDAConfig
3419                     	xdef	_UART2_ITConfig
3420                     	xdef	_UART2_Cmd
3421                     	xdef	_UART2_Init
3422                     	xdef	_UART2_DeInit
3423                     	xref	_assert_failed
3424                     	xref	_CLK_GetClockFreq
3425                     	switch	.const
3426  0008               L302:
3427  0008 656e2e737473  	dc.b	"en.stsw-stm8069_pe"
3428  001a 726970685f6c  	dc.b	"riph_lib\stm8s_std"
3429  002c 706572697068  	dc.b	"periph_lib\librari"
3430  003e 65735c73746d  	dc.b	"es\stm8s_stdperiph"
3431  0050 5f6472697665  	dc.b	"_driver\src\stm8s_"
3432  0062 75617274322e  	dc.b	"uart2.c",0
3433                     	xref.b	c_lreg
3434                     	xref.b	c_x
3454                     	xref	c_lursh
3455                     	xref	c_lsub
3456                     	xref	c_smul
3457                     	xref	c_ludv
3458                     	xref	c_rtol
3459                     	xref	c_llsh
3460                     	xref	c_lcmp
3461                     	xref	c_ltor
3462                     	end
