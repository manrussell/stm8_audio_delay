   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  46                     ; 52 void ADC1_DeInit(void)
  46                     ; 53 {
  48                     	switch	.text
  49  0000               _ADC1_DeInit:
  53                     ; 54   ADC1->CSR  = ADC1_CSR_RESET_VALUE;
  55  0000 725f5400      	clr	21504
  56                     ; 55   ADC1->CR1  = ADC1_CR1_RESET_VALUE;
  58  0004 725f5401      	clr	21505
  59                     ; 56   ADC1->CR2  = ADC1_CR2_RESET_VALUE;
  61  0008 725f5402      	clr	21506
  62                     ; 57   ADC1->CR3  = ADC1_CR3_RESET_VALUE;
  64  000c 725f5403      	clr	21507
  65                     ; 58   ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
  67  0010 725f5406      	clr	21510
  68                     ; 59   ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
  70  0014 725f5407      	clr	21511
  71                     ; 60   ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
  73  0018 35ff5408      	mov	21512,#255
  74                     ; 61   ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
  76  001c 35035409      	mov	21513,#3
  77                     ; 62   ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
  79  0020 725f540a      	clr	21514
  80                     ; 63   ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
  82  0024 725f540b      	clr	21515
  83                     ; 64   ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
  85  0028 725f540e      	clr	21518
  86                     ; 65   ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
  88  002c 725f540f      	clr	21519
  89                     ; 66 }
  92  0030 81            	ret	
 543                     ; 88 void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_PresSel_TypeDef ADC1_PrescalerSelection, ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState ADC1_SchmittTriggerState)
 543                     ; 89 {
 544                     	switch	.text
 545  0031               _ADC1_Init:
 547  0031 89            	pushw	x
 548       00000000      OFST:	set	0
 551                     ; 91   assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
 553                     ; 92   assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
 555                     ; 93   assert_param(IS_ADC1_PRESSEL_OK(ADC1_PrescalerSelection));
 557                     ; 94   assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
 559                     ; 95   assert_param(IS_FUNCTIONALSTATE_OK(((ADC1_ExtTriggerState))));
 561                     ; 96   assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 563                     ; 97   assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 565                     ; 98   assert_param(IS_FUNCTIONALSTATE_OK(ADC1_SchmittTriggerState));
 567                     ; 103   ADC1_ConversionConfig(ADC1_ConversionMode, ADC1_Channel, ADC1_Align);
 569  0032 7b08          	ld	a,(OFST+8,sp)
 570  0034 88            	push	a
 571  0035 7b02          	ld	a,(OFST+2,sp)
 572  0037 95            	ld	xh,a
 573  0038 cd0121        	call	_ADC1_ConversionConfig
 575  003b 84            	pop	a
 576                     ; 105   ADC1_PrescalerConfig(ADC1_PrescalerSelection);
 578  003c 7b05          	ld	a,(OFST+5,sp)
 579  003e ad54          	call	_ADC1_PrescalerConfig
 581                     ; 110   ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);
 583  0040 7b07          	ld	a,(OFST+7,sp)
 584  0042 97            	ld	xl,a
 585  0043 7b06          	ld	a,(OFST+6,sp)
 586  0045 95            	ld	xh,a
 587  0046 cd014e        	call	_ADC1_ExternalTriggerConfig
 589                     ; 115   ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);
 591  0049 7b0a          	ld	a,(OFST+10,sp)
 592  004b 97            	ld	xl,a
 593  004c 7b09          	ld	a,(OFST+9,sp)
 594  004e 95            	ld	xh,a
 595  004f ad56          	call	_ADC1_SchmittTriggerConfig
 597                     ; 118   ADC1->CR1 |= ADC1_CR1_ADON;
 599  0051 72105401      	bset	21505,#0
 600                     ; 119 }
 603  0055 85            	popw	x
 604  0056 81            	ret	
 639                     ; 126 void ADC1_Cmd(FunctionalState NewState)
 639                     ; 127 {
 640                     	switch	.text
 641  0057               _ADC1_Cmd:
 645                     ; 129   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 647                     ; 131   if (NewState != DISABLE)
 649  0057 4d            	tnz	a
 650  0058 2705          	jreq	L362
 651                     ; 133     ADC1->CR1 |= ADC1_CR1_ADON;
 653  005a 72105401      	bset	21505,#0
 656  005e 81            	ret	
 657  005f               L362:
 658                     ; 137     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_ADON);
 660  005f 72115401      	bres	21505,#0
 661                     ; 139 }
 664  0063 81            	ret	
 699                     ; 146 void ADC1_ScanModeCmd(FunctionalState NewState)
 699                     ; 147 {
 700                     	switch	.text
 701  0064               _ADC1_ScanModeCmd:
 705                     ; 149   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 707                     ; 151   if (NewState != DISABLE)
 709  0064 4d            	tnz	a
 710  0065 2705          	jreq	L503
 711                     ; 153     ADC1->CR2 |= ADC1_CR2_SCAN;
 713  0067 72125402      	bset	21506,#1
 716  006b 81            	ret	
 717  006c               L503:
 718                     ; 157     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_SCAN);
 720  006c 72135402      	bres	21506,#1
 721                     ; 159 }
 724  0070 81            	ret	
 759                     ; 166 void ADC1_DataBufferCmd(FunctionalState NewState)
 759                     ; 167 {
 760                     	switch	.text
 761  0071               _ADC1_DataBufferCmd:
 765                     ; 169   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 767                     ; 171   if (NewState != DISABLE)
 769  0071 4d            	tnz	a
 770  0072 2705          	jreq	L723
 771                     ; 173     ADC1->CR3 |= ADC1_CR3_DBUF;
 773  0074 721e5403      	bset	21507,#7
 776  0078 81            	ret	
 777  0079               L723:
 778                     ; 177     ADC1->CR3 &= (uint8_t)(~ADC1_CR3_DBUF);
 780  0079 721f5403      	bres	21507,#7
 781                     ; 179 }
 784  007d 81            	ret	
 940                     ; 190 void ADC1_ITConfig(ADC1_IT_TypeDef ADC1_IT, FunctionalState NewState)
 940                     ; 191 {
 941                     	switch	.text
 942  007e               _ADC1_ITConfig:
 944  007e 89            	pushw	x
 945       00000000      OFST:	set	0
 948                     ; 193   assert_param(IS_ADC1_IT_OK(ADC1_IT));
 950                     ; 194   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 952                     ; 196   if (NewState != DISABLE)
 954  007f 7b05          	ld	a,(OFST+5,sp)
 955  0081 2706          	jreq	L714
 956                     ; 199     ADC1->CSR |= (uint8_t)ADC1_IT;
 958  0083 9f            	ld	a,xl
 959  0084 ca5400        	or	a,21504
 961  0087 2006          	jra	L124
 962  0089               L714:
 963                     ; 204     ADC1->CSR &= (uint8_t)((uint16_t)~(uint16_t)ADC1_IT);
 965  0089 7b02          	ld	a,(OFST+2,sp)
 966  008b 43            	cpl	a
 967  008c c45400        	and	a,21504
 968  008f               L124:
 969  008f c75400        	ld	21504,a
 970                     ; 206 }
 973  0092 85            	popw	x
 974  0093 81            	ret	
