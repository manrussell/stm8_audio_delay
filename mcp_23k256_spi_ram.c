/********************************************************************
* Driver for MCP_23K256_SPI_RAM chip
* Author manrussell
* date
* free to use
*
********************************************************************/
/*

ERRRM why am i using a gpio, isn't there a cs pin that i can use
-> check spi init again

*/

#ifndef _MCP_23K256_SPI_RAM_C_
#define _MCP_23K256_SPI_RAM_C_

#include "main.h"
#include "delay.h"
#include "mcp_23k256_spi_ram.h"

void MCP_23K256_RAM_init( void )
{
    GPIO_Init( RAM_CS_port, RAM_CS_pin, GPIO_MODE_OUT_PP_HIGH_FAST );
    delay_ms( 10 );
}

/*
*
*/
void MCP_23K256_RAM_read_status_register( uint8_t *data )
{

  while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );

  GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );

  SPI_SendData( RDSR ); // read ststus reg

  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    // extra - why ? because you have to to receive stuff right ?
while( SPI_GetFlagStatus( SPI_FLAG_RXNE ) == RESET );
SPI_SendData( 255 );
while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

  *data = SPI_ReceiveData( );

  while( ! SPI_GetFlagStatus( SPI_FLAG_RXNE ) );

    // this delay was required because i was seeing the cs line
    // going high before the spi data was finished being written
    delay_us( 1 );

  GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );
}

/*
* status modes are:
* 00 = byte mode
* 10 = page mode
* 01 = sequential/burst mode
* 11 = reserved
*/
void MCP_23K256_RAM_write_status_register( uint8_t data )
{

  while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );

  GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );

    // write status register
  SPI_SendData( WRSR );
  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );


  SPI_SendData( data );
  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    // this delay was required because i was seeing the cs line
    // going high before the spi data was finished being written
    delay_us( 1 );

  GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );

}

/*
* write instruction = 0000 0010
*/
void MCP_23K256_RAM_write_byte( uint16_t address, unsigned char value )
{
    uint8_t addr = 0;

  while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );

  GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );

    // send instruction
  SPI_SendData( WRITE ); // instruction 2 write
  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    //send top 8 bits of address
    addr = address >> 8;
  SPI_SendData( addr ); // send 16 bit address // MSB is don't care
  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    //send bottom 8 bits of address
    addr = ( address & 255 );
  SPI_SendData( addr );
  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

  SPI_SendData( value );

  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    // this delay was required because i was seeing the cs line
    // going high before the spi data was finished being written
    delay_us( 1 );

  GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );
}

/*
* read instruction = 0000 0011
*/
void MCP_23K256_RAM_read_byte( uint16_t address, unsigned char *value )
{
    uint8_t addr = 0;

  while( SPI_GetFlagStatus( SPI_FLAG_BSY ) );

  GPIO_WriteLow( RAM_CS_port, RAM_CS_pin );

  SPI_SendData( READ ); // instruction 3 read

  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    //send top 8 bits of address
    addr = address >> 8;
  SPI_SendData( addr ); // send 16 bit address // MSB is don't care
  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

    //send bottom bits of address
    addr = ( address & 255 );
  SPI_SendData( addr );
  while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );

//  SPI_SendData( 6 );
//  while(!SPI_GetFlagStatus(SPI_FLAG_TXE));
while( SPI_GetFlagStatus( SPI_FLAG_RXNE ) == RESET );
SPI_SendData( 255 );
while( ! SPI_GetFlagStatus( SPI_FLAG_TXE ) );
while( ! SPI_GetFlagStatus( SPI_FLAG_RXNE ) );

    // read data back
    *value = SPI_ReceiveData( );

    // this delay was required because i was seeing the cs line
    // going high before the spi data was finished being written
    delay_us( 1 );

    GPIO_WriteHigh( RAM_CS_port, RAM_CS_pin );
}

/* like a memset for the ram, i think it init's to 0xff 
there maybe a better way if you check the datasheet, but i'm not doing that 
right now...
value         -> the value to fill RAM with
start_address -> this ensures that what ever address the read/write pointer was 
                 at before, it is  ... hmm this isn't neccessary...
*/
void MCP_23K256_RAM_set_all( unsigned char value )
{
    uint16_t addr;
    
    for ( addr = 0; addr < SRAM_SIZE; addr++ )
    {
        MCP_23K256_RAM_write_byte( addr, value );
    }
}

#endif /* _MCP_23K256_SPI_RAM_C_ */
