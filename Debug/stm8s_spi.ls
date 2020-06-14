   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  46                     ; 50 void SPI_DeInit(void)
  46                     ; 51 {
  48                     	switch	.text
  49  0000               _SPI_DeInit:
  53                     ; 52   SPI->CR1    = SPI_CR1_RESET_VALUE;
  55  0000 725f5200      	clr	20992
  56                     ; 53   SPI->CR2    = SPI_CR2_RESET_VALUE;
  58  0004 725f5201      	clr	20993
  59                     ; 54   SPI->ICR    = SPI_ICR_RESET_VALUE;
  61  0008 725f5202      	clr	20994
  62                     ; 55   SPI->SR     = SPI_SR_RESET_VALUE;
  64  000c 35025203      	mov	20995,#2
  65                     ; 56   SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  67  0010 35075205      	mov	20997,#7
  68                     ; 57 }
  71  0014 81            	ret	
 387                     ; 78 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 387                     ; 79 {
 388                     	switch	.text
 389  0015               _SPI_Init:
 391  0015 89            	pushw	x
 392  0016 88            	push	a
 393       00000001      OFST:	set	1
 396                     ; 81   assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 398                     ; 82   assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 400                     ; 83   assert_param(IS_SPI_MODE_OK(Mode));
 402                     ; 84   assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 404                     ; 85   assert_param(IS_SPI_PHASE_OK(ClockPhase));
 406                     ; 86   assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 408                     ; 87   assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 410                     ; 88   assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 412                     ; 91   SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 412                     ; 92                        (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 414  0017 7b07          	ld	a,(OFST+6,sp)
 415  0019 1a08          	or	a,(OFST+7,sp)
 416  001b 6b01          	ld	(OFST+0,sp),a
 418  001d 9f            	ld	a,xl
 419  001e 1a02          	or	a,(OFST+1,sp)
 420  0020 1a01          	or	a,(OFST+0,sp)
 421  0022 c75200        	ld	20992,a
 422                     ; 95   SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 424  0025 7b09          	ld	a,(OFST+8,sp)
 425  0027 1a0a          	or	a,(OFST+9,sp)
 426  0029 c75201        	ld	20993,a
 427                     ; 97   if (Mode == SPI_MODE_MASTER)
 429  002c 7b06          	ld	a,(OFST+5,sp)
 430  002e a104          	cp	a,#4
 431  0030 2606          	jrne	L302
 432                     ; 99     SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 434  0032 72105201      	bset	20993,#0
 436  0036 2004          	jra	L502
 437  0038               L302:
 438                     ; 103     SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 440  0038 72115201      	bres	20993,#0
 441  003c               L502:
 442                     ; 107   SPI->CR1 |= (uint8_t)(Mode);
 444  003c c65200        	ld	a,20992
 445  003f 1a06          	or	a,(OFST+5,sp)
 446  0041 c75200        	ld	20992,a
 447                     ; 110   SPI->CRCPR = (uint8_t)CRCPolynomial;
 449  0044 7b0b          	ld	a,(OFST+10,sp)
 450  0046 c75205        	ld	20997,a
 451                     ; 111 }
 454  0049 5b03          	addw	sp,#3
 455  004b 81            	ret	
 510                     ; 119 void SPI_Cmd(FunctionalState NewState)
 510                     ; 120 {
 511                     	switch	.text
 512  004c               _SPI_Cmd:
 516                     ; 122   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 518                     ; 124   if (NewState != DISABLE)
 520  004c 4d            	tnz	a
 521  004d 2705          	jreq	L532
 522                     ; 126     SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 524  004f 721c5200      	bset	20992,#6
 527  0053 81            	ret	
 528  0054               L532:
 529                     ; 130     SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 531  0054 721d5200      	bres	20992,#6
 532                     ; 132 }
 535  0058 81            	ret	
 644                     ; 141 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 644                     ; 142 {
 645                     	switch	.text
 646  0059               _SPI_ITConfig:
 648  0059 89            	pushw	x
 649  005a 88            	push	a
 650       00000001      OFST:	set	1
 653                     ; 143   uint8_t itpos = 0;
 655                     ; 145   assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 657                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 659                     ; 149   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 661  005b 9e            	ld	a,xh
 662  005c a40f          	and	a,#15
 663  005e 5f            	clrw	x
 664  005f 97            	ld	xl,a
 665  0060 a601          	ld	a,#1
 666  0062 5d            	tnzw	x
 667  0063 2704          	jreq	L41
 668  0065               L61:
 669  0065 48            	sll	a
 670  0066 5a            	decw	x
 671  0067 26fc          	jrne	L61
 672  0069               L41:
 673  0069 6b01          	ld	(OFST+0,sp),a
 675                     ; 151   if (NewState != DISABLE)
 677  006b 0d03          	tnz	(OFST+2,sp)
 678  006d 2707          	jreq	L113
 679                     ; 153     SPI->ICR |= itpos; /* Enable interrupt*/
 681  006f c65202        	ld	a,20994
 682  0072 1a01          	or	a,(OFST+0,sp)
 684  0074 2004          	jra	L313
 685  0076               L113:
 686                     ; 157     SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 688  0076 43            	cpl	a
 689  0077 c45202        	and	a,20994
 690  007a               L313:
 691  007a c75202        	ld	20994,a
 692                     ; 159 }
 695  007d 5b03          	addw	sp,#3
 696  007f 81            	ret	
 730                     ; 166 void SPI_SendData(uint8_t Data)
 730                     ; 167 {
 731                     	switch	.text
 732  0080               _SPI_SendData:
 736                     ; 168   SPI->DR = Data; /* Write in the DR register the data to be sent*/
 738  0080 c75204        	ld	20996,a
 739                     ; 169 }
 742  0083 81            	ret	
 765                     ; 176 uint8_t SPI_ReceiveData(void)
 765                     ; 177 {
 766                     	switch	.text
 767  0084               _SPI_ReceiveData:
 771                     ; 178   return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
 773  0084 c65204        	ld	a,20996
 776  0087 81            	ret	
 812                     ; 187 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 812                     ; 188 {
 813                     	switch	.text
 814  0088               _SPI_NSSInternalSoftwareCmd:
 818                     ; 190   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 820                     ; 192   if (NewState != DISABLE)
 822  0088 4d            	tnz	a
 823  0089 2705          	jreq	L163
 824                     ; 194     SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 826  008b 72105201      	bset	20993,#0
 829  008f 81            	ret	
 830  0090               L163:
 831                     ; 198     SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 833  0090 72115201      	bres	20993,#0
 834                     ; 200 }
 837  0094 81            	ret	
 860                     ; 207 void SPI_TransmitCRC(void)
 860                     ; 208 {
 861                     	switch	.text
 862  0095               _SPI_TransmitCRC:
 866                     ; 209   SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 868  0095 72185201      	bset	20993,#4
 869                     ; 210 }
 872  0099 81            	ret	
 908                     ; 218 void SPI_CalculateCRCCmd(FunctionalState NewState)
 908                     ; 219 {
 909                     	switch	.text
 910  009a               _SPI_CalculateCRCCmd:
 914                     ; 221   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 916                     ; 223   if (NewState != DISABLE)
 918  009a 4d            	tnz	a
 919  009b 2705          	jreq	L314
 920                     ; 225     SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 922  009d 721a5201      	bset	20993,#5
 925  00a1 81            	ret	
 926  00a2               L314:
 927                     ; 229     SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 929  00a2 721b5201      	bres	20993,#5
 930                     ; 231 }
 933  00a6 81            	ret	
 997                     ; 238 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 997                     ; 239 {
 998                     	switch	.text
 999  00a7               _SPI_GetCRC:
1001       00000001      OFST:	set	1
1004                     ; 240   uint8_t crcreg = 0;
1006                     ; 243   assert_param(IS_SPI_CRC_OK(SPI_CRC));
1008                     ; 245   if (SPI_CRC != SPI_CRC_RX)
1010  00a7 4d            	tnz	a
1011  00a8 2704          	jreq	L154
1012                     ; 247     crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1014  00aa c65207        	ld	a,20999
1018  00ad 81            	ret	
1019  00ae               L154:
1020                     ; 251     crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1022  00ae c65206        	ld	a,20998
1024                     ; 255   return crcreg;
1028  00b1 81            	ret	
1053                     ; 263 void SPI_ResetCRC(void)
1053                     ; 264 {
1054                     	switch	.text
1055  00b2               _SPI_ResetCRC:
1059                     ; 267   SPI_CalculateCRCCmd(ENABLE);
1061  00b2 a601          	ld	a,#1
1062  00b4 ade4          	call	_SPI_CalculateCRCCmd
1064                     ; 270   SPI_Cmd(ENABLE);
1066  00b6 a601          	ld	a,#1
1068                     ; 271 }
1071  00b8 2092          	jp	_SPI_Cmd
1095                     ; 278 uint8_t SPI_GetCRCPolynomial(void)
1095                     ; 279 {
1096                     	switch	.text
1097  00ba               _SPI_GetCRCPolynomial:
1101                     ; 280   return SPI->CRCPR; /* Return the CRC polynomial register */
1103  00ba c65205        	ld	a,20997
1106  00bd 81            	ret	
1162                     ; 288 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1162                     ; 289 {
1163                     	switch	.text
1164  00be               _SPI_BiDirectionalLineConfig:
1168                     ; 291   assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1170                     ; 293   if (SPI_Direction != SPI_DIRECTION_RX)
1172  00be 4d            	tnz	a
1173  00bf 2705          	jreq	L325
1174                     ; 295     SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1176  00c1 721c5201      	bset	20993,#6
1179  00c5 81            	ret	
1180  00c6               L325:
1181                     ; 299     SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1183  00c6 721d5201      	bres	20993,#6
1184                     ; 301 }
1187  00ca 81            	ret	
1308                     ; 311 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1308                     ; 312 {
1309                     	switch	.text
1310  00cb               _SPI_GetFlagStatus:
1312       00000001      OFST:	set	1
1315                     ; 313   FlagStatus status = RESET;
1317                     ; 315   assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1319                     ; 318   if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1321  00cb c45203        	and	a,20995
1322  00ce 2702          	jreq	L306
1323                     ; 320     status = SET; /* SPI_FLAG is set */
1325  00d0 a601          	ld	a,#1
1328  00d2               L306:
1329                     ; 324     status = RESET; /* SPI_FLAG is reset*/
1332                     ; 328   return status;
1336  00d2 81            	ret	
1371                     ; 346 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1371                     ; 347 {
1372                     	switch	.text
1373  00d3               _SPI_ClearFlag:
1377                     ; 348   assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1379                     ; 350   SPI->SR = (uint8_t)(~SPI_FLAG);
1381  00d3 43            	cpl	a
1382  00d4 c75203        	ld	20995,a
1383                     ; 351 }
1386  00d7 81            	ret	
1468                     ; 366 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1468                     ; 367 {
1469                     	switch	.text
1470  00d8               _SPI_GetITStatus:
1472  00d8 88            	push	a
1473  00d9 89            	pushw	x
1474       00000002      OFST:	set	2
1477                     ; 368   ITStatus pendingbitstatus = RESET;
1479                     ; 369   uint8_t itpos = 0;
1481                     ; 370   uint8_t itmask1 = 0;
1483                     ; 371   uint8_t itmask2 = 0;
1485                     ; 372   uint8_t enablestatus = 0;
1487                     ; 373   assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1489                     ; 375   itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1491  00da a40f          	and	a,#15
1492  00dc 5f            	clrw	x
1493  00dd 97            	ld	xl,a
1494  00de a601          	ld	a,#1
1495  00e0 5d            	tnzw	x
1496  00e1 2704          	jreq	L45
1497  00e3               L65:
1498  00e3 48            	sll	a
1499  00e4 5a            	decw	x
1500  00e5 26fc          	jrne	L65
1501  00e7               L45:
1502  00e7 6b01          	ld	(OFST-1,sp),a
1504                     ; 378   itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1506  00e9 7b03          	ld	a,(OFST+1,sp)
1507  00eb 4e            	swap	a
1508  00ec a40f          	and	a,#15
1509  00ee 6b02          	ld	(OFST+0,sp),a
1511                     ; 380   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1513  00f0 5f            	clrw	x
1514  00f1 97            	ld	xl,a
1515  00f2 a601          	ld	a,#1
1516  00f4 5d            	tnzw	x
1517  00f5 2704          	jreq	L06
1518  00f7               L26:
1519  00f7 48            	sll	a
1520  00f8 5a            	decw	x
1521  00f9 26fc          	jrne	L26
1522  00fb               L06:
1524                     ; 382   enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1526  00fb c45203        	and	a,20995
1527  00fe 6b02          	ld	(OFST+0,sp),a
1529                     ; 384   if (((SPI->ICR & itpos) != RESET) && enablestatus)
1531  0100 c65202        	ld	a,20994
1532  0103 1501          	bcp	a,(OFST-1,sp)
1533  0105 2708          	jreq	L766
1535  0107 7b02          	ld	a,(OFST+0,sp)
1536  0109 2704          	jreq	L766
1537                     ; 387     pendingbitstatus = SET;
1539  010b a601          	ld	a,#1
1542  010d 2001          	jra	L176
1543  010f               L766:
1544                     ; 392     pendingbitstatus = RESET;
1546  010f 4f            	clr	a
1548  0110               L176:
1549                     ; 395   return  pendingbitstatus;
1553  0110 5b03          	addw	sp,#3
1554  0112 81            	ret	
1599                     ; 412 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1599                     ; 413 {
1600                     	switch	.text
1601  0113               _SPI_ClearITPendingBit:
1603       00000001      OFST:	set	1
1606                     ; 414   uint8_t itpos = 0;
1608                     ; 415   assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1610                     ; 420   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
1612  0113 4e            	swap	a
1613  0114 a40f          	and	a,#15
1614  0116 5f            	clrw	x
1615  0117 97            	ld	xl,a
1616  0118 a601          	ld	a,#1
1617  011a 5d            	tnzw	x
1618  011b 2704          	jreq	L66
1619  011d               L07:
1620  011d 48            	sll	a
1621  011e 5a            	decw	x
1622  011f 26fc          	jrne	L07
1623  0121               L66:
1625                     ; 422   SPI->SR = (uint8_t)(~itpos);
1627  0121 43            	cpl	a
1628  0122 c75203        	ld	20995,a
1629                     ; 424 }
1632  0125 81            	ret	
1645                     	xdef	_SPI_ClearITPendingBit
1646                     	xdef	_SPI_GetITStatus
1647                     	xdef	_SPI_ClearFlag
1648                     	xdef	_SPI_GetFlagStatus
1649                     	xdef	_SPI_BiDirectionalLineConfig
1650                     	xdef	_SPI_GetCRCPolynomial
1651                     	xdef	_SPI_ResetCRC
1652                     	xdef	_SPI_GetCRC
1653                     	xdef	_SPI_CalculateCRCCmd
1654                     	xdef	_SPI_TransmitCRC
1655                     	xdef	_SPI_NSSInternalSoftwareCmd
1656                     	xdef	_SPI_ReceiveData
1657                     	xdef	_SPI_SendData
1658                     	xdef	_SPI_ITConfig
1659                     	xdef	_SPI_Cmd
1660                     	xdef	_SPI_Init
1661                     	xdef	_SPI_DeInit
1680                     	end
