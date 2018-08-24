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
		uC chip
		=======
		STM8S105K4T6C
	
		Pins uC
		=======
from stm8CubeMx...

		spi sclk pc-5
		spi sdi pc-6
		spi spo pc-7
		
		spi cs ram chip pa-1
		spi cs dac cip pc-4
		
		adc_mic					pb0
		adc_delay				pb1
		adc_feedback		pb2
		
	*/


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Private defines -----------------------------------------------------------*/
#define LED_pin                     GPIO_PIN_4
#define LED_port                    GPIOD

#define DAC_CS_pin 												GPIO_PIN_4 
#define DAC_CS_port 											GPIOC

#define RAM_CS_pin 												GPIO_PIN_1 
#define RAM_CS_port 											GPIOA

// INSTRUCTION SET SRAM
#define READ	0x03			// Read data from memory
#define WRITE	0x02			// Write data to memory
#define RDSR	0x05			// Read Status register
#define WRSR	0x01			// Write Status register

// STATUS REGISTER
#define	BYTE_MODE	0x00
#define	PAGE_MODE	0x80
#define SEQ_MODE	0x40

//SRAM SIZE
#define SRAM_SIZE 		32000


/* Private function prototypes -----------------------------------------------*/
void setup(void);
void clock_setup(void);
void GPIO_setup(void);
void SPI_setup(void);
void ADC1_setup(void);
void ADC1_setup_scan_mode(void);
void TIM2_setup(void);
void SPI_setup(void);

//spi device 1 DAC
void MCP4901_DAC_write(unsigned char value);
void MCP4901_DAC_init(void);

//spi device 2 RAM
void MCP_23K256_init(void);
void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value);
void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value);
// status registers
void MCP_23K256_read_status_register(uint8_t *data);
void MCP_23K256_write_status_register(uint8_t data);

void delay_us(unsigned int  value);
void delay_ms(unsigned int  value);

//tests
uint8_t TEST_ram_test_001(void);
uint8_t TEST_rampfunc_in_ram_to_dac(void);
void TEST_adc_to_dac(uint8_t *x);
void TEST_adc_to_ram_to_dac(void);
void TEST_adc_to_ram_to_dac_with_delay(void);
void TEST_adc_to_ram_to_dac_with_with_fback(void);

/* Private functions ---------------------------------------------------------*/

