/*
    rgb_lcd.cpp
    2013 Copyright (c) Seeed Technology Inc.  All right reserved.

    Author:Loovee
    2013-9-18

    add rgb backlight fucnction @ 2013-10-15

    The MIT License (MIT)

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.1  USA
*/
#include "project.h"
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#include "rgb_lcd.h"

static uint8_t rgb_chip_addr;

static uint8_t displayfunction;
static uint8_t displaycontrol;
static uint8_t displaymode;

//static uint8_t initialized;

static uint8_t numlines, currline;

void setColorAll() {
    setRGB(0, 0, 0);
}
void setColorWhite() {
    setRGB(255, 255, 255);
}

void i2c_send_byte(unsigned char dta) {
    uint8_t status;
    status = I2C_MasterSendStart(LCD_ADDRESS, I2C_WRITE_XFER_MODE);// transmit to device #4
    I2C_MasterWriteByte(dta);   // send byte
    I2C_MasterSendStop();       // stop transmitting
}

void i2c_send_byteS(unsigned char* dta, unsigned char len) {
    uint8_t status;
    status = I2C_MasterSendStart(LCD_ADDRESS, I2C_WRITE_XFER_MODE);// transmit to device #4
    for (int i = 0; i < len; i++) {
        I2C_MasterWriteByte(dta[i]);   // send byte
    }
    I2C_MasterSendStop();       // stop transmitting
}

/*********** mid level commands, for sending data/cmds */

// send command
inline void command(uint8_t value) {
    unsigned char dta[2] = {0x80, value};
    i2c_send_byteS(dta, 2);
}

// send data
size_t write(uint8_t value) {

    unsigned char dta[2] = {0x40, value};
    i2c_send_byteS(dta, 2);
    return 1; // assume sucess
}

void setReg(unsigned char reg, unsigned char dat) {
    uint8_t status;
    status = I2C_MasterSendStart(rgb_chip_addr, I2C_WRITE_XFER_MODE);// transmit to device #4
    I2C_MasterWriteByte(reg);   // send byte
    I2C_MasterWriteByte(dat);   // send byte
    I2C_MasterSendStop();       // stop transmitting
}

void setRGB(unsigned char r, unsigned char g, unsigned char b) {
    if (rgb_chip_addr == RGB_ADDRESS_V5)
    {
        setReg(0x06, r);
        setReg(0x07, g);
        setReg(0x08, b);
    }
    else
    {
        setReg(0x04, r);
        setReg(0x03, g);
        setReg(0x02, b);
    }
}

void setPWM(unsigned char color, unsigned char pwm) {
    switch (color)
    {
        case WHITE:
            setRGB(pwm, pwm, pwm);
            break;
        case RED:
            setRGB(pwm, 0, 0);
            break;
        case GREEN:
            setRGB(0, pwm, 0);
            break;
        case BLUE:
            setRGB(0, 0, pwm);
            break;
        default:
            break;
    }
}

const unsigned char color_define[4][3] = {
    {255, 255, 255},            // white
    {255, 0, 0},                // red
    {0, 255, 0},                // green
    {0, 0, 255},                // blue
};

void setColor(unsigned char color) {
    if (color > 3) {
        return ;
    }
    setRGB(color_define[color][0], color_define[color][1], color_define[color][2]);
}

void begin_rgb_lcd(uint8_t cols, uint8_t lines, uint8_t dotsize) {
    uint8_t status;
    
    I2C_Start();

    if (lines > 1) {
        displayfunction |= LCD_2LINE;
    }
    numlines = lines;
    currline = 0;

    // for some 1 line displays you can select a 10 pixel high font
    if ((dotsize != 0) && (lines == 1)) {
        displayfunction |= LCD_5x10DOTS;
    }

    // SEE PAGE 45/46 FOR INITIALIZATION SPECIFICATION!
    // according to datasheet, we need at least 40ms after power rises above 2.7V
    // before sending commands. Arduino can turn on way befer 4.5V so we'll wait 50
    CyDelay(2000);


    // this is according to the hitachi HD44780 datasheet
    // page 45 figure 23

    // Send function set command sequence
    command(LCD_FUNCTIONSET | displayfunction);
    CyDelayUs(4500);  // wait more than 4.1ms

    // second try
    command(LCD_FUNCTIONSET | displayfunction);
    CyDelayUs(150);

    // third go
    command(LCD_FUNCTIONSET | displayfunction);


    // finally, set # lines, font size, etc.
    command(LCD_FUNCTIONSET | displayfunction);

    // turn the display on with no cursor or blinking default
    displaycontrol = LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKOFF;
    display();

    // clear it off
    clear();

    // Initialize to default text direction (for romance languages)
    displaymode = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;
    // set the entry mode
    command(LCD_ENTRYMODESET | displaymode);

    // check rgb chip model
    status = I2C_MasterSendStart(RGB_ADDRESS_V5, I2C_WRITE_XFER_MODE); // transmit to device #4
    if (status == I2C_MSTR_NO_ERROR)
    {
        I2C_MasterSendStop();
        rgb_chip_addr = RGB_ADDRESS_V5;
        setReg(0x00, 0x07); // reset the chip
        CyDelayUs(200); // wait 200 us to complete
        setReg(0x04, 0x15); // set all led always on
    }
    else
    {
        I2C_MasterSendStop();
        rgb_chip_addr = RGB_ADDRESS;
        // backlight init
        setReg(REG_MODE1, 0);
        // set LEDs controllable by both PWM and GRPPWM registers
        setReg(REG_OUTPUT, 0xFF);
        // set MODE2 values
        // 0010 0000 -> 0x20  (DMBLNK to 1, ie blinky mode)
        setReg(REG_MODE2, 0x20);
    }

    setColorWhite();
}