1010                     ; 214 void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
1010                     ; 215 {
1011                     	switch	.text
1012  0094               _ADC1_PrescalerConfig:
1014  0094 88            	push	a
1015       00000000      OFST:	set	0
1018                     ; 217   assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));
1020                     ; 220   ADC1->CR1 &= (uint8_t)(~ADC1_CR1_SPSEL);
1022  0095 c65401        	ld	a,21505
1023  0098 a48f          	and	a,#143
1024  009a c75401        	ld	21505,a
1025                     ; 222   ADC1->CR1 |= (uint8_t)(ADC1_Prescaler);
1027  009d c65401        	ld	a,21505
1028  00a0 1a01          	or	a,(OFST+1,sp)
1029  00a2 c75401        	ld	21505,a
1030                     ; 223 }
1033  00a5 84            	pop	a
1034  00a6 81            	ret	
1081                     ; 233 void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
1081                     ; 234 {
1082                     	switch	.text
1083  00a7               _ADC1_SchmittTriggerConfig:
1085  00a7 89            	pushw	x
1086       00000000      OFST:	set	0
1089                     ; 236   assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
1091                     ; 237   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1093                     ; 239   if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
1095  00a8 9e            	ld	a,xh
1096  00a9 4c            	inc	a
1097  00aa 261d          	jrne	L364
1098                     ; 241     if (NewState != DISABLE)
1100  00ac 9f            	ld	a,xl
1101  00ad 4d            	tnz	a
1102  00ae 270a          	jreq	L564
1103                     ; 243       ADC1->TDRL &= (uint8_t)0x0;
1105  00b0 725f5407      	clr	21511
1106                     ; 244       ADC1->TDRH &= (uint8_t)0x0;
1108  00b4 725f5406      	clr	21510
1110  00b8 2065          	jra	L174
1111  00ba               L564:
1112                     ; 248       ADC1->TDRL |= (uint8_t)0xFF;
1114  00ba c65407        	ld	a,21511
1115  00bd aaff          	or	a,#255
1116  00bf c75407        	ld	21511,a
1117                     ; 249       ADC1->TDRH |= (uint8_t)0xFF;
1119  00c2 c65406        	ld	a,21510
1120  00c5 aaff          	or	a,#255
1121  00c7 2053          	jp	LC001
1122  00c9               L364:
1123                     ; 252   else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
1125  00c9 7b01          	ld	a,(OFST+1,sp)
1126  00cb a108          	cp	a,#8
1127  00cd 0d02          	tnz	(OFST+2,sp)
1128  00cf 2426          	jruge	L374
1129                     ; 254     if (NewState != DISABLE)
1131  00d1 2714          	jreq	L574
1132                     ; 256       ADC1->TDRL &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel));
1134  00d3 5f            	clrw	x
1135  00d4 97            	ld	xl,a
1136  00d5 a601          	ld	a,#1
1137  00d7 5d            	tnzw	x
1138  00d8 2704          	jreq	L43
1139  00da               L63:
1140  00da 48            	sll	a
1141  00db 5a            	decw	x
1142  00dc 26fc          	jrne	L63
1143  00de               L43:
1144  00de 43            	cpl	a
1145  00df c45407        	and	a,21511
1146  00e2               LC002:
1147  00e2 c75407        	ld	21511,a
1149  00e5 2038          	jra	L174
1150  00e7               L574:
1151                     ; 260       ADC1->TDRL |= (uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel);
1153  00e7 5f            	clrw	x
1154  00e8 97            	ld	xl,a
1155  00e9 a601          	ld	a,#1
1156  00eb 5d            	tnzw	x
1157  00ec 2704          	jreq	L04
1158  00ee               L24:
1159  00ee 48            	sll	a
1160  00ef 5a            	decw	x
1161  00f0 26fc          	jrne	L24
1162  00f2               L04:
1163  00f2 ca5407        	or	a,21511
1164  00f5 20eb          	jp	LC002
1165  00f7               L374:
1166                     ; 265     if (NewState != DISABLE)
1168  00f7 2713          	jreq	L305
1169                     ; 267       ADC1->TDRH &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8)));
1171  00f9 a008          	sub	a,#8
1172  00fb 5f            	clrw	x
1173  00fc 97            	ld	xl,a
1174  00fd a601          	ld	a,#1
1175  00ff 5d            	tnzw	x
1176  0100 2704          	jreq	L44
1177  0102               L64:
1178  0102 48            	sll	a
1179  0103 5a            	decw	x
1180  0104 26fc          	jrne	L64
1181  0106               L44:
1182  0106 43            	cpl	a
1183  0107 c45406        	and	a,21510
1185  010a 2010          	jp	LC001
1186  010c               L305:
1187                     ; 271       ADC1->TDRH |= (uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8));
1189  010c a008          	sub	a,#8
1190  010e 5f            	clrw	x
1191  010f 97            	ld	xl,a
1192  0110 a601          	ld	a,#1
1193  0112 5d            	tnzw	x
1194  0113 2704          	jreq	L05
1195  0115               L25:
1196  0115 48            	sll	a
1197  0116 5a            	decw	x
1198  0117 26fc          	jrne	L25
1199  0119               L05:
1200  0119 ca5406        	or	a,21510
1201  011c               LC001:
1202  011c c75406        	ld	21510,a
1203  011f               L174:
1204                     ; 274 }
1207  011f 85            	popw	x
1208  0120 81            	ret	
1265                     ; 286 void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
1265                     ; 287 {
1266                     	switch	.text
1267  0121               _ADC1_ConversionConfig:
1269  0121 89            	pushw	x
1270       00000000      OFST:	set	0
1273                     ; 289   assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
1275                     ; 290   assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
1277                     ; 291   assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
1279                     ; 294   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_ALIGN);
1281  0122 72175402      	bres	21506,#3
1282                     ; 296   ADC1->CR2 |= (uint8_t)(ADC1_Align);
1284  0126 c65402        	ld	a,21506
1285  0129 1a05          	or	a,(OFST+5,sp)
1286  012b c75402        	ld	21506,a
1287                     ; 298   if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
1289  012e 9e            	ld	a,xh
1290  012f 4a            	dec	a
1291  0130 2606          	jrne	L535
1292                     ; 301     ADC1->CR1 |= ADC1_CR1_CONT;
1294  0132 72125401      	bset	21505,#1
1296  0136 2004          	jra	L735
1297  0138               L535:
1298                     ; 306     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_CONT);
1300  0138 72135401      	bres	21505,#1
1301  013c               L735:
1302                     ; 310   ADC1->CSR &= (uint8_t)(~ADC1_CSR_CH);
1304  013c c65400        	ld	a,21504
1305  013f a4f0          	and	a,#240
1306  0141 c75400        	ld	21504,a
1307                     ; 312   ADC1->CSR |= (uint8_t)(ADC1_Channel);
1309  0144 c65400        	ld	a,21504
1310  0147 1a02          	or	a,(OFST+2,sp)
1311  0149 c75400        	ld	21504,a
1312                     ; 313 }
1315  014c 85            	popw	x
1316  014d 81            	ret	
1362                     ; 325 void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
1362                     ; 326 {
1363                     	switch	.text
1364  014e               _ADC1_ExternalTriggerConfig:
1366  014e 89            	pushw	x
1367       00000000      OFST:	set	0
1370                     ; 328   assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
1372                     ; 329   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1374                     ; 332   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTSEL);
1376  014f c65402        	ld	a,21506
1377  0152 a4cf          	and	a,#207
1378  0154 c75402        	ld	21506,a
1379                     ; 334   if (NewState != DISABLE)
1381  0157 9f            	ld	a,xl
1382  0158 4d            	tnz	a
1383  0159 2706          	jreq	L365
1384                     ; 337     ADC1->CR2 |= (uint8_t)(ADC1_CR2_EXTTRIG);
1386  015b 721c5402      	bset	21506,#6
1388  015f 2004          	jra	L565
1389  0161               L365:
1390                     ; 342     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTTRIG);
1392  0161 721d5402      	bres	21506,#6
1393  0165               L565:
1394                     ; 346   ADC1->CR2 |= (uint8_t)(ADC1_ExtTrigger);
1396  0165 c65402        	ld	a,21506
1397  0168 1a01          	or	a,(OFST+1,sp)
1398  016a c75402        	ld	21506,a
1399                     ; 347 }
1402  016d 85            	popw	x
1403  016e 81            	ret	
1427                     ; 358 void ADC1_StartConversion(void)
1427                     ; 359 {
1428                     	switch	.text
1429  016f               _ADC1_StartConversion:
1433                     ; 360   ADC1->CR1 |= ADC1_CR1_ADON;
1435  016f 72105401      	bset	21505,#0
1436                     ; 361 }
1439  0173 81            	ret	
1483                     ; 370 uint16_t ADC1_GetConversionValue(void)
1483                     ; 371 {
1484                     	switch	.text
1485  0174               _ADC1_GetConversionValue:
1487  0174 5205          	subw	sp,#5
1488       00000005      OFST:	set	5
1491                     ; 372   uint16_t temph = 0;
1493                     ; 373   uint8_t templ = 0;
1495                     ; 375   if ((ADC1->CR2 & ADC1_CR2_ALIGN) != 0) /* Right alignment */
1497  0176 720754020e    	btjf	21506,#3,L126
1498                     ; 378     templ = ADC1->DRL;
1500  017b c65405        	ld	a,21509
1501  017e 6b03          	ld	(OFST-2,sp),a
1503                     ; 380     temph = ADC1->DRH;
1505  0180 c65404        	ld	a,21508
1506  0183 97            	ld	xl,a
1508                     ; 382     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
1510  0184 7b03          	ld	a,(OFST-2,sp)
1511  0186 02            	rlwa	x,a
1514  0187 201a          	jra	L326
1515  0189               L126:
1516                     ; 387     temph = ADC1->DRH;
1518  0189 c65404        	ld	a,21508
1519  018c 97            	ld	xl,a
1521                     ; 389     templ = ADC1->DRL;
1523  018d c65405        	ld	a,21509
1524  0190 6b03          	ld	(OFST-2,sp),a
1526                     ; 391     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)((uint16_t)temph << 8));
1528  0192 4f            	clr	a
1529  0193 02            	rlwa	x,a
1530  0194 1f01          	ldw	(OFST-4,sp),x
1532  0196 7b03          	ld	a,(OFST-2,sp)
1533  0198 97            	ld	xl,a
1534  0199 a640          	ld	a,#64
1535  019b 42            	mul	x,a
1536  019c 01            	rrwa	x,a
1537  019d 1a02          	or	a,(OFST-3,sp)
1538  019f 01            	rrwa	x,a
1539  01a0 1a01          	or	a,(OFST-4,sp)
1540  01a2 01            	rrwa	x,a
1542  01a3               L326:
1543                     ; 394   return ((uint16_t)temph);
1547  01a3 5b05          	addw	sp,#5
1548  01a5 81            	ret	
1594                     ; 405 void ADC1_AWDChannelConfig(ADC1_Channel_TypeDef Channel, FunctionalState NewState)
1594                     ; 406 {
1595                     	switch	.text
1596  01a6               _ADC1_AWDChannelConfig:
1598  01a6 89            	pushw	x
1599       00000000      OFST:	set	0
1602                     ; 408   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1604                     ; 409   assert_param(IS_ADC1_CHANNEL_OK(Channel));
1606                     ; 411   if (Channel < (uint8_t)8)
1608  01a7 9e            	ld	a,xh
1609  01a8 a108          	cp	a,#8
1610  01aa 242b          	jruge	L746
1611                     ; 413     if (NewState != DISABLE)
1613  01ac 9f            	ld	a,xl
1614  01ad 4d            	tnz	a
1615  01ae 2711          	jreq	L156
1616                     ; 415       ADC1->AWCRL |= (uint8_t)((uint8_t)1 << Channel);
1618  01b0 9e            	ld	a,xh
1619  01b1 5f            	clrw	x
1620  01b2 97            	ld	xl,a
1621  01b3 a601          	ld	a,#1
1622  01b5 5d            	tnzw	x
1623  01b6 2704          	jreq	L66
1624  01b8               L07:
1625  01b8 48            	sll	a
1626  01b9 5a            	decw	x
1627  01ba 26fc          	jrne	L07
1628  01bc               L66:
1629  01bc ca540f        	or	a,21519
1631  01bf 2011          	jp	LC004
1632  01c1               L156:
1633                     ; 419       ADC1->AWCRL &= (uint8_t)~(uint8_t)((uint8_t)1 << Channel);
1635  01c1 7b01          	ld	a,(OFST+1,sp)
1636  01c3 5f            	clrw	x
1637  01c4 97            	ld	xl,a
1638  01c5 a601          	ld	a,#1
1639  01c7 5d            	tnzw	x
1640  01c8 2704          	jreq	L27
1641  01ca               L47:
1642  01ca 48            	sll	a
1643  01cb 5a            	decw	x
1644  01cc 26fc          	jrne	L47
1645  01ce               L27:
1646  01ce 43            	cpl	a
1647  01cf c4540f        	and	a,21519
1648  01d2               LC004:
1649  01d2 c7540f        	ld	21519,a
1650  01d5 202e          	jra	L556
1651  01d7               L746:
1652                     ; 424     if (NewState != DISABLE)
1654  01d7 7b02          	ld	a,(OFST+2,sp)
1655  01d9 2714          	jreq	L756
1656                     ; 426       ADC1->AWCRH |= (uint8_t)((uint8_t)1 << (Channel - (uint8_t)8));
1658  01db 7b01          	ld	a,(OFST+1,sp)
1659  01dd a008          	sub	a,#8
1660  01df 5f            	clrw	x
1661  01e0 97            	ld	xl,a
1662  01e1 a601          	ld	a,#1
1663  01e3 5d            	tnzw	x
1664  01e4 2704          	jreq	L67
1665  01e6               L001:
1666  01e6 48            	sll	a
1667  01e7 5a            	decw	x
1668  01e8 26fc          	jrne	L001
1669  01ea               L67:
1670  01ea ca540e        	or	a,21518
1672  01ed 2013          	jp	LC003
1673  01ef               L756:
1674                     ; 430       ADC1->AWCRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (uint8_t)(Channel - (uint8_t)8));
1676  01ef 7b01          	ld	a,(OFST+1,sp)
1677  01f1 a008          	sub	a,#8
1678  01f3 5f            	clrw	x
1679  01f4 97            	ld	xl,a
1680  01f5 a601          	ld	a,#1
1681  01f7 5d            	tnzw	x
1682  01f8 2704          	jreq	L201
1683  01fa               L401:
1684  01fa 48            	sll	a
1685  01fb 5a            	decw	x
1686  01fc 26fc          	jrne	L401
1687  01fe               L201:
1688  01fe 43            	cpl	a
1689  01ff c4540e        	and	a,21518
1690  0202               LC003:
1691  0202 c7540e        	ld	21518,a
1692  0205               L556:
1693                     ; 433 }
1696  0205 85            	popw	x
1697  0206 81            	ret	
1732                     ; 441 void ADC1_SetHighThreshold(uint16_t Threshold)
1732                     ; 442 {
1733                     	switch	.text
1734  0207               _ADC1_SetHighThreshold:
1736  0207 89            	pushw	x
1737       00000000      OFST:	set	0
1740                     ; 443   ADC1->HTRH = (uint8_t)(Threshold >> (uint8_t)2);
1742  0208 54            	srlw	x
1743  0209 54            	srlw	x
1744  020a 9f            	ld	a,xl
1745  020b c75408        	ld	21512,a
1746                     ; 444   ADC1->HTRL = (uint8_t)Threshold;
1748  020e 7b02          	ld	a,(OFST+2,sp)
1749  0210 c75409        	ld	21513,a
1750                     ; 445 }
1753  0213 85            	popw	x
1754  0214 81            	ret	
1789                     ; 453 void ADC1_SetLowThreshold(uint16_t Threshold)
1789                     ; 454 {
1790                     	switch	.text
1791  0215               _ADC1_SetLowThreshold:
1795                     ; 455   ADC1->LTRL = (uint8_t)Threshold;
1797  0215 9f            	ld	a,xl
1798  0216 c7540b        	ld	21515,a
1799                     ; 456   ADC1->LTRH = (uint8_t)(Threshold >> (uint8_t)2);
1801  0219 54            	srlw	x
1802  021a 54            	srlw	x
1803  021b 9f            	ld	a,xl
1804  021c c7540a        	ld	21514,a
1805                     ; 457 }
1808  021f 81            	ret	
1861                     ; 466 uint16_t ADC1_GetBufferValue(uint8_t Buffer)
1861                     ; 467 {
1862                     	switch	.text
1863  0220               _ADC1_GetBufferValue:
1865  0220 88            	push	a
1866  0221 5205          	subw	sp,#5
1867       00000005      OFST:	set	5
1870                     ; 468   uint16_t temph = 0;
1872                     ; 469   uint8_t templ = 0;
1874                     ; 472   assert_param(IS_ADC1_BUFFER_OK(Buffer));
1876                     ; 474   if ((ADC1->CR2 & ADC1_CR2_ALIGN) != 0) /* Right alignment */
1878  0223 48            	sll	a
1879  0224 5f            	clrw	x
1880  0225 97            	ld	xl,a
1881  0226 7207540213    	btjf	21506,#3,L547
1882                     ; 477     templ = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1) + 1);
1884  022b d653e1        	ld	a,(21473,x)
1885  022e 6b03          	ld	(OFST-2,sp),a
1887                     ; 479     temph = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1));
1889  0230 7b06          	ld	a,(OFST+1,sp)
1890  0232 48            	sll	a
1891  0233 5f            	clrw	x
1892  0234 97            	ld	xl,a
1893  0235 d653e0        	ld	a,(21472,x)
1894  0238 97            	ld	xl,a
1896                     ; 481     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
1898  0239 7b03          	ld	a,(OFST-2,sp)
1899  023b 02            	rlwa	x,a
1902  023c 2024          	jra	L747
1903  023e               L547:
1904                     ; 486     temph = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1));
1906  023e d653e0        	ld	a,(21472,x)
1907  0241 5f            	clrw	x
1908  0242 97            	ld	xl,a
1909  0243 1f04          	ldw	(OFST-1,sp),x
1911                     ; 488     templ = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1) + 1);
1913  0245 7b06          	ld	a,(OFST+1,sp)
1914  0247 48            	sll	a
1915  0248 5f            	clrw	x
1916  0249 97            	ld	xl,a
1917  024a d653e1        	ld	a,(21473,x)
1918  024d 6b03          	ld	(OFST-2,sp),a
1920                     ; 490     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)(temph << 8));
1922  024f 4f            	clr	a
1923  0250 1e04          	ldw	x,(OFST-1,sp)
1924  0252 02            	rlwa	x,a
1925  0253 1f01          	ldw	(OFST-4,sp),x
1927  0255 7b03          	ld	a,(OFST-2,sp)
1928  0257 97            	ld	xl,a
1929  0258 a640          	ld	a,#64
1930  025a 42            	mul	x,a
1931  025b 01            	rrwa	x,a
1932  025c 1a02          	or	a,(OFST-3,sp)
1933  025e 01            	rrwa	x,a
1934  025f 1a01          	or	a,(OFST-4,sp)
1935  0261 01            	rrwa	x,a
1937  0262               L747:
1938                     ; 493   return ((uint16_t)temph);
1942  0262 5b06          	addw	sp,#6
1943  0264 81            	ret	
2009                     ; 502 FlagStatus ADC1_GetAWDChannelStatus(ADC1_Channel_TypeDef Channel)
2009                     ; 503 {
2010                     	switch	.text
2011  0265               _ADC1_GetAWDChannelStatus:
2013       00000001      OFST:	set	1
2016                     ; 504   uint8_t status = 0;
2018                     ; 507   assert_param(IS_ADC1_CHANNEL_OK(Channel));
2020                     ; 509   if (Channel < (uint8_t)8)
2022  0265 a108          	cp	a,#8
2023  0267 240f          	jruge	L3001
2024                     ; 511     status = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << Channel));
2026  0269 5f            	clrw	x
2027  026a 97            	ld	xl,a
2028  026b a601          	ld	a,#1
2029  026d 5d            	tnzw	x
2030  026e 2704          	jreq	L611
2031  0270               L021:
2032  0270 48            	sll	a
2033  0271 5a            	decw	x
2034  0272 26fc          	jrne	L021
2035  0274               L611:
2036  0274 c4540d        	and	a,21517
2040  0277 81            	ret	
2041  0278               L3001:
2042                     ; 515     status = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (Channel - (uint8_t)8)));
2044  0278 a008          	sub	a,#8
2045  027a 5f            	clrw	x
2046  027b 97            	ld	xl,a
2047  027c a601          	ld	a,#1
2048  027e 5d            	tnzw	x
2049  027f 2704          	jreq	L221
2050  0281               L421:
2051  0281 48            	sll	a
2052  0282 5a            	decw	x
2053  0283 26fc          	jrne	L421
2054  0285               L221:
2055  0285 c4540c        	and	a,21516
2057                     ; 518   return ((FlagStatus)status);
2061  0288 81            	ret	
2219                     ; 527 FlagStatus ADC1_GetFlagStatus(ADC1_Flag_TypeDef Flag)
2219                     ; 528 {
2220                     	switch	.text
2221  0289               _ADC1_GetFlagStatus:
2223  0289 88            	push	a
2224  028a 88            	push	a
2225       00000001      OFST:	set	1
2228                     ; 529   uint8_t flagstatus = 0;
2230                     ; 530   uint8_t temp = 0;
2232                     ; 533   assert_param(IS_ADC1_FLAG_OK(Flag));
2234                     ; 535   if ((Flag & 0x0F) == 0x01)
2236  028b a40f          	and	a,#15
2237  028d 4a            	dec	a
2238  028e 2607          	jrne	L5701
2239                     ; 538     flagstatus = (uint8_t)(ADC1->CR3 & ADC1_CR3_OVR);
2241  0290 c65403        	ld	a,21507
2242  0293 a440          	and	a,#64
2245  0295 2039          	jra	L7701
2246  0297               L5701:
2247                     ; 540   else if ((Flag & 0xF0) == 0x10)
2249  0297 7b02          	ld	a,(OFST+1,sp)
2250  0299 a4f0          	and	a,#240
2251  029b a110          	cp	a,#16
2252  029d 262c          	jrne	L1011
2253                     ; 543     temp = (uint8_t)(Flag & (uint8_t)0x0F);
2255  029f 7b02          	ld	a,(OFST+1,sp)
2256  02a1 a40f          	and	a,#15
2257  02a3 6b01          	ld	(OFST+0,sp),a
2259                     ; 544     if (temp < 8)
2261  02a5 a108          	cp	a,#8
2262  02a7 2410          	jruge	L3011
2263                     ; 546       flagstatus = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
2265  02a9 5f            	clrw	x
2266  02aa 97            	ld	xl,a
2267  02ab a601          	ld	a,#1
2268  02ad 5d            	tnzw	x
2269  02ae 2704          	jreq	L031
2270  02b0               L231:
2271  02b0 48            	sll	a
2272  02b1 5a            	decw	x
2273  02b2 26fc          	jrne	L231
2274  02b4               L031:
2275  02b4 c4540d        	and	a,21517
2278  02b7 2017          	jra	L7701
2279  02b9               L3011:
2280                     ; 550       flagstatus = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
2282  02b9 a008          	sub	a,#8
2283  02bb 5f            	clrw	x
2284  02bc 97            	ld	xl,a
2285  02bd a601          	ld	a,#1
2286  02bf 5d            	tnzw	x
2287  02c0 2704          	jreq	L431
2288  02c2               L631:
2289  02c2 48            	sll	a
2290  02c3 5a            	decw	x
2291  02c4 26fc          	jrne	L631
2292  02c6               L431:
2293  02c6 c4540c        	and	a,21516
2295  02c9 2005          	jra	L7701
2296  02cb               L1011:
2297                     ; 555     flagstatus = (uint8_t)(ADC1->CSR & Flag);
2299  02cb c65400        	ld	a,21504
2300  02ce 1402          	and	a,(OFST+1,sp)
2302  02d0               L7701:
2303                     ; 557   return ((FlagStatus)flagstatus);
2307  02d0 85            	popw	x
2308  02d1 81            	ret	
2352                     ; 567 void ADC1_ClearFlag(ADC1_Flag_TypeDef Flag)
2352                     ; 568 {
2353                     	switch	.text
2354  02d2               _ADC1_ClearFlag:
2356  02d2 88            	push	a
2357  02d3 88            	push	a
2358       00000001      OFST:	set	1
2361                     ; 569   uint8_t temp = 0;
2363                     ; 572   assert_param(IS_ADC1_FLAG_OK(Flag));
2365                     ; 574   if ((Flag & 0x0F) == 0x01)
2367  02d4 a40f          	and	a,#15
2368  02d6 4a            	dec	a
2369  02d7 2606          	jrne	L3311
2370                     ; 577     ADC1->CR3 &= (uint8_t)(~ADC1_CR3_OVR);
2372  02d9 721d5403      	bres	21507,#6
2374  02dd 2045          	jra	L5311
2375  02df               L3311:
2376                     ; 579   else if ((Flag & 0xF0) == 0x10)
2378  02df 7b02          	ld	a,(OFST+1,sp)
2379  02e1 a4f0          	and	a,#240
2380  02e3 a110          	cp	a,#16
2381  02e5 2634          	jrne	L7311
2382                     ; 582     temp = (uint8_t)(Flag & (uint8_t)0x0F);
2384  02e7 7b02          	ld	a,(OFST+1,sp)
2385  02e9 a40f          	and	a,#15
2386  02eb 6b01          	ld	(OFST+0,sp),a
2388                     ; 583     if (temp < 8)
2390  02ed a108          	cp	a,#8
2391  02ef 2414          	jruge	L1411
2392                     ; 585       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
2394  02f1 5f            	clrw	x
2395  02f2 97            	ld	xl,a
2396  02f3 a601          	ld	a,#1
2397  02f5 5d            	tnzw	x
2398  02f6 2704          	jreq	L241
2399  02f8               L441:
2400  02f8 48            	sll	a
2401  02f9 5a            	decw	x
2402  02fa 26fc          	jrne	L441
2403  02fc               L241:
2404  02fc 43            	cpl	a
2405  02fd c4540d        	and	a,21517
2406  0300 c7540d        	ld	21517,a
2408  0303 201f          	jra	L5311
2409  0305               L1411:
2410                     ; 589       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
2412  0305 a008          	sub	a,#8
2413  0307 5f            	clrw	x
2414  0308 97            	ld	xl,a
2415  0309 a601          	ld	a,#1
2416  030b 5d            	tnzw	x
2417  030c 2704          	jreq	L641
2418  030e               L051:
2419  030e 48            	sll	a
2420  030f 5a            	decw	x
2421  0310 26fc          	jrne	L051
2422  0312               L641:
2423  0312 43            	cpl	a
2424  0313 c4540c        	and	a,21516
2425  0316 c7540c        	ld	21516,a
2426  0319 2009          	jra	L5311
2427  031b               L7311:
2428                     ; 594     ADC1->CSR &= (uint8_t) (~Flag);
2430  031b 7b02          	ld	a,(OFST+1,sp)
2431  031d 43            	cpl	a
2432  031e c45400        	and	a,21504
2433  0321 c75400        	ld	21504,a
2434  0324               L5311:
2435                     ; 596 }
2438  0324 85            	popw	x
2439  0325 81            	ret	
2494                     ; 616 ITStatus ADC1_GetITStatus(ADC1_IT_TypeDef ITPendingBit)
2494                     ; 617 {
2495                     	switch	.text
2496  0326               _ADC1_GetITStatus:
2498  0326 89            	pushw	x
2499  0327 88            	push	a
2500       00000001      OFST:	set	1
2503                     ; 618   ITStatus itstatus = RESET;
2505                     ; 619   uint8_t temp = 0;
2507                     ; 622   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
2509                     ; 624   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
2511  0328 01            	rrwa	x,a
2512  0329 a4f0          	and	a,#240
2513  032b 5f            	clrw	x
2514  032c 02            	rlwa	x,a
2515  032d a30010        	cpw	x,#16
2516  0330 262c          	jrne	L5711
2517                     ; 627     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
2519  0332 7b03          	ld	a,(OFST+2,sp)
2520  0334 a40f          	and	a,#15
2521  0336 6b01          	ld	(OFST+0,sp),a
2523                     ; 628     if (temp < 8)
2525  0338 a108          	cp	a,#8
2526  033a 2410          	jruge	L7711
2527                     ; 630       itstatus = (ITStatus)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
2529  033c 5f            	clrw	x
2530  033d 97            	ld	xl,a
2531  033e a601          	ld	a,#1
2532  0340 5d            	tnzw	x
2533  0341 2704          	jreq	L451
2534  0343               L651:
2535  0343 48            	sll	a
2536  0344 5a            	decw	x
2537  0345 26fc          	jrne	L651
2538  0347               L451:
2539  0347 c4540d        	and	a,21517
2542  034a 2017          	jra	L3021
2543  034c               L7711:
2544                     ; 634       itstatus = (ITStatus)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
2546  034c a008          	sub	a,#8
2547  034e 5f            	clrw	x
2548  034f 97            	ld	xl,a
2549  0350 a601          	ld	a,#1
2550  0352 5d            	tnzw	x
2551  0353 2704          	jreq	L061
2552  0355               L261:
2553  0355 48            	sll	a
2554  0356 5a            	decw	x
2555  0357 26fc          	jrne	L261
2556  0359               L061:
2557  0359 c4540c        	and	a,21516
2559  035c 2005          	jra	L3021
2560  035e               L5711:
2561                     ; 639     itstatus = (ITStatus)(ADC1->CSR & (uint8_t)ITPendingBit);
2563  035e c65400        	ld	a,21504
2564  0361 1403          	and	a,(OFST+2,sp)
2566  0363               L3021:
2567                     ; 641   return ((ITStatus)itstatus);
2571  0363 5b03          	addw	sp,#3
2572  0365 81            	ret	
2617                     ; 662 void ADC1_ClearITPendingBit(ADC1_IT_TypeDef ITPendingBit)
2617                     ; 663 {
2618                     	switch	.text
2619  0366               _ADC1_ClearITPendingBit:
2621  0366 89            	pushw	x
2622  0367 88            	push	a
2623       00000001      OFST:	set	1
2626                     ; 664   uint8_t temp = 0;
2628                     ; 667   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
2630                     ; 669   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
2632  0368 01            	rrwa	x,a
2633  0369 a4f0          	and	a,#240
2634  036b 5f            	clrw	x
2635  036c 02            	rlwa	x,a
2636  036d a30010        	cpw	x,#16
2637  0370 2634          	jrne	L7221
2638                     ; 672     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
2640  0372 7b03          	ld	a,(OFST+2,sp)
2641  0374 a40f          	and	a,#15
2642  0376 6b01          	ld	(OFST+0,sp),a
2644                     ; 673     if (temp < 8)
2646  0378 a108          	cp	a,#8
2647  037a 2414          	jruge	L1321
2648                     ; 675       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
2650  037c 5f            	clrw	x
2651  037d 97            	ld	xl,a
2652  037e a601          	ld	a,#1
2653  0380 5d            	tnzw	x
2654  0381 2704          	jreq	L661
2655  0383               L071:
2656  0383 48            	sll	a
2657  0384 5a            	decw	x
2658  0385 26fc          	jrne	L071
2659  0387               L661:
2660  0387 43            	cpl	a
2661  0388 c4540d        	and	a,21517
2662  038b c7540d        	ld	21517,a
2664  038e 201f          	jra	L5321
2665  0390               L1321:
2666                     ; 679       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
2668  0390 a008          	sub	a,#8
2669  0392 5f            	clrw	x
2670  0393 97            	ld	xl,a
2671  0394 a601          	ld	a,#1
2672  0396 5d            	tnzw	x
2673  0397 2704          	jreq	L271
2674  0399               L471:
2675  0399 48            	sll	a
2676  039a 5a            	decw	x
2677  039b 26fc          	jrne	L471
2678  039d               L271:
2679  039d 43            	cpl	a
2680  039e c4540c        	and	a,21516
2681  03a1 c7540c        	ld	21516,a
2682  03a4 2009          	jra	L5321
2683  03a6               L7221:
2684                     ; 684     ADC1->CSR &= (uint8_t)((uint16_t)~(uint16_t)ITPendingBit);
2686  03a6 7b03          	ld	a,(OFST+2,sp)
2687  03a8 43            	cpl	a
2688  03a9 c45400        	and	a,21504
2689  03ac c75400        	ld	21504,a
2690  03af               L5321:
2691                     ; 686 }
2694  03af 5b03          	addw	sp,#3
2695  03b1 81            	ret	
2708                     	xdef	_ADC1_ClearITPendingBit
2709                     	xdef	_ADC1_GetITStatus
2710                     	xdef	_ADC1_ClearFlag
2711                     	xdef	_ADC1_GetFlagStatus
2712                     	xdef	_ADC1_GetAWDChannelStatus
2713                     	xdef	_ADC1_GetBufferValue
2714                     	xdef	_ADC1_SetLowThreshold
2715                     	xdef	_ADC1_SetHighThreshold
2716                     	xdef	_ADC1_GetConversionValue
2717                     	xdef	_ADC1_StartConversion
2718                     	xdef	_ADC1_AWDChannelConfig
2719                     	xdef	_ADC1_ExternalTriggerConfig
2720                     	xdef	_ADC1_ConversionConfig
2721                     	xdef	_ADC1_SchmittTriggerConfig
2722                     	xdef	_ADC1_PrescalerConfig
2723                     	xdef	_ADC1_ITConfig
2724                     	xdef	_ADC1_DataBufferCmd
2725                     	xdef	_ADC1_ScanModeCmd
2726                     	xdef	_ADC1_Cmd
2727                     	xdef	_ADC1_Init
2728                     	xdef	_ADC1_DeInit
2747                     	end