void main(void)
{
	//uint16_t x = 8;
	//uint16_t y = 0;
	// putting  int16_t mapd_delay_dial = 0;  int16_t write_addr = 0; 
	
	uint16_t adc_val = 0;	
	uint16_t adc_delay = 0;	// length of delay in samples
	uint16_t adc_fb = 0;	// feedback dial
	
	uint8_t mapd_audio_value = 0; // mapped adc value of audio input
	uint16_t mapd_delay_dial = 0;
	uint16_t mapd_fb_dial = 0;
	
	uint16_t audio_signal = 0;
	
	uint8_t read_val = 0;	//read val from ram
	uint16_t write_addr = 0;	//write addr in ram
	uint16_t read_addr = 0;	// read addr in val
	
	uint8_t res = 0;
	
	clock_setup();
	GPIO_setup();
	ADC1_setup_scan_mode();
	SPI_setup();	
	MCP_23K256_init();
	MCP4901_DAC_init();
	
/*	
	res = TEST_ram_test_001();
	if(res != 0)
	{
		while(1);
	}
	
	TEST_adc_to_dac(&adc_val);
	
	res = TEST_rampfunc_in_ram_to_dac();
	if(res != 0)
	{
		while(1);
	}
	
	TEST_adc_to_ram_to_dac();
*/
	//TEST_adc_to_ram_to_dac_with_delay();

	//TEST_adc_to_ram_to_dac_with_with_fback();

	
  /* Infinite loop */
  while (1)
  {		
	//Sample value
		ADC1_ScanModeCmd(ENABLE);
		ADC1_StartConversion();
		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
		ADC1_ClearFlag(ADC1_FLAG_EOC);
		adc_val = ADC1_GetBufferValue(0);
		adc_delay = ADC1_GetBufferValue(1);
		adc_fb = ADC1_GetBufferValue(2);

		
	//map feedback to 
		//mapd_fb_dial = adc_fb>>8; // not used yet
		//mapd_fb_dial = 0;
		mapd_fb_dial = adc_fb;
		#define FB_ADC_RANGE 	1023

	//map delay 
		mapd_delay_dial = (adc_delay/4); // * 11; // adc_delay*(11000) /(1023) // juist do /2 to remove glitching
	
	// map function for adc
		// (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
		// input range 0-1024 out range 0-255 therefore
		// slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
		// function simplfys down to 
		mapd_audio_value = 0.25 *(float)adc_val ; // do i need the float or not ???
		
		//with feedback 50% wet
		//mapd_audio_value = mapd_audio_value/2 + read_val/2; // do i need the float or not ???
		
		//mapd_audio_value = ( ((FB_ADC_RANGE-mapd_fb_dial)/(float)FB_ADC_RANGE) * (float)mapd_audio_value) + ((mapd_fb_dial/(float)FB_ADC_RANGE) * (float)read_val);
		
		audio_signal =  (uint16_t)( ((FB_ADC_RANGE-mapd_fb_dial)/(float)FB_ADC_RANGE) * (float)mapd_audio_value);
		audio_signal += (uint16_t )( (mapd_fb_dial/(float)FB_ADC_RANGE) * (float)read_val);
		
	// sort out read addresses
		if( (int16_t)(write_addr - mapd_delay_dial) >= 0)
		{
			read_addr = write_addr - mapd_delay_dial;
		}
		else
		{
			//start up situation
			read_addr = SRAM_SIZE - mapd_delay_dial + write_addr;
		}
		

		
	//write to ram
//		MCP_23K256_RAM_write_byte(write_addr, mapd_audio_value);
	MCP_23K256_RAM_write_byte(write_addr, audio_signal);
	
	//read from ram
		MCP_23K256_RAM_read_byte(read_addr, &read_val);
		
	//write value to dac			
		MCP4901_DAC_write(read_val);
	
	//increment write pointer
		write_addr++;
		
	//is this quicker than mod SRAM_SIZE ? --and is it '<=' or '>'   ??
		if(write_addr > SRAM_SIZE)
		{
			write_addr = 0;
		}
			
	//11kHz sample rate
		delay_us(90);
		
	}
  
}


/*
	void MCP_23K256_read_status_register(uint8_t *data);
	void MCP_23K256_write_status_register(uint8_t data);
	void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value);
	void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value);

 Simply writes to ram and reads from ram
*/
uint8_t TEST_ram_test_001(void)
{
	uint8_t cnt = 0;
	uint8_t data = 0;
	uint8_t wdata = 0;
	uint16_t addr = 0;
	
	//write 0 to the status register
	data = BYTE_MODE;
	MCP_23K256_write_status_register(data);
	
	//
	MCP_23K256_read_status_register(&data);
/*	if(data != BYTE_MODE)
	{
		//failed 
		while(1);
	}
//2
	data = PAGE_MODE;
	MCP_23K256_write_status_register(data);
	
	//
	MCP_23K256_read_status_register(&data);
	if(data != PAGE_MODE)
	{
		//failed 
		//while(1);
	}	
	
//3
	data = SEQ_MODE;
	MCP_23K256_write_status_register(data);
	
	//
	MCP_23K256_read_status_register(&data);
	if(data != SEQ_MODE)
	{
		//failed
		//while(1);
	}
	
//4 reset atate	
	data = BYTE_MODE; 
	MCP_23K256_write_status_register(data);
	
	//
	MCP_23K256_read_status_register(&data);
	if(data != BYTE_MODE)
	{
		//failed 
		while(1);
	}
//2

*/
wdata = 2;
addr =0;
	//
	MCP_23K256_RAM_write_byte(addr, wdata);
	
	//
	MCP_23K256_RAM_read_byte(addr, &data);
	
	if (wdata != data)
	{
		//while(1);
	}
	
wdata = 250;
addr =1;
	//
	MCP_23K256_RAM_write_byte(addr, wdata);
	
	//
	MCP_23K256_RAM_read_byte(addr, &data);
	
	if (wdata != data)
	{
		//while(1);
	}
	
wdata = 4;
addr =2;
	//
	MCP_23K256_RAM_write_byte(addr, wdata);
	
	//
	MCP_23K256_RAM_read_byte(addr, &data);
	
	if (wdata != data)
	{
		//while(1);
	}

	// check memorylocations
	for(addr = 0; addr<3; addr++)
	{
		MCP_23K256_RAM_read_byte(addr, &data);
	}
	return 0;
}

