   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  67                     ; 18 void delay_us_old( unsigned int value )
  67                     ; 19 {
  69                     	switch	.text
  70  0000               _delay_us_old:
  72  0000 89            	pushw	x
  73       00000002      OFST:	set	2
  76                     ; 20     register unsigned int loops = ( dly_const * value );
  78  0001 cd0000        	call	c_uitof
  80  0004 ae0000        	ldw	x,#L73
  81  0007 cd0000        	call	c_fmul
  83  000a cd0000        	call	c_ftoi
  86  000d 2002          	jra	L74
  87  000f               L34:
  88                     ; 24         _asm ("nop");
  91  000f 9d            	nop	
  93                     ; 25         loops--;
  95  0010 5a            	decw	x
  96  0011               L74:
  97  0011 1f01          	ldw	(OFST-1,sp),x
  99                     ; 22     while(loops)
 101  0013 26fa          	jrne	L34
 102                     ; 27 }
 106  0015 85            	popw	x
 107  0016 81            	ret	
 142                     ; 29 void delay_ms_old( unsigned int value )
 142                     ; 30 {
 143                     	switch	.text
 144  0017               _delay_ms_old:
 146  0017 89            	pushw	x
 147       00000000      OFST:	set	0
 150  0018 200a          	jra	L37
 151  001a               L17:
 152                     ; 33         delay_us(1000);
 154  001a ae03e8        	ldw	x,#1000
 155  001d ad0b          	call	_delay_us
 157                     ; 34         value--;
 159  001f 1e01          	ldw	x,(OFST+1,sp)
 160  0021 5a            	decw	x
 161  0022 1f01          	ldw	(OFST+1,sp),x
 162  0024               L37:
 163                     ; 31     while(value)
 165  0024 1e01          	ldw	x,(OFST+1,sp)
 166  0026 26f2          	jrne	L17
 167                     ; 36 }
 171  0028 85            	popw	x
 172  0029 81            	ret	
 211                     ; 41 void delay_us( unsigned int us )
 211                     ; 42 {
 212                     	switch	.text
 213  002a               _delay_us:
 215  002a 89            	pushw	x
 216       00000000      OFST:	set	0
 219                     ; 43     TIM4_DeInit();
 221  002b cd0000        	call	_TIM4_DeInit
 223                     ; 45     if((us <= 200) && (us >= 0))
 225  002e 1e01          	ldw	x,(OFST+1,sp)
 226  0030 a300c9        	cpw	x,#201
 227  0033 2405          	jruge	L511
 228                     ; 47         TIM4_TimeBaseInit(TIM4_PRESCALER_16, 200);
 230  0035 ae04c8        	ldw	x,#1224
 232                     ; 48         TIM4_Cmd(ENABLE);
 235  0038 2041          	jp	LC001
 236  003a               L511:
 237                     ; 50     else if((us <= 400) && (us > 200))
 239  003a a30191        	cpw	x,#401
 240  003d 240e          	jruge	L121
 242  003f a300c9        	cpw	x,#201
 243  0042 2509          	jrult	L121
 244                     ; 52         us >>= 1;
 246  0044 0401          	srl	(OFST+1,sp)
 247                     ; 53         TIM4_TimeBaseInit(TIM4_PRESCALER_32, 200);
 249  0046 ae05c8        	ldw	x,#1480
 250  0049 0602          	rrc	(OFST+2,sp)
 252                     ; 54         TIM4_Cmd(ENABLE);
 255  004b 202e          	jp	LC001
 256  004d               L121:
 257                     ; 56     else if((us <= 800) && (us > 400))
 259  004d a30321        	cpw	x,#801
 260  0050 2413          	jruge	L521
 262  0052 a30191        	cpw	x,#401
 263  0055 250e          	jrult	L521
 264                     ; 58         us >>= 2;
 266  0057 a602          	ld	a,#2
 267  0059               L62:
 268  0059 0401          	srl	(OFST+1,sp)
 269  005b 0602          	rrc	(OFST+2,sp)
 270  005d 4a            	dec	a
 271  005e 26f9          	jrne	L62
 272                     ; 59         TIM4_TimeBaseInit(TIM4_PRESCALER_64, 200);
 274  0060 ae06c8        	ldw	x,#1736
 276                     ; 60         TIM4_Cmd(ENABLE);
 279  0063 2016          	jp	LC001
 280  0065               L521:
 281                     ; 62     else if((us <= 1600) && (us > 800))
 283  0065 a30641        	cpw	x,#1601
 284  0068 2419          	jruge	L531
 286  006a a30321        	cpw	x,#801
 287  006d 2514          	jrult	L531
 288                     ; 64         us >>= 3;
 290  006f a603          	ld	a,#3
 291  0071               L43:
 292  0071 0401          	srl	(OFST+1,sp)
 293  0073 0602          	rrc	(OFST+2,sp)
 294  0075 4a            	dec	a
 295  0076 26f9          	jrne	L43
 296                     ; 65         TIM4_TimeBaseInit(TIM4_PRESCALER_128, 200);
 298  0078 ae07c8        	ldw	x,#1992
 300                     ; 66         TIM4_Cmd(ENABLE);
 302  007b               LC001:
 303  007b cd0000        	call	_TIM4_TimeBaseInit
 307  007e a601          	ld	a,#1
 308  0080 cd0000        	call	_TIM4_Cmd
 310  0083               L531:
 311                     ; 69     while(TIM4_GetCounter() < us);
 313  0083 cd0000        	call	_TIM4_GetCounter
 315  0086 5f            	clrw	x
 316  0087 97            	ld	xl,a
 317  0088 1301          	cpw	x,(OFST+1,sp)
 318  008a 25f7          	jrult	L531
 319                     ; 70     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 321  008c a601          	ld	a,#1
 322  008e cd0000        	call	_TIM4_ClearFlag
 324                     ; 71     TIM4_Cmd(DISABLE);
 326  0091 4f            	clr	a
 327  0092 cd0000        	call	_TIM4_Cmd
 329                     ; 72 }
 332  0095 85            	popw	x
 333  0096 81            	ret	
 368                     ; 76 void delay_ms( unsigned int ms )
 368                     ; 77 {
 369                     	switch	.text
 370  0097               _delay_ms:
 372  0097 89            	pushw	x
 373       00000000      OFST:	set	0
 376  0098 2005          	jra	L161
 377  009a               L751:
 378                     ; 80         delay_us(1000);
 380  009a ae03e8        	ldw	x,#1000
 381  009d ad8b          	call	_delay_us
 383  009f               L161:
 384                     ; 78     while(ms--)
 386  009f 1e01          	ldw	x,(OFST+1,sp)
 387  00a1 5a            	decw	x
 388  00a2 1f01          	ldw	(OFST+1,sp),x
 389  00a4 5c            	incw	x
 390  00a5 26f3          	jrne	L751
 391                     ; 82 }
 395  00a7 85            	popw	x
 396  00a8 81            	ret	
 409                     	xdef	_delay_ms_old
 410                     	xdef	_delay_us_old
 411                     	xdef	_delay_ms
 412                     	xdef	_delay_us
 413                     	xref	_TIM4_ClearFlag
 414                     	xref	_TIM4_GetCounter
 415                     	xref	_TIM4_Cmd
 416                     	xref	_TIM4_TimeBaseInit
 417                     	xref	_TIM4_DeInit
 418                     .const:	section	.text
 419  0000               L73:
 420  0000 3e000000      	dc.w	15872,0
 421                     	xref.b	c_x
 441                     	xref	c_ftoi
 442                     	xref	c_fmul
 443                     	xref	c_uitof
 444                     	end
