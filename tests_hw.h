#ifndef __TESTS_H__
#define __TESTS_H__

#include "stm8s.h"

void TEST_ram_test_001( void );
void TEST_rampfunc_in_ram_to_dac( void );
void TEST_adc_to_dac( void );
void TEST_adc_to_ram_to_dac( void );
void TEST_adc_to_ram_to_dac_with_delay( void );
void TEST_adc_to_ram_to_dac_with_with_fback( void );
void TEST_clock_speed( void ); // Toggles pin every 1ms
void TEST_run_all_tests( void );

#endif /* __TESTS_H__ */
