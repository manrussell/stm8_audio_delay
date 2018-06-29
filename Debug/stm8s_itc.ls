   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  43                     ; 50 uint8_t ITC_GetCPUCC(void)
  43                     ; 51 {
  45                     	switch	.text
  46  0000               _ITC_GetCPUCC:
  50                     ; 53   _asm("push cc");
  53  0000 8a            push cc
  55                     ; 54   _asm("pop a");
  58  0001 84            pop a
  60                     ; 55   return; /* Ignore compiler warning, the returned value is in A register */
  63  0002 81            	ret
  86                     ; 80 void ITC_DeInit(void)
  86                     ; 81 {
  87                     	switch	.text
  88  0003               _ITC_DeInit:
  92                     ; 82   ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
  94  0003 35ff7f70      	mov	32624,#255
  95                     ; 83   ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
  97  0007 35ff7f71      	mov	32625,#255
  98                     ; 84   ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
 100  000b 35ff7f72      	mov	32626,#255
 101                     ; 85   ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
 103  000f 35ff7f73      	mov	32627,#255
 104                     ; 86   ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
 106  0013 35ff7f74      	mov	32628,#255
 107                     ; 87   ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
 109  0017 35ff7f75      	mov	32629,#255
 110                     ; 88   ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
 112  001b 35ff7f76      	mov	32630,#255
 113                     ; 89   ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
 115  001f 35ff7f77      	mov	32631,#255
 116                     ; 90 }
 119  0023 81            	ret
 144                     ; 97 uint8_t ITC_GetSoftIntStatus(void)
 144                     ; 98 {
 145                     	switch	.text
 146  0024               _ITC_GetSoftIntStatus:
 150                     ; 99   return (uint8_t)(ITC_GetCPUCC() & CPU_CC_I1I0);
 152  0024 adda          	call	_ITC_GetCPUCC
 154  0026 a428          	and	a,#40
 157  0028 81            	ret
 406                     .const:	section	.text
 407  0000               L22:
 408  0000 004c          	dc.w	L14
 409  0002 004c          	dc.w	L14
 410  0004 004c          	dc.w	L14
 411  0006 004c          	dc.w	L14
 412  0008 0055          	dc.w	L34
 413  000a 0055          	dc.w	L34
 414  000c 0055          	dc.w	L34
 415  000e 0055          	dc.w	L34
 416  0010 0089          	dc.w	L302
 417  0012 0089          	dc.w	L302
 418  0014 005e          	dc.w	L54
 419  0016 005e          	dc.w	L54
 420  0018 0067          	dc.w	L74
 421  001a 0067          	dc.w	L74
 422  001c 0067          	dc.w	L74
 423  001e 0067          	dc.w	L74
 424  0020 0070          	dc.w	L15
 425  0022 0089          	dc.w	L302
 426  0024 0089          	dc.w	L302
 427  0026 0070          	dc.w	L15
 428  0028 0079          	dc.w	L35
 429  002a 0079          	dc.w	L35
 430  002c 0079          	dc.w	L35
 431  002e 0079          	dc.w	L35
 432  0030 0082          	dc.w	L55
 433                     ; 107 ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_Irq_TypeDef IrqNum)
 433                     ; 108 {
 434                     	switch	.text
 435  0029               _ITC_GetSoftwarePriority:
 437  0029 88            	push	a
 438  002a 89            	pushw	x
 439       00000002      OFST:	set	2
 442                     ; 109   uint8_t Value = 0;
 444  002b 0f02          	clr	(OFST+0,sp)
 446                     ; 110   uint8_t Mask = 0;
 448                     ; 113   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 450                     ; 116   Mask = (uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U));
 452  002d a403          	and	a,#3
 453  002f 48            	sll	a
 454  0030 5f            	clrw	x
 455  0031 97            	ld	xl,a
 456  0032 a603          	ld	a,#3
 457  0034 5d            	tnzw	x
 458  0035 2704          	jreq	L41
 459  0037               L61:
 460  0037 48            	sll	a
 461  0038 5a            	decw	x
 462  0039 26fc          	jrne	L61
 463  003b               L41:
 464  003b 6b01          	ld	(OFST-1,sp),a
 466                     ; 118   switch (IrqNum)
 468  003d 7b03          	ld	a,(OFST+1,sp)
 470                     ; 198   default:
 470                     ; 199     break;
 471  003f a119          	cp	a,#25
 472  0041 2407          	jruge	L02
 473  0043 5f            	clrw	x
 474  0044 97            	ld	xl,a
 475  0045 58            	sllw	x
 476  0046 de0000        	ldw	x,(L22,x)
 477  0049 fc            	jp	(x)
 478  004a               L02:
 479  004a 203d          	jra	L302
 480  004c               L14:
 481                     ; 120   case ITC_IRQ_TLI: /* TLI software priority can be read but has no meaning */
 481                     ; 121   case ITC_IRQ_AWU:
 481                     ; 122   case ITC_IRQ_CLK:
 481                     ; 123   case ITC_IRQ_PORTA:
 481                     ; 124     Value = (uint8_t)(ITC->ISPR1 & Mask); /* Read software priority */
 483  004c c67f70        	ld	a,32624
 484  004f 1401          	and	a,(OFST-1,sp)
 485  0051 6b02          	ld	(OFST+0,sp),a
 487                     ; 125     break;
 489  0053 2034          	jra	L302
 490  0055               L34:
 491                     ; 127   case ITC_IRQ_PORTB:
 491                     ; 128   case ITC_IRQ_PORTC:
 491                     ; 129   case ITC_IRQ_PORTD:
 491                     ; 130   case ITC_IRQ_PORTE:
 491                     ; 131     Value = (uint8_t)(ITC->ISPR2 & Mask); /* Read software priority */
 493  0055 c67f71        	ld	a,32625
 494  0058 1401          	and	a,(OFST-1,sp)
 495  005a 6b02          	ld	(OFST+0,sp),a
 497                     ; 132     break;
 499  005c 202b          	jra	L302
 500  005e               L54:
 501                     ; 141   case ITC_IRQ_SPI:
 501                     ; 142   case ITC_IRQ_TIM1_OVF:
 501                     ; 143     Value = (uint8_t)(ITC->ISPR3 & Mask); /* Read software priority */
 503  005e c67f72        	ld	a,32626
 504  0061 1401          	and	a,(OFST-1,sp)
 505  0063 6b02          	ld	(OFST+0,sp),a
 507                     ; 144     break;
 509  0065 2022          	jra	L302
 510  0067               L74:
 511                     ; 146   case ITC_IRQ_TIM1_CAPCOM:
 511                     ; 147 #if defined (STM8S903) || defined (STM8AF622x)
 511                     ; 148   case ITC_IRQ_TIM5_OVFTRI:
 511                     ; 149   case ITC_IRQ_TIM5_CAPCOM:
 511                     ; 150 #else
 511                     ; 151   case ITC_IRQ_TIM2_OVF:
 511                     ; 152   case ITC_IRQ_TIM2_CAPCOM:
 511                     ; 153 #endif /* STM8S903 or STM8AF622x*/
 511                     ; 154   case ITC_IRQ_TIM3_OVF:
 511                     ; 155     Value = (uint8_t)(ITC->ISPR4 & Mask); /* Read software priority */
 513  0067 c67f73        	ld	a,32627
 514  006a 1401          	and	a,(OFST-1,sp)
 515  006c 6b02          	ld	(OFST+0,sp),a
 517                     ; 156     break;
 519  006e 2019          	jra	L302
 520  0070               L15:
 521                     ; 158   case ITC_IRQ_TIM3_CAPCOM:
 521                     ; 159 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 521                     ; 160     defined(STM8S003) ||defined(STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 521                     ; 161   case ITC_IRQ_UART1_TX:
 521                     ; 162   case ITC_IRQ_UART1_RX:
 521                     ; 163 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 521                     ; 164 #if defined(STM8AF622x)
 521                     ; 165   case ITC_IRQ_UART4_TX:
 521                     ; 166   case ITC_IRQ_UART4_RX:
 521                     ; 167 #endif /*STM8AF622x */
 521                     ; 168   case ITC_IRQ_I2C:
 521                     ; 169     Value = (uint8_t)(ITC->ISPR5 & Mask); /* Read software priority */
 523  0070 c67f74        	ld	a,32628
 524  0073 1401          	and	a,(OFST-1,sp)
 525  0075 6b02          	ld	(OFST+0,sp),a
 527                     ; 170     break;
 529  0077 2010          	jra	L302
 530  0079               L35:
 531                     ; 173   case ITC_IRQ_UART2_TX:
 531                     ; 174   case ITC_IRQ_UART2_RX:
 531                     ; 175 #endif /*STM8S105 or STM8AF626x*/
 531                     ; 176 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 531                     ; 177     defined(STM8AF62Ax)
 531                     ; 178   case ITC_IRQ_UART3_TX:
 531                     ; 179   case ITC_IRQ_UART3_RX:
 531                     ; 180   case ITC_IRQ_ADC2:
 531                     ; 181 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 531                     ; 182 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 531                     ; 183     defined(STM8S903) || defined(STM8AF626x) || defined(STM8AF622x)
 531                     ; 184   case ITC_IRQ_ADC1:
 531                     ; 185 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S903 or STM8AF626x or STM8AF622x */
 531                     ; 186 #if defined (STM8S903) || defined (STM8AF622x)
 531                     ; 187   case ITC_IRQ_TIM6_OVFTRI:
 531                     ; 188 #else
 531                     ; 189   case ITC_IRQ_TIM4_OVF:
 531                     ; 190 #endif /*STM8S903 or STM8AF622x */
 531                     ; 191     Value = (uint8_t)(ITC->ISPR6 & Mask); /* Read software priority */
 533  0079 c67f75        	ld	a,32629
 534  007c 1401          	and	a,(OFST-1,sp)
 535  007e 6b02          	ld	(OFST+0,sp),a
 537                     ; 192     break;
 539  0080 2007          	jra	L302
 540  0082               L55:
 541                     ; 194   case ITC_IRQ_EEPROM_EEC:
 541                     ; 195     Value = (uint8_t)(ITC->ISPR7 & Mask); /* Read software priority */
 543  0082 c67f76        	ld	a,32630
 544  0085 1401          	and	a,(OFST-1,sp)
 545  0087 6b02          	ld	(OFST+0,sp),a
 547                     ; 196     break;
 549  0089               L75:
 550                     ; 198   default:
 550                     ; 199     break;
 552  0089               L302:
 553                     ; 202   Value >>= (uint8_t)(((uint8_t)IrqNum % 4u) * 2u);
 555  0089 7b03          	ld	a,(OFST+1,sp)
 556  008b a403          	and	a,#3
 557  008d 48            	sll	a
 558  008e 5f            	clrw	x
 559  008f 97            	ld	xl,a
 560  0090 7b02          	ld	a,(OFST+0,sp)
 561  0092 5d            	tnzw	x
 562  0093 2704          	jreq	L42
 563  0095               L62:
 564  0095 44            	srl	a
 565  0096 5a            	decw	x
 566  0097 26fc          	jrne	L62
 567  0099               L42:
 568  0099 6b02          	ld	(OFST+0,sp),a
 570                     ; 204   return((ITC_PriorityLevel_TypeDef)Value);
 572  009b 7b02          	ld	a,(OFST+0,sp)
 575  009d 5b03          	addw	sp,#3
 576  009f 81            	ret
 640                     	switch	.const
 641  0032               L44:
 642  0032 00d5          	dc.w	L502
 643  0034 00d5          	dc.w	L502
 644  0036 00d5          	dc.w	L502
 645  0038 00d5          	dc.w	L502
 646  003a 00e7          	dc.w	L702
 647  003c 00e7          	dc.w	L702
 648  003e 00e7          	dc.w	L702
 649  0040 00e7          	dc.w	L702
 650  0042 0151          	dc.w	L162
 651  0044 0151          	dc.w	L162
 652  0046 00f9          	dc.w	L112
 653  0048 00f9          	dc.w	L112
 654  004a 010b          	dc.w	L312
 655  004c 010b          	dc.w	L312
 656  004e 010b          	dc.w	L312
 657  0050 010b          	dc.w	L312
 658  0052 011d          	dc.w	L512
 659  0054 0151          	dc.w	L162
 660  0056 0151          	dc.w	L162
 661  0058 011d          	dc.w	L512
 662  005a 012f          	dc.w	L712
 663  005c 012f          	dc.w	L712
 664  005e 012f          	dc.w	L712
 665  0060 012f          	dc.w	L712
 666  0062 0141          	dc.w	L122
 667                     ; 220 void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
 667                     ; 221 {
 668                     	switch	.text
 669  00a0               _ITC_SetSoftwarePriority:
 671  00a0 89            	pushw	x
 672  00a1 89            	pushw	x
 673       00000002      OFST:	set	2
 676                     ; 222   uint8_t Mask = 0;
 678                     ; 223   uint8_t NewPriority = 0;
 680                     ; 226   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 682                     ; 227   assert_param(IS_ITC_PRIORITY_OK(PriorityValue));
 684                     ; 230   assert_param(IS_ITC_INTERRUPTS_DISABLED);
 686                     ; 234   Mask = (uint8_t)(~(uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U)));
 688  00a2 9e            	ld	a,xh
 689  00a3 a403          	and	a,#3
 690  00a5 48            	sll	a
 691  00a6 5f            	clrw	x
 692  00a7 97            	ld	xl,a
 693  00a8 a603          	ld	a,#3
 694  00aa 5d            	tnzw	x
 695  00ab 2704          	jreq	L23
 696  00ad               L43:
 697  00ad 48            	sll	a
 698  00ae 5a            	decw	x
 699  00af 26fc          	jrne	L43
 700  00b1               L23:
 701  00b1 43            	cpl	a
 702  00b2 6b01          	ld	(OFST-1,sp),a
 704                     ; 237   NewPriority = (uint8_t)((uint8_t)(PriorityValue) << (((uint8_t)IrqNum % 4U) * 2U));
 706  00b4 7b03          	ld	a,(OFST+1,sp)
 707  00b6 a403          	and	a,#3
 708  00b8 48            	sll	a
 709  00b9 5f            	clrw	x
 710  00ba 97            	ld	xl,a
 711  00bb 7b04          	ld	a,(OFST+2,sp)
 712  00bd 5d            	tnzw	x
 713  00be 2704          	jreq	L63
 714  00c0               L04:
 715  00c0 48            	sll	a
 716  00c1 5a            	decw	x
 717  00c2 26fc          	jrne	L04
 718  00c4               L63:
 719  00c4 6b02          	ld	(OFST+0,sp),a
 721                     ; 239   switch (IrqNum)
 723  00c6 7b03          	ld	a,(OFST+1,sp)
 725                     ; 329   default:
 725                     ; 330     break;
 726  00c8 a119          	cp	a,#25
 727  00ca 2407          	jruge	L24
 728  00cc 5f            	clrw	x
 729  00cd 97            	ld	xl,a
 730  00ce 58            	sllw	x
 731  00cf de0032        	ldw	x,(L44,x)
 732  00d2 fc            	jp	(x)
 733  00d3               L24:
 734  00d3 207c          	jra	L162
 735  00d5               L502:
 736                     ; 241   case ITC_IRQ_TLI: /* TLI software priority can be written but has no meaning */
 736                     ; 242   case ITC_IRQ_AWU:
 736                     ; 243   case ITC_IRQ_CLK:
 736                     ; 244   case ITC_IRQ_PORTA:
 736                     ; 245     ITC->ISPR1 &= Mask;
 738  00d5 c67f70        	ld	a,32624
 739  00d8 1401          	and	a,(OFST-1,sp)
 740  00da c77f70        	ld	32624,a
 741                     ; 246     ITC->ISPR1 |= NewPriority;
 743  00dd c67f70        	ld	a,32624
 744  00e0 1a02          	or	a,(OFST+0,sp)
 745  00e2 c77f70        	ld	32624,a
 746                     ; 247     break;
 748  00e5 206a          	jra	L162
 749  00e7               L702:
 750                     ; 249   case ITC_IRQ_PORTB:
 750                     ; 250   case ITC_IRQ_PORTC:
 750                     ; 251   case ITC_IRQ_PORTD:
 750                     ; 252   case ITC_IRQ_PORTE:
 750                     ; 253     ITC->ISPR2 &= Mask;
 752  00e7 c67f71        	ld	a,32625
 753  00ea 1401          	and	a,(OFST-1,sp)
 754  00ec c77f71        	ld	32625,a
 755                     ; 254     ITC->ISPR2 |= NewPriority;
 757  00ef c67f71        	ld	a,32625
 758  00f2 1a02          	or	a,(OFST+0,sp)
 759  00f4 c77f71        	ld	32625,a
 760                     ; 255     break;
 762  00f7 2058          	jra	L162
 763  00f9               L112:
 764                     ; 264   case ITC_IRQ_SPI:
 764                     ; 265   case ITC_IRQ_TIM1_OVF:
 764                     ; 266     ITC->ISPR3 &= Mask;
 766  00f9 c67f72        	ld	a,32626
 767  00fc 1401          	and	a,(OFST-1,sp)
 768  00fe c77f72        	ld	32626,a
 769                     ; 267     ITC->ISPR3 |= NewPriority;
 771  0101 c67f72        	ld	a,32626
 772  0104 1a02          	or	a,(OFST+0,sp)
 773  0106 c77f72        	ld	32626,a
 774                     ; 268     break;
 776  0109 2046          	jra	L162
 777  010b               L312:
 778                     ; 270   case ITC_IRQ_TIM1_CAPCOM:
 778                     ; 271 #if defined(STM8S903) || defined(STM8AF622x) 
 778                     ; 272   case ITC_IRQ_TIM5_OVFTRI:
 778                     ; 273   case ITC_IRQ_TIM5_CAPCOM:
 778                     ; 274 #else
 778                     ; 275   case ITC_IRQ_TIM2_OVF:
 778                     ; 276   case ITC_IRQ_TIM2_CAPCOM:
 778                     ; 277 #endif /*STM8S903 or STM8AF622x */
 778                     ; 278   case ITC_IRQ_TIM3_OVF:
 778                     ; 279     ITC->ISPR4 &= Mask;
 780  010b c67f73        	ld	a,32627
 781  010e 1401          	and	a,(OFST-1,sp)
 782  0110 c77f73        	ld	32627,a
 783                     ; 280     ITC->ISPR4 |= NewPriority;
 785  0113 c67f73        	ld	a,32627
 786  0116 1a02          	or	a,(OFST+0,sp)
 787  0118 c77f73        	ld	32627,a
 788                     ; 281     break;
 790  011b 2034          	jra	L162
 791  011d               L512:
 792                     ; 283   case ITC_IRQ_TIM3_CAPCOM:
 792                     ; 284 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 792                     ; 285     defined(STM8S003) ||defined(STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 792                     ; 286   case ITC_IRQ_UART1_TX:
 792                     ; 287   case ITC_IRQ_UART1_RX:
 792                     ; 288 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 792                     ; 289 #if defined(STM8AF622x)
 792                     ; 290   case ITC_IRQ_UART4_TX:
 792                     ; 291   case ITC_IRQ_UART4_RX:
 792                     ; 292 #endif /*STM8AF622x */
 792                     ; 293   case ITC_IRQ_I2C:
 792                     ; 294     ITC->ISPR5 &= Mask;
 794  011d c67f74        	ld	a,32628
 795  0120 1401          	and	a,(OFST-1,sp)
 796  0122 c77f74        	ld	32628,a
 797                     ; 295     ITC->ISPR5 |= NewPriority;
 799  0125 c67f74        	ld	a,32628
 800  0128 1a02          	or	a,(OFST+0,sp)
 801  012a c77f74        	ld	32628,a
 802                     ; 296     break;
 804  012d 2022          	jra	L162
 805  012f               L712:
 806                     ; 299   case ITC_IRQ_UART2_TX:
 806                     ; 300   case ITC_IRQ_UART2_RX:
 806                     ; 301 #endif /*STM8S105 or STM8AF626x */
 806                     ; 302     
 806                     ; 303 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 806                     ; 304     defined(STM8AF62Ax)
 806                     ; 305   case ITC_IRQ_UART3_TX:
 806                     ; 306   case ITC_IRQ_UART3_RX:
 806                     ; 307   case ITC_IRQ_ADC2:
 806                     ; 308 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 806                     ; 309     
 806                     ; 310 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 806                     ; 311     defined(STM8S903) || defined(STM8AF626x) || defined (STM8AF622x)
 806                     ; 312   case ITC_IRQ_ADC1:
 806                     ; 313 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S903 or STM8AF626x or STM8AF622x */
 806                     ; 314     
 806                     ; 315 #if defined (STM8S903) || defined (STM8AF622x)
 806                     ; 316   case ITC_IRQ_TIM6_OVFTRI:
 806                     ; 317 #else
 806                     ; 318   case ITC_IRQ_TIM4_OVF:
 806                     ; 319 #endif /* STM8S903 or STM8AF622x */
 806                     ; 320     ITC->ISPR6 &= Mask;
 808  012f c67f75        	ld	a,32629
 809  0132 1401          	and	a,(OFST-1,sp)
 810  0134 c77f75        	ld	32629,a
 811                     ; 321     ITC->ISPR6 |= NewPriority;
 813  0137 c67f75        	ld	a,32629
 814  013a 1a02          	or	a,(OFST+0,sp)
 815  013c c77f75        	ld	32629,a
 816                     ; 322     break;
 818  013f 2010          	jra	L162
 819  0141               L122:
 820                     ; 324   case ITC_IRQ_EEPROM_EEC:
 820                     ; 325     ITC->ISPR7 &= Mask;
 822  0141 c67f76        	ld	a,32630
 823  0144 1401          	and	a,(OFST-1,sp)
 824  0146 c77f76        	ld	32630,a
 825                     ; 326     ITC->ISPR7 |= NewPriority;
 827  0149 c67f76        	ld	a,32630
 828  014c 1a02          	or	a,(OFST+0,sp)
 829  014e c77f76        	ld	32630,a
 830                     ; 327     break;
 832  0151               L322:
 833                     ; 329   default:
 833                     ; 330     break;
 835  0151               L162:
 836                     ; 332 }
 839  0151 5b04          	addw	sp,#4
 840  0153 81            	ret
 853                     	xdef	_ITC_GetSoftwarePriority
 854                     	xdef	_ITC_SetSoftwarePriority
 855                     	xdef	_ITC_GetSoftIntStatus
 856                     	xdef	_ITC_DeInit
 857                     	xdef	_ITC_GetCPUCC
 876                     	end
