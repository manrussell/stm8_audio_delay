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
/*
* I might have borken all the Test functions now i am using multichannel ADC's
* Why do the spi function need a delay_us(1) -> is the caputre flag set correctly?

* I think the clocks are set wrong! HSI not HSE, check it out, hmm maybe my ext clock is 8MHz.
* check out the cs pin for spi, do i need to init my own gpio? yes
* check for any extra gpio hat might have been used, and are redundant.
* review tests

*/

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "main.h"
#include "delay.h"
#include "mcp4901_spi_dac.h"
#include "mcp_23k256_spi_ram.h"
#include "tests_hw.h"

/* Private defines -----------------------------------------------------------*/

/* Private function prototypes -----------------------------------------------*/
void setup(void);
void clock_setup(void);
void GPIO_setup(void);
void SPI_setup(void);
void ADC1_setup(void);
void TIM2_setup(void);

//tests, used while setting up hardware.

/* Private functions ---------------------------------------------------------*/
uint8_t state = 0; /* updated by Tim2 timer interrupt function */

void main( void )
{
    uint16_t adc_leftChannel = 0;
    uint16_t adc_feedback    = 0;
    uint16_t adc_delay       = 0;
    uint8_t  mapd_value      = 0;    // mapped adc valu
    uint8_t  read_val        = 0;    // read val from ram
    uint16_t write_addr      = 0;    // write addr in ram
    uint16_t read_addr       = 0;    // read addr in val
    uint16_t delay           = 110;  // length of delay in samples
    uint8_t  res             = 0;

    uint16_t delay_length_samples[NUM_Of_ADCPOT_SAMPLES] = {0}; // 4 samples of the pot are calculated

    clock_setup( );
    GPIO_setup( );
    ADC1_setup( );
    SPI_setup( );
    MCP_23K256_RAM_init( );
    MCP4901_DAC_init( );
    TIM2_setup( );

  /* Infinite loop */
  while (1)
  {
        switch( state )
        {
            case 0:
            case 1:
            case 2:
            case 3:
                /* Read ADC's of pots and store in array */
                // multi channel ADC's
                // how long does the scantake? meaaure this start/stop -> gpio-> oscilloscope
                // will want to separate the knobs from signal input,
                //
                ADC1_ScanModeCmd( ENABLE );
                ADC1_StartConversion( );
                while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
                ADC1_ClearFlag( ADC1_FLAG_EOC );
                //adc_leftChannel = ADC1_GetBufferValue( 0 ); //ADC_LEFTCHANNEL );
                adc_delay  = ADC1_GetBufferValue( 1 ); //ADC_FEEDBACK_AMOUNT );
                //adc_delay = ADC1_GetBufferValue( ADC_DELAY_LENGTH );

                //ADC1_ClearFlag( ADC1_FLAG_EOC );

                //set delay buffer length, longer == longer delay
                delay = ( adc_delay << 2 );
                delay_length_samples[ state ] = ( adc_delay << 2 );

                break;
            case 4:
            case 5:
            case 6:
                /* do nothing */
                break;
            case 7:
                /* do average of ADC pots values */
                // how long does this take?
                // this seems to break, is the maths? do i need a bigger type, or to cast?
                //delay = ( delay_length_samples[0] + delay_length_samples[1] + delay_length_samples[2] + delay_length_samples[3] ) / NUM_Of_ADCPOT_SAMPLES;
                break;
            case 8:
                /* Sample Audio ADC, process, write to DAC */
                //sample audio input
                ADC1_ScanModeCmd( ENABLE );
                ADC1_StartConversion( );
                while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
                ADC1_ClearFlag(ADC1_FLAG_EOC);
                adc_leftChannel = ADC1_GetBufferValue( 0 ); //ADC_LEFTCHANNEL );

                // map function 10bit to 8bit
                // (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
                // input range 0-1024 out range 0-255 therefore
                // slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
                // function simplfys down to
                mapd_value = (adc_leftChannel >> 2);

                //with feedback 50% wet
                mapd_value = mapd_value/2 +  read_val/2;

                // sort out read addresses
                if( (write_addr - delay) < 0)
                {
                    //start up situation
                    read_addr = SRAM_SIZE - delay + write_addr;
                }

                if( (write_addr - delay) >= 0)
                {
                    read_addr = write_addr - delay;
                }

                //write to ram
                    MCP_23K256_RAM_write_byte(write_addr, mapd_value);

                //read from ram
                    MCP_23K256_RAM_read_byte(read_addr, &read_val);

                //write value to dac
                    MCP4901_DAC_write(read_val);

                //increment write pointer
                    write_addr++;

                break;
            case 9:
                /* update ram, read new ram value for feedback */

                break;

            default:
                /* do nothing */
                break;
        }
    }
}

