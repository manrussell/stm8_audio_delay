/********************************************************************
* Driver delay for stm8
* Author manrussell
* date
* free to use
*
********************************************************************/

#ifndef __DELAY_C__
#define __DELAY_C__

#include "delay.h"

//stm_delay.h
#define F_CPU               2000000UL
#define dly_const           (F_CPU / 16000000.0F)

void delay_us_old( unsigned int value )
{
    register unsigned int loops = ( dly_const * value );

    while(loops)
    {
        _asm ("nop");
        loops--;
    };
}

void delay_ms_old( unsigned int value )
{
    while(value)
    {
        delay_us(1000);
        value--;
    };
}


/* Blocking delay
*/
void delay_us( unsigned int us )
{
    TIM4_DeInit();

    if((us <= 200) && (us >= 0))
    {
        TIM4_TimeBaseInit(TIM4_PRESCALER_16, 200);
        TIM4_Cmd(ENABLE);
    }
    else if((us <= 400) && (us > 200))
    {
        us >>= 1;
        TIM4_TimeBaseInit(TIM4_PRESCALER_32, 200);
        TIM4_Cmd(ENABLE);
    }
    else if((us <= 800) && (us > 400))
    {
        us >>= 2;
        TIM4_TimeBaseInit(TIM4_PRESCALER_64, 200);
        TIM4_Cmd(ENABLE);
    }
    else if((us <= 1600) && (us > 800))
    {
        us >>= 3;
        TIM4_TimeBaseInit(TIM4_PRESCALER_128, 200);
        TIM4_Cmd(ENABLE);
    }

    while(TIM4_GetCounter() < us);
    TIM4_ClearFlag(TIM4_FLAG_UPDATE);
    TIM4_Cmd(DISABLE);
}

/* Blocking delay
*/
void delay_ms( unsigned int ms )
{
    while(ms--)
    {
        delay_us(1000);
    };
}


#endif /* __DELAY_C__ */
