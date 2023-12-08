import processing.sound.*;
import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import cc.arduino.*;
import java.util.Arrays;
import java.io.File;
import java.util.Collections;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
Arduino arduino;

int ledPin = 13;    // LED connected to digital pin 13
int ledPin2 = 12;     // LED connected to digital pin 12
int ledPin3 = 11;     // LED connected to digital pin 11
int ledPin4 = 9;     // LED connected to digital pin 9
int ledPin5 = 8;   // LED connected to digital pin 8
int ledPin6 = 7;     // LED connected to digital pin 7
int ledPinBlink = 2; // Additional LED connected to digital pin 2 for blinking

float kickSize, snareSize, hatSize, pSize;

String[] playlist;
int currentSongIndex = 0;

boolean continuePlaying = true;  // Flag to control whether to play the next song

void setup() {
  size(512, 200, P3D);

  minim = new Minim(this);

  // Check for available serial ports
  String[] portList = Arduino.list();
  if (portList.length >= 1) {
    // Check if there are at least 3 available ports before accessing index 2
    arduino = new Arduino(this, Arduino.list()[0], 57600);
  } else {
    println("Error: Not enough serial ports available.");
    exit(); // Exit the sketch if there are not enough serial ports
  }

  // Set pin 2 to HIGH (always on)
  arduino.pinMode(ledPinBlink, Arduino.OUTPUT);
  arduino.digitalWrite(ledPinBlink, Arduino.HIGH); // Set initially to LOW


  // Get the list of MP3 files in the data directory
  String dataPath = sketchPath("data");
  File directory = new File(dataPath);
  File[] files = directory.listFiles((dir, name) -> name.toLowerCase().endsWith(".mp3"));

  // Shuffle the files to play them in a random order
  Arrays.sort(files);
  Collections.shuffle(Arrays.asList(files));

  // Create a playlist from the shuffled files
  playlist = Arrays.stream(files).map(File::getAbsolutePath).toArray(String[]::new);

  // Load and play the first song in the playlist
  playNextSong();

  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(235);
  kickSize = 32;
  snareSize = 16;
  hatSize = 24;
  pSize = 16;
  bl = new BeatListener(beat, song);
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER);
  
  arduino.pinMode(ledPin, Arduino.OUTPUT);
  arduino.pinMode(ledPin2, Arduino.OUTPUT);
  arduino.pinMode(ledPin3, Arduino.OUTPUT);
  arduino.pinMode(ledPin4, Arduino.OUTPUT);
  arduino.pinMode(ledPin5, Arduino.OUTPUT);
  arduino.digitalWrite(ledPin5, Arduino.HIGH)
  arduino.pinMode(ledPin6, Arduino.OUTPUT);
}

void draw() {
  background(0);
  fill(255);

  if (beat.isKick()) {
    triggerPin(ledPin);
    triggerPin(ledPin4);
    kickSize = 30;
  }

  if (beat.isSnare()) {
    triggerPin(ledPin2);
    pinTrigger(ledPin5);
    snareSize = 35;
  }

  if (beat.isHat()) {
    triggerPin(ledPin6);
    triggerPin(ledPin3);
    hatSize = 40;
  }

  // Example conditions to trigger pins based on beat parameters
  if (beat.isOnset(2)) {
    triggerPin(ledPin4);
    triggerPin(ledPin);
  }

  if (beat.isOnset(4)) {
    pinTrigger(ledPin5);
  }

  // Blink an additional LED along with the song
  arduino.digitalWrite(ledPin3, beat.isOnset() ? Arduino.HIGH : Arduino.LOW);
  delay(200);

  textSize(kickSize);
  text("FUNK", width / 2, height / 2);
  textSize(snareSize);
  text("GROOVE", width / 6, height / 2);
  textSize(hatSize);
  text("RHYTHM", 3 * width / 4, height / 2);
  textSize(pSize);
  text("Press 's' to stop", 1 * width / 8, height / 1);
  kickSize = constrain(kickSize * 0.95, 16, 32);
  snareSize = constrain(snareSize * 0.95, 16, 32);
  hatSize = constrain(hatSize * 0.95, 16, 32);

  // Play the next song directly within the draw loop
  if (!song.isPlaying() && continuePlaying) {
    playNextSong(); // Play the next song
    println("New song started!");
  }

  // Prompt the user to continue or stop
  if (!continuePlaying) {
    textSize(20);
    fill(255, 0, 255);
    text("Press 's' to stop", width / 2, height -30);
  }
}

void triggerPin(int pin) {
  arduino.digitalWrite(pin, Arduino.HIGH);
  delay(200);
  arduino.digitalWrite(pin, Arduino.LOW);
}
void pinTrigger(int pin) {
  arduino.digitalWrite(pin, Arduino.LOW);
  delay(200);
  arduino.digitalWrite(pin, Arduino.HIGH);
}
void keyPressed() {
  if (key == 's' || key == 'S') {
    continuePlaying = false;  // Stop playing the next song
    arduino.digitalWrite(ledPinBlink, Arduino.LOW); // Set to LOW to resume normal operation
   stop();
   exit();
  }
}

// Function to load and play the next song in the playlist
void playNextSong() {
  if (currentSongIndex < playlist.length) {
    if (song != null) {
      song.close();
    }
    try {
      song = minim.loadFile(playlist[currentSongIndex], 2048);
      song.play();
      currentSongIndex++;
      beat = new BeatDetect(song.bufferSize(), song.sampleRate());
      beat.setSensitivity(450);
      kickSize = 32;
      snareSize = 16;
      hatSize = 24;
      pSize = 18;
      bl = new BeatListener(beat, song);
      textFont(createFont("Helvetica", 16));
      textAlign(CENTER);
    } catch (Exception e) {
      println("Error loading MP3 file: " + e.getMessage());
    }
  }
}
