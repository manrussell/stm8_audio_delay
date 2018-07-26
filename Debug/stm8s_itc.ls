   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  46                     ; 50 uint8_t ITC_GetCPUCC(void)
  46                     ; 51 {
  48                     	switch	.text
  49  0000               _ITC_GetCPUCC:
  53                     ; 53   _asm("push cc");
  56  0000 8a            	push	cc
  58                     ; 54   _asm("pop a");
  61  0001 84            	pop	a
  63                     ; 55   return; /* Ignore compiler warning, the returned value is in A register */
  66  0002 81            	ret	
  89                     ; 80 void ITC_DeInit(void)
  89                     ; 81 {
  90                     	switch	.text
  91  0003               _ITC_DeInit:
  95                     ; 82   ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
  97  0003 35ff7f70      	mov	32624,#255
  98                     ; 83   ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
 100  0007 35ff7f71      	mov	32625,#255
 101                     ; 84   ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
 103  000b 35ff7f72      	mov	32626,#255
 104                     ; 85   ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
 106  000f 35ff7f73      	mov	32627,#255
 107                     ; 86   ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
 109  0013 35ff7f74      	mov	32628,#255
 110                     ; 87   ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
 112  0017 35ff7f75      	mov	32629,#255
 113                     ; 88   ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
 115  001b 35ff7f76      	mov	32630,#255
 116                     ; 89   ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
 118  001f 35ff7f77      	mov	32631,#255
 119                     ; 90 }
 122  0023 81            	ret	
 147                     ; 97 uint8_t ITC_GetSoftIntStatus(void)
 147                     ; 98 {
 148                     	switch	.text
 149  0024               _ITC_GetSoftIntStatus:
 153                     ; 99   return (uint8_t)(ITC_GetCPUCC() & CPU_CC_I1I0);
 155  0024 adda          	call	_ITC_GetCPUCC
 157  0026 a428          	and	a,#40
 160  0028 81            	ret	
 409                     .const:	section	.text
 410  0000               L42:
 411  0000 004a          	dc.w	L14
 412  0002 004a          	dc.w	L14
 413  0004 004a          	dc.w	L14
 414  0006 004a          	dc.w	L14
 415  0008 004f          	dc.w	L34
 416  000a 004f          	dc.w	L34
 417  000c 004f          	dc.w	L34
 418  000e 004f          	dc.w	L34
 419  0010 006f          	dc.w	L302
 420  0012 006f          	dc.w	L302
 421  0014 0054          	dc.w	L54
 422  0016 0054          	dc.w	L54
 423  0018 0059          	dc.w	L74
 424  001a 0059          	dc.w	L74
 425  001c 0059          	dc.w	L74
 426  001e 0059          	dc.w	L74
 427  0020 005e          	dc.w	L15
 428  0022 006f          	dc.w	L302
 429  0024 006f          	dc.w	L302
 430  0026 005e          	dc.w	L15
 431  0028 0063          	dc.w	L35
 432  002a 0063          	dc.w	L35
 433  002c 0063          	dc.w	L35
 434  002e 0063          	dc.w	L35
 435  0030 0068          	dc.w	L55
 436                     ; 107 ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_Irq_TypeDef IrqNum)
 436                     ; 108 {
 437                     	switch	.text
 438  0029               _ITC_GetSoftwarePriority:
 440  0029 88            	push	a
 441  002a 89            	pushw	x
 442       00000002      OFST:	set	2
 445                     ; 109   uint8_t Value = 0;
 447  002b 0f02          	clr	(OFST+0,sp)
 449                     ; 110   uint8_t Mask = 0;
 451                     ; 113   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 453                     ; 116   Mask = (uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U));
 455  002d a403          	and	a,#3
 456  002f 48            	sll	a
 457  0030 5f            	clrw	x
 458  0031 97            	ld	xl,a
 459  0032 a603          	ld	a,#3
 460  0034 5d            	tnzw	x
 461  0035 2704          	jreq	L61
 462  0037               L02:
 463  0037 48            	sll	a
 464  0038 5a            	decw	x
 465  0039 26fc          	jrne	L02
 466  003b               L61:
 467  003b 6b01          	ld	(OFST-1,sp),a
 469                     ; 118   switch (IrqNum)
 471  003d 7b03          	ld	a,(OFST+1,sp)
 473                     ; 198   default:
 473                     ; 199     break;
 474  003f a119          	cp	a,#25
 475  0041 242c          	jruge	L302
 476  0043 5f            	clrw	x
 477  0044 97            	ld	xl,a
 478  0045 58            	sllw	x
 479  0046 de0000        	ldw	x,(L42,x)
 480  0049 fc            	jp	(x)
 481  004a               L14:
 482                     ; 120   case ITC_IRQ_TLI: /* TLI software priority can be read but has no meaning */
 482                     ; 121   case ITC_IRQ_AWU:
 482                     ; 122   case ITC_IRQ_CLK:
 482                     ; 123   case ITC_IRQ_PORTA:
 482                     ; 124     Value = (uint8_t)(ITC->ISPR1 & Mask); /* Read software priority */
 484  004a c67f70        	ld	a,32624
 485                     ; 125     break;
 487  004d 201c          	jp	LC001
 488  004f               L34:
 489                     ; 127   case ITC_IRQ_PORTB:
 489                     ; 128   case ITC_IRQ_PORTC:
 489                     ; 129   case ITC_IRQ_PORTD:
 489                     ; 130   case ITC_IRQ_PORTE:
 489                     ; 131     Value = (uint8_t)(ITC->ISPR2 & Mask); /* Read software priority */
 491  004f c67f71        	ld	a,32625
 492                     ; 132     break;
 494  0052 2017          	jp	LC001
 495  0054               L54:
 496                     ; 141   case ITC_IRQ_SPI:
 496                     ; 142   case ITC_IRQ_TIM1_OVF:
 496                     ; 143     Value = (uint8_t)(ITC->ISPR3 & Mask); /* Read software priority */
 498  0054 c67f72        	ld	a,32626
 499                     ; 144     break;
 501  0057 2012          	jp	LC001
 502  0059               L74:
 503                     ; 146   case ITC_IRQ_TIM1_CAPCOM:
 503                     ; 147 #if defined (STM8S903) || defined (STM8AF622x)
 503                     ; 148   case ITC_IRQ_TIM5_OVFTRI:
 503                     ; 149   case ITC_IRQ_TIM5_CAPCOM:
 503                     ; 150 #else
 503                     ; 151   case ITC_IRQ_TIM2_OVF:
 503                     ; 152   case ITC_IRQ_TIM2_CAPCOM:
 503                     ; 153 #endif /* STM8S903 or STM8AF622x*/
 503                     ; 154   case ITC_IRQ_TIM3_OVF:
 503                     ; 155     Value = (uint8_t)(ITC->ISPR4 & Mask); /* Read software priority */
 505  0059 c67f73        	ld	a,32627
 506                     ; 156     break;
 508  005c 200d          	jp	LC001
 509  005e               L15:
 510                     ; 158   case ITC_IRQ_TIM3_CAPCOM:
 510                     ; 159 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 510                     ; 160     defined(STM8S003) ||defined(STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 510                     ; 161   case ITC_IRQ_UART1_TX:
 510                     ; 162   case ITC_IRQ_UART1_RX:
 510                     ; 163 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 510                     ; 164 #if defined(STM8AF622x)
 510                     ; 165   case ITC_IRQ_UART4_TX:
 510                     ; 166   case ITC_IRQ_UART4_RX:
 510                     ; 167 #endif /*STM8AF622x */
 510                     ; 168   case ITC_IRQ_I2C:
 510                     ; 169     Value = (uint8_t)(ITC->ISPR5 & Mask); /* Read software priority */
 512  005e c67f74        	ld	a,32628
 513                     ; 170     break;
 515  0061 2008          	jp	LC001
 516  0063               L35:
 517                     ; 173   case ITC_IRQ_UART2_TX:
 517                     ; 174   case ITC_IRQ_UART2_RX:
 517                     ; 175 #endif /*STM8S105 or STM8AF626x*/
 517                     ; 176 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 517                     ; 177     defined(STM8AF62Ax)
 517                     ; 178   case ITC_IRQ_UART3_TX:
 517                     ; 179   case ITC_IRQ_UART3_RX:
 517                     ; 180   case ITC_IRQ_ADC2:
 517                     ; 181 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 517                     ; 182 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 517                     ; 183     defined(STM8S903) || defined(STM8AF626x) || defined(STM8AF622x)
 517                     ; 184   case ITC_IRQ_ADC1:
 517                     ; 185 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S903 or STM8AF626x or STM8AF622x */
 517                     ; 186 #if defined (STM8S903) || defined (STM8AF622x)
 517                     ; 187   case ITC_IRQ_TIM6_OVFTRI:
 517                     ; 188 #else
 517                     ; 189   case ITC_IRQ_TIM4_OVF:
 517                     ; 190 #endif /*STM8S903 or STM8AF622x */
 517                     ; 191     Value = (uint8_t)(ITC->ISPR6 & Mask); /* Read software priority */
 519  0063 c67f75        	ld	a,32629
 520                     ; 192     break;
 522  0066 2003          	jp	LC001
 523  0068               L55:
 524                     ; 194   case ITC_IRQ_EEPROM_EEC:
 524                     ; 195     Value = (uint8_t)(ITC->ISPR7 & Mask); /* Read software priority */
 526  0068 c67f76        	ld	a,32630
 527  006b               LC001:
 528  006b 1401          	and	a,(OFST-1,sp)
 529  006d 6b02          	ld	(OFST+0,sp),a
 531                     ; 196     break;
 533                     ; 198   default:
 533                     ; 199     break;
 535  006f               L302:
 536                     ; 202   Value >>= (uint8_t)(((uint8_t)IrqNum % 4u) * 2u);
 538  006f 7b03          	ld	a,(OFST+1,sp)
 539  0071 a403          	and	a,#3
 540  0073 48            	sll	a
 541  0074 5f            	clrw	x
 542  0075 97            	ld	xl,a
 543  0076 7b02          	ld	a,(OFST+0,sp)
 544  0078 5d            	tnzw	x
 545  0079 2704          	jreq	L62
 546  007b               L03:
 547  007b 44            	srl	a
 548  007c 5a            	decw	x
 549  007d 26fc          	jrne	L03
 550  007f               L62:
 552                     ; 204   return((ITC_PriorityLevel_TypeDef)Value);
 556  007f 5b03          	addw	sp,#3
 557  0081 81            	ret	
 621                     	switch	.const
 622  0032               L64:
 623  0032 00b8          	dc.w	L502
 624  0034 00b8          	dc.w	L502
 625  0036 00b8          	dc.w	L502
 626  0038 00b8          	dc.w	L502
 627  003a 00ca          	dc.w	L702
 628  003c 00ca          	dc.w	L702
 629  003e 00ca          	dc.w	L702
 630  0040 00ca          	dc.w	L702
 631  0042 0134          	dc.w	L162
 632  0044 0134          	dc.w	L162
 633  0046 00dc          	dc.w	L112
 634  0048 00dc          	dc.w	L112
 635  004a 00ee          	dc.w	L312
 636  004c 00ee          	dc.w	L312
 637  004e 00ee          	dc.w	L312
 638  0050 00ee          	dc.w	L312
 639  0052 0100          	dc.w	L512
 640  0054 0134          	dc.w	L162
 641  0056 0134          	dc.w	L162
 642  0058 0100          	dc.w	L512
 643  005a 0112          	dc.w	L712
 644  005c 0112          	dc.w	L712
 645  005e 0112          	dc.w	L712
 646  0060 0112          	dc.w	L712
 647  0062 0124          	dc.w	L122
 648                     ; 220 void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
 648                     ; 221 {
 649                     	switch	.text
 650  0082               _ITC_SetSoftwarePriority:
 652  0082 89            	pushw	x
 653  0083 89            	pushw	x
 654       00000002      OFST:	set	2
 657                     ; 222   uint8_t Mask = 0;
 659                     ; 223   uint8_t NewPriority = 0;
 661                     ; 226   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 663                     ; 227   assert_param(IS_ITC_PRIORITY_OK(PriorityValue));
 665                     ; 230   assert_param(IS_ITC_INTERRUPTS_DISABLED);
 667                     ; 234   Mask = (uint8_t)(~(uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U)));
 669  0084 9e            	ld	a,xh
 670  0085 a403          	and	a,#3
 671  0087 48            	sll	a
 672  0088 5f            	clrw	x
 673  0089 97            	ld	xl,a
 674  008a a603          	ld	a,#3
 675  008c 5d            	tnzw	x
 676  008d 2704          	jreq	L43
 677  008f               L63:
 678  008f 48            	sll	a
 679  0090 5a            	decw	x
 680  0091 26fc          	jrne	L63
 681  0093               L43:
 682  0093 43            	cpl	a
 683  0094 6b01          	ld	(OFST-1,sp),a
 685                     ; 237   NewPriority = (uint8_t)((uint8_t)(PriorityValue) << (((uint8_t)IrqNum % 4U) * 2U));
 687  0096 7b03          	ld	a,(OFST+1,sp)
 688  0098 a403          	and	a,#3
 689  009a 48            	sll	a
 690  009b 5f            	clrw	x
 691  009c 97            	ld	xl,a
 692  009d 7b04          	ld	a,(OFST+2,sp)
 693  009f 5d            	tnzw	x
 694  00a0 2704          	jreq	L04
 695  00a2               L24:
 696  00a2 48            	sll	a
 697  00a3 5a            	decw	x
 698  00a4 26fc          	jrne	L24
 699  00a6               L04:
 700  00a6 6b02          	ld	(OFST+0,sp),a
 702                     ; 239   switch (IrqNum)
 704  00a8 7b03          	ld	a,(OFST+1,sp)
 706                     ; 329   default:
 706                     ; 330     break;
 707  00aa a119          	cp	a,#25
 708  00ac 2503cc0134    	jruge	L162
 709  00b1 5f            	clrw	x
 710  00b2 97            	ld	xl,a
 711  00b3 58            	sllw	x
 712  00b4 de0032        	ldw	x,(L64,x)
 713  00b7 fc            	jp	(x)
 714  00b8               L502:
 715                     ; 241   case ITC_IRQ_TLI: /* TLI software priority can be written but has no meaning */
 715                     ; 242   case ITC_IRQ_AWU:
 715                     ; 243   case ITC_IRQ_CLK:
 715                     ; 244   case ITC_IRQ_PORTA:
 715                     ; 245     ITC->ISPR1 &= Mask;
 717  00b8 c67f70        	ld	a,32624
 718  00bb 1401          	and	a,(OFST-1,sp)
 719  00bd c77f70        	ld	32624,a
 720                     ; 246     ITC->ISPR1 |= NewPriority;
 722  00c0 c67f70        	ld	a,32624
 723  00c3 1a02          	or	a,(OFST+0,sp)
 724  00c5 c77f70        	ld	32624,a
 725                     ; 247     break;
 727  00c8 206a          	jra	L162
 728  00ca               L702:
 729                     ; 249   case ITC_IRQ_PORTB:
 729                     ; 250   case ITC_IRQ_PORTC:
 729                     ; 251   case ITC_IRQ_PORTD:
 729                     ; 252   case ITC_IRQ_PORTE:
 729                     ; 253     ITC->ISPR2 &= Mask;
 731  00ca c67f71        	ld	a,32625
 732  00cd 1401          	and	a,(OFST-1,sp)
 733  00cf c77f71        	ld	32625,a
 734                     ; 254     ITC->ISPR2 |= NewPriority;
 736  00d2 c67f71        	ld	a,32625
 737  00d5 1a02          	or	a,(OFST+0,sp)
 738  00d7 c77f71        	ld	32625,a
 739                     ; 255     break;
 741  00da 2058          	jra	L162
 742  00dc               L112:
 743                     ; 264   case ITC_IRQ_SPI:
 743                     ; 265   case ITC_IRQ_TIM1_OVF:
 743                     ; 266     ITC->ISPR3 &= Mask;
 745  00dc c67f72        	ld	a,32626
 746  00df 1401          	and	a,(OFST-1,sp)
 747  00e1 c77f72        	ld	32626,a
 748                     ; 267     ITC->ISPR3 |= NewPriority;
 750  00e4 c67f72        	ld	a,32626
 751  00e7 1a02          	or	a,(OFST+0,sp)
 752  00e9 c77f72        	ld	32626,a
 753                     ; 268     break;
 755  00ec 2046          	jra	L162
 756  00ee               L312:
 757                     ; 270   case ITC_IRQ_TIM1_CAPCOM:
 757                     ; 271 #if defined(STM8S903) || defined(STM8AF622x) 
 757                     ; 272   case ITC_IRQ_TIM5_OVFTRI:
 757                     ; 273   case ITC_IRQ_TIM5_CAPCOM:
 757                     ; 274 #else
 757                     ; 275   case ITC_IRQ_TIM2_OVF:
 757                     ; 276   case ITC_IRQ_TIM2_CAPCOM:
 757                     ; 277 #endif /*STM8S903 or STM8AF622x */
 757                     ; 278   case ITC_IRQ_TIM3_OVF:
 757                     ; 279     ITC->ISPR4 &= Mask;
 759  00ee c67f73        	ld	a,32627
 760  00f1 1401          	and	a,(OFST-1,sp)
 761  00f3 c77f73        	ld	32627,a
 762                     ; 280     ITC->ISPR4 |= NewPriority;
 764  00f6 c67f73        	ld	a,32627
 765  00f9 1a02          	or	a,(OFST+0,sp)
 766  00fb c77f73        	ld	32627,a
 767                     ; 281     break;
 769  00fe 2034          	jra	L162
 770  0100               L512:
 771                     ; 283   case ITC_IRQ_TIM3_CAPCOM:
 771                     ; 284 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 771                     ; 285     defined(STM8S003) ||defined(STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 771                     ; 286   case ITC_IRQ_UART1_TX:
 771                     ; 287   case ITC_IRQ_UART1_RX:
 771                     ; 288 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 771                     ; 289 #if defined(STM8AF622x)
 771                     ; 290   case ITC_IRQ_UART4_TX:
 771                     ; 291   case ITC_IRQ_UART4_RX:
 771                     ; 292 #endif /*STM8AF622x */
 771                     ; 293   case ITC_IRQ_I2C:
 771                     ; 294     ITC->ISPR5 &= Mask;
 773  0100 c67f74        	ld	a,32628
 774  0103 1401          	and	a,(OFST-1,sp)
 775  0105 c77f74        	ld	32628,a
 776                     ; 295     ITC->ISPR5 |= NewPriority;
 778  0108 c67f74        	ld	a,32628
 779  010b 1a02          	or	a,(OFST+0,sp)
 780  010d c77f74        	ld	32628,a
 781                     ; 296     break;
 783  0110 2022          	jra	L162
 784  0112               L712:
 785                     ; 299   case ITC_IRQ_UART2_TX:
 785                     ; 300   case ITC_IRQ_UART2_RX:
 785                     ; 301 #endif /*STM8S105 or STM8AF626x */
 785                     ; 302     
 785                     ; 303 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 785                     ; 304     defined(STM8AF62Ax)
 785                     ; 305   case ITC_IRQ_UART3_TX:
 785                     ; 306   case ITC_IRQ_UART3_RX:
 785                     ; 307   case ITC_IRQ_ADC2:
 785                     ; 308 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 785                     ; 309     
 785                     ; 310 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 785                     ; 311     defined(STM8S903) || defined(STM8AF626x) || defined (STM8AF622x)
 785                     ; 312   case ITC_IRQ_ADC1:
 785                     ; 313 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S903 or STM8AF626x or STM8AF622x */
 785                     ; 314     
 785                     ; 315 #if defined (STM8S903) || defined (STM8AF622x)
 785                     ; 316   case ITC_IRQ_TIM6_OVFTRI:
 785                     ; 317 #else
 785                     ; 318   case ITC_IRQ_TIM4_OVF:
 785                     ; 319 #endif /* STM8S903 or STM8AF622x */
 785                     ; 320     ITC->ISPR6 &= Mask;
 787  0112 c67f75        	ld	a,32629
 788  0115 1401          	and	a,(OFST-1,sp)
 789  0117 c77f75        	ld	32629,a
 790                     ; 321     ITC->ISPR6 |= NewPriority;
 792  011a c67f75        	ld	a,32629
 793  011d 1a02          	or	a,(OFST+0,sp)
 794  011f c77f75        	ld	32629,a
 795                     ; 322     break;
 797  0122 2010          	jra	L162
 798  0124               L122:
 799                     ; 324   case ITC_IRQ_EEPROM_EEC:
 799                     ; 325     ITC->ISPR7 &= Mask;
 801  0124 c67f76        	ld	a,32630
 802  0127 1401          	and	a,(OFST-1,sp)
 803  0129 c77f76        	ld	32630,a
 804                     ; 326     ITC->ISPR7 |= NewPriority;
 806  012c c67f76        	ld	a,32630
 807  012f 1a02          	or	a,(OFST+0,sp)
 808  0131 c77f76        	ld	32630,a
 809                     ; 327     break;
 811                     ; 329   default:
 811                     ; 330     break;
 813  0134               L162:
 814                     ; 332 }
 817  0134 5b04          	addw	sp,#4
 818  0136 81            	ret	
 831                     	xdef	_ITC_GetSoftwarePriority
 832                     	xdef	_ITC_SetSoftwarePriority
 833                     	xdef	_ITC_GetSoftIntStatus
 834                     	xdef	_ITC_DeInit
 835                     	xdef	_ITC_GetCPUCC
 854                     	end
