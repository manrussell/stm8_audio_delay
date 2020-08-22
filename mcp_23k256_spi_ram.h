
#ifndef _MCP_23K256_SPI_RAM_H_
#define _MCP_23K256_SPI_RAM_H_

#include "stm8s.h"

// INSTRUCTION SET SRAM
#define READ        0x03            // Read data from memory
#define WRITE       0x02            // Write data to memory
#define RDSR        0x05            // Read Status register
#define WRSR        0x01            // Write Status register

// STATUS REGISTER
#define NUM_OF_SPI_MODES    4 //wasts a space by going back to normal read mode
#define BYTE_MODE   0x00
#define PAGE_MODE   0x80
#define SEQ_MODE    0x40

//SRAM SIZE
#define SRAM_SIZE 32000

void MCP_23K256_RAM_init( void );
void MCP_23K256_RAM_read_status_register( uint8_t *data );
void MCP_23K256_RAM_write_status_register( uint8_t data );
void MCP_23K256_RAM_write_byte( uint16_t address, unsigned char value );
void MCP_23K256_RAM_read_byte( uint16_t address, unsigned char *value );
void MCP_23K256_RAM_set_all( unsigned char value );

/*
Redefined sa HW tests and main program are component agnostic
*/
#define RAM_init( )                    		MCP_23K256_RAM_init( )
#define RAM_read_status_register( data )    MCP_23K256_RAM_read_status_register( data )
#define RAM_write_status_register( data )   MCP_23K256_RAM_write_status_register( data )
#define RAM_write_byte( address, value )    MCP_23K256_RAM_write_byte( address, value )
#define RAM_read_byte( address, value )     MCP_23K256_RAM_read_byte( address, value )
#define RAM_set_all( value )                MCP_23K256_RAM_set_all( value )



#endif /* _MCP_23K256_SPI_RAM_H_ */
