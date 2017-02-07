import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;
int lineStatus = 0;   //initializing the line's "status"

void setup(){
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  
  size(300, 300);    //sets size of processing window
  background(0);     //background black
  
}



void oscEvent(OscMessage theOscMessage){
  println("received message");
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
      if(theOscMessage.checkTypetag("f")) {
        float f = theOscMessage.get(0).floatValue();
        messageReceived(int(f));    
        //calls message received with the wekinator output (should be integer)
      }
  }
}

void messageReceived(int i){  //function that sets the line's status
  lineStatus = i;
}

void draw(){
  frameRate(30);
  stroke(255);
  strokeWeight(4);
  smooth();
  
  if (lineStatus == 1) {  // if the lineStatus is 1 (i.e. output 1 sent)
    line(pmouseX, pmouseY, mouseX, mouseY);
    // pmouseX & Y are processing positions where the line is drawn, these correspond
    // to the mouseX & Y of the cursor
  }
}