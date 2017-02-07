import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;
int lineStatus = 1;   //initializing the line's "status"
float pos_X = 0.2;
float pos_Y = 0.2;
float old_X = 0.2;
float old_Y = 0.2;

void setup(){
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  
  size(700, 700);    //sets size of processing window
  background(0);     //background black
  
}



void oscEvent(OscMessage theOscMessage){
  
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
      if(theOscMessage.checkTypetag("ff")) {
        float i = theOscMessage.get(0).floatValue();
        float j = theOscMessage.get(1).floatValue();
        println("received message: x = " +i +", y = " + j);
        messageReceived(i, j);    
        //calls message received with the wekinator output (should be integer)
      }
  
  }
}

void messageReceived(float i, float j){  //function that sets the line's status
  old_X = pos_X;
  old_Y = pos_Y;
  pos_X = i;
  pos_Y = j;
}

void draw(){
  frameRate(30);
  stroke(255);
  strokeWeight(4);
  smooth();
  
  if (lineStatus == 1) {  // if the lineStatus is 1 (i.e. output 1 sent)
    line(pos_X*500, pos_Y*500, old_X*500, old_Y*500);
    // pmouseX & Y are processing positions where the line is drawn, these correspond
    // to the mouseX & Y of the cursor
  }
}