//This demo triggers a image display with each new class
// Works with 1 classifier output, any number of classes
//Listens on port 12000 for message /wek/outputs (defaults)

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;


//No need to edit:
PImage imgT, imgJ, imgE, imgO;
PImage[] images = new PImage[5];
PFont myFont, myBigFont;
final int myHeight = 400;
final int myWidth = 400;
int frameNum = 0;
int currentHue = 100;
int currentTextHue = 255;
String currentMessage = "";
PImage currentBackground;



void setup() {
  //Initialize OSC communication
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  
  images[0] = loadImage("static.gif");
  images[1] = loadImage("dtnew.jpg");
  images[2] = loadImage("kk.jpg");
  images[3] = loadImage("ew.gif");
  images[4] = loadImage("ow.gif");
  
  colorMode(HSB);
  size(1024,768, P3D);
  smooth();
  currentBackground = images[0];
  
  String typeTag = "f";
  myFont = createFont("Arial", 14);
  myBigFont = createFont("Arial", 80);
}


void draw() {
  frameRate(60);
  drawText();
}

String[] arraynames = {"Placeholder", "Emma Watson", "Oprah Winfrey", "James Earl Jones", "Donald Trump"};


//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 println("received message");
    if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
      if(theOscMessage.checkTypetag("f")) {
      float f = theOscMessage.get(0).floatValue();
      println("received1");
       showMessage((int)f);
      }
    }
 
}

void showMessage(int i) {
    currentMessage = arraynames[i-1];
    currentBackground = images[i-1];
}

//Write instructions to screen.
void drawText() {
    stroke(0);
    textFont(myFont);
    textAlign(LEFT, TOP); 
    fill(currentTextHue, 255, 255);

    //text("Receives 1 classifier output message from wekinator", 10, 10);
    //text("Listening for OSC message /wek/outputs, port 12000", 10, 30);
    
    textFont(myBigFont);
    text(currentMessage, 190, 180);
    background(currentBackground);
   
}