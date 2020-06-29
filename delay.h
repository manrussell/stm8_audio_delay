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

void delay_us( unsigned int us );
void delay_ms( unsigned int ms );

// below delays use 'nops' and were used during development
void delay_us_old( unsigned int value );
void delay_ms_old( unsigned int value );

#endif /* __DELAY_H__ */
