import processing.serial.*; 
Serial myPort; //let's get that data flowing out of arudio to processing by 
//going to the the serial port and seeing what's there! 

int lf = 10;    // Linefeed in ASCII.  
float num =0.0;  //this variable holds the chang
String myString = null; //all data from arduino 

void setup() {
  println(Serial.list()); //what ports are on my computer! 
  myPort = new Serial(this, "/dev/tty.usbmodem1421",57600); //pick the right port and
  //set the speed were' going to check the port at 
  size(displayWidth, displayHeight); 
  //this sets up the window size to the size of your screen 
  background(0); 
  //turns the background black 
}

void draw() {
  smooth(); //sets the drawing up to be sexy 
  //handle arduino data.   
  while (myPort.available() > 0) { //hey while there's data at the port 
    myString = myPort.readStringUntil(lf); //read it until you hit the end of the line
    //and save it into the myString variable 
    if (myString != null) { //if we did that successfully 
    //print(myString);  // Prints String 
    num=float(myString);  // Converts and prints int
    println(num); //prints coverted data as a number verses as a word. 
    }
  }
  myPort.clear(); // clean up the port so it's ready for new data  

 //draw some fun things 
   if(num > 0) //this keeps us from always getting a straight line across
   //our drawing on start up     
      {
        pushMatrix();
        translate(width/2,height/2);
        //these two lines of code move us to the middle of the screen 

//this next bit of code just takes the frequency data from arduino
//and relates it to a cirle's radius and the nubmer of segments used
//to draw it. 
        int mappedNum = (int)map(num, 65,800, 3, 50);
        //map the tone ranges from the musicBox.h file we set up in Arduino
        //to how many segments we want our form to have 

        int circleResolution = (int)map(((int)num),0,height,2, mappedNum);
        //we then map that number to the spaceof the actual display.  

        println(circleResolution); //what's our circle resolution 
       
        int widthMap = (int)map(num, 65.0, 800.0, 0.0,(float)displayWidth); 
        //more mapping. this time with width for what the radius of 
        //the circle will be

        float radius = widthMap/2;
        //divide the widthmap by two so it's an equal circle raduis

        float angle = TWO_PI/circleResolution;
        //we are going to be moving around the cicle by an angle 
        
        noFill(); 
        strokeWeight(1);
        stroke(255, 25);
    
        beginShape();
        for (int i=0; i<=circleResolution; i++){
          float x = 0 + cos(angle*i) * radius;
          float y = 0 + sin(angle*i) * radius;
          vertex(x, y);
        }
        endShape();
        
        popMatrix();
      }
}









