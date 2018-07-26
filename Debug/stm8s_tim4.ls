   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  46                     ; 49 void TIM4_DeInit(void)
  46                     ; 50 {
  48                     	switch	.text
  49  0000               _TIM4_DeInit:
  53                     ; 51   TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  55  0000 725f5340      	clr	21312
  56                     ; 52   TIM4->IER = TIM4_IER_RESET_VALUE;
  58  0004 725f5341      	clr	21313
  59                     ; 53   TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  61  0008 725f5344      	clr	21316
  62                     ; 54   TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  64  000c 725f5345      	clr	21317
  65                     ; 55   TIM4->ARR = TIM4_ARR_RESET_VALUE;
  67  0010 35ff5346      	mov	21318,#255
  68                     ; 56   TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  70  0014 725f5342      	clr	21314
  71                     ; 57 }
  74  0018 81            	ret	
 180                     ; 65 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
 180                     ; 66 {
 181                     	switch	.text
 182  0019               _TIM4_TimeBaseInit:
 186                     ; 68   assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 188                     ; 70   TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
 190  0019 9e            	ld	a,xh
 191  001a c75345        	ld	21317,a
 192                     ; 72   TIM4->ARR = (uint8_t)(TIM4_Period);
 194  001d 9f            	ld	a,xl
 195  001e c75346        	ld	21318,a
 196                     ; 73 }
 199  0021 81            	ret	
 254                     ; 81 void TIM4_Cmd(FunctionalState NewState)
 254                     ; 82 {
 255                     	switch	.text
 256  0022               _TIM4_Cmd:
 260                     ; 84   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 262                     ; 87   if (NewState != DISABLE)
 264  0022 4d            	tnz	a
 265  0023 2705          	jreq	L511
 266                     ; 89     TIM4->CR1 |= TIM4_CR1_CEN;
 268  0025 72105340      	bset	21312,#0
 271  0029 81            	ret	
 272  002a               L511:
 273                     ; 93     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
 275  002a 72115340      	bres	21312,#0
 276                     ; 95 }
 279  002e 81            	ret	
 337                     ; 107 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 337                     ; 108 {
 338                     	switch	.text
 339  002f               _TIM4_ITConfig:
 341  002f 89            	pushw	x
 342       00000000      OFST:	set	0
 345                     ; 110   assert_param(IS_TIM4_IT_OK(TIM4_IT));
 347                     ; 111   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 349                     ; 113   if (NewState != DISABLE)
 351  0030 9f            	ld	a,xl
 352  0031 4d            	tnz	a
 353  0032 2706          	jreq	L151
 354                     ; 116     TIM4->IER |= (uint8_t)TIM4_IT;
 356  0034 9e            	ld	a,xh
 357  0035 ca5341        	or	a,21313
 359  0038 2006          	jra	L351
 360  003a               L151:
 361                     ; 121     TIM4->IER &= (uint8_t)(~TIM4_IT);
 363  003a 7b01          	ld	a,(OFST+1,sp)
 364  003c 43            	cpl	a
 365  003d c45341        	and	a,21313
 366  0040               L351:
 367  0040 c75341        	ld	21313,a
 368                     ; 123 }
 371  0043 85            	popw	x
 372  0044 81            	ret	
 408                     ; 131 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 408                     ; 132 {
 409                     	switch	.text
 410  0045               _TIM4_UpdateDisableConfig:
 414                     ; 134   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 416                     ; 137   if (NewState != DISABLE)
 418  0045 4d            	tnz	a
 419  0046 2705          	jreq	L371
 420                     ; 139     TIM4->CR1 |= TIM4_CR1_UDIS;
 422  0048 72125340      	bset	21312,#1
 425  004c 81            	ret	
 426  004d               L371:
 427                     ; 143     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
 429  004d 72135340      	bres	21312,#1
 430                     ; 145 }
 433  0051 81            	ret	
 491                     ; 155 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 491                     ; 156 {
 492                     	switch	.text
 493  0052               _TIM4_UpdateRequestConfig:
 497                     ; 158   assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));
 499                     ; 161   if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 501  0052 4d            	tnz	a
 502  0053 2705          	jreq	L522
 503                     ; 163     TIM4->CR1 |= TIM4_CR1_URS;
 505  0055 72145340      	bset	21312,#2
 508  0059 81            	ret	
 509  005a               L522:
 510                     ; 167     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
 512  005a 72155340      	bres	21312,#2
 513                     ; 169 }
 516  005e 81            	ret	
 573                     ; 179 void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
 573                     ; 180 {
 574                     	switch	.text
 575  005f               _TIM4_SelectOnePulseMode:
 579                     ; 182   assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));
 581                     ; 185   if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
 583  005f 4d            	tnz	a
 584  0060 2705          	jreq	L752
 585                     ; 187     TIM4->CR1 |= TIM4_CR1_OPM;
 587  0062 72165340      	bset	21312,#3
 590  0066 81            	ret	
 591  0067               L752:
 592                     ; 191     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
 594  0067 72175340      	bres	21312,#3
 595                     ; 193 }
 598  006b 81            	ret	
 666                     ; 215 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 666                     ; 216 {
 667                     	switch	.text
 668  006c               _TIM4_PrescalerConfig:
 672                     ; 218   assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
 674                     ; 219   assert_param(IS_TIM4_PRESCALER_OK(Prescaler));
 676                     ; 222   TIM4->PSCR = (uint8_t)Prescaler;
 678  006c 9e            	ld	a,xh
 679  006d c75345        	ld	21317,a
 680                     ; 225   TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
 682  0070 9f            	ld	a,xl
 683  0071 c75343        	ld	21315,a
 684                     ; 226 }
 687  0074 81            	ret	
 723                     ; 234 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 723                     ; 235 {
 724                     	switch	.text
 725  0075               _TIM4_ARRPreloadConfig:
 729                     ; 237   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 731                     ; 240   if (NewState != DISABLE)
 733  0075 4d            	tnz	a
 734  0076 2705          	jreq	L333
 735                     ; 242     TIM4->CR1 |= TIM4_CR1_ARPE;
 737  0078 721e5340      	bset	21312,#7
 740  007c 81            	ret	
 741  007d               L333:
 742                     ; 246     TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
 744  007d 721f5340      	bres	21312,#7
 745                     ; 248 }
 748  0081 81            	ret	
 797                     ; 257 void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
 797                     ; 258 {
 798                     	switch	.text
 799  0082               _TIM4_GenerateEvent:
 803                     ; 260   assert_param(IS_TIM4_EVENT_SOURCE_OK(TIM4_EventSource));
 805                     ; 263   TIM4->EGR = (uint8_t)(TIM4_EventSource);
 807  0082 c75343        	ld	21315,a
 808                     ; 264 }
 811  0085 81            	ret	
 845                     ; 272 void TIM4_SetCounter(uint8_t Counter)
 845                     ; 273 {
 846                     	switch	.text
 847  0086               _TIM4_SetCounter:
 851                     ; 275   TIM4->CNTR = (uint8_t)(Counter);
 853  0086 c75344        	ld	21316,a
 854                     ; 276 }
 857  0089 81            	ret	
 891                     ; 284 void TIM4_SetAutoreload(uint8_t Autoreload)
 891                     ; 285 {
 892                     	switch	.text
 893  008a               _TIM4_SetAutoreload:
 897                     ; 287   TIM4->ARR = (uint8_t)(Autoreload);
 899  008a c75346        	ld	21318,a
 900                     ; 288 }
 903  008d 81            	ret	
 926                     ; 295 uint8_t TIM4_GetCounter(void)
 926                     ; 296 {
 927                     	switch	.text
 928  008e               _TIM4_GetCounter:
 932                     ; 298   return (uint8_t)(TIM4->CNTR);
 934  008e c65344        	ld	a,21316
 937  0091 81            	ret	
 961                     ; 306 TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
 961                     ; 307 {
 962                     	switch	.text
 963  0092               _TIM4_GetPrescaler:
 967                     ; 309   return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
 969  0092 c65345        	ld	a,21317
 972  0095 81            	ret	
1051                     ; 319 FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
1051                     ; 320 {
1052                     	switch	.text
1053  0096               _TIM4_GetFlagStatus:
1055       00000001      OFST:	set	1
1058                     ; 321   FlagStatus bitstatus = RESET;
1060                     ; 324   assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1062                     ; 326   if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
1064  0096 c45342        	and	a,21314
1065  0099 2702          	jreq	L774
1066                     ; 328     bitstatus = SET;
1068  009b a601          	ld	a,#1
1071  009d               L774:
1072                     ; 332     bitstatus = RESET;
1075                     ; 334   return ((FlagStatus)bitstatus);
1079  009d 81            	ret	
1114                     ; 344 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
1114                     ; 345 {
1115                     	switch	.text
1116  009e               _TIM4_ClearFlag:
1120                     ; 347   assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1122                     ; 350   TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
1124  009e 43            	cpl	a
1125  009f c75342        	ld	21314,a
1126                     ; 351 }
1129  00a2 81            	ret	
1193                     ; 360 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
1193                     ; 361 {
1194                     	switch	.text
1195  00a3               _TIM4_GetITStatus:
1197  00a3 88            	push	a
1198  00a4 89            	pushw	x
1199       00000002      OFST:	set	2
1202                     ; 362   ITStatus bitstatus = RESET;
1204                     ; 364   uint8_t itstatus = 0x0, itenable = 0x0;
1208                     ; 367   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1210                     ; 369   itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
1212  00a5 c45342        	and	a,21314
1213  00a8 6b01          	ld	(OFST-1,sp),a
1215                     ; 371   itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
1217  00aa c65341        	ld	a,21313
1218  00ad 1403          	and	a,(OFST+1,sp)
1219  00af 6b02          	ld	(OFST+0,sp),a
1221                     ; 373   if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
1223  00b1 7b01          	ld	a,(OFST-1,sp)
1224  00b3 2708          	jreq	L355
1226  00b5 7b02          	ld	a,(OFST+0,sp)
1227  00b7 2704          	jreq	L355
1228                     ; 375     bitstatus = (ITStatus)SET;
1230  00b9 a601          	ld	a,#1
1233  00bb 2001          	jra	L555
1234  00bd               L355:
1235                     ; 379     bitstatus = (ITStatus)RESET;
1237  00bd 4f            	clr	a
1239  00be               L555:
1240                     ; 381   return ((ITStatus)bitstatus);
1244  00be 5b03          	addw	sp,#3
1245  00c0 81            	ret	
1281                     ; 391 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
1281                     ; 392 {
1282                     	switch	.text
1283  00c1               _TIM4_ClearITPendingBit:
1287                     ; 394   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1289                     ; 397   TIM4->SR1 = (uint8_t)(~TIM4_IT);
1291  00c1 43            	cpl	a
1292  00c2 c75342        	ld	21314,a
1293                     ; 398 }
1296  00c5 81            	ret	
1309                     	xdef	_TIM4_ClearITPendingBit
1310                     	xdef	_TIM4_GetITStatus
1311                     	xdef	_TIM4_ClearFlag
1312                     	xdef	_TIM4_GetFlagStatus
1313                     	xdef	_TIM4_GetPrescaler
1314                     	xdef	_TIM4_GetCounter
1315                     	xdef	_TIM4_SetAutoreload
1316                     	xdef	_TIM4_SetCounter
1317                     	xdef	_TIM4_GenerateEvent
1318                     	xdef	_TIM4_ARRPreloadConfig
1319                     	xdef	_TIM4_PrescalerConfig
1320                     	xdef	_TIM4_SelectOnePulseMode
1321                     	xdef	_TIM4_UpdateRequestConfig
1322                     	xdef	_TIM4_UpdateDisableConfig
1323                     	xdef	_TIM4_ITConfig
1324                     	xdef	_TIM4_Cmd
1325                     	xdef	_TIM4_TimeBaseInit
1326                     	xdef	_TIM4_DeInit
1345                     	end