/*
* fills ram with ramp function data 0-255
* loops: reads out value from ram, send to dac, wait 
*/
uint8_t TEST_rampfunc_in_ram_to_dac(void)
{
	uint8_t data = 0;
	uint8_t wdata = 0;
	uint16_t addr = 0;	
	
	/* fill ram with values*/
	for(addr = 0, wdata; addr<255; addr++, wdata++)
	{
		MCP_23K256_RAM_write_byte(addr, wdata);
	}
	
	/*read values outof ram  and write to DAC */
	while(1)
	{
		for(addr = 0; addr<255; addr++)
		{
			MCP_23K256_RAM_read_byte(addr, &data);
			MCP4901_DAC_write(data);
			delay_us(90);	//11kHz sample rate
		}
	}
	
	return 0;
}

/*Simply sends adc value to the dac -no ram involved*/
void TEST_adc_to_dac(uint8_t *x)
{
	/*
	while(1)
	{
		ADC1_StartConversion();
		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
		
		*x = ADC1_GetConversionValue(); // for led knob
		ADC1_ClearFlag(ADC1_FLAG_EOC);
		
		// map function
		// (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
		// input range 0-1024 out range 0-255 therefore
		// slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
		// function simplfys down to 
		*x = 0.25 *(float)x ; // do i need the float or not ???
			MCP4901_DAC_write(adc_val);
				
		//11kHz sample rate
		delay_us(90);
	
	}
	
*/
}


void TEST_adc_to_ram_to_dac(void)
{
	uint16_t adc_val = 0;
	uint16_t addr = 0;
	uint8_t mapd_value = 0; 
	
	while(1)
	{
		//Sample value
		ADC1_StartConversion();
		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
		
		adc_val = ADC1_GetConversionValue(); // for led knob
		ADC1_ClearFlag(ADC1_FLAG_EOC);
		
		// map function
		// (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
		// input range 0-1024 out range 0-255 therefore
		// slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
		// function simplfys down to 
		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
		
		//write to ram
		MCP_23K256_RAM_write_byte(addr, mapd_value);
		// retrieve value from ram
		
		mapd_value = 0; // check value
		MCP_23K256_RAM_read_byte(addr, &mapd_value);
		
		//check that addr
		addr++;
		
		MCP4901_DAC_write(mapd_value);
			
		//11kHz sample rate
		delay_us(90);
		
	}
	
}


void TEST_adc_to_ram_to_dac_with_delay(void)
{
	uint16_t adc_val = 0;	
	uint8_t mapd_value = 0; // mapped adc valu
	uint8_t read_val = 0;	//read val from ram
	uint16_t write_addr = 0;	//write addr in ram
	uint16_t read_addr = 0;	// read addr in val
	uint16_t delay = 110; // length of delay in samples
	uint8_t res = 0;
	
	
  while (1)
  {		
	//Sample value
		ADC1_StartConversion();
		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
	
		adc_val = ADC1_GetConversionValue(); // for led knob
		ADC1_ClearFlag(ADC1_FLAG_EOC);
	
		// map function
		// (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
		// input range 0-1024 out range 0-255 therefore
		// slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
		// function simplfys down to 
		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
		
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
		
	//11kHz sample rate
		delay_us(90);
		
		
	}
}


