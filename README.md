# xmas_lights_sound
Put music to your Xmas Lights
# lights-to-music
control script for putting lights to the sound of music via relay controled by arduino
## X-mas Lights to Music was the original thought behind this project, but you can use this for whatver suits your needs. 

## Simple  and inexpensive way to sync music to your Christmas lights.
### !!!Warning!!! #### You are responsible for getting your own music. Please do so Leagaly
### What you will need:
  * Arduino Uno ( Honestly, I think any arduino will do as long as it is programable and can perform digitalwrite out functionality)/
  * Arduino IDE Software found [here](https://www.arduino.cc/en/software/)
  * The program code is written with the processing tool you can find the download [here](https://processing.org/download) and is written in Java if I am not mistaken.  I will upload the original scripts cause you may need to edit them which you can do with a normal txt editor, but we'll get to that. 
  * 5vDC MO/NC relay board, I picked one up from amazon for about 9 bucks
  * A hand full of electical outlets.
  * wire
  * speakers - I used the old car speakers from when I upgraded my sound system in my Jeep.
  * some sort of power behind those speakers.  - I used a cheep 500W car amp off Ebay to power the speakers.
  
  * Patients! lots and lots of patients.  Hopefully I did a majority of the heavy lifting and you will  have an easier time getting this functional in your envirornment.
  

### Steps
*Step 1
** install IDE software,  
** Navigate to the libraries area search for firmata in the search bar and install it.
** Once installed, go to File/Examples/Firmata/StandardFirmata and open up that example sketch. 
** Upload that sketch to your arduino.  This sketch enabels the serial through the USB port functionality.
* Step 2
** Put the songs you want the lights to "dance" to in the data folder.  The code is designed to shuffle play the .MP3 files within that folder.
* There is an area of code that you may need to edit, and that has to do with the device and what serial port is being taken up by the aduino.  If you are on Windows you will need to make sure to install the device drivers, especially if you are using 3rd party hardware.
* Step 3
** wire it all together.
   <sub>diagrams and pictures coming soon, but if you already understand basic electronics and how relays operate you should have no problem

## I have added a wireless method using 2 ESP8266 for a satalite controle and Ill put in the method I used to switch 24VDC on and off using Mosfet transistors.  
