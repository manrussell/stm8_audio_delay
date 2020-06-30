   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  49                     ; 47 void TIM2_UPD_IRQHandler( void )
  49                     ; 48 {
  50                     	switch	.text
  51  0000               f_TIM2_UPD_IRQHandler:
  53  0000 8a            	push	cc
  54  0001 84            	pop	a
  55  0002 a4bf          	and	a,#191
  56  0004 88            	push	a
  57  0005 86            	pop	cc
  58  0006 3b0002        	push	c_x+2
  59  0009 be00          	ldw	x,c_x
  60  000b 89            	pushw	x
  61  000c 3b0002        	push	c_y+2
  62  000f be00          	ldw	x,c_y
  65                     ; 49     state++;
  67  0011 3c00          	inc	_state
  68  0013 89            	pushw	x
  69                     ; 50     if ( 10 <= state ) state = 0;
  71  0014 b600          	ld	a,_state
  72  0016 a10a          	cp	a,#10
  73  0018 2502          	jrult	L12
  76  001a 3f00          	clr	_state
  77  001c               L12:
  78                     ; 51     TIM2_ClearFlag(TIM2_FLAG_UPDATE);
  80  001c ae0001        	ldw	x,#1
  81  001f cd0000        	call	_TIM2_ClearFlag
  83                     ; 52 }
  86  0022 85            	popw	x
  87  0023 bf00          	ldw	c_y,x
  88  0025 320002        	pop	c_y+2
  89  0028 85            	popw	x
  90  0029 bf00          	ldw	c_x,x
  91  002b 320002        	pop	c_x+2
  92  002e 80            	iret	
 115                     ; 64 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 115                     ; 65 {
 116                     	switch	.text
 117  002f               f_NonHandledInterrupt:
 121                     ; 69 }
 124  002f 80            	iret	
 146                     ; 77 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 146                     ; 78 {
 147                     	switch	.text
 148  0030               f_TRAP_IRQHandler:
 152                     ; 82 }
 155  0030 80            	iret	
 177                     ; 89 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 177                     ; 90 
 177                     ; 91 {
 178                     	switch	.text
 179  0031               f_TLI_IRQHandler:
 183                     ; 95 }
 186  0031 80            	iret	
 208                     ; 102 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 208                     ; 103 {
 209                     	switch	.text
 210  0032               f_AWU_IRQHandler:
 214                     ; 107 }
 217  0032 80            	iret	
 239                     ; 114 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 239                     ; 115 {
 240                     	switch	.text
 241  0033               f_CLK_IRQHandler:
 245                     ; 119 }
 248  0033 80            	iret	
 271                     ; 126 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 271                     ; 127 {
 272                     	switch	.text
 273  0034               f_EXTI_PORTA_IRQHandler:
 277                     ; 131 }
 280  0034 80            	iret	
 303                     ; 138 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 303                     ; 139 {
 304                     	switch	.text
 305  0035               f_EXTI_PORTB_IRQHandler:
 309                     ; 143 }
 312  0035 80            	iret	
 335                     ; 150 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 335                     ; 151 {
 336                     	switch	.text
 337  0036               f_EXTI_PORTC_IRQHandler:
 341                     ; 155 }
 344  0036 80            	iret	
 367                     ; 162 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 367                     ; 163 {
 368                     	switch	.text
 369  0037               f_EXTI_PORTD_IRQHandler:
 373                     ; 167 }
 376  0037 80            	iret	
 399                     ; 174 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 399                     ; 175 {
 400                     	switch	.text
 401  0038               f_EXTI_PORTE_IRQHandler:
 405                     ; 179 }
 408  0038 80            	iret	
 430                     ; 226 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 430                     ; 227 {
 431                     	switch	.text
 432  0039               f_SPI_IRQHandler:
 436                     ; 231 }
 439  0039 80            	iret	
 462                     ; 238 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 462                     ; 239 {
 463                     	switch	.text
 464  003a               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 468                     ; 243 }
 471  003a 80            	iret	
 494                     ; 250 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 494                     ; 251 {
 495                     	switch	.text
 496  003b               f_TIM1_CAP_COM_IRQHandler:
 500                     ; 255 }
 503  003b 80            	iret	
 526                     ; 288  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 526                     ; 289  {
 527                     	switch	.text
 528  003c               f_TIM2_UPD_OVF_BRK_IRQHandler:
 532                     ; 293  }
 535  003c 80            	iret	
 558                     ; 300  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 558                     ; 301  {
 559                     	switch	.text
 560  003d               f_TIM2_CAP_COM_IRQHandler:
 564                     ; 305  }
 567  003d 80            	iret	
 590                     ; 315  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 590                     ; 316  {
 591                     	switch	.text
 592  003e               f_TIM3_UPD_OVF_BRK_IRQHandler:
 596                     ; 320  }
 599  003e 80            	iret	
 622                     ; 327  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 622                     ; 328  {
 623                     	switch	.text
 624  003f               f_TIM3_CAP_COM_IRQHandler:
 628                     ; 332  }
 631  003f 80            	iret	
 653                     ; 393 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 653                     ; 394 {
 654                     	switch	.text
 655  0040               f_I2C_IRQHandler:
 659                     ; 398 }
 662  0040 80            	iret	
 685                     ; 406  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 685                     ; 407  {
 686                     	switch	.text
 687  0041               f_UART2_TX_IRQHandler:
 691                     ; 411  }
 694  0041 80            	iret	
 717                     ; 418  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 717                     ; 419  {
 718                     	switch	.text
 719  0042               f_UART2_RX_IRQHandler:
 723                     ; 423  }
 726  0042 80            	iret	
 748                     ; 472  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 748                     ; 473  {
 749                     	switch	.text
 750  0043               f_ADC1_IRQHandler:
 754                     ; 477  }
 757  0043 80            	iret	
 780                     ; 498  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 780                     ; 499  {
 781                     	switch	.text
 782  0044               f_TIM4_UPD_OVF_IRQHandler:
 786                     ; 503  }
 789  0044 80            	iret	
 812                     ; 511 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 812                     ; 512 {
 813                     	switch	.text
 814  0045               f_EEPROM_EEC_IRQHandler:
 818                     ; 516 }
 821  0045 80            	iret	
 833                     	xref.b	_state
 834                     	xdef	f_EEPROM_EEC_IRQHandler
 835                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 836                     	xdef	f_ADC1_IRQHandler
 837                     	xdef	f_UART2_TX_IRQHandler
 838                     	xdef	f_UART2_RX_IRQHandler
 839                     	xdef	f_I2C_IRQHandler
 840                     	xdef	f_TIM3_CAP_COM_IRQHandler
 841                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 842                     	xdef	f_TIM2_CAP_COM_IRQHandler
 843                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 844                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 845                     	xdef	f_TIM1_CAP_COM_IRQHandler
 846                     	xdef	f_SPI_IRQHandler
 847                     	xdef	f_EXTI_PORTE_IRQHandler
 848                     	xdef	f_EXTI_PORTD_IRQHandler
 849                     	xdef	f_EXTI_PORTC_IRQHandler
 850                     	xdef	f_EXTI_PORTB_IRQHandler
 851                     	xdef	f_EXTI_PORTA_IRQHandler
 852                     	xdef	f_CLK_IRQHandler
 853                     	xdef	f_AWU_IRQHandler
 854                     	xdef	f_TLI_IRQHandler
 855                     	xdef	f_TRAP_IRQHandler
 856                     	xdef	f_NonHandledInterrupt
 857                     	xref	_TIM2_ClearFlag
 858                     	xdef	f_TIM2_UPD_IRQHandler
 859                     	xref.b	c_x
 860                     	xref.b	c_y
 879                     	end