void TEST_adc_to_ram_to_dac_with_with_fback(void)
{

	uint16_t adc_val = 0;	
	uint8_t mapd_value = 0; // mapped adc valu
	uint8_t read_val = 0;	//read val from ram
	int16_t write_addr = 0;	//write addr in ram
	uint16_t read_addr = 0;	// read addr in val
	int16_t delay = 110; // length of delay in samples
	uint8_t res = 0;
	
  /* Infinite loop */
  while (1)
  {		
	//Sample value
		ADC1_StartConversion();
		while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
	
		adc_val = ADC1_GetConversionValue(); // for led knob
		ADC1_ClearFlag(ADC1_FLAG_EOC);
	
	// map function
		// (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
		// input range 0-1024 out range 0-255 therefore
		// slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
		// function simplfys down to 
		mapd_value = 0.25 *(float)adc_val ; // do i need the float or not ???
		
		//with feedback 50% wet
		mapd_value = mapd_value/2 +  read_val/2; // do i need the float or not ???
		
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
			
	//11kHz sample rate
		delay_us(90);
		
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
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
                                
}

void GPIO_setup(void)
{   
	// C5=sck  C6=mosi
  GPIO_DeInit(GPIOC);
	GPIO_Init(GPIOC, ((GPIO_Pin_TypeDef)GPIO_PIN_5 | GPIO_PIN_6 ), 
               GPIO_MODE_OUT_PP_HIGH_FAST);
							 
  //adc_audio pin b0, adc_delay_tme pb1, adc_feedback pb2
	GPIO_DeInit(GPIOB);
  GPIO_Init(GPIOB, ((GPIO_Pin_TypeDef)(GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_2)), GPIO_MODE_IN_FL_NO_IT); // 
	
  //GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	

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

void ADC1_setup_scan_mode(void)
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
	
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
  ADC1_CHANNEL_1,\
  ADC1_PRESSEL_FCPU_D18, \
  ADC1_EXTTRIG_GPIO, \
  DISABLE, \
  ADC1_ALIGN_RIGHT, \
  ADC1_SCHMITTTRIG_CHANNEL1, \
  DISABLE);
	
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, \
  ADC1_CHANNEL_2,\
  ADC1_PRESSEL_FCPU_D18, \
  ADC1_EXTTRIG_GPIO, \
  DISABLE, \
  ADC1_ALIGN_RIGHT, \
  ADC1_SCHMITTTRIG_CHANNEL2, \
  DISABLE);
	
	ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, \
	((ADC1_Channel_TypeDef)(ADC1_CHANNEL_0 | ADC1_CHANNEL_1 | ADC1_CHANNEL_2)), \
	ADC1_ALIGN_RIGHT);

	ADC1_DataBufferCmd(ENABLE);

  ADC1_Cmd(ENABLE);

}


void TIM2_setup(void)
{
  TIM2_DeInit();
  TIM2_TimeBaseInit(TIM2_PRESCALER_32, 1000);
  TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000, TIM2_OCPOLARITY_HIGH);
  TIM2_Cmd(ENABLE);

}


void SPI_setup(void)
{
  SPI_DeInit();
  
	//SPI_CLOCKPOLARITY_HIGH, \
	//SPI_CLOCKPOLARITY_LOW clock goes low(idle) to high
	
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

void MCP_23K256_init()
{
	GPIO_Init(RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  delay_ms(10);
}

/*
*  
*/
void MCP_23K256_read_status_register(uint8_t *data)
{
	
  while(SPI_GetFlagStatus(SPI_FLAG_BSY));
	
  GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
	
  SPI_SendData(RDSR); // read ststus reg
	
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	//extra
while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
SPI_SendData( 255 );
while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
  *data = SPI_ReceiveData(); 
	
  while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));
	
	// this delay was required because i was seeing the cs line 
	// going high before the spi data was finished being written
	delay_us(1);

  GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
}

