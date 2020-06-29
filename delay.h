/********************************************************************
* Driver delay for stm8
* Author manrussell
* date
* free to use
*
********************************************************************/

#ifndef __DELAY_H__
#define __DELAY_H__

#include "stm8s.h"

void delay_us( unsigned int value );
void delay_ms( unsigned int value );
void delay_us_new( unsigned int us );
void delay_ms_new( unsigned int ms );

#endif /* __DELAY_H__ */
