#include <mega32a.h>
#include <delay.h>
#include <i2c.h>
#include <ds1307.h>
#include <stdio.h>
#include <alcd.h>

//newline by darvish
#include <iostream>
#include <fstream>
using namespace std;
//end newline by darvish
#define ADC_VREF_TYPE ((0<<REFS1) | (0<<REFS0) | (0<<ADLAR))



// new func by darvish

int writein(string one){
    //write your specific path here.
    const char *path= "/home/lrd/Documents/test24.txt"   ;
    std::ofstream file(path);
    string data = one ;
    //std::string data();
    file << data;
    return 4321;
};
//end new func by darvish




unsigned int read_adc(unsigned char adc_input)
{
    ADMUX=adc_input | ADC_VREF_TYPE;
// Delay needed for the stabilization of the ADC input voltage
    delay_us(10);
// Start the AD conversion
    ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
    while ((ADCSRA & (1<<ADIF))==0);
    ADCSRA|=(1<<ADIF);
    return ADCW;
}

#define DHT11_PORT PORTA
#define DHT11_PORTPIN PORTA1
#define DHT11_DDR DDRA
#define DHT11_DDRPIN DDA1
#define DHT11_PINPORT PINA
#define DHT11_PIN PINA1

#define DHT11_INPUT_MODE() DHT11_DDR&=~(1<<DHT11_DDRPIN)
#define DHT11_OUTPUT_MODE() DHT11_DDR|=(1<<DHT11_DDRPIN)
#define DHT11_LOW() DHT11_PORT&=~(1<<DHT11_PORTPIN)
#define DHT11_HIGH() DHT11_PORT|=(1<<DHT11_PORTPIN)

#define DHTLIB_OK                               0
#define DHTLIB_ERROR_CHECKSUM                    -1
#define DHTLIB_ERROR_TIMEOUT                    -2

int read_dht11(int *temp,int *humidity);


char shift[4]={0xFE,0xFD,0xFB,0xF7};
char keypad[15]={'1','2','3',
                 '','4','5','6',
                 '','7','8','9',
                 '','*','0','#'};
char read(void)
{
    while(1)
    {
        int x=-1;
        int i=0;
        for( i=0 ; i<=3 ; i++ )
        {

            PORTD=shift[i];
            delay_ms(150);
            if(PIND.5==0)
            {
                delay_ms(150);
                if(PIND.5==0)
                x=1;
            }
            if(PIND.4==0)
            {
                delay_ms(150);
                if(PIND.4==0)
                x=0;
            }
            if(PIND.6==0)
            {
                delay_ms(150);
                if(PIND.6==0)
                x=2;
            }
            if(x!=-1)
            {
                x=-1;
                return (keypad[(i*4)+x]);
            }

        }

    }
}

void main(void)
{
    char hh,mm,ss,h,m,s,he,me,tmin,tmax;
    char buffer[17];
    char lcd_buff[17];
    int temp=0;
    int humidity=0;
    int status=0;
    lcd_init(16);
    i2c_init();
    rtc_init(0,0,0);
    rtc_set_time(2,2,1);
//status=read_dht11(&temp,&humidity);
//rtc_get_time(&hh,&mm,&ss);
//lcd_clear();
//lcd_gotoxy(0,0);
//sprintf(lcd_buff,"Temp:%02d H:%02d  ",temp,humidity);
//lcd_puts(lcd_buff);
//delay_ms(1);
//lcd_gotoxy(1,1);
//sprintf(buffer,"%d:%d:%d" ,hh,mm,ss );
//lcd_puts(buffer);
//delay_ms(2000);
    lcd_clear();
    lcd_puts("start hour?");
    h = read();
    lcd_clear();
    lcd_puts("start minute?");
    m = read();
    lcd_clear();
    lcd_puts("stop hour?");
    he = read();
    lcd_clear();
    lcd_puts("stop minute?");
    me = read();
    lcd_clear();
    PORTC.7=0;
    //lines by darvish
    //int writein ;
    writein(me);
    //endline by darvish
    while (1)
    {
        status=read_dht11(&temp,&humidity);
        rtc_get_time(&hh,&mm,&ss);
        if (he>>hh )        //he>>hh && h<<hh && temp>>tmin && me>>mm && m<<mm
        {

            //status=read_dht11(&temp,&humidity);
            //rtc_get_time(&hh,&mm,&ss);
            PORTC.7=1;
            lcd_clear();
            lcd_gotoxy(0,0);
            sprintf(buffer,"you started at %d" ,h );
            lcd_puts(buffer);
            delay_ms(1);
            lcd_gotoxy(1,1);
            sprintf(buffer,"It will end at %d" ,he );
            lcd_puts(buffer);
            delay_ms(20);

        }
        else
        {
            //status=read_dht11(&temp,&humidity);
            //rtc_get_time(&hh,&mm,&ss);
            PORTC.7=0;
            lcd_clear();
            lcd_gotoxy(0,0);
            sprintf(buffer,"started at %d" ,h);
            lcd_puts(buffer);
            delay_ms(1);
            lcd_gotoxy(1,1);
            sprintf(buffer,"end at %d" ,he );
            lcd_puts(buffer);
            delay_ms(20);
        }
    }

}
int read_dht11(int *temp,int *humidity){
    unsigned char bytes[5];
    unsigned char sum;
    unsigned int bitcount=8;
    unsigned int loopcount=0;
    unsigned int byteid=0;
    int i=0;
// EMPTY BUFFER
    for (i=0; i< 5; i++) bytes[i] = 0;
// REQUEST SAMPLE
    DHT11_OUTPUT_MODE();
    DHT11_LOW();
    delay_ms(20);
    DHT11_HIGH();
    delay_us(2);
    DHT11_INPUT_MODE();
    DHT11_LOW();
    loopcount=0;
    while(!(DHT11_PINPORT&(1<<DHT11_PIN))){ //pin is low
        delay_us(40);
        loopcount++;
    }
    if (loopcount>80) return DHTLIB_ERROR_TIMEOUT;
    loopcount=0;
    while((DHT11_PINPORT&(1<<DHT11_PIN))){ //pin is high
        delay_us(1);
        loopcount++;
    }
    if (loopcount>80) return DHTLIB_ERROR_TIMEOUT;
    for(i=0;i<40;i++){
        loopcount=0;
        while(!(DHT11_PINPORT&(1<<DHT11_PIN))){}
        while((DHT11_PINPORT&(1<<DHT11_PIN)) && loopcount<100){loopcount++;delay_us(1);}
        if(loopcount>15)
            bytes[byteid] |= (1 << bitcount);
        if (bitcount == 0)   // next byte?
        {
            bitcount = 7;    // restart at MSB
            byteid++;      // next byte!
        }
        else bitcount--;
    }
    *humidity    = bytes[0];
    *temp = bytes[2];
    sum = (bytes[0] + bytes[1]+ bytes[2]+ bytes[3])&0xff;
    if (bytes[4] != sum) return DHTLIB_ERROR_CHECKSUM;
    return DHTLIB_OK;
}
