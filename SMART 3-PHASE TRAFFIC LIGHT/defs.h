/* definitions / defines file */
#define DEFS_H

#define SW_VERSION		13   /* i.e. major.minor software version nbr. */

#ifndef NULL
#define NULL  0
#endif
        
// logix ...
#define TRUE	1
#define FALSE	0 
#define DUMMY	0

#define wdogtrig()			#asm("wdr") // call often if Watchdog timer enabled

#define CR				0x0D
#define LF				0x0A  

#define LED1 PORTD.6        // PORTx is used for output
#define SW1 PIND.5          // PINx is used for input
#define TESTP PORTD.4       // test bit durations

 //PENTRU PIETONII DE PE STRADA 1
#define LPS1_V PORTB.0
#define LPS1_R PORTB.1
 //PENTRU PIETONII DE PE STRADA 2
#define LPS2_V PORTB.2
#define LPS2_R PORTB.3
 //PENTRU  MASINILE DE PE STRADA 1
#define LMS1_V PORTB.4
#define LMS1_R PORTB.5
  //PENTRU MASINILE DE PE STRADA 2A
#define LMS2A_V PORTB.6
#define LMS2A_R PORTC.0
  //PENTRU MASINILE DE PE STRADA 2B
#define LMS2B_V PORTC.1
#define LMS2B_R PORTC.2

#define HIGH 1
#define LOW 0

#include "funct.h"

