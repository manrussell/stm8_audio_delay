   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
 112                     ; 53 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 112                     ; 54 {
 114                     	switch	.text
 115  0000               _GPIO_DeInit:
 119                     ; 55   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 121  0000 7f            	clr	(x)
 122                     ; 56   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 124  0001 6f02          	clr	(2,x)
 125                     ; 57   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 127  0003 6f03          	clr	(3,x)
 128                     ; 58   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 130  0005 6f04          	clr	(4,x)
 131                     ; 59 }
 134  0007 81            	ret	
 374                     ; 71 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 374                     ; 72 {
 375                     	switch	.text
 376  0008               _GPIO_Init:
 378  0008 89            	pushw	x
 379       00000000      OFST:	set	0
 382                     ; 77   assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 384                     ; 78   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 386                     ; 81   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 388  0009 7b05          	ld	a,(OFST+5,sp)
 389  000b 43            	cpl	a
 390  000c e404          	and	a,(4,x)
 391  000e e704          	ld	(4,x),a
 392                     ; 87   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 394  0010 7b06          	ld	a,(OFST+6,sp)
 395  0012 2a16          	jrpl	L771
 396                     ; 89     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 398  0014 a510          	bcp	a,#16
 399  0016 2705          	jreq	L102
 400                     ; 91       GPIOx->ODR |= (uint8_t)GPIO_Pin;
 402  0018 f6            	ld	a,(x)
 403  0019 1a05          	or	a,(OFST+5,sp)
 405  001b 2004          	jra	L302
 406  001d               L102:
 407                     ; 95       GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 409  001d 7b05          	ld	a,(OFST+5,sp)
 410  001f 43            	cpl	a
 411  0020 f4            	and	a,(x)
 412  0021               L302:
 413  0021 f7            	ld	(x),a
 414                     ; 98     GPIOx->DDR |= (uint8_t)GPIO_Pin;
 416  0022 1e01          	ldw	x,(OFST+1,sp)
 417  0024 e602          	ld	a,(2,x)
 418  0026 1a05          	or	a,(OFST+5,sp)
 420  0028 2005          	jra	L502
 421  002a               L771:
 422                     ; 103     GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 424  002a 7b05          	ld	a,(OFST+5,sp)
 425  002c 43            	cpl	a
 426  002d e402          	and	a,(2,x)
 427  002f               L502:
 428  002f e702          	ld	(2,x),a
 429                     ; 110   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 431  0031 7b06          	ld	a,(OFST+6,sp)
 432  0033 a540          	bcp	a,#64
 433  0035 2706          	jreq	L702
 434                     ; 112     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 436  0037 e603          	ld	a,(3,x)
 437  0039 1a05          	or	a,(OFST+5,sp)
 439  003b 2005          	jra	L112
 440  003d               L702:
 441                     ; 116     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 443  003d 7b05          	ld	a,(OFST+5,sp)
 444  003f 43            	cpl	a
 445  0040 e403          	and	a,(3,x)
 446  0042               L112:
 447  0042 e703          	ld	(3,x),a
 448                     ; 123   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 450  0044 7b06          	ld	a,(OFST+6,sp)
 451  0046 a520          	bcp	a,#32
 452  0048 2706          	jreq	L312
 453                     ; 125     GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 455  004a e604          	ld	a,(4,x)
 456  004c 1a05          	or	a,(OFST+5,sp)
 458  004e 2005          	jra	L512
 459  0050               L312:
 460                     ; 129     GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 462  0050 7b05          	ld	a,(OFST+5,sp)
 463  0052 43            	cpl	a
 464  0053 e404          	and	a,(4,x)
 465  0055               L512:
 466  0055 e704          	ld	(4,x),a
 467                     ; 131 }
 470  0057 85            	popw	x
 471  0058 81            	ret	
 517                     ; 141 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 517                     ; 142 {
 518                     	switch	.text
 519  0059               _GPIO_Write:
 521       fffffffe      OFST: set -2
 524                     ; 143   GPIOx->ODR = PortVal;
 526  0059 7b03          	ld	a,(OFST+5,sp)
 527  005b f7            	ld	(x),a
 528                     ; 144 }
 531  005c 81            	ret	
 578                     ; 154 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 578                     ; 155 {
 579                     	switch	.text
 580  005d               _GPIO_WriteHigh:
 582       fffffffe      OFST: set -2
 585                     ; 156   GPIOx->ODR |= (uint8_t)PortPins;
 587  005d f6            	ld	a,(x)
 588  005e 1a03          	or	a,(OFST+5,sp)
 589  0060 f7            	ld	(x),a
 590                     ; 157 }
 593  0061 81            	ret	
 640                     ; 167 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 640                     ; 168 {
 641                     	switch	.text
 642  0062               _GPIO_WriteLow:
 644       fffffffe      OFST: set -2
 647                     ; 169   GPIOx->ODR &= (uint8_t)(~PortPins);
 649  0062 7b03          	ld	a,(OFST+5,sp)
 650  0064 43            	cpl	a
 651  0065 f4            	and	a,(x)
 652  0066 f7            	ld	(x),a
 653                     ; 170 }
 656  0067 81            	ret	
 703                     ; 180 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 703                     ; 181 {
 704                     	switch	.text
 705  0068               _GPIO_WriteReverse:
 707       fffffffe      OFST: set -2
 710                     ; 182   GPIOx->ODR ^= (uint8_t)PortPins;
 712  0068 f6            	ld	a,(x)
 713  0069 1803          	xor	a,(OFST+5,sp)
 714  006b f7            	ld	(x),a
 715                     ; 183 }
 718  006c 81            	ret	
 756                     ; 191 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 756                     ; 192 {
 757                     	switch	.text
 758  006d               _GPIO_ReadOutputData:
 762                     ; 193   return ((uint8_t)GPIOx->ODR);
 764  006d f6            	ld	a,(x)
 767  006e 81            	ret	
 804                     ; 202 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 804                     ; 203 {
 805                     	switch	.text
 806  006f               _GPIO_ReadInputData:
 810                     ; 204   return ((uint8_t)GPIOx->IDR);
 812  006f e601          	ld	a,(1,x)
 815  0071 81            	ret	
 883                     ; 213 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 883                     ; 214 {
 884                     	switch	.text
 885  0072               _GPIO_ReadInputPin:
 887       fffffffe      OFST: set -2
 890                     ; 215   return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 892  0072 e601          	ld	a,(1,x)
 893  0074 1403          	and	a,(OFST+5,sp)
 896  0076 81            	ret	
 974                     ; 225 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 974                     ; 226 {
 975                     	switch	.text
 976  0077               _GPIO_ExternalPullUpConfig:
 978       fffffffe      OFST: set -2
 981                     ; 228   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 983                     ; 229   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 985                     ; 231   if (NewState != DISABLE) /* External Pull-Up Set*/
 987  0077 7b04          	ld	a,(OFST+6,sp)
 988  0079 2706          	jreq	L374
 989                     ; 233     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 991  007b e603          	ld	a,(3,x)
 992  007d 1a03          	or	a,(OFST+5,sp)
 994  007f 2005          	jra	L574
 995  0081               L374:
 996                     ; 236     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 998  0081 7b03          	ld	a,(OFST+5,sp)
 999  0083 43            	cpl	a
1000  0084 e403          	and	a,(3,x)
1001  0086               L574:
1002  0086 e703          	ld	(3,x),a
1003                     ; 238 }
1006  0088 81            	ret	
1019                     	xdef	_GPIO_ExternalPullUpConfig
1020                     	xdef	_GPIO_ReadInputPin
1021                     	xdef	_GPIO_ReadOutputData
1022                     	xdef	_GPIO_ReadInputData
1023                     	xdef	_GPIO_WriteReverse
1024                     	xdef	_GPIO_WriteLow
1025                     	xdef	_GPIO_WriteHigh
1026                     	xdef	_GPIO_Write
1027                     	xdef	_GPIO_Init
1028                     	xdef	_GPIO_DeInit
1047                     	end
