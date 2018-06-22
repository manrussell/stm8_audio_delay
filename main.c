/**
  ******************************************************************************
  * @file    Project/main.c 
  * @author  MCD Application Team
  * @version V2.2.0
  * @date    30-September-2014
  * @brief   Main program body
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Private defines -----------------------------------------------------------*/
#define LED_pin                      GPIO_PIN_4
#define LED_port                     GPIOD

/* Private function prototypes -----------------------------------------------*/
void setup(void);
void clock_setup(void);
void GPIO_setup(void);
void SPI_setup(void);
void ADC1_setup(void);
void TIM2_setup(void);

void delay_us(unsigned int  value);
void delay_ms(unsigned int  value);

/* Private functions ---------------------------------------------------------*/

void main(void)
{
	uint16_t i = 1;
	uint16_t x = 8;
	uint16_t pwm_duty = 0;
	
	clock_setup();
	GPIO_setup();
	ADC1_setup();
	TIM2_setup();
		
	GPIO_WriteHigh(LED_port, LED_pin);
	
	GPIO_WriteLow(LED_port, LED_pin);
	
  /* Infinite loop */
  while (1)
  {
		i +=1;
		
		ADC1_StartConversion();
		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
														 
		//x = (ADC1_GetConversionValue() %1000)-500; // for led brightness proportional to volume
		x = (ADC1_GetConversionValue() %1000); // for led knob
		ADC1_ClearFlag(ADC1_FLAG_EOC);
	
		TIM2_SetCompare1(x);
		
	}
  
}

void clock_setup(void)
{
  CLK_DeInit();

  CLK_HSECmd(DISABLE);
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
                                
  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
                                
  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                                
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
  //CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
                                
}

void GPIO_setup(void)
{                               
  //GPIO_DeInit(GPIOC);
  //GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6), GPIO_MODE_OUT_PP_HIGH_FAST);
  
  //adc pin b0
	GPIO_DeInit(GPIOB);
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
	
  GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
}

void ADC1_setup(void)
{
  ADC1_DeInit();         
  
  ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
  ADC1_CHANNEL_0,\
  ADC1_PRESSEL_FCPU_D18, \
  ADC1_EXTTRIG_GPIO, \
  DISABLE, \
  ADC1_ALIGN_RIGHT, \
  ADC1_SCHMITTTRIG_CHANNEL0, \
  DISABLE);

  ADC1_Cmd(ENABLE);

}




void TIM2_setup(void)
{
  TIM2_DeInit();
  TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
  TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
  TIM2_Cmd(ENABLE);

}

//stm_delay.h
#define F_CPU 				2000000UL 
#define dly_const			(F_CPU / 16000000.0F) 

void delay_us(unsigned int  value)
{
	register unsigned int loops =  (dly_const * value) ;
	
	while(loops)
	{
		_asm ("nop");
		loops--;
	};
}

void delay_ms(unsigned int  value)
{
	while(value)
	{
		delay_us(1000);
		value--;
	};
}




#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
