#ifndef _MCP4901_SPI_DAC_H_
#define _MCP4901_SPI_DAC_H_

#include "stm8s.h"

void MCP4901_DAC_init( void );
void MCP4901_DAC_write( unsigned char value );

#define DAC_init( )         MCP4901_DAC_init( )
#define DAC_write( val )    MCP4901_DAC_write( val )

#endif /* _MCP4901_SPI_DAC_H_ */
