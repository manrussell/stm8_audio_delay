   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
   4                     ; Optimizer V4.4.7 - 05 Oct 2017
  46                     ; 52 void TIM2_DeInit(void)
  46                     ; 53 {
  48                     	switch	.text
  49  0000               _TIM2_DeInit:
  53                     ; 54   TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  55  0000 725f5300      	clr	21248
  56                     ; 55   TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  58  0004 725f5301      	clr	21249
  59                     ; 56   TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  61  0008 725f5303      	clr	21251
  62                     ; 59   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  64  000c 725f5308      	clr	21256
  65                     ; 60   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  67  0010 725f5309      	clr	21257
  68                     ; 64   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  70  0014 725f5308      	clr	21256
  71                     ; 65   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  73  0018 725f5309      	clr	21257
  74                     ; 66   TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  76  001c 725f5305      	clr	21253
  77                     ; 67   TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  79  0020 725f5306      	clr	21254
  80                     ; 68   TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  82  0024 725f5307      	clr	21255
  83                     ; 69   TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  85  0028 725f530a      	clr	21258
  86                     ; 70   TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  88  002c 725f530b      	clr	21259
  89                     ; 71   TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  91  0030 725f530c      	clr	21260
  92                     ; 72   TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  94  0034 35ff530d      	mov	21261,#255
  95                     ; 73   TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
  97  0038 35ff530e      	mov	21262,#255
  98                     ; 74   TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
 100  003c 725f530f      	clr	21263
 101                     ; 75   TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 103  0040 725f5310      	clr	21264
 104                     ; 76   TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 106  0044 725f5311      	clr	21265
 107                     ; 77   TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 109  0048 725f5312      	clr	21266
 110                     ; 78   TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 112  004c 725f5313      	clr	21267
 113                     ; 79   TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 115  0050 725f5314      	clr	21268
 116                     ; 80   TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 118  0054 725f5302      	clr	21250
 119                     ; 81 }
 122  0058 81            	ret	
 290                     ; 89 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 290                     ; 90                         uint16_t TIM2_Period)
 290                     ; 91 {
 291                     	switch	.text
 292  0059               _TIM2_TimeBaseInit:
 294       ffffffff      OFST: set -1
 297                     ; 93   TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 299  0059 c7530c        	ld	21260,a
 300                     ; 95   TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 302  005c 7b03          	ld	a,(OFST+4,sp)
 303  005e c7530d        	ld	21261,a
 304                     ; 96   TIM2->ARRL = (uint8_t)(TIM2_Period);
 306  0061 7b04          	ld	a,(OFST+5,sp)
 307  0063 c7530e        	ld	21262,a
 308                     ; 97 }
 311  0066 81            	ret	
 468                     ; 108 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 468                     ; 109                   TIM2_OutputState_TypeDef TIM2_OutputState,
 468                     ; 110                   uint16_t TIM2_Pulse,
 468                     ; 111                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 468                     ; 112 {
 469                     	switch	.text
 470  0067               _TIM2_OC1Init:
 472  0067 89            	pushw	x
 473  0068 88            	push	a
 474       00000001      OFST:	set	1
 477                     ; 114   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 479                     ; 115   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 481                     ; 116   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 483                     ; 119   TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 485  0069 c65308        	ld	a,21256
 486  006c a4fc          	and	a,#252
 487  006e c75308        	ld	21256,a
 488                     ; 121   TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER1_CC1E ) | 
 488                     ; 122                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC1P));
 490  0071 7b08          	ld	a,(OFST+7,sp)
 491  0073 a402          	and	a,#2
 492  0075 6b01          	ld	(OFST+0,sp),a
 494  0077 9f            	ld	a,xl
 495  0078 a401          	and	a,#1
 496  007a 1a01          	or	a,(OFST+0,sp)
 497  007c ca5308        	or	a,21256
 498  007f c75308        	ld	21256,a
 499                     ; 125   TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM)) |
 499                     ; 126                           (uint8_t)TIM2_OCMode);
 501  0082 c65305        	ld	a,21253
 502  0085 a48f          	and	a,#143
 503  0087 1a02          	or	a,(OFST+1,sp)
 504  0089 c75305        	ld	21253,a
 505                     ; 129   TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
 507  008c 7b06          	ld	a,(OFST+5,sp)
 508  008e c7530f        	ld	21263,a
 509                     ; 130   TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
 511  0091 7b07          	ld	a,(OFST+6,sp)
 512  0093 c75310        	ld	21264,a
 513                     ; 131 }
 516  0096 5b03          	addw	sp,#3
 517  0098 81            	ret	
 581                     ; 142 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 581                     ; 143                   TIM2_OutputState_TypeDef TIM2_OutputState,
 581                     ; 144                   uint16_t TIM2_Pulse,
 581                     ; 145                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 581                     ; 146 {
 582                     	switch	.text
 583  0099               _TIM2_OC2Init:
 585  0099 89            	pushw	x
 586  009a 88            	push	a
 587       00000001      OFST:	set	1
 590                     ; 148   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 592                     ; 149   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 594                     ; 150   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 596                     ; 154   TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 598  009b c65308        	ld	a,21256
 599  009e a4cf          	and	a,#207
 600  00a0 c75308        	ld	21256,a
 601                     ; 156   TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState  & TIM2_CCER1_CC2E ) |
 601                     ; 157                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC2P));
 603  00a3 7b08          	ld	a,(OFST+7,sp)
 604  00a5 a420          	and	a,#32
 605  00a7 6b01          	ld	(OFST+0,sp),a
 607  00a9 9f            	ld	a,xl
 608  00aa a410          	and	a,#16
 609  00ac 1a01          	or	a,(OFST+0,sp)
 610  00ae ca5308        	or	a,21256
 611  00b1 c75308        	ld	21256,a
 612                     ; 161   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM)) | 
 612                     ; 162                           (uint8_t)TIM2_OCMode);
 614  00b4 c65306        	ld	a,21254
 615  00b7 a48f          	and	a,#143
 616  00b9 1a02          	or	a,(OFST+1,sp)
 617  00bb c75306        	ld	21254,a
 618                     ; 166   TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
 620  00be 7b06          	ld	a,(OFST+5,sp)
 621  00c0 c75311        	ld	21265,a
 622                     ; 167   TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
 624  00c3 7b07          	ld	a,(OFST+6,sp)
 625  00c5 c75312        	ld	21266,a
 626                     ; 168 }
 629  00c8 5b03          	addw	sp,#3
 630  00ca 81            	ret	
 694                     ; 179 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 694                     ; 180                   TIM2_OutputState_TypeDef TIM2_OutputState,
 694                     ; 181                   uint16_t TIM2_Pulse,
 694                     ; 182                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 694                     ; 183 {
 695                     	switch	.text
 696  00cb               _TIM2_OC3Init:
 698  00cb 89            	pushw	x
 699  00cc 88            	push	a
 700       00000001      OFST:	set	1
 703                     ; 185   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 705                     ; 186   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 707                     ; 187   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 709                     ; 189   TIM2->CCER2 &= (uint8_t)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 711  00cd c65309        	ld	a,21257
 712  00d0 a4fc          	and	a,#252
 713  00d2 c75309        	ld	21257,a
 714                     ; 191   TIM2->CCER2 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER2_CC3E) |  
 714                     ; 192                            (uint8_t)(TIM2_OCPolarity & TIM2_CCER2_CC3P));
 716  00d5 7b08          	ld	a,(OFST+7,sp)
 717  00d7 a402          	and	a,#2
 718  00d9 6b01          	ld	(OFST+0,sp),a
 720  00db 9f            	ld	a,xl
 721  00dc a401          	and	a,#1
 722  00de 1a01          	or	a,(OFST+0,sp)
 723  00e0 ca5309        	or	a,21257
 724  00e3 c75309        	ld	21257,a
 725                     ; 195   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM)) |
 725                     ; 196                           (uint8_t)TIM2_OCMode);
 727  00e6 c65307        	ld	a,21255
 728  00e9 a48f          	and	a,#143
 729  00eb 1a02          	or	a,(OFST+1,sp)
 730  00ed c75307        	ld	21255,a
 731                     ; 199   TIM2->CCR3H = (uint8_t)(TIM2_Pulse >> 8);
 733  00f0 7b06          	ld	a,(OFST+5,sp)
 734  00f2 c75313        	ld	21267,a
 735                     ; 200   TIM2->CCR3L = (uint8_t)(TIM2_Pulse);
 737  00f5 7b07          	ld	a,(OFST+6,sp)
 738  00f7 c75314        	ld	21268,a
 739                     ; 201 }
 742  00fa 5b03          	addw	sp,#3
 743  00fc 81            	ret	
 936                     ; 212 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
 936                     ; 213                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
 936                     ; 214                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
 936                     ; 215                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
 936                     ; 216                  uint8_t TIM2_ICFilter)
 936                     ; 217 {
 937                     	switch	.text
 938  00fd               _TIM2_ICInit:
 940  00fd 89            	pushw	x
 941       00000000      OFST:	set	0
 944                     ; 219   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
 946                     ; 220   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
 948                     ; 221   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
 950                     ; 222   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
 952                     ; 223   assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
 954                     ; 225   if (TIM2_Channel == TIM2_CHANNEL_1)
 956  00fe 9e            	ld	a,xh
 957  00ff 4d            	tnz	a
 958  0100 2614          	jrne	L104
 959                     ; 228     TI1_Config((uint8_t)TIM2_ICPolarity,
 959                     ; 229                (uint8_t)TIM2_ICSelection,
 959                     ; 230                (uint8_t)TIM2_ICFilter);
 961  0102 7b07          	ld	a,(OFST+7,sp)
 962  0104 88            	push	a
 963  0105 7b06          	ld	a,(OFST+6,sp)
 964  0107 97            	ld	xl,a
 965  0108 7b03          	ld	a,(OFST+3,sp)
 966  010a 95            	ld	xh,a
 967  010b cd0409        	call	L3_TI1_Config
 969  010e 84            	pop	a
 970                     ; 233     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
 972  010f 7b06          	ld	a,(OFST+6,sp)
 973  0111 cd032a        	call	_TIM2_SetIC1Prescaler
 976  0114 202b          	jra	L304
 977  0116               L104:
 978                     ; 235   else if (TIM2_Channel == TIM2_CHANNEL_2)
 980  0116 7b01          	ld	a,(OFST+1,sp)
 981  0118 4a            	dec	a
 982  0119 2614          	jrne	L504
 983                     ; 238     TI2_Config((uint8_t)TIM2_ICPolarity,
 983                     ; 239                (uint8_t)TIM2_ICSelection,
 983                     ; 240                (uint8_t)TIM2_ICFilter);
 985  011b 7b07          	ld	a,(OFST+7,sp)
 986  011d 88            	push	a
 987  011e 7b06          	ld	a,(OFST+6,sp)
 988  0120 97            	ld	xl,a
 989  0121 7b03          	ld	a,(OFST+3,sp)
 990  0123 95            	ld	xh,a
 991  0124 cd0439        	call	L5_TI2_Config
 993  0127 84            	pop	a
 994                     ; 243     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
 996  0128 7b06          	ld	a,(OFST+6,sp)
 997  012a cd0337        	call	_TIM2_SetIC2Prescaler
1000  012d 2012          	jra	L304
1001  012f               L504:
1002                     ; 248     TI3_Config((uint8_t)TIM2_ICPolarity,
1002                     ; 249                (uint8_t)TIM2_ICSelection,
1002                     ; 250                (uint8_t)TIM2_ICFilter);
1004  012f 7b07          	ld	a,(OFST+7,sp)
1005  0131 88            	push	a
1006  0132 7b06          	ld	a,(OFST+6,sp)
1007  0134 97            	ld	xl,a
1008  0135 7b03          	ld	a,(OFST+3,sp)
1009  0137 95            	ld	xh,a
1010  0138 cd0469        	call	L7_TI3_Config
1012  013b 84            	pop	a
1013                     ; 253     TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
1015  013c 7b06          	ld	a,(OFST+6,sp)
1016  013e cd0344        	call	_TIM2_SetIC3Prescaler
1018  0141               L304:
1019                     ; 255 }
1022  0141 85            	popw	x
1023  0142 81            	ret	
1119                     ; 266 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1119                     ; 267                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1119                     ; 268                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1119                     ; 269                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1119                     ; 270                      uint8_t TIM2_ICFilter)
1119                     ; 271 {
1120                     	switch	.text
1121  0143               _TIM2_PWMIConfig:
1123  0143 89            	pushw	x
1124  0144 89            	pushw	x
1125       00000002      OFST:	set	2
1128                     ; 272   uint8_t icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1130                     ; 273   uint8_t icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1132                     ; 276   assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1134                     ; 277   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1136                     ; 278   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1138                     ; 279   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1140                     ; 282   if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1142  0145 9f            	ld	a,xl
1143  0146 a144          	cp	a,#68
1144  0148 2706          	jreq	L754
1145                     ; 284     icpolarity = (uint8_t)TIM2_ICPOLARITY_FALLING;
1147  014a a644          	ld	a,#68
1148  014c 6b01          	ld	(OFST-1,sp),a
1151  014e 2002          	jra	L164
1152  0150               L754:
1153                     ; 288     icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1155  0150 0f01          	clr	(OFST-1,sp)
1157  0152               L164:
1158                     ; 292   if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1160  0152 7b07          	ld	a,(OFST+5,sp)
1161  0154 4a            	dec	a
1162  0155 2604          	jrne	L364
1163                     ; 294     icselection = (uint8_t)TIM2_ICSELECTION_INDIRECTTI;
1165  0157 a602          	ld	a,#2
1167  0159 2002          	jra	L564
1168  015b               L364:
1169                     ; 298     icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1171  015b a601          	ld	a,#1
1172  015d               L564:
1173  015d 6b02          	ld	(OFST+0,sp),a
1175                     ; 301   if (TIM2_Channel == TIM2_CHANNEL_1)
1177  015f 7b03          	ld	a,(OFST+1,sp)
1178  0161 2626          	jrne	L764
1179                     ; 304     TI1_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1179                     ; 305                (uint8_t)TIM2_ICFilter);
1181  0163 7b09          	ld	a,(OFST+7,sp)
1182  0165 88            	push	a
1183  0166 7b08          	ld	a,(OFST+6,sp)
1184  0168 97            	ld	xl,a
1185  0169 7b05          	ld	a,(OFST+3,sp)
1186  016b 95            	ld	xh,a
1187  016c cd0409        	call	L3_TI1_Config
1189  016f 84            	pop	a
1190                     ; 308     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1192  0170 7b08          	ld	a,(OFST+6,sp)
1193  0172 cd032a        	call	_TIM2_SetIC1Prescaler
1195                     ; 311     TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1197  0175 7b09          	ld	a,(OFST+7,sp)
1198  0177 88            	push	a
1199  0178 7b03          	ld	a,(OFST+1,sp)
1200  017a 97            	ld	xl,a
1201  017b 7b02          	ld	a,(OFST+0,sp)
1202  017d 95            	ld	xh,a
1203  017e cd0439        	call	L5_TI2_Config
1205  0181 84            	pop	a
1206                     ; 314     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1208  0182 7b08          	ld	a,(OFST+6,sp)
1209  0184 cd0337        	call	_TIM2_SetIC2Prescaler
1212  0187 2024          	jra	L174
1213  0189               L764:
1214                     ; 319     TI2_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1214                     ; 320                (uint8_t)TIM2_ICFilter);
1216  0189 7b09          	ld	a,(OFST+7,sp)
1217  018b 88            	push	a
1218  018c 7b08          	ld	a,(OFST+6,sp)
1219  018e 97            	ld	xl,a
1220  018f 7b05          	ld	a,(OFST+3,sp)
1221  0191 95            	ld	xh,a
1222  0192 cd0439        	call	L5_TI2_Config
1224  0195 84            	pop	a
1225                     ; 323     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1227  0196 7b08          	ld	a,(OFST+6,sp)
1228  0198 cd0337        	call	_TIM2_SetIC2Prescaler
1230                     ; 326     TI1_Config((uint8_t)icpolarity, icselection, (uint8_t)TIM2_ICFilter);
1232  019b 7b09          	ld	a,(OFST+7,sp)
1233  019d 88            	push	a
1234  019e 7b03          	ld	a,(OFST+1,sp)
1235  01a0 97            	ld	xl,a
1236  01a1 7b02          	ld	a,(OFST+0,sp)
1237  01a3 95            	ld	xh,a
1238  01a4 cd0409        	call	L3_TI1_Config
1240  01a7 84            	pop	a
1241                     ; 329     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1243  01a8 7b08          	ld	a,(OFST+6,sp)
1244  01aa cd032a        	call	_TIM2_SetIC1Prescaler
1246  01ad               L174:
1247                     ; 331 }
1250  01ad 5b04          	addw	sp,#4
1251  01af 81            	ret	
1306                     ; 339 void TIM2_Cmd(FunctionalState NewState)
1306                     ; 340 {
1307                     	switch	.text
1308  01b0               _TIM2_Cmd:
1312                     ; 342   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1314                     ; 345   if (NewState != DISABLE)
1316  01b0 4d            	tnz	a
1317  01b1 2705          	jreq	L125
1318                     ; 347     TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
1320  01b3 72105300      	bset	21248,#0
1323  01b7 81            	ret	
1324  01b8               L125:
1325                     ; 351     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
1327  01b8 72115300      	bres	21248,#0
1328                     ; 353 }
1331  01bc 81            	ret	
1410                     ; 368 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1410                     ; 369 {
1411                     	switch	.text
1412  01bd               _TIM2_ITConfig:
1414  01bd 89            	pushw	x
1415       00000000      OFST:	set	0
1418                     ; 371   assert_param(IS_TIM2_IT_OK(TIM2_IT));
1420                     ; 372   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1422                     ; 374   if (NewState != DISABLE)
1424  01be 9f            	ld	a,xl
1425  01bf 4d            	tnz	a
1426  01c0 2706          	jreq	L365
1427                     ; 377     TIM2->IER |= (uint8_t)TIM2_IT;
1429  01c2 9e            	ld	a,xh
1430  01c3 ca5301        	or	a,21249
1432  01c6 2006          	jra	L565
1433  01c8               L365:
1434                     ; 382     TIM2->IER &= (uint8_t)(~TIM2_IT);
1436  01c8 7b01          	ld	a,(OFST+1,sp)
1437  01ca 43            	cpl	a
1438  01cb c45301        	and	a,21249
1439  01ce               L565:
1440  01ce c75301        	ld	21249,a
1441                     ; 384 }
1444  01d1 85            	popw	x
1445  01d2 81            	ret	
1481                     ; 392 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1481                     ; 393 {
1482                     	switch	.text
1483  01d3               _TIM2_UpdateDisableConfig:
1487                     ; 395   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1489                     ; 398   if (NewState != DISABLE)
1491  01d3 4d            	tnz	a
1492  01d4 2705          	jreq	L506
1493                     ; 400     TIM2->CR1 |= (uint8_t)TIM2_CR1_UDIS;
1495  01d6 72125300      	bset	21248,#1
1498  01da 81            	ret	
1499  01db               L506:
1500                     ; 404     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_UDIS);
1502  01db 72135300      	bres	21248,#1
1503                     ; 406 }
1506  01df 81            	ret	
1564                     ; 416 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
1564                     ; 417 {
1565                     	switch	.text
1566  01e0               _TIM2_UpdateRequestConfig:
1570                     ; 419   assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
1572                     ; 422   if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
1574  01e0 4d            	tnz	a
1575  01e1 2705          	jreq	L736
1576                     ; 424     TIM2->CR1 |= (uint8_t)TIM2_CR1_URS;
1578  01e3 72145300      	bset	21248,#2
1581  01e7 81            	ret	
1582  01e8               L736:
1583                     ; 428     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_URS);
1585  01e8 72155300      	bres	21248,#2
1586                     ; 430 }
1589  01ec 81            	ret	
1646                     ; 440 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1646                     ; 441 {
1647                     	switch	.text
1648  01ed               _TIM2_SelectOnePulseMode:
1652                     ; 443   assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
1654                     ; 446   if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
1656  01ed 4d            	tnz	a
1657  01ee 2705          	jreq	L176
1658                     ; 448     TIM2->CR1 |= (uint8_t)TIM2_CR1_OPM;
1660  01f0 72165300      	bset	21248,#3
1663  01f4 81            	ret	
1664  01f5               L176:
1665                     ; 452     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_OPM);
1667  01f5 72175300      	bres	21248,#3
1668                     ; 454 }
1671  01f9 81            	ret	
1739                     ; 484 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
1739                     ; 485                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
1739                     ; 486 {
1740                     	switch	.text
1741  01fa               _TIM2_PrescalerConfig:
1745                     ; 488   assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
1747                     ; 489   assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
1749                     ; 492   TIM2->PSCR = (uint8_t)Prescaler;
1751  01fa 9e            	ld	a,xh
1752  01fb c7530c        	ld	21260,a
1753                     ; 495   TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
1755  01fe 9f            	ld	a,xl
1756  01ff c75304        	ld	21252,a
1757                     ; 496 }
1760  0202 81            	ret	
1818                     ; 507 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1818                     ; 508 {
1819                     	switch	.text
1820  0203               _TIM2_ForcedOC1Config:
1822  0203 88            	push	a
1823       00000000      OFST:	set	0
1826                     ; 510   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1828                     ; 513   TIM2->CCMR1  =  (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))  
1828                     ; 514                             | (uint8_t)TIM2_ForcedAction);
1830  0204 c65305        	ld	a,21253
1831  0207 a48f          	and	a,#143
1832  0209 1a01          	or	a,(OFST+1,sp)
1833  020b c75305        	ld	21253,a
1834                     ; 515 }
1837  020e 84            	pop	a
1838  020f 81            	ret	
1874                     ; 526 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1874                     ; 527 {
1875                     	switch	.text
1876  0210               _TIM2_ForcedOC2Config:
1878  0210 88            	push	a
1879       00000000      OFST:	set	0
1882                     ; 529   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1884                     ; 532   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))  
1884                     ; 533                           | (uint8_t)TIM2_ForcedAction);
1886  0211 c65306        	ld	a,21254
1887  0214 a48f          	and	a,#143
1888  0216 1a01          	or	a,(OFST+1,sp)
1889  0218 c75306        	ld	21254,a
1890                     ; 534 }
1893  021b 84            	pop	a
1894  021c 81            	ret	
1930                     ; 545 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1930                     ; 546 {
1931                     	switch	.text
1932  021d               _TIM2_ForcedOC3Config:
1934  021d 88            	push	a
1935       00000000      OFST:	set	0
1938                     ; 548   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1940                     ; 551   TIM2->CCMR3  =  (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
1940                     ; 552                             | (uint8_t)TIM2_ForcedAction);
1942  021e c65307        	ld	a,21255
1943  0221 a48f          	and	a,#143
1944  0223 1a01          	or	a,(OFST+1,sp)
1945  0225 c75307        	ld	21255,a
1946                     ; 553 }
1949  0228 84            	pop	a
1950  0229 81            	ret	
1986                     ; 561 void TIM2_ARRPreloadConfig(FunctionalState NewState)
1986                     ; 562 {
1987                     	switch	.text
1988  022a               _TIM2_ARRPreloadConfig:
1992                     ; 564   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1994                     ; 567   if (NewState != DISABLE)
1996  022a 4d            	tnz	a
1997  022b 2705          	jreq	L7201
1998                     ; 569     TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
2000  022d 721e5300      	bset	21248,#7
2003  0231 81            	ret	
2004  0232               L7201:
2005                     ; 573     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_ARPE);
2007  0232 721f5300      	bres	21248,#7
2008                     ; 575 }
2011  0236 81            	ret	
2047                     ; 583 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2047                     ; 584 {
2048                     	switch	.text
2049  0237               _TIM2_OC1PreloadConfig:
2053                     ; 586   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2055                     ; 589   if (NewState != DISABLE)
2057  0237 4d            	tnz	a
2058  0238 2705          	jreq	L1501
2059                     ; 591     TIM2->CCMR1 |= (uint8_t)TIM2_CCMR_OCxPE;
2061  023a 72165305      	bset	21253,#3
2064  023e 81            	ret	
2065  023f               L1501:
2066                     ; 595     TIM2->CCMR1 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2068  023f 72175305      	bres	21253,#3
2069                     ; 597 }
2072  0243 81            	ret	
2108                     ; 605 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2108                     ; 606 {
2109                     	switch	.text
2110  0244               _TIM2_OC2PreloadConfig:
2114                     ; 608   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2116                     ; 611   if (NewState != DISABLE)
2118  0244 4d            	tnz	a
2119  0245 2705          	jreq	L3701
2120                     ; 613     TIM2->CCMR2 |= (uint8_t)TIM2_CCMR_OCxPE;
2122  0247 72165306      	bset	21254,#3
2125  024b 81            	ret	
2126  024c               L3701:
2127                     ; 617     TIM2->CCMR2 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2129  024c 72175306      	bres	21254,#3
2130                     ; 619 }
2133  0250 81            	ret	
2169                     ; 627 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2169                     ; 628 {
2170                     	switch	.text
2171  0251               _TIM2_OC3PreloadConfig:
2175                     ; 630   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2177                     ; 633   if (NewState != DISABLE)
2179  0251 4d            	tnz	a
2180  0252 2705          	jreq	L5111
2181                     ; 635     TIM2->CCMR3 |= (uint8_t)TIM2_CCMR_OCxPE;
2183  0254 72165307      	bset	21255,#3
2186  0258 81            	ret	
2187  0259               L5111:
2188                     ; 639     TIM2->CCMR3 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2190  0259 72175307      	bres	21255,#3
2191                     ; 641 }
2194  025d 81            	ret	
2267                     ; 653 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2267                     ; 654 {
2268                     	switch	.text
2269  025e               _TIM2_GenerateEvent:
2273                     ; 656   assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
2275                     ; 659   TIM2->EGR = (uint8_t)TIM2_EventSource;
2277  025e c75304        	ld	21252,a
2278                     ; 660 }
2281  0261 81            	ret	
2317                     ; 670 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2317                     ; 671 {
2318                     	switch	.text
2319  0262               _TIM2_OC1PolarityConfig:
2323                     ; 673   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2325                     ; 676   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2327  0262 4d            	tnz	a
2328  0263 2705          	jreq	L1711
2329                     ; 678     TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1P;
2331  0265 72125308      	bset	21256,#1
2334  0269 81            	ret	
2335  026a               L1711:
2336                     ; 682     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
2338  026a 72135308      	bres	21256,#1
2339                     ; 684 }
2342  026e 81            	ret	
2378                     ; 694 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2378                     ; 695 {
2379                     	switch	.text
2380  026f               _TIM2_OC2PolarityConfig:
2384                     ; 697   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2386                     ; 700   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2388  026f 4d            	tnz	a
2389  0270 2705          	jreq	L3121
2390                     ; 702     TIM2->CCER1 |= TIM2_CCER1_CC2P;
2392  0272 721a5308      	bset	21256,#5
2395  0276 81            	ret	
2396  0277               L3121:
2397                     ; 706     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
2399  0277 721b5308      	bres	21256,#5
2400                     ; 708 }
2403  027b 81            	ret	
2439                     ; 718 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2439                     ; 719 {
2440                     	switch	.text
2441  027c               _TIM2_OC3PolarityConfig:
2445                     ; 721   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2447                     ; 724   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2449  027c 4d            	tnz	a
2450  027d 2705          	jreq	L5321
2451                     ; 726     TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3P;
2453  027f 72125309      	bset	21257,#1
2456  0283 81            	ret	
2457  0284               L5321:
2458                     ; 730     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
2460  0284 72135309      	bres	21257,#1
2461                     ; 732 }
2464  0288 81            	ret	
2509                     ; 745 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
2509                     ; 746 {
2510                     	switch	.text
2511  0289               _TIM2_CCxCmd:
2513  0289 89            	pushw	x
2514       00000000      OFST:	set	0
2517                     ; 748   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2519                     ; 749   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2521                     ; 751   if (TIM2_Channel == TIM2_CHANNEL_1)
2523  028a 9e            	ld	a,xh
2524  028b 4d            	tnz	a
2525  028c 2610          	jrne	L3621
2526                     ; 754     if (NewState != DISABLE)
2528  028e 9f            	ld	a,xl
2529  028f 4d            	tnz	a
2530  0290 2706          	jreq	L5621
2531                     ; 756       TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1E;
2533  0292 72105308      	bset	21256,#0
2535  0296 2029          	jra	L1721
2536  0298               L5621:
2537                     ; 760       TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2539  0298 72115308      	bres	21256,#0
2540  029c 2023          	jra	L1721
2541  029e               L3621:
2542                     ; 764   else if (TIM2_Channel == TIM2_CHANNEL_2)
2544  029e 7b01          	ld	a,(OFST+1,sp)
2545  02a0 4a            	dec	a
2546  02a1 2610          	jrne	L3721
2547                     ; 767     if (NewState != DISABLE)
2549  02a3 7b02          	ld	a,(OFST+2,sp)
2550  02a5 2706          	jreq	L5721
2551                     ; 769       TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC2E;
2553  02a7 72185308      	bset	21256,#4
2555  02ab 2014          	jra	L1721
2556  02ad               L5721:
2557                     ; 773       TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2559  02ad 72195308      	bres	21256,#4
2560  02b1 200e          	jra	L1721
2561  02b3               L3721:
2562                     ; 779     if (NewState != DISABLE)
2564  02b3 7b02          	ld	a,(OFST+2,sp)
2565  02b5 2706          	jreq	L3031
2566                     ; 781       TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3E;
2568  02b7 72105309      	bset	21257,#0
2570  02bb 2004          	jra	L1721
2571  02bd               L3031:
2572                     ; 785       TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2574  02bd 72115309      	bres	21257,#0
2575  02c1               L1721:
2576                     ; 788 }
2579  02c1 85            	popw	x
2580  02c2 81            	ret	
2625                     ; 810 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
2625                     ; 811 {
2626                     	switch	.text
2627  02c3               _TIM2_SelectOCxM:
2629  02c3 89            	pushw	x
2630       00000000      OFST:	set	0
2633                     ; 813   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2635                     ; 814   assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
2637                     ; 816   if (TIM2_Channel == TIM2_CHANNEL_1)
2639  02c4 9e            	ld	a,xh
2640  02c5 4d            	tnz	a
2641  02c6 2610          	jrne	L1331
2642                     ; 819     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2644  02c8 72115308      	bres	21256,#0
2645                     ; 822     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))
2645                     ; 823                             | (uint8_t)TIM2_OCMode);
2647  02cc c65305        	ld	a,21253
2648  02cf a48f          	and	a,#143
2649  02d1 1a02          	or	a,(OFST+2,sp)
2650  02d3 c75305        	ld	21253,a
2652  02d6 2023          	jra	L3331
2653  02d8               L1331:
2654                     ; 825   else if (TIM2_Channel == TIM2_CHANNEL_2)
2656  02d8 7b01          	ld	a,(OFST+1,sp)
2657  02da 4a            	dec	a
2658  02db 2610          	jrne	L5331
2659                     ; 828     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2661  02dd 72195308      	bres	21256,#4
2662                     ; 831     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))
2662                     ; 832                             | (uint8_t)TIM2_OCMode);
2664  02e1 c65306        	ld	a,21254
2665  02e4 a48f          	and	a,#143
2666  02e6 1a02          	or	a,(OFST+2,sp)
2667  02e8 c75306        	ld	21254,a
2669  02eb 200e          	jra	L3331
2670  02ed               L5331:
2671                     ; 837     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2673  02ed 72115309      	bres	21257,#0
2674                     ; 840     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
2674                     ; 841                             | (uint8_t)TIM2_OCMode);
2676  02f1 c65307        	ld	a,21255
2677  02f4 a48f          	and	a,#143
2678  02f6 1a02          	or	a,(OFST+2,sp)
2679  02f8 c75307        	ld	21255,a
2680  02fb               L3331:
2681                     ; 843 }
2684  02fb 85            	popw	x
2685  02fc 81            	ret	
2719                     ; 851 void TIM2_SetCounter(uint16_t Counter)
2719                     ; 852 {
2720                     	switch	.text
2721  02fd               _TIM2_SetCounter:
2725                     ; 854   TIM2->CNTRH = (uint8_t)(Counter >> 8);
2727  02fd 9e            	ld	a,xh
2728  02fe c7530a        	ld	21258,a
2729                     ; 855   TIM2->CNTRL = (uint8_t)(Counter);
2731  0301 9f            	ld	a,xl
2732  0302 c7530b        	ld	21259,a
2733                     ; 856 }
2736  0305 81            	ret	
2770                     ; 864 void TIM2_SetAutoreload(uint16_t Autoreload)
2770                     ; 865 {
2771                     	switch	.text
2772  0306               _TIM2_SetAutoreload:
2776                     ; 867   TIM2->ARRH = (uint8_t)(Autoreload >> 8);
2778  0306 9e            	ld	a,xh
2779  0307 c7530d        	ld	21261,a
2780                     ; 868   TIM2->ARRL = (uint8_t)(Autoreload);
2782  030a 9f            	ld	a,xl
2783  030b c7530e        	ld	21262,a
2784                     ; 869 }
2787  030e 81            	ret	
2821                     ; 877 void TIM2_SetCompare1(uint16_t Compare1)
2821                     ; 878 {
2822                     	switch	.text
2823  030f               _TIM2_SetCompare1:
2827                     ; 880   TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
2829  030f 9e            	ld	a,xh
2830  0310 c7530f        	ld	21263,a
2831                     ; 881   TIM2->CCR1L = (uint8_t)(Compare1);
2833  0313 9f            	ld	a,xl
2834  0314 c75310        	ld	21264,a
2835                     ; 882 }
2838  0317 81            	ret	
2872                     ; 890 void TIM2_SetCompare2(uint16_t Compare2)
2872                     ; 891 {
2873                     	switch	.text
2874  0318               _TIM2_SetCompare2:
2878                     ; 893   TIM2->CCR2H = (uint8_t)(Compare2 >> 8);
2880  0318 9e            	ld	a,xh
2881  0319 c75311        	ld	21265,a
2882                     ; 894   TIM2->CCR2L = (uint8_t)(Compare2);
2884  031c 9f            	ld	a,xl
2885  031d c75312        	ld	21266,a
2886                     ; 895 }
2889  0320 81            	ret	
2923                     ; 903 void TIM2_SetCompare3(uint16_t Compare3)
2923                     ; 904 {
2924                     	switch	.text
2925  0321               _TIM2_SetCompare3:
2929                     ; 906   TIM2->CCR3H = (uint8_t)(Compare3 >> 8);
2931  0321 9e            	ld	a,xh
2932  0322 c75313        	ld	21267,a
2933                     ; 907   TIM2->CCR3L = (uint8_t)(Compare3);
2935  0325 9f            	ld	a,xl
2936  0326 c75314        	ld	21268,a
2937                     ; 908 }
2940  0329 81            	ret	
2976                     ; 920 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
2976                     ; 921 {
2977                     	switch	.text
2978  032a               _TIM2_SetIC1Prescaler:
2980  032a 88            	push	a
2981       00000000      OFST:	set	0
2984                     ; 923   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
2986                     ; 926   TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_ICxPSC))
2986                     ; 927                           | (uint8_t)TIM2_IC1Prescaler);
2988  032b c65305        	ld	a,21253
2989  032e a4f3          	and	a,#243
2990  0330 1a01          	or	a,(OFST+1,sp)
2991  0332 c75305        	ld	21253,a
2992                     ; 928 }
2995  0335 84            	pop	a
2996  0336 81            	ret	
3032                     ; 940 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
3032                     ; 941 {
3033                     	switch	.text
3034  0337               _TIM2_SetIC2Prescaler:
3036  0337 88            	push	a
3037       00000000      OFST:	set	0
3040                     ; 943   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3042                     ; 946   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3042                     ; 947                           | (uint8_t)TIM2_IC2Prescaler);
3044  0338 c65306        	ld	a,21254
3045  033b a4f3          	and	a,#243
3046  033d 1a01          	or	a,(OFST+1,sp)
3047  033f c75306        	ld	21254,a
3048                     ; 948 }
3051  0342 84            	pop	a
3052  0343 81            	ret	
3088                     ; 960 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
3088                     ; 961 {
3089                     	switch	.text
3090  0344               _TIM2_SetIC3Prescaler:
3092  0344 88            	push	a
3093       00000000      OFST:	set	0
3096                     ; 964   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
3098                     ; 966   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3098                     ; 967                           | (uint8_t)TIM2_IC3Prescaler);
3100  0345 c65307        	ld	a,21255
3101  0348 a4f3          	and	a,#243
3102  034a 1a01          	or	a,(OFST+1,sp)
3103  034c c75307        	ld	21255,a
3104                     ; 968 }
3107  034f 84            	pop	a
3108  0350 81            	ret	
3160                     ; 975 uint16_t TIM2_GetCapture1(void)
3160                     ; 976 {
3161                     	switch	.text
3162  0351               _TIM2_GetCapture1:
3164  0351 5204          	subw	sp,#4
3165       00000004      OFST:	set	4
3168                     ; 978   uint16_t tmpccr1 = 0;
3170                     ; 979   uint8_t tmpccr1l=0, tmpccr1h=0;
3174                     ; 981   tmpccr1h = TIM2->CCR1H;
3176  0353 c6530f        	ld	a,21263
3177  0356 6b02          	ld	(OFST-2,sp),a
3179                     ; 982   tmpccr1l = TIM2->CCR1L;
3181  0358 c65310        	ld	a,21264
3182  035b 6b01          	ld	(OFST-3,sp),a
3184                     ; 984   tmpccr1 = (uint16_t)(tmpccr1l);
3186  035d 5f            	clrw	x
3187  035e 97            	ld	xl,a
3188  035f 1f03          	ldw	(OFST-1,sp),x
3190                     ; 985   tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3192  0361 5f            	clrw	x
3193  0362 7b02          	ld	a,(OFST-2,sp)
3194  0364 97            	ld	xl,a
3195  0365 7b04          	ld	a,(OFST+0,sp)
3196  0367 01            	rrwa	x,a
3197  0368 1a03          	or	a,(OFST-1,sp)
3198  036a 01            	rrwa	x,a
3200                     ; 987   return (uint16_t)tmpccr1;
3204  036b 5b04          	addw	sp,#4
3205  036d 81            	ret	
3257                     ; 995 uint16_t TIM2_GetCapture2(void)
3257                     ; 996 {
3258                     	switch	.text
3259  036e               _TIM2_GetCapture2:
3261  036e 5204          	subw	sp,#4
3262       00000004      OFST:	set	4
3265                     ; 998   uint16_t tmpccr2 = 0;
3267                     ; 999   uint8_t tmpccr2l=0, tmpccr2h=0;
3271                     ; 1001   tmpccr2h = TIM2->CCR2H;
3273  0370 c65311        	ld	a,21265
3274  0373 6b02          	ld	(OFST-2,sp),a
3276                     ; 1002   tmpccr2l = TIM2->CCR2L;
3278  0375 c65312        	ld	a,21266
3279  0378 6b01          	ld	(OFST-3,sp),a
3281                     ; 1004   tmpccr2 = (uint16_t)(tmpccr2l);
3283  037a 5f            	clrw	x
3284  037b 97            	ld	xl,a
3285  037c 1f03          	ldw	(OFST-1,sp),x
3287                     ; 1005   tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3289  037e 5f            	clrw	x
3290  037f 7b02          	ld	a,(OFST-2,sp)
3291  0381 97            	ld	xl,a
3292  0382 7b04          	ld	a,(OFST+0,sp)
3293  0384 01            	rrwa	x,a
3294  0385 1a03          	or	a,(OFST-1,sp)
3295  0387 01            	rrwa	x,a
3297                     ; 1007   return (uint16_t)tmpccr2;
3301  0388 5b04          	addw	sp,#4
3302  038a 81            	ret	
3354                     ; 1015 uint16_t TIM2_GetCapture3(void)
3354                     ; 1016 {
3355                     	switch	.text
3356  038b               _TIM2_GetCapture3:
3358  038b 5204          	subw	sp,#4
3359       00000004      OFST:	set	4
3362                     ; 1018   uint16_t tmpccr3 = 0;
3364                     ; 1019   uint8_t tmpccr3l=0, tmpccr3h=0;
3368                     ; 1021   tmpccr3h = TIM2->CCR3H;
3370  038d c65313        	ld	a,21267
3371  0390 6b02          	ld	(OFST-2,sp),a
3373                     ; 1022   tmpccr3l = TIM2->CCR3L;
3375  0392 c65314        	ld	a,21268
3376  0395 6b01          	ld	(OFST-3,sp),a
3378                     ; 1024   tmpccr3 = (uint16_t)(tmpccr3l);
3380  0397 5f            	clrw	x
3381  0398 97            	ld	xl,a
3382  0399 1f03          	ldw	(OFST-1,sp),x
3384                     ; 1025   tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
3386  039b 5f            	clrw	x
3387  039c 7b02          	ld	a,(OFST-2,sp)
3388  039e 97            	ld	xl,a
3389  039f 7b04          	ld	a,(OFST+0,sp)
3390  03a1 01            	rrwa	x,a
3391  03a2 1a03          	or	a,(OFST-1,sp)
3392  03a4 01            	rrwa	x,a
3394                     ; 1027   return (uint16_t)tmpccr3;
3398  03a5 5b04          	addw	sp,#4
3399  03a7 81            	ret	
3433                     ; 1035 uint16_t TIM2_GetCounter(void)
3433                     ; 1036 {
3434                     	switch	.text
3435  03a8               _TIM2_GetCounter:
3437  03a8 89            	pushw	x
3438       00000002      OFST:	set	2
3441                     ; 1037   uint16_t tmpcntr = 0;
3443                     ; 1039   tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
3445  03a9 c6530a        	ld	a,21258
3446  03ac 97            	ld	xl,a
3447  03ad 4f            	clr	a
3448  03ae 02            	rlwa	x,a
3449  03af 1f01          	ldw	(OFST-1,sp),x
3451                     ; 1041   return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
3453  03b1 c6530b        	ld	a,21259
3454  03b4 5f            	clrw	x
3455  03b5 97            	ld	xl,a
3456  03b6 01            	rrwa	x,a
3457  03b7 1a02          	or	a,(OFST+0,sp)
3458  03b9 01            	rrwa	x,a
3459  03ba 1a01          	or	a,(OFST-1,sp)
3460  03bc 01            	rrwa	x,a
3463  03bd 5b02          	addw	sp,#2
3464  03bf 81            	ret	
3488                     ; 1049 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
3488                     ; 1050 {
3489                     	switch	.text
3490  03c0               _TIM2_GetPrescaler:
3494                     ; 1052   return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
3496  03c0 c6530c        	ld	a,21260
3499  03c3 81            	ret	
3638                     ; 1068 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
3638                     ; 1069 {
3639                     	switch	.text
3640  03c4               _TIM2_GetFlagStatus:
3642  03c4 89            	pushw	x
3643  03c5 89            	pushw	x
3644       00000002      OFST:	set	2
3647                     ; 1070   FlagStatus bitstatus = RESET;
3649                     ; 1071   uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
3653                     ; 1074   assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
3655                     ; 1076   tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
3657  03c6 9f            	ld	a,xl
3658  03c7 c45302        	and	a,21250
3659  03ca 6b01          	ld	(OFST-1,sp),a
3661                     ; 1077   tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
3663  03cc 7b03          	ld	a,(OFST+1,sp)
3664  03ce 6b02          	ld	(OFST+0,sp),a
3666                     ; 1079   if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
3668  03d0 c45303        	and	a,21251
3669  03d3 1a01          	or	a,(OFST-1,sp)
3670  03d5 2702          	jreq	L5371
3671                     ; 1081     bitstatus = SET;
3673  03d7 a601          	ld	a,#1
3676  03d9               L5371:
3677                     ; 1085     bitstatus = RESET;
3680                     ; 1087   return (FlagStatus)bitstatus;
3684  03d9 5b04          	addw	sp,#4
3685  03db 81            	ret	
3720                     ; 1103 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
3720                     ; 1104 {
3721                     	switch	.text
3722  03dc               _TIM2_ClearFlag:
3726                     ; 1106   assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
3728                     ; 1109   TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
3730  03dc 9f            	ld	a,xl
3731  03dd 43            	cpl	a
3732  03de c75302        	ld	21250,a
3733                     ; 1110   TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
3735  03e1 35ff5303      	mov	21251,#255
3736                     ; 1111 }
3739  03e5 81            	ret	
3803                     ; 1123 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
3803                     ; 1124 {
3804                     	switch	.text
3805  03e6               _TIM2_GetITStatus:
3807  03e6 88            	push	a
3808  03e7 89            	pushw	x
3809       00000002      OFST:	set	2
3812                     ; 1125   ITStatus bitstatus = RESET;
3814                     ; 1126   uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
3818                     ; 1129   assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
3820                     ; 1131   TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
3822  03e8 c45302        	and	a,21250
3823  03eb 6b01          	ld	(OFST-1,sp),a
3825                     ; 1133   TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
3827  03ed c65301        	ld	a,21249
3828  03f0 1403          	and	a,(OFST+1,sp)
3829  03f2 6b02          	ld	(OFST+0,sp),a
3831                     ; 1135   if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
3833  03f4 7b01          	ld	a,(OFST-1,sp)
3834  03f6 2708          	jreq	L1102
3836  03f8 7b02          	ld	a,(OFST+0,sp)
3837  03fa 2704          	jreq	L1102
3838                     ; 1137     bitstatus = SET;
3840  03fc a601          	ld	a,#1
3843  03fe 2001          	jra	L3102
3844  0400               L1102:
3845                     ; 1141     bitstatus = RESET;
3847  0400 4f            	clr	a
3849  0401               L3102:
3850                     ; 1143   return (ITStatus)(bitstatus);
3854  0401 5b03          	addw	sp,#3
3855  0403 81            	ret	
3891                     ; 1156 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
3891                     ; 1157 {
3892                     	switch	.text
3893  0404               _TIM2_ClearITPendingBit:
3897                     ; 1159   assert_param(IS_TIM2_IT_OK(TIM2_IT));
3899                     ; 1162   TIM2->SR1 = (uint8_t)(~TIM2_IT);
3901  0404 43            	cpl	a
3902  0405 c75302        	ld	21250,a
3903                     ; 1163 }
3906  0408 81            	ret	
3958                     ; 1181 static void TI1_Config(uint8_t TIM2_ICPolarity,
3958                     ; 1182                        uint8_t TIM2_ICSelection,
3958                     ; 1183                        uint8_t TIM2_ICFilter)
3958                     ; 1184 {
3959                     	switch	.text
3960  0409               L3_TI1_Config:
3962  0409 89            	pushw	x
3963  040a 88            	push	a
3964       00000001      OFST:	set	1
3967                     ; 1186   TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3969  040b 72115308      	bres	21256,#0
3970                     ; 1189   TIM2->CCMR1  = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF )))
3970                     ; 1190                            | (uint8_t)(((TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
3972  040f 7b06          	ld	a,(OFST+5,sp)
3973  0411 97            	ld	xl,a
3974  0412 a610          	ld	a,#16
3975  0414 42            	mul	x,a
3976  0415 9f            	ld	a,xl
3977  0416 1a03          	or	a,(OFST+2,sp)
3978  0418 6b01          	ld	(OFST+0,sp),a
3980  041a c65305        	ld	a,21253
3981  041d a40c          	and	a,#12
3982  041f 1a01          	or	a,(OFST+0,sp)
3983  0421 c75305        	ld	21253,a
3984                     ; 1193   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
3986  0424 7b02          	ld	a,(OFST+1,sp)
3987  0426 2706          	jreq	L1602
3988                     ; 1195     TIM2->CCER1 |= TIM2_CCER1_CC1P;
3990  0428 72125308      	bset	21256,#1
3992  042c 2004          	jra	L3602
3993  042e               L1602:
3994                     ; 1199     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
3996  042e 72135308      	bres	21256,#1
3997  0432               L3602:
3998                     ; 1202   TIM2->CCER1 |= TIM2_CCER1_CC1E;
4000  0432 72105308      	bset	21256,#0
4001                     ; 1203 }
4004  0436 5b03          	addw	sp,#3
4005  0438 81            	ret	
4057                     ; 1221 static void TI2_Config(uint8_t TIM2_ICPolarity,
4057                     ; 1222                        uint8_t TIM2_ICSelection,
4057                     ; 1223                        uint8_t TIM2_ICFilter)
4057                     ; 1224 {
4058                     	switch	.text
4059  0439               L5_TI2_Config:
4061  0439 89            	pushw	x
4062  043a 88            	push	a
4063       00000001      OFST:	set	1
4066                     ; 1226   TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
4068  043b 72195308      	bres	21256,#4
4069                     ; 1229   TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF ))) 
4069                     ; 1230                           | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4071  043f 7b06          	ld	a,(OFST+5,sp)
4072  0441 97            	ld	xl,a
4073  0442 a610          	ld	a,#16
4074  0444 42            	mul	x,a
4075  0445 9f            	ld	a,xl
4076  0446 1a03          	or	a,(OFST+2,sp)
4077  0448 6b01          	ld	(OFST+0,sp),a
4079  044a c65306        	ld	a,21254
4080  044d a40c          	and	a,#12
4081  044f 1a01          	or	a,(OFST+0,sp)
4082  0451 c75306        	ld	21254,a
4083                     ; 1234   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4085  0454 7b02          	ld	a,(OFST+1,sp)
4086  0456 2706          	jreq	L3112
4087                     ; 1236     TIM2->CCER1 |= TIM2_CCER1_CC2P;
4089  0458 721a5308      	bset	21256,#5
4091  045c 2004          	jra	L5112
4092  045e               L3112:
4093                     ; 1240     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
4095  045e 721b5308      	bres	21256,#5
4096  0462               L5112:
4097                     ; 1244   TIM2->CCER1 |= TIM2_CCER1_CC2E;
4099  0462 72185308      	bset	21256,#4
4100                     ; 1245 }
4103  0466 5b03          	addw	sp,#3
4104  0468 81            	ret	
4156                     ; 1261 static void TI3_Config(uint8_t TIM2_ICPolarity, uint8_t TIM2_ICSelection,
4156                     ; 1262                        uint8_t TIM2_ICFilter)
4156                     ; 1263 {
4157                     	switch	.text
4158  0469               L7_TI3_Config:
4160  0469 89            	pushw	x
4161  046a 88            	push	a
4162       00000001      OFST:	set	1
4165                     ; 1265   TIM2->CCER2 &=  (uint8_t)(~TIM2_CCER2_CC3E);
4167  046b 72115309      	bres	21257,#0
4168                     ; 1268   TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF))) 
4168                     ; 1269                           | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4170  046f 7b06          	ld	a,(OFST+5,sp)
4171  0471 97            	ld	xl,a
4172  0472 a610          	ld	a,#16
4173  0474 42            	mul	x,a
4174  0475 9f            	ld	a,xl
4175  0476 1a03          	or	a,(OFST+2,sp)
4176  0478 6b01          	ld	(OFST+0,sp),a
4178  047a c65307        	ld	a,21255
4179  047d a40c          	and	a,#12
4180  047f 1a01          	or	a,(OFST+0,sp)
4181  0481 c75307        	ld	21255,a
4182                     ; 1273   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4184  0484 7b02          	ld	a,(OFST+1,sp)
4185  0486 2706          	jreq	L5412
4186                     ; 1275     TIM2->CCER2 |= TIM2_CCER2_CC3P;
4188  0488 72125309      	bset	21257,#1
4190  048c 2004          	jra	L7412
4191  048e               L5412:
4192                     ; 1279     TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
4194  048e 72135309      	bres	21257,#1
4195  0492               L7412:
4196                     ; 1282   TIM2->CCER2 |= TIM2_CCER2_CC3E;
4198  0492 72105309      	bset	21257,#0
4199                     ; 1283 }
4202  0496 5b03          	addw	sp,#3
4203  0498 81            	ret	
4216                     	xdef	_TIM2_ClearITPendingBit
4217                     	xdef	_TIM2_GetITStatus
4218                     	xdef	_TIM2_ClearFlag
4219                     	xdef	_TIM2_GetFlagStatus
4220                     	xdef	_TIM2_GetPrescaler
4221                     	xdef	_TIM2_GetCounter
4222                     	xdef	_TIM2_GetCapture3
4223                     	xdef	_TIM2_GetCapture2
4224                     	xdef	_TIM2_GetCapture1
4225                     	xdef	_TIM2_SetIC3Prescaler
4226                     	xdef	_TIM2_SetIC2Prescaler
4227                     	xdef	_TIM2_SetIC1Prescaler
4228                     	xdef	_TIM2_SetCompare3
4229                     	xdef	_TIM2_SetCompare2
4230                     	xdef	_TIM2_SetCompare1
4231                     	xdef	_TIM2_SetAutoreload
4232                     	xdef	_TIM2_SetCounter
4233                     	xdef	_TIM2_SelectOCxM
4234                     	xdef	_TIM2_CCxCmd
4235                     	xdef	_TIM2_OC3PolarityConfig
4236                     	xdef	_TIM2_OC2PolarityConfig
4237                     	xdef	_TIM2_OC1PolarityConfig
4238                     	xdef	_TIM2_GenerateEvent
4239                     	xdef	_TIM2_OC3PreloadConfig
4240                     	xdef	_TIM2_OC2PreloadConfig
4241                     	xdef	_TIM2_OC1PreloadConfig
4242                     	xdef	_TIM2_ARRPreloadConfig
4243                     	xdef	_TIM2_ForcedOC3Config
4244                     	xdef	_TIM2_ForcedOC2Config
4245                     	xdef	_TIM2_ForcedOC1Config
4246                     	xdef	_TIM2_PrescalerConfig
4247                     	xdef	_TIM2_SelectOnePulseMode
4248                     	xdef	_TIM2_UpdateRequestConfig
4249                     	xdef	_TIM2_UpdateDisableConfig
4250                     	xdef	_TIM2_ITConfig
4251                     	xdef	_TIM2_Cmd
4252                     	xdef	_TIM2_PWMIConfig
4253                     	xdef	_TIM2_ICInit
4254                     	xdef	_TIM2_OC3Init
4255                     	xdef	_TIM2_OC2Init
4256                     	xdef	_TIM2_OC1Init
4257                     	xdef	_TIM2_TimeBaseInit
4258                     	xdef	_TIM2_DeInit
4277                     	end
