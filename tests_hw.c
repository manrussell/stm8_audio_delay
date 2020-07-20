/********************************************************************
* Driver for MCP4901_SPI_DAC chip, on stm8
* Author manrussell
* date
* free to use
*
********************************************************************/

/*
make PB fire an external interrupt, less chance of human error when doing manual tests.

there are some local variables that have the same name as some global, this is not what we want!!

Tests to add. 
Timer interrupt tests, for everything.

*/
#ifndef __TESTS_HW_C__
#define __TESTS_HW_C__

#include "stm8s.h"
#include "main.h"
#include "delay.h"
#include "mcp4901_spi_dac.h"
#include "mcp_23k256_spi_ram.h"
#include "tests_hw.h"

#define SW_DEBOUNCE     1
#define BUTTON_PRESSED  ( 0 == GPIO_ReadInputPin( NEXT_TEST_BUTTON_PORT, NEXT_TEST_BUTTON_PIN ) )

static void setupNextTestButton( void );
static uint8_t moveToNextTest( void ); // rename like nextTest( ) ... button pressed( )

void TEST_run_all_tests( void )
{
    uint8_t state = 0;
    uint8_t runningTests = 1;

    /* Each test has own setup routine, so they can be run seperately. */

    while ( runningTests )
    {
        switch( state )
        {
            case 0:
                TEST_clock_speed( );
                break;
            case 1:
                TEST_ram_test_001( );
                break;
            case 2:
                //TEST_adc_to_dac( &adc_val );
                break;
            case 3:
                TEST_rampfunc_in_ram_to_dac( );
                break;
            case 4:
                TEST_adc_to_ram_to_dac( );
                break;
            case 5:
                TEST_adc_to_ram_to_dac_with_delay( );
                break;
            case 6:
                TEST_adc_to_ram_to_dac_with_with_fback( );
                break;
            case 7:
                TEST_rampfunc_in_ram_to_dac( );
                break;
            case 8:
                runningTests = 0;
            default:
                //error!
                while( 1 );
        }
        /* This is so we don't catch a button press when we don't want to. */
        delay_us( 1000 );
    }

    /* Tests completed!! Now onto normal system running... */
}

/*
** Test will check read and writes to RAM.
** If any fail, it get get stuck in the while loop.
*/
void TEST_ram_test_001( void )
{
    uint8_t  data  = 0;
    uint8_t  wdata = 0;
    uint16_t addr  = 0;
    uint8_t  RAM_MODE[ NUM_OF_SPI_MODES ] = { PAGE_MODE, SEQ_MODE, BYTE_MODE };
    uint8_t  mode = 0;

    //disable interrupts? .. maybe in SPI func ?
    CLOCK_setup( );
    setupNextTestButton( );
    GPIO_setupDebugPin( );
    SPI_setup( );
    MCP_23K256_RAM_init( );

    /* Test writing to status register.
       Set to SEQ/PAGE/BYTE mode.
       leave in BYTE mode for the following tests.
    */
    for ( mode = 0; mode <= NUM_OF_SPI_MODES; mode++)
    {
        MCP_23K256_RAM_write_status_register( RAM_MODE[ mode ] );
        MCP_23K256_RAM_read_status_register( &data );

        if( RAM_MODE[ mode ] != data )
        {
            /* Test failed */
            while( 1 );
        }
    }

    /*  Test writing and reading from RAM.
        Do an exhaustive test of ram write/reading.
        Ram initial state should be 0xff so write to 0x0
        Could add GPIO toggle to time test!
    */
    wdata = 0x55;
    addr  = 0;

    for( addr = 0; addr < SRAM_SIZE; addr++ ) //is it <= or <  --Test!
    {
        MCP_23K256_RAM_write_byte( addr, wdata );
        MCP_23K256_RAM_read_byte( addr, &data );
        if ( wdata != data )
        {
            /* Test failed */
            while( 1 );
        }
    }
}

/*
* fills ram with ramp function data 0-255
* loops: reads out value from ram, send to dac, wait
*/
void TEST_rampfunc_in_ram_to_dac( void )
{
    uint8_t  data  = 0;
    uint8_t  wdata = 0;
    uint16_t addr  = 0;
    uint8_t  testIncomplete = 1;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    CLOCK_setup( );
    setupNextTestButton( );
    GPIO_setupDebugPin( );
    SPI_setup( );
    MCP_23K256_RAM_init( );
    MCP4901_DAC_init( );

    /* fill ram with values */
    for( addr = 0, wdata; addr<255; addr++, wdata+=4 )
    {
        MCP_23K256_RAM_write_byte( addr, wdata );
    }

    /* Read values out of ram and write to DAC */
    while( testIncomplete )
    {
        for( addr = 0; addr<255; addr++ )
        {
            MCP_23K256_RAM_read_byte( addr, &data );
            MCP4901_DAC_write( data );
            delay_us( 90 );   // ~11kHz sample rate // phasor == frequ
        }

        /* big delay in here to poll for button press -> maybe a better HW debounce would be quicker. */
        testIncomplete = moveToNextTest( );
    }

}

/* Simply sends adc value to the dac */
void TEST_adc_to_dac( void )
{
    uint8_t  testIncomplete = 1;
    uint16_t adcVal = 0;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    MCP4901_DAC_init( );

    while( testIncomplete )
    {
        /* Read ADC */
        /* uses single conversion ADC. */
        //ADC1_StartConversion( );
        //while( ADC1_GetFlagStatus( ADC1_FLAG_EOC ) == FALSE );
        //adcVal = ADC1_GetConversionValue( ); // for led knob
        //ADC1_ClearFlag( ADC1_FLAG_EOC );
        
        /* uses multichannel ADC. */
        ADC_readMultiChannelInputs( );
        adcVal  = ADC1_GetBufferValue( 1 ); //magic number!

        /* Drop adcVal from 10 bit to 8 bit ( for DAC) */
        adcVal >>= 2;
        MCP4901_DAC_write( (uint8_t)adcVal );

        /* ~11kHz sample rate */
        delay_us( 90 );

        /* Test for end of test.. */
        testIncomplete = moveToNextTest( );
    }
}


