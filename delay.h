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

/* Uses timer TIM4? i think, make this clearer, it is blocking */
void delay_us( unsigned int us );
void delay_ms( unsigned int ms );

/* below delays use 'nops' and were used during development, it uses some magic numbers about CPU freq n stuff so i don't like ->maybe keep/update  and just say uses nop's */
void delay_us_old( unsigned int value );
void delay_ms_old( unsigned int value );

#endif /* __DELAY_H__ */
