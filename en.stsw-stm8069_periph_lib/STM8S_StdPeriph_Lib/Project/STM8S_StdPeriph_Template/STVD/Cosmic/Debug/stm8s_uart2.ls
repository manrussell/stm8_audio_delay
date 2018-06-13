   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  49                     ; 53 void UART2_DeInit(void)
  49                     ; 54 {
  51                     .text:	section	.text,new
  52  0000               _UART2_DeInit:
  56                     ; 57   (void) UART2->SR;
  58  0000 c65240        	ld	a,21056
  59                     ; 58   (void)UART2->DR;
  61  0003 c65241        	ld	a,21057
  62                     ; 60   UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  64  0006 725f5243      	clr	21059
  65                     ; 61   UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  67  000a 725f5242      	clr	21058
  68                     ; 63   UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  70  000e 725f5244      	clr	21060
  71                     ; 64   UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  73  0012 725f5245      	clr	21061
  74                     ; 65   UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  76  0016 725f5246      	clr	21062
  77                     ; 66   UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  79  001a 725f5247      	clr	21063
  80                     ; 67   UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  82  001e 725f5248      	clr	21064
  83                     ; 68   UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  85  0022 725f5249      	clr	21065
  86                     ; 69 }
  89  0026 81            	ret	
 401                     .const:	section	.text
 402  0000               L21:
 403  0000 00098969      	dc.l	625001
 404  0004               L27:
 405  0004 00000064      	dc.l	100
 406                     ; 85 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 406                     ; 86 {
 407                     .text:	section	.text,new
 408  0000               _UART2_Init:
 410  0000 520e          	subw	sp,#14
 411       0000000e      OFST:	set	14
 414                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 418                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 422                     ; 91   assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 424  0002 96            	ldw	x,sp
 425  0003 1c0011        	addw	x,#OFST+3
 426  0006 cd0000        	call	c_ltor
 428  0009 ae0000        	ldw	x,#L21
 429  000c cd0000        	call	c_lcmp
 431  000f 2506          	jrult	L41
 432  0011 ae005b        	ldw	x,#91
 433  0014 cd01af        	call	LC001
 434  0017               L41:
 435                     ; 92   assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 437  0017 7b15          	ld	a,(OFST+7,sp)
 438  0019 270a          	jreq	L42
 439  001b a110          	cp	a,#16
 440  001d 2706          	jreq	L42
 441  001f ae005c        	ldw	x,#92
 442  0022 cd01af        	call	LC001
 443  0025               L42:
 444                     ; 93   assert_param(IS_UART2_STOPBITS_OK(StopBits));
 446  0025 7b16          	ld	a,(OFST+8,sp)
 447  0027 2712          	jreq	L43
 448  0029 a110          	cp	a,#16
 449  002b 270e          	jreq	L43
 450  002d a120          	cp	a,#32
 451  002f 270a          	jreq	L43
 452  0031 a130          	cp	a,#48
 453  0033 2706          	jreq	L43
 454  0035 ae005d        	ldw	x,#93
 455  0038 cd01af        	call	LC001
 456  003b               L43:
 457                     ; 94   assert_param(IS_UART2_PARITY_OK(Parity));
 459  003b 7b17          	ld	a,(OFST+9,sp)
 460  003d 270e          	jreq	L44
 461  003f a104          	cp	a,#4
 462  0041 270a          	jreq	L44
 463  0043 a106          	cp	a,#6
 464  0045 2706          	jreq	L44
 465  0047 ae005e        	ldw	x,#94
 466  004a cd01af        	call	LC001
 467  004d               L44:
 468                     ; 95   assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 470  004d 7b19          	ld	a,(OFST+11,sp)
 471  004f a108          	cp	a,#8
 472  0051 2722          	jreq	L45
 473  0053 a140          	cp	a,#64
 474  0055 271e          	jreq	L45
 475  0057 a104          	cp	a,#4
 476  0059 271a          	jreq	L45
 477  005b a180          	cp	a,#128
 478  005d 2716          	jreq	L45
 479  005f a10c          	cp	a,#12
 480  0061 2712          	jreq	L45
 481  0063 a144          	cp	a,#68
 482  0065 270e          	jreq	L45
 483  0067 a1c0          	cp	a,#192
 484  0069 270a          	jreq	L45
 485  006b a188          	cp	a,#136
 486  006d 2706          	jreq	L45
 487  006f ae005f        	ldw	x,#95
 488  0072 cd01af        	call	LC001
 489  0075               L45:
 490                     ; 96   assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 492  0075 7b18          	ld	a,(OFST+10,sp)
 493  0077 a488          	and	a,#136
 494  0079 a188          	cp	a,#136
 495  007b 2718          	jreq	L06
 496  007d 7b18          	ld	a,(OFST+10,sp)
 497  007f a444          	and	a,#68
 498  0081 a144          	cp	a,#68
 499  0083 2710          	jreq	L06
 500  0085 7b18          	ld	a,(OFST+10,sp)
 501  0087 a422          	and	a,#34
 502  0089 a122          	cp	a,#34
 503  008b 2708          	jreq	L06
 504  008d 7b18          	ld	a,(OFST+10,sp)
 505  008f a411          	and	a,#17
 506  0091 a111          	cp	a,#17
 507  0093 2606          	jrne	L26
 508  0095               L06:
 509  0095 ae0060        	ldw	x,#96
 510  0098 cd01af        	call	LC001
 511  009b               L26:
 512                     ; 99   UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 514  009b 72195244      	bres	21060,#4
 515                     ; 101   UART2->CR1 |= (uint8_t)WordLength; 
 517  009f c65244        	ld	a,21060
 518  00a2 1a15          	or	a,(OFST+7,sp)
 519  00a4 c75244        	ld	21060,a
 520                     ; 104   UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 522  00a7 c65246        	ld	a,21062
 523  00aa a4cf          	and	a,#207
 524  00ac c75246        	ld	21062,a
 525                     ; 106   UART2->CR3 |= (uint8_t)StopBits; 
 527  00af c65246        	ld	a,21062
 528  00b2 1a16          	or	a,(OFST+8,sp)
 529  00b4 c75246        	ld	21062,a
 530                     ; 109   UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 532  00b7 c65244        	ld	a,21060
 533  00ba a4f9          	and	a,#249
 534  00bc c75244        	ld	21060,a
 535                     ; 111   UART2->CR1 |= (uint8_t)Parity;
 537  00bf c65244        	ld	a,21060
 538  00c2 1a17          	or	a,(OFST+9,sp)
 539  00c4 c75244        	ld	21060,a
 540                     ; 114   UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 542  00c7 725f5242      	clr	21058
 543                     ; 116   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 545  00cb c65243        	ld	a,21059
 546  00ce a40f          	and	a,#15
 547  00d0 c75243        	ld	21059,a
 548                     ; 118   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 550  00d3 c65243        	ld	a,21059
 551  00d6 a4f0          	and	a,#240
 552  00d8 c75243        	ld	21059,a
 553                     ; 121   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 555  00db 96            	ldw	x,sp
 556  00dc cd01bb        	call	LC002
 558  00df 96            	ldw	x,sp
 559  00e0 5c            	incw	x
 560  00e1 cd0000        	call	c_rtol
 563  00e4 cd0000        	call	_CLK_GetClockFreq
 565  00e7 96            	ldw	x,sp
 566  00e8 5c            	incw	x
 567  00e9 cd0000        	call	c_ludv
 569  00ec 96            	ldw	x,sp
 570  00ed 1c000b        	addw	x,#OFST-3
 571  00f0 cd0000        	call	c_rtol
 574                     ; 122   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 576  00f3 96            	ldw	x,sp
 577  00f4 cd01bb        	call	LC002
 579  00f7 96            	ldw	x,sp
 580  00f8 5c            	incw	x
 581  00f9 cd0000        	call	c_rtol
 584  00fc cd0000        	call	_CLK_GetClockFreq
 586  00ff a664          	ld	a,#100
 587  0101 cd0000        	call	c_smul
 589  0104 96            	ldw	x,sp
 590  0105 5c            	incw	x
 591  0106 cd0000        	call	c_ludv
 593  0109 96            	ldw	x,sp
 594  010a 1c0007        	addw	x,#OFST-7
 595  010d cd0000        	call	c_rtol
 598                     ; 126   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 598                     ; 127                                 << 4) / 100) & (uint8_t)0x0F); 
 600  0110 96            	ldw	x,sp
 601  0111 1c000b        	addw	x,#OFST-3
 602  0114 cd0000        	call	c_ltor
 604  0117 a664          	ld	a,#100
 605  0119 cd0000        	call	c_smul
 607  011c 96            	ldw	x,sp
 608  011d 5c            	incw	x
 609  011e cd0000        	call	c_rtol
 612  0121 96            	ldw	x,sp
 613  0122 1c0007        	addw	x,#OFST-7
 614  0125 cd0000        	call	c_ltor
 616  0128 96            	ldw	x,sp
 617  0129 5c            	incw	x
 618  012a cd0000        	call	c_lsub
 620  012d a604          	ld	a,#4
 621  012f cd0000        	call	c_llsh
 623  0132 ae0004        	ldw	x,#L27
 624  0135 cd0000        	call	c_ludv
 626  0138 b603          	ld	a,c_lreg+3
 627  013a a40f          	and	a,#15
 628  013c 6b05          	ld	(OFST-9,sp),a
 630                     ; 128   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 632  013e 96            	ldw	x,sp
 633  013f 1c000b        	addw	x,#OFST-3
 634  0142 cd0000        	call	c_ltor
 636  0145 a604          	ld	a,#4
 637  0147 cd0000        	call	c_lursh
 639  014a b603          	ld	a,c_lreg+3
 640  014c a4f0          	and	a,#240
 641  014e b703          	ld	c_lreg+3,a
 642  0150 3f02          	clr	c_lreg+2
 643  0152 3f01          	clr	c_lreg+1
 644  0154 3f00          	clr	c_lreg
 645  0156 6b06          	ld	(OFST-8,sp),a
 647                     ; 130   UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 649  0158 1a05          	or	a,(OFST-9,sp)
 650  015a c75243        	ld	21059,a
 651                     ; 132   UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 653  015d 7b0e          	ld	a,(OFST+0,sp)
 654  015f c75242        	ld	21058,a
 655                     ; 135   UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 657  0162 c65245        	ld	a,21061
 658  0165 a4f3          	and	a,#243
 659  0167 c75245        	ld	21061,a
 660                     ; 137   UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 662  016a c65246        	ld	a,21062
 663  016d a4f8          	and	a,#248
 664  016f c75246        	ld	21062,a
 665                     ; 139   UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 665                     ; 140     UART2_CR3_CPHA | UART2_CR3_LBCL));
 667  0172 7b18          	ld	a,(OFST+10,sp)
 668  0174 a407          	and	a,#7
 669  0176 ca5246        	or	a,21062
 670  0179 c75246        	ld	21062,a
 671                     ; 142   if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 673  017c 7b19          	ld	a,(OFST+11,sp)
 674  017e a504          	bcp	a,#4
 675  0180 2706          	jreq	L371
 676                     ; 145     UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 678  0182 72165245      	bset	21061,#3
 680  0186 2004          	jra	L571
 681  0188               L371:
 682                     ; 150     UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 684  0188 72175245      	bres	21061,#3
 685  018c               L571:
 686                     ; 152   if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 688  018c a508          	bcp	a,#8
 689  018e 2706          	jreq	L771
 690                     ; 155     UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 692  0190 72145245      	bset	21061,#2
 694  0194 2004          	jra	L102
 695  0196               L771:
 696                     ; 160     UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 698  0196 72155245      	bres	21061,#2
 699  019a               L102:
 700                     ; 164   if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 702  019a 7b18          	ld	a,(OFST+10,sp)
 703  019c 2a06          	jrpl	L302
 704                     ; 167     UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 706  019e 72175246      	bres	21062,#3
 708  01a2 2008          	jra	L502
 709  01a4               L302:
 710                     ; 171     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 712  01a4 a408          	and	a,#8
 713  01a6 ca5246        	or	a,21062
 714  01a9 c75246        	ld	21062,a
 715  01ac               L502:
 716                     ; 173 }
 719  01ac 5b0e          	addw	sp,#14
 720  01ae 81            	ret	
 721  01af               LC001:
 722  01af 89            	pushw	x
 723  01b0 5f            	clrw	x
 724  01b1 89            	pushw	x
 725  01b2 ae0008        	ldw	x,#L171
 726  01b5 cd0000        	call	_assert_failed
 728  01b8 5b04          	addw	sp,#4
 729  01ba 81            	ret	
 730  01bb               LC002:
 731  01bb 1c0011        	addw	x,#OFST+3
 732  01be cd0000        	call	c_ltor
 734  01c1 a604          	ld	a,#4
 735  01c3 cc0000        	jp	c_llsh
 790                     ; 181 void UART2_Cmd(FunctionalState NewState)
 790                     ; 182 {
 791                     .text:	section	.text,new
 792  0000               _UART2_Cmd:
 796                     ; 183   if (NewState != DISABLE)
 798  0000 4d            	tnz	a
 799  0001 2705          	jreq	L532
 800                     ; 186     UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 802  0003 721b5244      	bres	21060,#5
 805  0007 81            	ret	
 806  0008               L532:
 807                     ; 191     UART2->CR1 |= UART2_CR1_UARTD; 
 809  0008 721a5244      	bset	21060,#5
 810                     ; 193 }
 813  000c 81            	ret	
 942                     ; 210 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 942                     ; 211 {
 943                     .text:	section	.text,new
 944  0000               _UART2_ITConfig:
 946  0000 89            	pushw	x
 947  0001 89            	pushw	x
 948       00000002      OFST:	set	2
 951                     ; 212   uint8_t uartreg = 0, itpos = 0x00;
 955                     ; 215   assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 957  0002 a30100        	cpw	x,#256
 958  0005 2724          	jreq	L401
 959  0007 a30277        	cpw	x,#631
 960  000a 271f          	jreq	L401
 961  000c a30266        	cpw	x,#614
 962  000f 271a          	jreq	L401
 963  0011 a30205        	cpw	x,#517
 964  0014 2715          	jreq	L401
 965  0016 a30244        	cpw	x,#580
 966  0019 2710          	jreq	L401
 967  001b a30412        	cpw	x,#1042
 968  001e 270b          	jreq	L401
 969  0020 a30346        	cpw	x,#838
 970  0023 2706          	jreq	L401
 971  0025 ae00d7        	ldw	x,#215
 972  0028 cd00b5        	call	LC007
 973  002b               L401:
 974                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 976  002b 7b07          	ld	a,(OFST+5,sp)
 977  002d 2708          	jreq	L411
 978  002f 4a            	dec	a
 979  0030 2705          	jreq	L411
 980  0032 ae00d8        	ldw	x,#216
 981  0035 ad7e          	call	LC007
 982  0037               L411:
 983                     ; 219   uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 985  0037 7b03          	ld	a,(OFST+1,sp)
 986  0039 6b01          	ld	(OFST-1,sp),a
 988                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 990  003b 7b04          	ld	a,(OFST+2,sp)
 991  003d a40f          	and	a,#15
 992  003f 5f            	clrw	x
 993  0040 97            	ld	xl,a
 994  0041 a601          	ld	a,#1
 995  0043 5d            	tnzw	x
 996  0044 2704          	jreq	L021
 997  0046               L221:
 998  0046 48            	sll	a
 999  0047 5a            	decw	x
1000  0048 26fc          	jrne	L221
1001  004a               L021:
1002  004a 6b02          	ld	(OFST+0,sp),a
1004                     ; 224   if (NewState != DISABLE)
1006  004c 7b07          	ld	a,(OFST+5,sp)
1007  004e 272a          	jreq	L513
1008                     ; 227     if (uartreg == 0x01)
1010  0050 7b01          	ld	a,(OFST-1,sp)
1011  0052 a101          	cp	a,#1
1012  0054 2607          	jrne	L713
1013                     ; 229       UART2->CR1 |= itpos;
1015  0056 c65244        	ld	a,21060
1016  0059 1a02          	or	a,(OFST+0,sp)
1018  005b 2029          	jp	LC005
1019  005d               L713:
1020                     ; 231     else if (uartreg == 0x02)
1022  005d a102          	cp	a,#2
1023  005f 2607          	jrne	L323
1024                     ; 233       UART2->CR2 |= itpos;
1026  0061 c65245        	ld	a,21061
1027  0064 1a02          	or	a,(OFST+0,sp)
1029  0066 202d          	jp	LC004
1030  0068               L323:
1031                     ; 235     else if (uartreg == 0x03)
1033  0068 a103          	cp	a,#3
1034  006a 2607          	jrne	L723
1035                     ; 237       UART2->CR4 |= itpos;
1037  006c c65247        	ld	a,21063
1038  006f 1a02          	or	a,(OFST+0,sp)
1040  0071 2031          	jp	LC006
1041  0073               L723:
1042                     ; 241       UART2->CR6 |= itpos;
1044  0073 c65249        	ld	a,21065
1045  0076 1a02          	or	a,(OFST+0,sp)
1046  0078 2035          	jp	LC003
1047  007a               L513:
1048                     ; 247     if (uartreg == 0x01)
1050  007a 7b01          	ld	a,(OFST-1,sp)
1051  007c a101          	cp	a,#1
1052  007e 260b          	jrne	L533
1053                     ; 249       UART2->CR1 &= (uint8_t)(~itpos);
1055  0080 7b02          	ld	a,(OFST+0,sp)
1056  0082 43            	cpl	a
1057  0083 c45244        	and	a,21060
1058  0086               LC005:
1059  0086 c75244        	ld	21060,a
1061  0089 2027          	jra	L333
1062  008b               L533:
1063                     ; 251     else if (uartreg == 0x02)
1065  008b a102          	cp	a,#2
1066  008d 260b          	jrne	L143
1067                     ; 253       UART2->CR2 &= (uint8_t)(~itpos);
1069  008f 7b02          	ld	a,(OFST+0,sp)
1070  0091 43            	cpl	a
1071  0092 c45245        	and	a,21061
1072  0095               LC004:
1073  0095 c75245        	ld	21061,a
1075  0098 2018          	jra	L333
1076  009a               L143:
1077                     ; 255     else if (uartreg == 0x03)
1079  009a a103          	cp	a,#3
1080  009c 260b          	jrne	L543
1081                     ; 257       UART2->CR4 &= (uint8_t)(~itpos);
1083  009e 7b02          	ld	a,(OFST+0,sp)
1084  00a0 43            	cpl	a
1085  00a1 c45247        	and	a,21063
1086  00a4               LC006:
1087  00a4 c75247        	ld	21063,a
1089  00a7 2009          	jra	L333
1090  00a9               L543:
1091                     ; 261       UART2->CR6 &= (uint8_t)(~itpos);
1093  00a9 7b02          	ld	a,(OFST+0,sp)
1094  00ab 43            	cpl	a
1095  00ac c45249        	and	a,21065
1096  00af               LC003:
1097  00af c75249        	ld	21065,a
1098  00b2               L333:
1099                     ; 264 }
1102  00b2 5b04          	addw	sp,#4
1103  00b4 81            	ret	
1104  00b5               LC007:
1105  00b5 89            	pushw	x
1106  00b6 5f            	clrw	x
1107  00b7 89            	pushw	x
1108  00b8 ae0008        	ldw	x,#L171
1109  00bb cd0000        	call	_assert_failed
1111  00be 5b04          	addw	sp,#4
1112  00c0 81            	ret	
1170                     ; 272 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1170                     ; 273 {
1171                     .text:	section	.text,new
1172  0000               _UART2_IrDAConfig:
1174  0000 88            	push	a
1175       00000000      OFST:	set	0
1178                     ; 274   assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1180  0001 a101          	cp	a,#1
1181  0003 2711          	jreq	L231
1182  0005 4d            	tnz	a
1183  0006 270e          	jreq	L231
1184  0008 ae0112        	ldw	x,#274
1185  000b 89            	pushw	x
1186  000c 5f            	clrw	x
1187  000d 89            	pushw	x
1188  000e ae0008        	ldw	x,#L171
1189  0011 cd0000        	call	_assert_failed
1191  0014 5b04          	addw	sp,#4
1192  0016               L231:
1193                     ; 276   if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1195  0016 7b01          	ld	a,(OFST+1,sp)
1196  0018 2706          	jreq	L773
1197                     ; 278     UART2->CR5 |= UART2_CR5_IRLP;
1199  001a 72145248      	bset	21064,#2
1201  001e 2004          	jra	L104
1202  0020               L773:
1203                     ; 282     UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1205  0020 72155248      	bres	21064,#2
1206  0024               L104:
1207                     ; 284 }
1210  0024 84            	pop	a
1211  0025 81            	ret	
1247                     ; 292 void UART2_IrDACmd(FunctionalState NewState)
1247                     ; 293 {
1248                     .text:	section	.text,new
1249  0000               _UART2_IrDACmd:
1251  0000 88            	push	a
1252       00000000      OFST:	set	0
1255                     ; 295   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1257  0001 4d            	tnz	a
1258  0002 2711          	jreq	L441
1259  0004 4a            	dec	a
1260  0005 270e          	jreq	L441
1261  0007 ae0127        	ldw	x,#295
1262  000a 89            	pushw	x
1263  000b 5f            	clrw	x
1264  000c 89            	pushw	x
1265  000d ae0008        	ldw	x,#L171
1266  0010 cd0000        	call	_assert_failed
1268  0013 5b04          	addw	sp,#4
1269  0015               L441:
1270                     ; 297   if (NewState != DISABLE)
1272  0015 7b01          	ld	a,(OFST+1,sp)
1273  0017 2706          	jreq	L124
1274                     ; 300     UART2->CR5 |= UART2_CR5_IREN;
1276  0019 72125248      	bset	21064,#1
1278  001d 2004          	jra	L324
1279  001f               L124:
1280                     ; 305     UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1282  001f 72135248      	bres	21064,#1
1283  0023               L324:
1284                     ; 307 }
1287  0023 84            	pop	a
1288  0024 81            	ret	
1348                     ; 316 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1348                     ; 317 {
1349                     .text:	section	.text,new
1350  0000               _UART2_LINBreakDetectionConfig:
1352  0000 88            	push	a
1353       00000000      OFST:	set	0
1356                     ; 319   assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1358  0001 4d            	tnz	a
1359  0002 2711          	jreq	L651
1360  0004 4a            	dec	a
1361  0005 270e          	jreq	L651
1362  0007 ae013f        	ldw	x,#319
1363  000a 89            	pushw	x
1364  000b 5f            	clrw	x
1365  000c 89            	pushw	x
1366  000d ae0008        	ldw	x,#L171
1367  0010 cd0000        	call	_assert_failed
1369  0013 5b04          	addw	sp,#4
1370  0015               L651:
1371                     ; 321   if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1373  0015 7b01          	ld	a,(OFST+1,sp)
1374  0017 2706          	jreq	L354
1375                     ; 323     UART2->CR4 |= UART2_CR4_LBDL;
1377  0019 721a5247      	bset	21063,#5
1379  001d 2004          	jra	L554
1380  001f               L354:
1381                     ; 327     UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1383  001f 721b5247      	bres	21063,#5
1384  0023               L554:
1385                     ; 329 }
1388  0023 84            	pop	a
1389  0024 81            	ret	
1511                     ; 341 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1511                     ; 342                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1511                     ; 343                      UART2_LinDivUp_TypeDef UART2_DivUp)
1511                     ; 344 {
1512                     .text:	section	.text,new
1513  0000               _UART2_LINConfig:
1515  0000 89            	pushw	x
1516       00000000      OFST:	set	0
1519                     ; 346   assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1521  0001 9e            	ld	a,xh
1522  0002 4d            	tnz	a
1523  0003 2709          	jreq	L071
1524  0005 9e            	ld	a,xh
1525  0006 4a            	dec	a
1526  0007 2705          	jreq	L071
1527  0009 ae015a        	ldw	x,#346
1528  000c ad46          	call	LC008
1529  000e               L071:
1530                     ; 347   assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1532  000e 7b02          	ld	a,(OFST+2,sp)
1533  0010 4a            	dec	a
1534  0011 2709          	jreq	L002
1535  0013 7b02          	ld	a,(OFST+2,sp)
1536  0015 2705          	jreq	L002
1537  0017 ae015b        	ldw	x,#347
1538  001a ad38          	call	LC008
1539  001c               L002:
1540                     ; 348   assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1542  001c 7b05          	ld	a,(OFST+5,sp)
1543  001e 2708          	jreq	L012
1544  0020 4a            	dec	a
1545  0021 2705          	jreq	L012
1546  0023 ae015c        	ldw	x,#348
1547  0026 ad2c          	call	LC008
1548  0028               L012:
1549                     ; 350   if (UART2_Mode != UART2_LIN_MODE_MASTER)
1551  0028 7b01          	ld	a,(OFST+1,sp)
1552  002a 2706          	jreq	L535
1553                     ; 352     UART2->CR6 |=  UART2_CR6_LSLV;
1555  002c 721a5249      	bset	21065,#5
1557  0030 2004          	jra	L735
1558  0032               L535:
1559                     ; 356     UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1561  0032 721b5249      	bres	21065,#5
1562  0036               L735:
1563                     ; 359   if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1565  0036 7b02          	ld	a,(OFST+2,sp)
1566  0038 2706          	jreq	L145
1567                     ; 361     UART2->CR6 |=  UART2_CR6_LASE ;
1569  003a 72185249      	bset	21065,#4
1571  003e 2004          	jra	L345
1572  0040               L145:
1573                     ; 365     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1575  0040 72195249      	bres	21065,#4
1576  0044               L345:
1577                     ; 368   if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1579  0044 7b05          	ld	a,(OFST+5,sp)
1580  0046 2706          	jreq	L545
1581                     ; 370     UART2->CR6 |=  UART2_CR6_LDUM;
1583  0048 721e5249      	bset	21065,#7
1585  004c 2004          	jra	L745
1586  004e               L545:
1587                     ; 374     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1589  004e 721f5249      	bres	21065,#7
1590  0052               L745:
1591                     ; 376 }
1594  0052 85            	popw	x
1595  0053 81            	ret	
1596  0054               LC008:
1597  0054 89            	pushw	x
1598  0055 5f            	clrw	x
1599  0056 89            	pushw	x
1600  0057 ae0008        	ldw	x,#L171
1601  005a cd0000        	call	_assert_failed
1603  005d 5b04          	addw	sp,#4
1604  005f 81            	ret	
1640                     ; 384 void UART2_LINCmd(FunctionalState NewState)
1640                     ; 385 {
1641                     .text:	section	.text,new
1642  0000               _UART2_LINCmd:
1644  0000 88            	push	a
1645       00000000      OFST:	set	0
1648                     ; 386   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1650  0001 4d            	tnz	a
1651  0002 2711          	jreq	L222
1652  0004 4a            	dec	a
1653  0005 270e          	jreq	L222
1654  0007 ae0182        	ldw	x,#386
1655  000a 89            	pushw	x
1656  000b 5f            	clrw	x
1657  000c 89            	pushw	x
1658  000d ae0008        	ldw	x,#L171
1659  0010 cd0000        	call	_assert_failed
1661  0013 5b04          	addw	sp,#4
1662  0015               L222:
1663                     ; 388   if (NewState != DISABLE)
1665  0015 7b01          	ld	a,(OFST+1,sp)
1666  0017 2706          	jreq	L765
1667                     ; 391     UART2->CR3 |= UART2_CR3_LINEN;
1669  0019 721c5246      	bset	21062,#6
1671  001d 2004          	jra	L175
1672  001f               L765:
1673                     ; 396     UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1675  001f 721d5246      	bres	21062,#6
1676  0023               L175:
1677                     ; 398 }
1680  0023 84            	pop	a
1681  0024 81            	ret	
1717                     ; 406 void UART2_SmartCardCmd(FunctionalState NewState)
1717                     ; 407 {
1718                     .text:	section	.text,new
1719  0000               _UART2_SmartCardCmd:
1721  0000 88            	push	a
1722       00000000      OFST:	set	0
1725                     ; 409   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1727  0001 4d            	tnz	a
1728  0002 2711          	jreq	L432
1729  0004 4a            	dec	a
1730  0005 270e          	jreq	L432
1731  0007 ae0199        	ldw	x,#409
1732  000a 89            	pushw	x
1733  000b 5f            	clrw	x
1734  000c 89            	pushw	x
1735  000d ae0008        	ldw	x,#L171
1736  0010 cd0000        	call	_assert_failed
1738  0013 5b04          	addw	sp,#4
1739  0015               L432:
1740                     ; 411   if (NewState != DISABLE)
1742  0015 7b01          	ld	a,(OFST+1,sp)
1743  0017 2706          	jreq	L116
1744                     ; 414     UART2->CR5 |= UART2_CR5_SCEN;
1746  0019 721a5248      	bset	21064,#5
1748  001d 2004          	jra	L316
1749  001f               L116:
1750                     ; 419     UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1752  001f 721b5248      	bres	21064,#5
1753  0023               L316:
1754                     ; 421 }
1757  0023 84            	pop	a
1758  0024 81            	ret	
1795                     ; 429 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1795                     ; 430 {
1796                     .text:	section	.text,new
1797  0000               _UART2_SmartCardNACKCmd:
1799  0000 88            	push	a
1800       00000000      OFST:	set	0
1803                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1805  0001 4d            	tnz	a
1806  0002 2711          	jreq	L642
1807  0004 4a            	dec	a
1808  0005 270e          	jreq	L642
1809  0007 ae01b0        	ldw	x,#432
1810  000a 89            	pushw	x
1811  000b 5f            	clrw	x
1812  000c 89            	pushw	x
1813  000d ae0008        	ldw	x,#L171
1814  0010 cd0000        	call	_assert_failed
1816  0013 5b04          	addw	sp,#4
1817  0015               L642:
1818                     ; 434   if (NewState != DISABLE)
1820  0015 7b01          	ld	a,(OFST+1,sp)
1821  0017 2706          	jreq	L336
1822                     ; 437     UART2->CR5 |= UART2_CR5_NACK;
1824  0019 72185248      	bset	21064,#4
1826  001d 2004          	jra	L536
1827  001f               L336:
1828                     ; 442     UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1830  001f 72195248      	bres	21064,#4
1831  0023               L536:
1832                     ; 444 }
1835  0023 84            	pop	a
1836  0024 81            	ret	
1894                     ; 452 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1894                     ; 453 {
1895                     .text:	section	.text,new
1896  0000               _UART2_WakeUpConfig:
1898  0000 88            	push	a
1899       00000000      OFST:	set	0
1902                     ; 454   assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1904  0001 4d            	tnz	a
1905  0002 2712          	jreq	L062
1906  0004 a108          	cp	a,#8
1907  0006 270e          	jreq	L062
1908  0008 ae01c6        	ldw	x,#454
1909  000b 89            	pushw	x
1910  000c 5f            	clrw	x
1911  000d 89            	pushw	x
1912  000e ae0008        	ldw	x,#L171
1913  0011 cd0000        	call	_assert_failed
1915  0014 5b04          	addw	sp,#4
1916  0016               L062:
1917                     ; 456   UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1919  0016 72175244      	bres	21060,#3
1920                     ; 457   UART2->CR1 |= (uint8_t)UART2_WakeUp;
1922  001a c65244        	ld	a,21060
1923  001d 1a01          	or	a,(OFST+1,sp)
1924  001f c75244        	ld	21060,a
1925                     ; 458 }
1928  0022 84            	pop	a
1929  0023 81            	ret	
1966                     ; 466 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1966                     ; 467 {
1967                     .text:	section	.text,new
1968  0000               _UART2_ReceiverWakeUpCmd:
1970  0000 88            	push	a
1971       00000000      OFST:	set	0
1974                     ; 468   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1976  0001 4d            	tnz	a
1977  0002 2711          	jreq	L272
1978  0004 4a            	dec	a
1979  0005 270e          	jreq	L272
1980  0007 ae01d4        	ldw	x,#468
1981  000a 89            	pushw	x
1982  000b 5f            	clrw	x
1983  000c 89            	pushw	x
1984  000d ae0008        	ldw	x,#L171
1985  0010 cd0000        	call	_assert_failed
1987  0013 5b04          	addw	sp,#4
1988  0015               L272:
1989                     ; 470   if (NewState != DISABLE)
1991  0015 7b01          	ld	a,(OFST+1,sp)
1992  0017 2706          	jreq	L307
1993                     ; 473     UART2->CR2 |= UART2_CR2_RWU;
1995  0019 72125245      	bset	21061,#1
1997  001d 2004          	jra	L507
1998  001f               L307:
1999                     ; 478     UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
2001  001f 72135245      	bres	21061,#1
2002  0023               L507:
2003                     ; 480 }
2006  0023 84            	pop	a
2007  0024 81            	ret	
2030                     ; 487 uint8_t UART2_ReceiveData8(void)
2030                     ; 488 {
2031                     .text:	section	.text,new
2032  0000               _UART2_ReceiveData8:
2036                     ; 489   return ((uint8_t)UART2->DR);
2038  0000 c65241        	ld	a,21057
2041  0003 81            	ret	
2073                     ; 497 uint16_t UART2_ReceiveData9(void)
2073                     ; 498 {
2074                     .text:	section	.text,new
2075  0000               _UART2_ReceiveData9:
2077  0000 89            	pushw	x
2078       00000002      OFST:	set	2
2081                     ; 499   uint16_t temp = 0;
2083                     ; 501   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
2085  0001 c65244        	ld	a,21060
2086  0004 a480          	and	a,#128
2087  0006 5f            	clrw	x
2088  0007 02            	rlwa	x,a
2089  0008 58            	sllw	x
2090  0009 1f01          	ldw	(OFST-1,sp),x
2092                     ; 503   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
2094  000b c65241        	ld	a,21057
2095  000e 5f            	clrw	x
2096  000f 97            	ld	xl,a
2097  0010 01            	rrwa	x,a
2098  0011 1a02          	or	a,(OFST+0,sp)
2099  0013 01            	rrwa	x,a
2100  0014 1a01          	or	a,(OFST-1,sp)
2101  0016 a401          	and	a,#1
2102  0018 01            	rrwa	x,a
2105  0019 5b02          	addw	sp,#2
2106  001b 81            	ret	
2138                     ; 511 void UART2_SendData8(uint8_t Data)
2138                     ; 512 {
2139                     .text:	section	.text,new
2140  0000               _UART2_SendData8:
2144                     ; 514   UART2->DR = Data;
2146  0000 c75241        	ld	21057,a
2147                     ; 515 }
2150  0003 81            	ret	
2182                     ; 522 void UART2_SendData9(uint16_t Data)
2182                     ; 523 {
2183                     .text:	section	.text,new
2184  0000               _UART2_SendData9:
2186  0000 89            	pushw	x
2187       00000000      OFST:	set	0
2190                     ; 525   UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
2192  0001 721d5244      	bres	21060,#6
2193                     ; 528   UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
2195  0005 54            	srlw	x
2196  0006 54            	srlw	x
2197  0007 9f            	ld	a,xl
2198  0008 a440          	and	a,#64
2199  000a ca5244        	or	a,21060
2200  000d c75244        	ld	21060,a
2201                     ; 531   UART2->DR   = (uint8_t)(Data);                    
2203  0010 7b02          	ld	a,(OFST+2,sp)
2204  0012 c75241        	ld	21057,a
2205                     ; 532 }
2208  0015 85            	popw	x
2209  0016 81            	ret	
2232                     ; 539 void UART2_SendBreak(void)
2232                     ; 540 {
2233                     .text:	section	.text,new
2234  0000               _UART2_SendBreak:
2238                     ; 541   UART2->CR2 |= UART2_CR2_SBK;
2240  0000 72105245      	bset	21061,#0
2241                     ; 542 }
2244  0004 81            	ret	
2277                     ; 549 void UART2_SetAddress(uint8_t UART2_Address)
2277                     ; 550 {
2278                     .text:	section	.text,new
2279  0000               _UART2_SetAddress:
2281  0000 88            	push	a
2282       00000000      OFST:	set	0
2285                     ; 552   assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2287  0001 a110          	cp	a,#16
2288  0003 250e          	jrult	L413
2289  0005 ae0228        	ldw	x,#552
2290  0008 89            	pushw	x
2291  0009 5f            	clrw	x
2292  000a 89            	pushw	x
2293  000b ae0008        	ldw	x,#L171
2294  000e cd0000        	call	_assert_failed
2296  0011 5b04          	addw	sp,#4
2297  0013               L413:
2298                     ; 555   UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2300  0013 c65247        	ld	a,21063
2301  0016 a4f0          	and	a,#240
2302  0018 c75247        	ld	21063,a
2303                     ; 557   UART2->CR4 |= UART2_Address;
2305  001b c65247        	ld	a,21063
2306  001e 1a01          	or	a,(OFST+1,sp)
2307  0020 c75247        	ld	21063,a
2308                     ; 558 }
2311  0023 84            	pop	a
2312  0024 81            	ret	
2344                     ; 566 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2344                     ; 567 {
2345                     .text:	section	.text,new
2346  0000               _UART2_SetGuardTime:
2350                     ; 569   UART2->GTR = UART2_GuardTime;
2352  0000 c7524a        	ld	21066,a
2353                     ; 570 }
2356  0003 81            	ret	
2388                     ; 594 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2388                     ; 595 {
2389                     .text:	section	.text,new
2390  0000               _UART2_SetPrescaler:
2394                     ; 597   UART2->PSCR = UART2_Prescaler;
2396  0000 c7524b        	ld	21067,a
2397                     ; 598 }
2400  0003 81            	ret	
2558                     ; 606 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2558                     ; 607 {
2559                     .text:	section	.text,new
2560  0000               _UART2_GetFlagStatus:
2562  0000 89            	pushw	x
2563  0001 88            	push	a
2564       00000001      OFST:	set	1
2567                     ; 608   FlagStatus status = RESET;
2569                     ; 611   assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2571  0002 a30080        	cpw	x,#128
2572  0005 2745          	jreq	L233
2573  0007 a30040        	cpw	x,#64
2574  000a 2740          	jreq	L233
2575  000c a30020        	cpw	x,#32
2576  000f 273b          	jreq	L233
2577  0011 a30010        	cpw	x,#16
2578  0014 2736          	jreq	L233
2579  0016 a30008        	cpw	x,#8
2580  0019 2731          	jreq	L233
2581  001b a30004        	cpw	x,#4
2582  001e 272c          	jreq	L233
2583  0020 a30002        	cpw	x,#2
2584  0023 2727          	jreq	L233
2585  0025 a30001        	cpw	x,#1
2586  0028 2722          	jreq	L233
2587  002a a30101        	cpw	x,#257
2588  002d 271d          	jreq	L233
2589  002f a30301        	cpw	x,#769
2590  0032 2718          	jreq	L233
2591  0034 a30302        	cpw	x,#770
2592  0037 2713          	jreq	L233
2593  0039 a30210        	cpw	x,#528
2594  003c 270e          	jreq	L233
2595  003e ae0263        	ldw	x,#611
2596  0041 89            	pushw	x
2597  0042 5f            	clrw	x
2598  0043 89            	pushw	x
2599  0044 ae0008        	ldw	x,#L171
2600  0047 cd0000        	call	_assert_failed
2602  004a 5b04          	addw	sp,#4
2603  004c               L233:
2604                     ; 614   if (UART2_FLAG == UART2_FLAG_LBDF)
2606  004c 1e02          	ldw	x,(OFST+1,sp)
2607  004e a30210        	cpw	x,#528
2608  0051 2609          	jrne	L5211
2609                     ; 616     if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2611  0053 c65247        	ld	a,21063
2612  0056 1503          	bcp	a,(OFST+2,sp)
2613  0058 2725          	jreq	L1511
2614                     ; 619       status = SET;
2616  005a 201f          	jp	LC010
2617                     ; 624       status = RESET;
2618  005c               L5211:
2619                     ; 627   else if (UART2_FLAG == UART2_FLAG_SBK)
2621  005c a30101        	cpw	x,#257
2622  005f 2609          	jrne	L5311
2623                     ; 629     if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2625  0061 c65245        	ld	a,21061
2626  0064 1503          	bcp	a,(OFST+2,sp)
2627  0066 2717          	jreq	L1511
2628                     ; 632       status = SET;
2630  0068 2011          	jp	LC010
2631                     ; 637       status = RESET;
2632  006a               L5311:
2633                     ; 640   else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2635  006a a30302        	cpw	x,#770
2636  006d 2705          	jreq	L7411
2638  006f a30301        	cpw	x,#769
2639  0072 260f          	jrne	L5411
2640  0074               L7411:
2641                     ; 642     if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2643  0074 c65249        	ld	a,21065
2644  0077 1503          	bcp	a,(OFST+2,sp)
2645  0079 2704          	jreq	L1511
2646                     ; 645       status = SET;
2648  007b               LC010:
2652  007b a601          	ld	a,#1
2655  007d 2001          	jra	L3311
2656  007f               L1511:
2657                     ; 650       status = RESET;
2662  007f 4f            	clr	a
2664  0080               L3311:
2665                     ; 668   return  status;
2669  0080 5b03          	addw	sp,#3
2670  0082 81            	ret	
2671  0083               L5411:
2672                     ; 655     if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2674  0083 c65240        	ld	a,21056
2675  0086 1503          	bcp	a,(OFST+2,sp)
2676  0088 27f5          	jreq	L1511
2677                     ; 658       status = SET;
2679  008a 20ef          	jp	LC010
2680                     ; 663       status = RESET;
2716                     ; 699 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2716                     ; 700 {
2717                     .text:	section	.text,new
2718  0000               _UART2_ClearFlag:
2720  0000 89            	pushw	x
2721       00000000      OFST:	set	0
2724                     ; 701   assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2726  0001 a30020        	cpw	x,#32
2727  0004 271d          	jreq	L443
2728  0006 a30302        	cpw	x,#770
2729  0009 2718          	jreq	L443
2730  000b a30301        	cpw	x,#769
2731  000e 2713          	jreq	L443
2732  0010 a30210        	cpw	x,#528
2733  0013 270e          	jreq	L443
2734  0015 ae02bd        	ldw	x,#701
2735  0018 89            	pushw	x
2736  0019 5f            	clrw	x
2737  001a 89            	pushw	x
2738  001b ae0008        	ldw	x,#L171
2739  001e cd0000        	call	_assert_failed
2741  0021 5b04          	addw	sp,#4
2742  0023               L443:
2743                     ; 704   if (UART2_FLAG == UART2_FLAG_RXNE)
2745  0023 1e01          	ldw	x,(OFST+1,sp)
2746  0025 a30020        	cpw	x,#32
2747  0028 2606          	jrne	L1021
2748                     ; 706     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2750  002a 35df5240      	mov	21056,#223
2752  002e 201a          	jra	L3021
2753  0030               L1021:
2754                     ; 709   else if (UART2_FLAG == UART2_FLAG_LBDF)
2756  0030 a30210        	cpw	x,#528
2757  0033 2606          	jrne	L5021
2758                     ; 711     UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2760  0035 72195247      	bres	21063,#4
2762  0039 200f          	jra	L3021
2763  003b               L5021:
2764                     ; 714   else if (UART2_FLAG == UART2_FLAG_LHDF)
2766  003b a30302        	cpw	x,#770
2767  003e 2606          	jrne	L1121
2768                     ; 716     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2770  0040 72135249      	bres	21065,#1
2772  0044 2004          	jra	L3021
2773  0046               L1121:
2774                     ; 721     UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2776  0046 72115249      	bres	21065,#0
2777  004a               L3021:
2778                     ; 723 }
2781  004a 85            	popw	x
2782  004b 81            	ret	
2857                     ; 738 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2857                     ; 739 {
2858                     .text:	section	.text,new
2859  0000               _UART2_GetITStatus:
2861  0000 89            	pushw	x
2862  0001 89            	pushw	x
2863       00000002      OFST:	set	2
2866                     ; 740   ITStatus pendingbitstatus = RESET;
2868                     ; 741   uint8_t itpos = 0;
2870                     ; 742   uint8_t itmask1 = 0;
2872                     ; 743   uint8_t itmask2 = 0;
2874                     ; 744   uint8_t enablestatus = 0;
2876                     ; 747   assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2878  0002 a30277        	cpw	x,#631
2879  0005 2731          	jreq	L653
2880  0007 a30266        	cpw	x,#614
2881  000a 272c          	jreq	L653
2882  000c a30255        	cpw	x,#597
2883  000f 2727          	jreq	L653
2884  0011 a30244        	cpw	x,#580
2885  0014 2722          	jreq	L653
2886  0016 a30235        	cpw	x,#565
2887  0019 271d          	jreq	L653
2888  001b a30346        	cpw	x,#838
2889  001e 2718          	jreq	L653
2890  0020 a30412        	cpw	x,#1042
2891  0023 2713          	jreq	L653
2892  0025 a30100        	cpw	x,#256
2893  0028 270e          	jreq	L653
2894  002a ae02eb        	ldw	x,#747
2895  002d 89            	pushw	x
2896  002e 5f            	clrw	x
2897  002f 89            	pushw	x
2898  0030 ae0008        	ldw	x,#L171
2899  0033 cd0000        	call	_assert_failed
2901  0036 5b04          	addw	sp,#4
2902  0038               L653:
2903                     ; 750   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2905  0038 7b04          	ld	a,(OFST+2,sp)
2906  003a a40f          	and	a,#15
2907  003c 5f            	clrw	x
2908  003d 97            	ld	xl,a
2909  003e a601          	ld	a,#1
2910  0040 5d            	tnzw	x
2911  0041 2704          	jreq	L263
2912  0043               L463:
2913  0043 48            	sll	a
2914  0044 5a            	decw	x
2915  0045 26fc          	jrne	L463
2916  0047               L263:
2917  0047 6b01          	ld	(OFST-1,sp),a
2919                     ; 752   itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2921  0049 7b04          	ld	a,(OFST+2,sp)
2922  004b 4e            	swap	a
2923  004c a40f          	and	a,#15
2924  004e 6b02          	ld	(OFST+0,sp),a
2926                     ; 754   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2928  0050 5f            	clrw	x
2929  0051 97            	ld	xl,a
2930  0052 a601          	ld	a,#1
2931  0054 5d            	tnzw	x
2932  0055 2704          	jreq	L663
2933  0057               L073:
2934  0057 48            	sll	a
2935  0058 5a            	decw	x
2936  0059 26fc          	jrne	L073
2937  005b               L663:
2938  005b 6b02          	ld	(OFST+0,sp),a
2940                     ; 757   if (UART2_IT == UART2_IT_PE)
2942  005d 1e03          	ldw	x,(OFST+1,sp)
2943  005f a30100        	cpw	x,#256
2944  0062 260c          	jrne	L7421
2945                     ; 760     enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2947  0064 c65244        	ld	a,21060
2948  0067 1402          	and	a,(OFST+0,sp)
2949  0069 6b02          	ld	(OFST+0,sp),a
2951                     ; 763     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2953  006b c65240        	ld	a,21056
2955                     ; 766       pendingbitstatus = SET;
2957  006e 2020          	jp	LC013
2958                     ; 771       pendingbitstatus = RESET;
2959  0070               L7421:
2960                     ; 774   else if (UART2_IT == UART2_IT_LBDF)
2962  0070 a30346        	cpw	x,#838
2963  0073 260c          	jrne	L7521
2964                     ; 777     enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2966  0075 c65247        	ld	a,21063
2967  0078 1402          	and	a,(OFST+0,sp)
2968  007a 6b02          	ld	(OFST+0,sp),a
2970                     ; 779     if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2972  007c c65247        	ld	a,21063
2974                     ; 782       pendingbitstatus = SET;
2976  007f 200f          	jp	LC013
2977                     ; 787       pendingbitstatus = RESET;
2978  0081               L7521:
2979                     ; 790   else if (UART2_IT == UART2_IT_LHDF)
2981  0081 a30412        	cpw	x,#1042
2982  0084 2616          	jrne	L7621
2983                     ; 793     enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
2985  0086 c65249        	ld	a,21065
2986  0089 1402          	and	a,(OFST+0,sp)
2987  008b 6b02          	ld	(OFST+0,sp),a
2989                     ; 795     if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2991  008d c65249        	ld	a,21065
2993  0090               LC013:
2994  0090 1501          	bcp	a,(OFST-1,sp)
2995  0092 271a          	jreq	L7721
2996  0094 7b02          	ld	a,(OFST+0,sp)
2997  0096 2716          	jreq	L7721
2998                     ; 798       pendingbitstatus = SET;
3000  0098               LC012:
3004  0098 a601          	ld	a,#1
3007  009a 2013          	jra	L5521
3008                     ; 803       pendingbitstatus = RESET;
3009  009c               L7621:
3010                     ; 809     enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
3012  009c c65245        	ld	a,21061
3013  009f 1402          	and	a,(OFST+0,sp)
3014  00a1 6b02          	ld	(OFST+0,sp),a
3016                     ; 811     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
3018  00a3 c65240        	ld	a,21056
3019  00a6 1501          	bcp	a,(OFST-1,sp)
3020  00a8 2704          	jreq	L7721
3022  00aa 7b02          	ld	a,(OFST+0,sp)
3023                     ; 814       pendingbitstatus = SET;
3025  00ac 26ea          	jrne	LC012
3026  00ae               L7721:
3027                     ; 819       pendingbitstatus = RESET;
3032  00ae 4f            	clr	a
3034  00af               L5521:
3035                     ; 823   return  pendingbitstatus;
3039  00af 5b04          	addw	sp,#4
3040  00b1 81            	ret	
3077                     ; 852 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
3077                     ; 853 {
3078                     .text:	section	.text,new
3079  0000               _UART2_ClearITPendingBit:
3081  0000 89            	pushw	x
3082       00000000      OFST:	set	0
3085                     ; 854   assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
3087  0001 a30255        	cpw	x,#597
3088  0004 2718          	jreq	L004
3089  0006 a30412        	cpw	x,#1042
3090  0009 2713          	jreq	L004
3091  000b a30346        	cpw	x,#838
3092  000e 270e          	jreq	L004
3093  0010 ae0356        	ldw	x,#854
3094  0013 89            	pushw	x
3095  0014 5f            	clrw	x
3096  0015 89            	pushw	x
3097  0016 ae0008        	ldw	x,#L171
3098  0019 cd0000        	call	_assert_failed
3100  001c 5b04          	addw	sp,#4
3101  001e               L004:
3102                     ; 857   if (UART2_IT == UART2_IT_RXNE)
3104  001e 1e01          	ldw	x,(OFST+1,sp)
3105  0020 a30255        	cpw	x,#597
3106  0023 2606          	jrne	L1231
3107                     ; 859     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
3109  0025 35df5240      	mov	21056,#223
3111  0029 200f          	jra	L3231
3112  002b               L1231:
3113                     ; 862   else if (UART2_IT == UART2_IT_LBDF)
3115  002b a30346        	cpw	x,#838
3116  002e 2606          	jrne	L5231
3117                     ; 864     UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
3119  0030 72195247      	bres	21063,#4
3121  0034 2004          	jra	L3231
3122  0036               L5231:
3123                     ; 869     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
3125  0036 72135249      	bres	21065,#1
3126  003a               L3231:
3127                     ; 871 }
3130  003a 85            	popw	x
3131  003b 81            	ret	
3144                     	xdef	_UART2_ClearITPendingBit
3145                     	xdef	_UART2_GetITStatus
3146                     	xdef	_UART2_ClearFlag
3147                     	xdef	_UART2_GetFlagStatus
3148                     	xdef	_UART2_SetPrescaler
3149                     	xdef	_UART2_SetGuardTime
3150                     	xdef	_UART2_SetAddress
3151                     	xdef	_UART2_SendBreak
3152                     	xdef	_UART2_SendData9
3153                     	xdef	_UART2_SendData8
3154                     	xdef	_UART2_ReceiveData9
3155                     	xdef	_UART2_ReceiveData8
3156                     	xdef	_UART2_ReceiverWakeUpCmd
3157                     	xdef	_UART2_WakeUpConfig
3158                     	xdef	_UART2_SmartCardNACKCmd
3159                     	xdef	_UART2_SmartCardCmd
3160                     	xdef	_UART2_LINCmd
3161                     	xdef	_UART2_LINConfig
3162                     	xdef	_UART2_LINBreakDetectionConfig
3163                     	xdef	_UART2_IrDACmd
3164                     	xdef	_UART2_IrDAConfig
3165                     	xdef	_UART2_ITConfig
3166                     	xdef	_UART2_Cmd
3167                     	xdef	_UART2_Init
3168                     	xdef	_UART2_DeInit
3169                     	xref	_assert_failed
3170                     	xref	_CLK_GetClockFreq
3171                     	switch	.const
3172  0008               L171:
3173  0008 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
3174  001a 6965735c7374  	dc.b	"ies\stm8s_stdperip"
3175  002c 685f64726976  	dc.b	"h_driver\src\stm8s"
3176  003e 5f7561727432  	dc.b	"_uart2.c",0
3177                     	xref.b	c_lreg
3178                     	xref.b	c_x
3198                     	xref	c_lursh
3199                     	xref	c_lsub
3200                     	xref	c_smul
3201                     	xref	c_ludv
3202                     	xref	c_rtol
3203                     	xref	c_llsh
3204                     	xref	c_lcmp
3205                     	xref	c_ltor
3206                     	end
