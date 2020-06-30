/********************************************************************
* Driver delay for stm8
* Author manrussell
* date
* free to use
*
********************************************************************/

#ifndef __MAIN_H__
#define __MAIN_H__
/*
    Pins uC
    =======
    from stm8CubeMx...

    spi sclk pc-5
    spi sdi pc-6
    spi spo pc-7

    spi cs ram chip pa-1
    spi cs dac cip pc-4

*/

#include "stm8s.h"

// is this used anymore?
#define LED_pin                     GPIO_PIN_4 
#define LED_port                    GPIOD

//SPI uC
#define SPI_PORT                    GPIOC
#define SPI_CLK                     GPIO_PIN_5
#define SPI_MOSI                    GPIO_PIN_6
#define SPI_MISO                    GPIO_PIN_7

//SPI DAC
#define DAC_CS_pin                  GPIO_PIN_4
#define DAC_CS_port                 GPIOC

//SPI RAM
#define RAM_CS_pin                  GPIO_PIN_1
#define RAM_CS_port                 GPIOA

//uC ADC
#define ADC_port                    GPIOB
#define ADC_LEFTCHANNEL_IN_pin      GPIO_PIN_0 // % ??
#define ADC_LEFTCHANNEL             0

#define ADC_FEEDBACK_AMOUNT_pin     GPIO_PIN_1 // % ??
#define ADC_FEEDBACK_AMOUNT         1

#define ADC_DELAY_LENGTH_pin        GPIO_PIN_2 // ms ??
#define ADC_DELAY_LENGTH            2

#define ADC_DRYWETMIX_pin           GPIO_PIN_3
#define ADC_DRYWETMIX               3

#define ADC_ELSE_pin                GPIO_PIN_4 // not used so far
#define ADC_ELSE                    4

#define ADC_Multichannel_pins       ((GPIO_Pin_TypeDef)(ADC_LEFTCHANNEL_IN_pin | ADC_FEEDBACK_AMOUNT_pin | ADC_DELAY_LENGTH_pin | ADC_DRYWETMIX_pin ))

#define NUM_Of_ADCPOT_SAMPLES       4

#endif /* __MAIN_H__ */
