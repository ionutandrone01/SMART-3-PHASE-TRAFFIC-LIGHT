/*********************************************
Project : Test software
**********************************************
Chip type: ATmega164A
Clock frequency: 20 MHz
Compilers:  CVAVR 2.x
*********************************************/

#include <mega164a.h>

#include <stdio.h>
#include <delay.h>  
#include <string.h> 
#include <stdlib.h>
#include "defs.h"    



//*************************************************************************************************
//*********** BEGIN SERIAL STUFF (interrupt-driven, generated by Code Wizard) *********************
//*************************************************************************************************

#ifndef RXB8
#define RXB8 1
#endif

#ifndef TXB8
#define TXB8 0
#endif

#ifndef UPE
#define UPE 2
#endif

#ifndef DOR
#define DOR 3
#endif

#ifndef FE
#define FE 4
#endif

#ifndef UDRE
#define UDRE 5
#endif

#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)


// USART0 Receiver buffer
#define RX_BUFFER_SIZE0 8
char rx_buffer0[RX_BUFFER_SIZE0];

#if RX_BUFFER_SIZE0 <= 256
unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
#else
unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
#endif

// This flag is set on USART0 Receiver buffer overflow
bit rx_buffer_overflow0;

// USART0 Receiver interrupt service routine
interrupt [USART0_RXC] void usart0_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer0[rx_wr_index0++]=data;
#if RX_BUFFER_SIZE0 == 256
   // special case for receiver buffer size=256
   if (++rx_counter0 == 0) rx_buffer_overflow0=1;
#else
   if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
   if (++rx_counter0 == RX_BUFFER_SIZE0)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      }
#endif
   }
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART0 Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter0==0);
data=rx_buffer0[rx_rd_index0++];
#if RX_BUFFER_SIZE0 != 256
if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
#endif
#asm("cli")
--rx_counter0;
#asm("sei")
return data;
}
#pragma used-
#endif

// USART0 Transmitter buffer
#define TX_BUFFER_SIZE0 8
char tx_buffer0[TX_BUFFER_SIZE0];

#if TX_BUFFER_SIZE0 <= 256
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
#else
unsigned int tx_wr_index0,tx_rd_index0,tx_counter0;
#endif

