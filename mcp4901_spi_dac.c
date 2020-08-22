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

#ifndef _MCP4901_SPI_DAC_C_
#define _MCP4901_SPI_DAC_C_

#include "main.h"
#include "delay.h"
#include "mcp4901_spi_dac.h"

/*
*  initialise the CS pin
*/
void MCP4901_DAC_init( void )
{
  GPIO_Init( DAC_CS_port, DAC_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST );
  delay_ms( 10 );
}

/*
*
*/
void MCP4901_DAC_write( unsigned char value )
{

    //0,BUF,GS,SHDN, 8bit data, x,x,x,x
    //0,BUF,GS,SHDN, 4bit data | 4 bits data, x,x,x,x

    //bit 15:
    // 0 write to dac
    // 1 ignore this command

    //bit 14: buf
    // 1 = buffered
    // 0 = unbuffered

    //bit 13: GA output gain selection bit
    // 1 = unity
    // 0 = 2 times

    //bit 12: SHDN output shutdown control bit
    // 1 = active mode operation
    // 0 = shutdown the device

    //

    //address[7] = 0; // write to dac
    //address[6] = 0; // unbuffered
    //address[5] = 1; // unity
    //address[4] = 1; // active

    unsigned char address = 0x30;   // 00,11,00,00
    address |= ( value >> 4 );      // assume 0's shoved in the left

    value = ( value << 4 );         // assume 0 shoved in from the right


    while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );
    GPIO_WriteLow( DAC_CS_port, DAC_CS_pin );
    
    SPI_SendData( address );
    while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
    
    SPI_SendData( value );
    while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    // this delay was required because i was seeing the cs line
    // going high before the spi data was finished being written
    delay_us( 1 );
    /*for(int i=0;i<1024;i++)
    {
        _asm ("nop");
    }*/

  GPIO_WriteHigh( DAC_CS_port, DAC_CS_pin );

}

#endif /* _MCP4901_SPI_DAC_C_ */
