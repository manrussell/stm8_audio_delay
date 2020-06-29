#ifndef _MCP4901_SPI_DAC_H_
#define _MCP4901_SPI_DAC_H_

#include "stm8s.h"

void MCP4901_DAC_init( void );
void MCP4901_DAC_write( unsigned char value );

#endif /* _MCP4901_SPI_DAC_H_ */