void clock_setup(void)
{
  CLK_DeInit();

  CLK_HSECmd(DISABLE); // DISABLE ->24MHz ext, what do i have 16?
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);   //ENABLE, 16MHz internal
  while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);

  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);

  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);

}

/*
    Timer interrupt for 11025Hz freq
    16,000,000 / 11025 = 1451.247
    https://eleccelerator.com/avr-timer-calculator/

    if count = 1451
    then Freq = 11026.878015161958
*/
void TIM2_setup( void )
{
  TIM2_DeInit( );
  TIM2_TimeBaseInit( TIM2_PRESCALER_1, 145 );
  TIM2_ITConfig( TIM2_IT_UPDATE, ENABLE );
  TIM2_Cmd( ENABLE );
  enableInterrupts( );
}


void GPIO_setup( void )
{
    //GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
}

/*
* Multichannle ADC
Explanation required.

• input impedance of <10K Ohms
• It is better to keep ADC clock within or less than 4MHz
• Schmitt triggers must be disabled.
• Opamp-based input buffer and filter circuits are preferred if possible
• If the ADC has reference source pins, they should be connected to a precision reference source
like LM336. It is recommended to use a good LDO regulator chip otherwise.
• Unused ADC pins should not be configured or disabled. This will reduce power consumption.
• Rather taking single samples, ADC readings should be sampled at fixed regular intervals and averaged to get rid of minute fluctuations in readings.
• Right-justified data alignment should be used as it is most convenient to use.
• PCB/wire tracks leading to ADC channels must be short to reduce interference effects.

*/
// ADC1_CONVERSIONMODE_SINGLE
// ADC1_CONVERSIONMODE_CONTINUOUS

/*
Single mode seems to take the last reading(buff 1) and pass that to both
outputs, leftchannel and delay.

continuous mode seems to take the buffer 0 one and ignore buffer 1 and pass that to leftchannel and delay

*/
void ADC1_setup(void)
{
  // ADC, we have to set out ADC pin as a floating GPIO with no interrupt capability:
  // ADC gpio's for scan mode
  GPIO_DeInit(ADC_port);
  GPIO_Init(ADC_port, ADC_Multichannel_pins, GPIO_MODE_IN_FL_NO_IT);

  ADC1_DeInit();

  ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
  ADC1_CHANNEL_0,\
  ADC1_PRESSEL_FCPU_D18, \
  ADC1_EXTTRIG_GPIO, \
  DISABLE, \
  ADC1_ALIGN_RIGHT, \
  ADC1_SCHMITTTRIG_CHANNEL0, \
  DISABLE);

  ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, \
  ADC1_CHANNEL_1,\
  ADC1_PRESSEL_FCPU_D18, \
  ADC1_EXTTRIG_GPIO, \
  DISABLE, \
  ADC1_ALIGN_RIGHT, \
  ADC1_SCHMITTTRIG_CHANNEL1, \
  DISABLE);

  ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, ((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1)), ADC1_ALIGN_RIGHT);

  ADC1_DataBufferCmd(ENABLE);
  ADC1_Cmd(ENABLE);

}

/*
* spi device 1 DAC
* spi device 2 RAM
* I think sets up SPI at 1MHz
* When the master is communicating with SPI slaves which need to be deselected between transmissions, the NSS pin must be configured as a GPIO.
* i'm guessing NSS_SOFT is no cs pin...
* just polling, or does this use interrupts?
*/
void SPI_setup(void)
{
  GPIO_Init(SPI_PORT, (GPIO_Pin_TypeDef)(SPI_CLK | SPI_MOSI | SPI_MISO), GPIO_MODE_OUT_PP_HIGH_FAST);

  SPI_DeInit();

  SPI_Init(SPI_FIRSTBIT_MSB, \
    SPI_BAUDRATEPRESCALER_16, \
    SPI_MODE_MASTER, \
    SPI_CLOCKPOLARITY_LOW, \
    SPI_CLOCKPHASE_1EDGE, \
    SPI_DATADIRECTION_2LINES_FULLDUPLEX, \
    SPI_NSS_SOFT, \
    0x0);

  SPI_Cmd(ENABLE);
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
