#ifndef __TESTS_H__
#define __TESTS_H__

#include "stm8s.h"

uint8_t TEST_ram_test_001( void );
uint8_t TEST_rampfunc_in_ram_to_dac( void );
void    TEST_adc_to_dac( uint8_t *x );
void    TEST_adc_to_ram_to_dac( void );
void    TEST_adc_to_ram_to_dac_with_delay( void );
void    TEST_adc_to_ram_to_dac_with_with_fback( void );
void    TEST_clock_speed( void );
void    TEST_run_all_tests( void );

#endif /* __TESTS_H__ */