void TEST_adc_to_ram_to_dac( void )
{
    uint16_t addr = 0;
    uint8_t  testIncomplete = 1;
    uint16_t adcVal = 0;
    uint8_t  ramData = 0;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    MCP_23K256_RAM_init( );
    MCP4901_DAC_init( );

    while( testIncomplete )
    {
        /* uses multichannel ADC. */
        ADC_readMultiChannelInputs( );
        adcVal  = ADC1_GetBufferValue( 1 ); //magic number!
        
        /* Drop ADC to 8 bits. */
        adcVal >>= 2;

        /* write to ram */
        MCP_23K256_RAM_write_byte( addr, (uint8_t)adcVal );
        
        /* retrieve value from ram */
        MCP_23K256_RAM_read_byte( addr, &ramData ); // er adcVal is uint16 this returna uint8 ..

        MCP4901_DAC_write( ramData );
        
        /* check next addr, becaues why not. */
        addr++;

        //11kHz sample rate
        delay_us( 90 );
        
        /* Test for end of test.. */
        testIncomplete = moveToNextTest( );
    }
}


void TEST_adc_to_ram_to_dac_with_delay( void )
{
    uint8_t  read_val = 0;   //read val from ram
    uint16_t write_addr = 0;    //write addr in ram
    uint16_t read_addr = 0; // read addr in val
    uint16_t delayLength = 110; // length of delay in samples
    uint8_t  testIncomplete = 1;
    uint16_t adcVal = 0;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    MCP_23K256_RAM_init( );
    MCP4901_DAC_init( );
    
    while( testIncomplete )
    {
        /* uses multichannel ADC. */
        ADC_readMultiChannelInputs( );
        adcVal  = ADC1_GetBufferValue( 1 ); //magic number!
        
        /* Drop ADC to 8 bits. */
        adcVal >>= 2;

    // sort out read addresses
        if( (write_addr - delayLength) < 0) // move '0' to LHS
        {
            //start up situation
            read_addr = SRAM_SIZE - delayLength + write_addr;
        }

        if( (write_addr - delayLength) >= 0)
        {
            read_addr = write_addr - delayLength;
        }

    //write to ram
        MCP_23K256_RAM_write_byte( write_addr, (uint8_t)adcVal );

    //read from ram
        MCP_23K256_RAM_read_byte( read_addr, &read_val );

    //write value to dac
        MCP4901_DAC_write( read_val );

    //increment write pointer
        write_addr++;

    //11kHz sample rate
        delay_us( 90 );
        
        /* Test for end of test.. */
        testIncomplete = moveToNextTest( );
    }
}



void TEST_adc_to_ram_to_dac_with_with_fback( void )
{
    uint16_t adc0_val = 0;  //er are these 8 or 16 big?
    uint16_t adc1_val = 0;
    uint8_t  mapd_value = 0; // mapped adc valu
    uint8_t  read_val = 0;   //read val from ram
    uint16_t write_addr = 0;    //write addr in ram
    uint16_t read_addr = 0; // read addr in val
    uint16_t delay = 110; // length of delay in samples
    uint8_t  testIncomplete = 1;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    MCP_23K256_RAM_init( );
    MCP4901_DAC_init( );

    while( testIncomplete )
    {
        /* uses multichannel ADC. */
        ADC_readMultiChannelInputs( );
        adc0_val = ADC1_GetBufferValue( 0 );
        adc1_val = ADC1_GetBufferValue( 1 );

    //untested: set delay length (vari length delay) using adc
        delay = ( adc1_val>>2 );

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
        
        /* Test for end of test.. */
        testIncomplete = moveToNextTest( );
    }
}

/*
    test clock speed by toggling a gpio
    uses a delay of 1 ms
    should be good for a 10MHz toggle, using GPIO_MODE_OUT_PP_HIGH_FAST
*/
void TEST_clock_speed( void )
{
    uint8_t testIncomplete = 1;
    CLOCK_setup( );
    setupNextTestButton( );
    GPIO_setupDebugPin( );

    while ( testIncomplete )
    {
        delay_ms( 1 );
        GPIO_WriteReverse( TEST_port, TEST_pin );
        testIncomplete = moveToNextTest( );
    }
}

/*
    For testing setup this pin to increment the function under test
    Input pull-up, no external interrupt
*/
static void setupNextTestButton( void )
{
    /* Why not set up as external interrupt! */
    GPIO_Init(NEXT_TEST_BUTTON_PORT, NEXT_TEST_BUTTON_PIN, GPIO_MODE_IN_PU_NO_IT);
}

/* if pin pulled low then return '0'.
    Currently debounce done in SW only.
*/
static uint8_t moveToNextTest( void )
{
#if SW_DEBOUNCE
    if ( BUTTON_PRESSED )
    {
        /* debounce in sw.
           wait 50ms see if button still pressed, if it is then we take that as a positive reading, shonky but what the hey. */
        delay_ms( 50 );

        return BUTTON_PRESSED;
    }

    return 1;

#else /* ! SW_DEBOUNCE*/
#   error HW debounce has not been implemented yet. Maybe use external interrupt pin.
    return BUTTON_PRESSED;
#endif /* SW_DEBOUNCE */
}

#endif /* __TESTS_HW_C__ */
