/********************************************************************
* Some tests i made up 
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

void EXTI_setup( void );

static void     setupNextTestButton( void );
static uint8_t  moveToNextTest( void ); // rename like nextTest( ) ... button pressed( )
static void     huge_Deinit( void );

uint8_t  testIncomplete = 1; /* updated by the ext interrupt pin. */

void TEST_run_all_tests( void )
{
    uint8_t HW_TEST_state = 0;  /* What inc's this? */
    uint8_t runningTests = 1;   /* what changes this? */

    /* Each test has own setup routine, so they can be run seperately. All require human intervebtion unless stated. */

    while ( runningTests )
    {
        switch( HW_TEST_state )
        {
            case 0:
                /* Toggles pin every 1ms */
                TEST_clock_speed( );
                break;
            case 1:
                /* Rename, readWrite test */
                /* If any fail, it get get stuck in the while loop. */
                TEST_ram_test_001( );
                break;
            case 2:
                TEST_adc_to_dac( );
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

        HW_TEST_state++;
        /* This is so we don't catch a button press when we don't want to. */
        delay_us( 1000 );
    }
    
    huge_Deinit( ); // incomplete ( ? )
    /* Tests completed!! Now onto normal system running... */
}

/*
** Test will check read and writes to RAM.
** If any fail, it get get stuck in the while loop.
*/
/*
review:
This test is several tests
read/write status byte
read/write values to RAM --> byte mode only

Missing tests:
where are the tests for SEQ/PAGE ?

Check did i fuck jup the test? when modifying it?
is this line the problem? if( RAM_MODE[ mode ] != data )

*/
void TEST_ram_test_001( void )
{
    uint8_t  data  = 0;
    uint8_t  wdata = 0;
    uint16_t addr  = 0;
    uint8_t  RAM_MODE[ NUM_OF_SPI_MODES ] = { BYTE_MODE, SEQ_MODE, PAGE_MODE, BYTE_MODE };
    uint8_t  mode = 0;

    //disable interrupts? .. maybe in SPI func ?
    CLOCK_setup( );
    setupNextTestButton( );
    // GPIO_setupDebugPin( );

    disableInterrupts( );
    SPI_setup( );
    RAM_init( );
    //DAC_init( ); //if unint will this effect the bus? seems not so .. should be tristate right?????
    enableInterrupts( );

    /* Test writing to status register.
       Set to SEQ/PAGE/BYTE mode.
       leave in BYTE mode for the following tests.
    */
    // for ( mode = 0; mode <= NUM_OF_SPI_MODES; mode++ )
    // {
    //     data = RAM_MODE[ mode ];
    //     RAM_write_status_register( data );
    //     RAM_read_status_register( &data );

    //     if( RAM_MODE[ mode ] != data )
    //     {
    //         /* Test failed */
    //         while( 1 );
    //     }
    // }

// fall back position
RAM_write_status_register( BYTE_MODE );

    /*  Test writing and reading from RAM.
        Do an exhaustive test of ram write/reading.
        Ram initial state should be 0xff so write to 0x0
        Could add GPIO toggle to time test!
    */
    wdata = 0x55;
    addr  = 0;

    for( addr = 0; addr < SRAM_SIZE; addr++ ) //is it <= or <  --Test!
    {
        RAM_write_byte( addr, wdata );
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
    testIncomplete = 1;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    disableInterrupts( );
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    SPI_setup( );
    RAM_init( );
    DAC_init( );
    enableInterrupts( );

    /* fill ram with values */
    for( addr = 0, wdata; addr<255; addr++, wdata+=4 )
    {
        RAM_write_byte( addr, wdata );
    }

    /* Read values out of ram and write to DAC */
    while( testIncomplete )
    {
        for( addr = 0; addr<255; addr++ )
        {
            RAM_read_byte( addr, &data );
            DAC_write( data );
            delay_us( 90 );   // ~11kHz sample rate // phasor == frequ
        }

        /* big delay in here to poll for button press -> maybe a better HW debounce would be quicker. */
        //testIncomplete = moveToNextTest( );
    }

}

/* Simply sends adc value to the dac */
void TEST_adc_to_dac( void )
{
    uint16_t adcVal = 0;
    testIncomplete = 1;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    disableInterrupts( );
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    DAC_init( );
    enableInterrupts( );

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
        DAC_write( (uint8_t)adcVal );

        /* ~11kHz sample rate */
        delay_us( 90 );

        /* Test for end of test.. */
        //testIncomplete = moveToNextTest( );
    }
}


void TEST_adc_to_ram_to_dac( void )
{
    uint16_t addr = 0;
    uint16_t adcVal = 0;
    uint8_t  ramData = 0;
    testIncomplete = 1;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    disableInterrupts( );
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    RAM_init( );
    DAC_init( );
    enableInterrupts( );

    while( testIncomplete )
    {
        /* uses multichannel ADC. */
        ADC_readMultiChannelInputs( );
        adcVal  = ADC1_GetBufferValue( 1 ); //magic number!
        
        /* Drop ADC to 8 bits. */
        adcVal >>= 2;

        /* write to ram */
        RAM_write_byte( addr, (uint8_t)adcVal );
        
        /* retrieve value from ram */
        RAM_read_byte( addr, &ramData ); // er adcVal is uint16 this returna uint8 ..

        DAC_write( ramData );
        
        /* check next addr, becaues why not. */
        addr++;

        //11kHz sample rate-ish
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
    uint16_t adcVal = 0;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    disableInterrupts( );
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    RAM_init( );
    DAC_init( );
    enableInterrupts( );
    
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
        RAM_write_byte( write_addr, (uint8_t)adcVal );

    //read from ram
        RAM_read_byte( read_addr, &read_val );

    //write value to dac
        DAC_write( read_val );

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
    testIncomplete = 1;

    /* disable interrupts/timers/spi/dac/ram/gpio?? */
    disableInterrupts( );
    CLOCK_setup( );
    setupNextTestButton( );
    //GPIO_setupDebugPin( );
    ADC1_setupMultiChannel( );
    SPI_setup( );
    RAM_init( );
    DAC_init( );
    enableInterrupts( );

    while( testIncomplete )
    {
        /* uses multichannel ADC. */
        ADC_readMultiChannelInputs( );
        adc0_val = ADC1_GetBufferValue( 0 );
        adc1_val = ADC1_GetBufferValue( 1 );

    //untested: set delay length (vari length delay) using adc
        delay = ( adc1_val >> 2 );

        // knob for feedback
        // knob for gain of ..

    // map function
        // (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
        // input range 0-1024 out range 0-255 therefore
        // slope = (255 - 0) / (1024 - 0); == 0.25 note float!!
        // function simplfys down to
        mapd_value = ( adc0_val >> 2 ) ; // do i need the float or not ??? -No use a lft shift

        // add in 16 bit then reduce down to 8 bit

        //with feedback 50% wet
        mapd_value = ( mapd_value / 2 ) + ( read_val / 2 ); // do i need the float or not ???

    // sort out read addresses
        if( (write_addr - delay) < 0 )
        {
            //start up situation
            read_addr = SRAM_SIZE - delay + write_addr;
        }

        if( (write_addr - delay) >= 0 )
        {
            read_addr = write_addr - delay;
        }

    //write to ram
        RAM_write_byte( write_addr, mapd_value );

    //read from ram
        RAM_read_byte( read_addr, &read_val );

    //write value to dac
        DAC_write( read_val );

    //increment write pointer
        write_addr++;

    //11kHz sample rate
        delay_us( 90 );
        
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
    testIncomplete = 1;

    //disableInterrupts( );
    CLOCK_setup( );
    setupNextTestButton( );
    GPIO_setupDebugPin( );
    //enableInterrupts( );

    while ( testIncomplete )
    {
        delay_ms( 1 ); // clock ~1kHz ??
        GPIO_WriteReverse( LOGICANALYSER_port, LOGICANALYSER_pin );
        //testIncomplete = moveToNextTest( );
    }
}

/*
    For testing setup this pin to increment the function under test
    Input pull-up, no external interrupt
*/
static void setupNextTestButton( void )
{
    /* set up as external interrupt! */
    /* Input pull-up, external interrupt */
    GPIO_Init(NEXT_TEST_BUTTON_PORT, NEXT_TEST_BUTTON_PIN, GPIO_MODE_IN_PU_IT);
    EXTI_setup( );
}

/* setup external interrupt pin  */
void EXTI_setup( void )
{
    /* deinitiate the interrupt controller and set priority while initiating it. It is not mandatory unless you want to set interrupt priority. */
    ITC_DeInit( );
    //ITC_SetSoftwarePriority( ITC_IRQ_PORTC, ITC_PRIORITYLEVEL_0 );
    
    /* configure the external interrupt on NEXT_TEST_BUTTON_PORT pins. We also set the edge that will invoke an interrupt. */
    EXTI_DeInit( );
    EXTI_SetExtIntSensitivity( EXTI_PORT_GPIOC, EXTI_SENSITIVITY_FALL_ONLY );
    EXTI_SetTLISensitivity( EXTI_TLISENSITIVITY_FALL_ONLY );
    enableInterrupts( );
}

/* if pin pulled low then return '0'.
    Currently debounce done in SW only.
*/
static uint8_t moveToNextTest( void )
{
//#warning DONT NEED ANYMORE :)
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
//#   warning Using external interrupt pin. HW debounce has not been implemented yet. 
    return BUTTON_PRESSED;
#endif /* SW_DEBOUNCE */
}

/* puts them back into there reset values
    so is this useful or not,
    probably useful to remove some test only gpio
    extInt stuff
*/
static void huge_Deinit( void )
{
    disableInterrupts( );
    /* deinitiate the interrupt controller */
    ITC_DeInit( );
    EXTI_DeInit( );
    /* GPIOD, GPIO_PIN_4*/
    /* port or pin ? */
    GPIO_DeInit( GPIOA );
    GPIO_DeInit( GPIOB );
    GPIO_DeInit( GPIOC );
    GPIO_DeInit( GPIOD );
    /* other gpio ports ?? */
    
    ADC1_DeInit( );
    SPI_DeInit( );
    TIM2_DeInit( );
    TIM4_DeInit( );
    CLK_DeInit( );

//#warning is this all the DeInit-s??
}

#endif /* __TESTS_HW_C__ */