/********** high level commands, for the user! */
void printString(char *c) {
    while (*c) 
        write(*c++);
}

void clear() {
    command(LCD_CLEARDISPLAY);        // clear display, set cursor position to zero
    CyDelayUs(2000);          // this command takes a long time!
}

void home() {
    command(LCD_RETURNHOME);        // set cursor position to zero
    CyDelayUs(2000);        // this command takes a long time!
}

void setCursor(uint8_t col, uint8_t row) {

    col = (row == 0 ? col | 0x80 : col | 0xc0);
    unsigned char dta[2] = {0x80, col};

    i2c_send_byteS(dta, 2);

}

// Turn the display on/off (quickly)
void noDisplay() {
    displaycontrol &= ~LCD_DISPLAYON;
    command(LCD_DISPLAYCONTROL | displaycontrol);
}

void display() {
    displaycontrol |= LCD_DISPLAYON;
    command(LCD_DISPLAYCONTROL | displaycontrol);
}

// Turns the underline cursor on/off
void noCursor() {
    displaycontrol &= ~LCD_CURSORON;
    command(LCD_DISPLAYCONTROL | displaycontrol);
}

void cursor() {
    displaycontrol |= LCD_CURSORON;
    command(LCD_DISPLAYCONTROL | displaycontrol);
}

// Turn on and off the blinking cursor
void noBlink() {
    displaycontrol &= ~LCD_BLINKON;
    command(LCD_DISPLAYCONTROL | displaycontrol);
}
void blink() {
    displaycontrol |= LCD_BLINKON;
    command(LCD_DISPLAYCONTROL | displaycontrol);
}

// These commands scroll the display without changing the RAM
void scrollDisplayLeft(void) {
    command(LCD_CURSORSHIFT | LCD_DISPLAYMOVE | LCD_MOVELEFT);
}
void scrollDisplayRight(void) {
    command(LCD_CURSORSHIFT | LCD_DISPLAYMOVE | LCD_MOVERIGHT);
}

// This is for text that flows Left to Right
void leftToRight(void) {
    displaymode |= LCD_ENTRYLEFT;
    command(LCD_ENTRYMODESET | displaymode);
}

// This is for text that flows Right to Left
void rightToLeft(void) {
    displaymode &= ~LCD_ENTRYLEFT;
    command(LCD_ENTRYMODESET | displaymode);
}

// This will 'right justify' text from the cursor
void autoscroll(void) {
    displaymode |= LCD_ENTRYSHIFTINCREMENT;
    command(LCD_ENTRYMODESET | displaymode);
}

// This will 'left justify' text from the cursor
void noAutoscroll(void) {
    displaymode &= ~LCD_ENTRYSHIFTINCREMENT;
    command(LCD_ENTRYMODESET | displaymode);
}

// Allows us to fill the first 8 CGRAM locations
// with custom characters
void createChar(uint8_t location, uint8_t charmap[]) {

    location &= 0x7; // we only have 8 locations 0-7
    command(LCD_SETCGRAMADDR | (location << 3));


    unsigned char dta[9];
    dta[0] = 0x40;
    for (int i = 0; i < 8; i++) {
        dta[i + 1] = charmap[i];
    }
    i2c_send_byteS(dta, 9);
}

//// Equivalent to createChar but using array from PROGMEM
//void createCharFromProgmem(uint8_t location, const uint8_t *charmap) {
//
//    location &= 0x7; // we only have 8 locations 0-7
//    command(LCD_SETCGRAMADDR | (location << 3));
//
//
//    unsigned char dta[9];
//    dta[0] = 0x40;
//    for (int i = 0; i < 8; i++) {
//        dta[i + 1] = pgm_read_byte_near(charmap+i);
//    }
//    i2c_send_byteS(dta, 9);
//}

// Control the backlight LED blinking
void blinkLED(void) {
    if (rgb_chip_addr == RGB_ADDRESS_V5){
        // attach all led to pwm1
        // blink period in seconds = (<reg 1> + 2) *0.128s
        // pwm1 on/off ratio = <reg 2> / 256
        setReg(0x04, 0x2a);  // 0010 1010
        setReg(0x01, 0x06);  // blink every second
        setReg(0x02, 0x7f);  // half on, half off
    }else{
        // blink period in seconds = (<reg 7> + 1) / 24
        // on/off ratio = <reg 6> / 256
        setReg(0x07, 0x17);  // blink every second
        setReg(0x06, 0x7f);  // half on, half off
    }
}

void noBlinkLED(void) {
    if (rgb_chip_addr == RGB_ADDRESS_V5) {
        setReg(0x04, 0x15);  // 0001 0101
    } else {
        setReg(0x07, 0x00);
        setReg(0x06, 0xff);
    }
}