// USART0 Transmitter interrupt service routine
interrupt [USART0_TXC] void usart0_tx_isr(void)
{
if (tx_counter0)
   {
   --tx_counter0;
   UDR0=tx_buffer0[tx_rd_index0++];
#if TX_BUFFER_SIZE0 != 256
   if (tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
#endif
   }
}

#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART0 Transmitter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used+
void putchar(char c)
{
while (tx_counter0 == TX_BUFFER_SIZE0);
#asm("cli")
if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
   {
   tx_buffer0[tx_wr_index0++]=c;
#if TX_BUFFER_SIZE0 != 256
   if (tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
#endif
   ++tx_counter0;
   }
else
   UDR0=c;
#asm("sei")
}
#pragma used-
#endif
//*************************************************************************************************
//********************END SERIAL STUFF (USART0)  **************************************************
//*************************************************************************************************
//*******   if you need USART1, enable it in Code Wizard and copy coresponding code here  *********
//*************************************************************************************************

/*
 * Timer 1 Output Compare A interrupt is used to blink LED
 */
interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
LED1 = ~LED1; // invert LED
}                                  

 void etapa1()
 {                      //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
       LMS2A_V = LOW;
       LMS2A_R = HIGH;
       
       delay_ms(1500);  //LA TERMINAREA CICLULUI MAI INTAI SE FACE ROSU PE STRADA 2A IAR CULORILE CELORLALTE SEMAFOARE COMUTA DUPA O INTARZIERE DE 1.5 SECUNDE
                        //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSIE
       LPS1_V = LOW;
       LPS1_R = HIGH;
                        //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSIE
       LPS2_V = LOW;
       LPS2_R = HIGH;
                        //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
       LMS2B_V = LOW;
       LMS2B_R = HIGH;
                        //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
       LMS1_V = HIGH;
       LMS1_R = LOW;
 } 
 
 void etapa2()
 {                      //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
       LMS2A_V = LOW;
       LMS2A_R = HIGH;
                        //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSIE
       LPS1_V = LOW;
       LPS1_R = HIGH;
                        //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSIE
       LPS2_V = LOW;
       LPS2_R = HIGH;
                         //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
       LMS2B_V = LOW;
       LMS2B_R = HIGH;
                        //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA GABLBEN
       LMS1_V = HIGH;
       LMS1_R = HIGH;
 }
 
 void etapa3()
 {                       //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
       LMS1_V = LOW;
       LMS1_R = HIGH;
       
       delay_ms(1500);  //DUPA CE SE FACE ROSU PE STRADA 1, CULORILE CELORLALTE SEMAFOARE COMUTA DUPA 1.5 SECUNDE
                        //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
       LMS2A_V = LOW;
       LMS2A_R = HIGH;
                         //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA VERDE
       LPS1_V = HIGH;
       LPS1_R = LOW;
                        //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSIE
       LPS2_V = LOW;
       LPS2_R = HIGH;
                        //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA VERDE
       LMS2B_V = HIGH;
       LMS2B_R = LOW;   
       
 }  
    
 void etapa4()
 {                       //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
       LPS1_V = LOW;
       LPS1_R = HIGH;
                         //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
       LPS2_V = LOW;
       LPS2_R = HIGH;
                         //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
       LMS1_V = LOW;
       LMS1_R = HIGH;
                         //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
       LMS2A_V = LOW;
       LMS2A_R = HIGH;   
     
                          //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA VERDE
       LMS2B_V = HIGH;
       LMS2B_R = LOW;   
       
       delay_ms(4000);
 }     

 
 void etapa5()
 {                       //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
       LPS1_V = LOW;
       LPS1_R = HIGH;
                         //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
       LPS2_V = LOW;
       LPS2_R = HIGH;
                         //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
       LMS1_V = LOW;
       LMS1_R = HIGH;
                         //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
       LMS2A_V = LOW;
       LMS2A_R = HIGH;   
     
                          //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA GALBEN
       LMS2B_V = HIGH;
       LMS2B_R = HIGH; 
 }     
 
 void etapa6()
 {                        //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
       LMS2B_V = LOW;
       LMS2B_R = HIGH;
        
       delay_ms(1500);   //DUPA CE SE FACE ROSU PE STRADA 2B, CULORILE CELORLALTE SEMAFOARE COMUTA DUPA 1.5 SECUNDE
                         //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
       LPS1_V = LOW;
       LPS1_R = HIGH;
                         //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA VERDE
       LPS2_V = HIGH;
       LPS2_R = LOW;
                          //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
       LMS1_V = LOW;
       LMS1_R = HIGH;
                         //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA ROSIE
       LMS2A_V = LOW;
       LMS2A_R = HIGH;
 } 
 
 void etapa7()
 {                      //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
       LPS2_V = LOW;
       LPS2_R = HIGH;
          
       delay_ms(1500);  //DUPA CE SE FACE ROSU LA PIETONII DE PE STRADA 2, CULORILE CELORLALTE SEMAFOARE COMUTA DUPA 2 SECUNDE
                        //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
       LPS1_V = LOW;
       LPS1_R = HIGH;
                         //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
       LMS1_V = LOW;
       LMS1_R = HIGH; 
                         //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA VERDE
       LMS2A_V = HIGH;
       LMS2A_R = LOW;
                          //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
       LMS2B_V = LOW;
       LMS2B_R = HIGH;
 } 
 
 void etapa8()
 {                       //SEMAFOARELE PE STRADA 2 PENTRU PIETONI AU CULOAREA ROSU
       LPS2_V = LOW;
       LPS2_R = HIGH;  
                         //SEMAFOARELE PE STRADA 1 PENTRU PIETONI AU CULOAREA ROSU
       LPS1_V = LOW;
       LPS1_R = HIGH;   
                         //SEMAFORUL PE STRADA 1 PENTRU MASINI ARE CULOAREA ROSIE
       LMS1_V = LOW;
       LMS1_R = HIGH;  
                         //SEMAFORUL PE STRADA 2B PENTRU MASINI ARE CULOAREA ROSIE
       LMS2B_V = LOW;
       LMS2B_R = HIGH; 
                          //SEMAFORUL PE STRADA 2A PENTRU MASINI ARE CULOAREA GALBEN
       LMS2A_V = HIGH;
       LMS2A_R = HIGH;
 }
 
 //flashuri
 
 void flash_PS1()       //este functia luminare intermitenta pentru semoaferele pietonilor de pe strada 1 si se activeaza atunci
                         //cand timpul pentru traversare este aproape de final
 {                    
      int initialState = LPS1_V;   //retinem starea culorii verzi a semafoarelor pentru pietonii de pe strada 1
      int i = 0;
      for(i = 0 ; i < 4; i++)     //prin parcurgerea buclei for asiguram aprinderea si stingerea led-ului de 4 ori
      {
         LPS1_V = LOW;
         delay_ms(500);
         LPS1_V = HIGH; 
         delay_ms(500);
      }     
      LPS1_V = initialState;
 }  
 
  void flash_PS2()         //este functia luminare intermitenta pentru semoaferele pietonilor de pe strada 2 si se activeaza atunci
                           //cand timpul pentru traversare este aproape de final
 {                    
      int initialState = LPS2_V;   //retinem starea culorii verzi a semafoarelor pentru pietonii de pe strada 2
      int i;
      for(i = 0 ; i < 4; i++)     //prin parcurgerea buclei for asiguram aprinderea si stingerea led-ului de 4 ori
      {
         LPS2_V = LOW;
         delay_ms(500);
         LPS2_V = HIGH; 
         delay_ms(500);
      }     
      LPS2_V = initialState;
 }  
 
int get_delay (char arg) {     //functie prin care atribuim caracterelor introduse valori prestabilite ale delay-urilor pe care dorim sa le setam 
  switch(arg) {               //switch-ul functioneaza doar cu numere, iar noi chiar daca ii dam un caracter, el o sa foloseasca coduri ASCII
   case '1': return 15;      //daca se introduce in terminal '1', functia returneaza o durata de 15 secunde (10% din ciclul de 2 minute si 30 sec = 150 sec)
   case '2': return 30;      //daca se introduce in terminal '2', functia returneaza o durata de 30 secunde (20% din ciclul de 2 minute si 30 sec)
   case '3': return 45;      //daca se introduce in terminal '3', functia returneaza o durata de 45 secunde (30% din ciclul de 2 minute si 30 sec)
   case '4': return 60;      //daca se introduce in terminal '4', functia returneaza o durata de 60 secunde (40% din ciclul de 2 minute si 30 sec)
   case '5': return 75;      //daca se introduce in terminal '5', functia returneaza o durata de 75 secunde (50% din ciclul de 2 minute si 30 sec)
   case '6': return 90;      //daca se introduce in terminal '6', functia returneaza o durata de 60 secunde (60% din ciclul de 2 minute si 30 sec)
   case '7': return 105;     //daca se introduce in terminal '7', functia returneaza o durata de 60 secunde (70% din ciclul de 2 minute si 30 sec)
   case '8': return 120;     //daca se introduce in terminal '8', functia returneaza o durata de 60 secunde (80% din ciclul de 2 minute si 30 sec)
      
   default : return 5;
   
  }
 }
/*
 * main function of program
 */
void main (void)
{          
unsigned char temp;
//initializarea variabilelor prin care setam delay-uri
int t_P=0, t_S2A=0, t_S2B=0, t_S1=0;
int dif;
int flag = 0;
int i;


char SS[4] = "";     //vector in care retinem caracterele introduse necesare setarii delay-ului
int s=0;             //index cu care parcurgem vectorul

	Init_initController();  // this must be the first "init" action/call!
	#asm("sei")             // enable interrupts
	LED1 = 1;           	// initial state, will be changed by timer 1
    DDRB = 0xFF;         //setarea pinilor din porturile B si C ca output 
    DDRC = 0xFF; 
    
    PORTB = PORTC = 0x00;//LOW = 0 HIGH = 1        //toate led-urile controlate de pini din B si C sunt stinse 
    
	while(TRUE)
	{
		wdogtrig();	        // call often else processor will reset
		if(rx_counter0)     // if a character is available on serial port USART0
		{
			temp = getchar();    
            if( temp ==  'A' ||  temp ==  'B'  || temp ==  'C'  || (temp >= '1' && temp <= '8')) 
            {
           
            SS[s++] = temp;   //retinem in SS caracterele introduse, primul caracter e retinut in SS[0] iar s=0, urmatorul caracter este retinut
                              // in SS[1], iar s=1
            if(s >= 2) {          //asigurare ca va rula codul chiar si atunci cand sunt introduse caractere in plus
            if (SS[0] == 'A' )    //compara codul ASCII
            {   flag = 1;
                t_S2A = get_delay(SS[1]);    //retinem in t_S2A valoarea intoarsa de functia get_delay
                dif = 123 - t_S2A;          //ciclul are 150 secunde, dar 27 sec sunt pierdute in cadrul fazelor 
                t_S1 = dif/3;               //alegem ca timpul ramas sa fie distribuit in mod egal   
                t_P = dif/3; 
                t_S2B = dif/3; 
               
            }
             
            
            if (SS[0] == 'B' )            
            {  flag = 1;
               t_S2B = get_delay(SS[1]);      //retinem in t_S2B valoarea intoarsa de functia get_delay
               dif = 123 - t_S2B;             //ciclul are 150 secunde, dar 27 sec sunt pierdute in cadrul fazelor
               t_S1 = dif/3;                  //alegem ca timpul ramas sa fie distribuit in mod egal             
               t_P =  dif/3;                
               t_S2A = dif/3;  
              
            }
            
            
            if (SS[0] == 'C' ) 
            {   flag = 1;
                t_S1 = get_delay(SS[1]);       //retinem in t_S1 valoarea intoarsa de functia get_delay
                dif = 123 - t_S1;              //ciclul are 150 secunde, dar 27 sec sunt pierdute in cadrul fazelor
                t_S2B = dif/3;                 //alegem ca timpul ramas sa fie distribuit in mod egal    
                t_P =  dif/3;
                t_S2A = dif/3;    
             // printf("\n");
             // printf("%d\n", t_S1);
             // printf("%d\n", dif);
               
             }  
            
             if(flag) {           // verificam daca a fost scris un caracter de identificare a strazilor
             
                while(1) {        // am introdus ciclul intr-o bucla infinita pentru a asigura continuitatea acestuia  
                
                
                etapa1();
                for(i=0; i< t_S1; i++){
                delay_ms (1000);   //cat timp au verde masinile de pe strada 1 identificata prin 'C'
                }
                etapa2();
       
                delay_ms(3000);         //cat dureaza culoarea galben a semaforului de pe strada 1 ('C')
        
                etapa3();
                for(i=0; i< t_S2B; i++){

                delay_ms(1000);  //cat timp au verde masinile de pe strada 2B (in acelasi timp pietonii de pe strada 1 au verde)
                }
                flash_PS1();         //semaforul pietonilor de pe strada 1 lumineaza intermitent cand acestia mai au putin timp pentru a traversa
        
                etapa4();   
                
                etapa5();
        
                delay_ms(3000);     //cat dureaza culoarea galben a semaforului pe strada 2B
        
                etapa6();
                for(i=0; i< t_P; i++){

                delay_ms(1000);   // semafoarele pietonilor de pe strazile 2A si 2B au culoarea verde
                }
                flash_PS2();          //semafoarele pietonilor de pe strazile 2A si 2B lumineaza intermitent cand acestia mai au putin timp pentru a traversa
        
                etapa7();
                for(i=0; i< t_S2A; i++){

                delay_ms(1000);   // cat timp au verde masinile de pe strada 2A
                }
                etapa8();
        
                delay_ms(3000);         //cat dureaza culoarea galben a semaforului de pe strada 2A
                }
             }
            
            }
            
         
		    } 
            
            else {           //in cazul in care sunt introduse alte caractere decat cele prin care sunt identificate strazile, am stabilit un ciclu implicit 
                while(1) {
                etapa1();
        
                delay_ms(35000);
        
                etapa2();
       
                delay_ms(3000);
        
                etapa3();
        
                delay_ms(35000); 
        
                flash_PS1(); 
        
                etapa4();  
                
                etapa5();
        
                delay_ms(3000);
        
                etapa6();
        
                delay_ms(18000);
        
                flash_PS2();
        
                etapa7();
        
                delay_ms(35000);
        
                etapa8();
        
                delay_ms(3000); 
                }
            }
        } 
        
              

    } 

            
}// end main loop 


