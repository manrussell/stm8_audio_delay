/********************************************************************
* Driver for MCP4901_SPI_DAC chip, on stm8
* Author manrussell
* date
* free to use
*
********************************************************************/
/*
ERRRM why am i using a gpio, isn't there a cs pin that i can use
-> check spi init again
*/

#ifndef __TESTS_HW_C__
#define __TESTS_HW_C__

#include "stm8s.h"
#include "main.h"
#include "delay.h"
#include "mcp4901_spi_dac.h"
#include "mcp_23k256_spi_ram.h"
#include "tests_hw.h"

/*
    void MCP_23K256_read_status_register(uint8_t *data);
    void MCP_23K256_write_status_register(uint8_t data);
    void MCP_23K256_RAM_write_byte(uint16_t address, unsigned char value);
    void MCP_23K256_RAM_read_byte(uint16_t address, unsigned char *value);

 Simply writes to ram and reads from ram
*/
uint8_t TEST_ram_test_001( void )
{
    uint8_t cnt = 0;
    uint8_t data = 0;
    uint8_t wdata = 0;
    uint16_t addr = 0;

    //write 0 to the status register
    data = BYTE_MODE;
    MCP_23K256_RAM_write_status_register(data);

    //
    MCP_23K256_RAM_read_status_register(&data);
/*  if(data != BYTE_MODE)
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
uint8_t TEST_rampfunc_in_ram_to_dac( void )
{
    uint8_t data = 0;
    uint8_t wdata = 0;
    uint16_t addr = 0;

    /* fill ram with values*/
    for(addr = 0, wdata; addr<255; addr++, wdata+=4)
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
            delay_us(90);   //11kHz sample rate // phasor == frequ
        }
    }

    return 0;
}

/*Simply sends adc value to the dac -no ram involved*/
void TEST_adc_to_dac( uint8_t *x )
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


void TEST_adc_to_ram_to_dac( void )
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


void TEST_adc_to_ram_to_dac_with_delay( void )
{
    uint16_t adc_val = 0;
    uint8_t mapd_value = 0; // mapped adc valu
    uint8_t read_val = 0;   //read val from ram
    uint16_t write_addr = 0;    //write addr in ram
    uint16_t read_addr = 0; // read addr in val
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



void TEST_adc_to_ram_to_dac_with_with_fback( void )
{

    uint16_t adc0_val = 0;  //er are these 8 or 16 big?
    uint16_t adc1_val = 0;
    uint8_t mapd_value = 0; // mapped adc valu
    uint8_t read_val = 0;   //read val from ram
    uint16_t write_addr = 0;    //write addr in ram
    uint16_t read_addr = 0; // read addr in val
    uint16_t delay = 110; // length of delay in samples
    uint8_t res = 0;

  /* Infinite loop */
  while (1)
  {
    //Sample value
    /*
    original one adc version
        ADC1_StartConversion();
        while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);

        adc_val = ADC1_GetConversionValue(); // for led knob
        ADC1_ClearFlag(ADC1_FLAG_EOC);
    */
    // multi channel ADC's
    ADC1_ScanModeCmd(ENABLE);
    ADC1_StartConversion();
    while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
    // ADC1_ClearFlag(ADC1_FLAG_EOC);
    adc0_val = ADC1_GetBufferValue(0);
    adc1_val = ADC1_GetBufferValue(1);
    ADC1_ClearFlag(ADC1_FLAG_EOC);

    //untested: set delay length (vari length delay) using adc
    delay = (adc1_val>>2);

    // knob for feedback
    // knob for gain of ..

    // map function
        // (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
        // input range 0-1024 out range 0-255 therefore
        // slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
        // function simplfys down to
        mapd_value = (adc0_val>>2) ; // do i need the float or not ??? -No use a lft shift

        // add in 16 bit then reduce down to 8 bit

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

#endif /* __TESTS_HW_C__ */