/*
* status modes are:
* 00 = byte mode
* 10 = page mode
* 01 = sequential/burst mode
* 11 = reserved
*/
void MCP_23K256_write_status_register(uint8_t data)
{
	
  while(SPI_GetFlagStatus(SPI_FLAG_BSY));
	
  GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
	
	// write status register
  SPI_SendData(WRSR); 
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	
  SPI_SendData(data); 
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	// this delay was required because i was seeing the cs line 
	// going high before the spi data was finished being written
	delay_us(1);

  GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);

}



/*


write instruction = 0000 0010
*/
void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value)
{
	uint8_t addr = 0;
	
  while(SPI_GetFlagStatus(SPI_FLAG_BSY));
	
  GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
	
	// send instruction
  SPI_SendData(WRITE); // instruction 2 write
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	//send top 8 bits of address
	addr = address>>8;
  SPI_SendData(addr); // send 16 bit address // MSB is don't care
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	//send bottom 8 bits of address
	addr = (address&255);
  SPI_SendData( addr );
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
  SPI_SendData(value); 
	
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	// this delay was required because i was seeing the cs line 
	// going high before the spi data was finished being written
	delay_us(1);

  GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
	
	
}

/*
 read instruction = 0000 0011
*/


void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value)
{		
	uint8_t addr = 0;

  while(SPI_GetFlagStatus(SPI_FLAG_BSY));
	
  GPIO_WriteLow(RAM_CS_port, RAM_CS_pin);
	
  SPI_SendData(READ); // instruction 3 read
	
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	//send top 8 bits of address
	addr = address>>8;
  SPI_SendData(addr); // send 16 bit address // MSB is don't care
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	//send bottom bits of address
	addr = (address&255);
  SPI_SendData( addr );
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
//  SPI_SendData( 6 );
//  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
SPI_SendData( 255 );
while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
while(!SPI_GetFlagStatus(SPI_FLAG_RXNE));	
	
	// read data back
  *value = SPI_ReceiveData();  
	
	

	
	// this delay was required because i was seeing the cs line 
	// going high before the spi data was finished being written
	delay_us(1);

  GPIO_WriteHigh(RAM_CS_port, RAM_CS_pin);
}

/*
*  initialise the CS pin
*/
void MCP4901_DAC_init(void)
{
  GPIO_Init(DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  delay_ms(10);
}

/*
* 

*/
void MCP4901_DAC_write( unsigned char value)
{
	
	//0,BUF,GS,SHDN, 8bit data, x,x,x,x
	//0,BUF,GS,SHDN, 4bit data | 4 bits data, x,x,x,x
	
	//bit 15: 
	// 0 write to dac
	// 1 ignore this command
	
	//bit 14: buf 
	// 1=buffered
	// 0= unbuffered
	
	//bit 13: GA output gain selection bit
	// 1= unity
	// 0= 2 times
	
	//bit 12: SHDN output shutdown control bit 
	// 1= active mode operation
	// 0 shutdown the device
	
	//
	
	//address[7] = 0; // write to dac
	//address[6] = 0; // unbuffered
	//address[5] = 1; // unity
	//address[4] = 1; // active
	
	unsigned char address = 0x30; // 00,11,00,00
	address |= ( value>>4); // assume 0's shoved in the left
	
	value = ( value<<4 ); // assume 0 shoved in from the right

	
  while(SPI_GetFlagStatus(SPI_FLAG_BSY));
	
  GPIO_WriteLow(DAC_CS_port, DAC_CS_pin);
	
  SPI_SendData(address);
	
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
  SPI_SendData(value); 
	
  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
	
	// this delay was required because i was seeing the cs line 
	// going high before the spi data was finished being written
	delay_us(1);
	/*for(int i=0;i<1024;i++)
	{
		_asm ("nop");
	}*/
	

  GPIO_WriteHigh(DAC_CS_port, DAC_CS_pin);
	
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
