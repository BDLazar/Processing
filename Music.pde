import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;
AudioPlayer sound; //variable name

PFont f;
float theta;
Circle c;
int x=0; //counter
int up=1; // arm up or down
String message = "Music is the strongest form of magic";
int walk = 0;//which leg steps
int x1 = 0;//main body motion
int stepl = 0;//left leg step
int stepr = 0;//right leg step 
boolean move = false;

//Array of particles
ArrayList<Particle> particles = new ArrayList<Particle>();

// An array of Letter objects
Letter[] letters;

// One array of Shapes
ArrayList<Shape> shapes = new ArrayList<Shape>();


void setup() 
{
  size(640, 360);
  noFill();
  smooth();
  cursor(CROSS);
  frameRate(50);
  
  
  f = createFont("Arial", 20, true);
  textFont(f);
  
  // Create the array the same size as the String
  letters = new Letter[message.length()];
  
  // Initialize Letters at the correct x location
  int x = 50;
  for (int i = 0; i < message.length(); i ++ ) 
  {
    // Letter objects are initialized with their location within the String as well as what character they should display.
    letters[i] = new Letter(x,25,message.charAt(i)); 
    x += textWidth(message.charAt(i));
  }
  
  //circle
  int r = int(random(10));
  for (int i = 0; i < r; i++ )
  {   
    int rad = int(random(50));  
    shapes.add(new Circle(100,100,rad,color(random(255),100)));    
  }
   c = new Circle(125,125,20,color(175));
  
  minim = new Minim(this);
  sound = minim.loadFile("Andre Rieu - My Way.mp3");
  sound.loop();
}

void draw() 
{
  background(0);
  
   //Rain 
  for (int k = 2; k < 40; k++)
  {
     particles.add(new Particle(350,-500));
     if(keyPressed == true)
     {
         k = k +5;
     }
  }
  for (int i = 2; i < particles.size(); i++)
  {
     Particle p = (Particle)particles.get(i);
     p.update();
     p.rain();
    if(keyPressed == true)
    {
        i = i +5;
     }
 }
  
  stroke(255);//stick man is white
  ellipse(200+x1,200,40,40);//head
  line(200+x1,220,200+x1,280);//body
  line(200+x1,250,160+x1,220);//left arm
  line(200+x1,250,240+x1,220);//right arm
  
  if (walk == 0)//which leg is moving
  {
    stepl = stepl + 2;//left,go faster
  } else {
    stepr = stepr + 2;//right,go faster
  }
  
  line(200+x1,280,180+stepl,340);//move left
  line(200+x1,280,200+stepr,340);//move right
  
  if (abs(stepl - stepr) >= 15)//calculates the absolute value (magnitude) 
  {
    walk = 1 - walk;//yes,switch legs
  }
  x1 = x1 + 1;//move rest of body

  for (int i = 0; i < letters.length; i ++ ) 
  {
    
    // Display all letters
    letters[i].display();
    
    // If the mouse is pressed the letters shake
    // If not, they return to their original location
    if (mousePressed) {
      letters[i].shake();
    } else {
      letters[i].home();
    }
  }
  // Jiggle and display the shape
  for (int i = 0; i < shapes.size(); i++ ) 
  {
   shapes.get(i).jiggle();
   shapes.get(i).display();
  }
  c.jiggle();
  c.display();
  stroke(255);//outline

  
  //Pick an angle 0 to 90 degrees based on the mouse position
  float a = (mouseX / (float) width) * 90f;
  
  // Convert it to radians
  theta = radians(a);
  
  // Start the tree from the bottom of the screen
  translate(width/2,height);
  
  // Draw a line 120 pixels
  line(0,0,0,-120);
  
  // Move to the end of that line
  translate(0,-120);
  
  // Start the recursive branching
  branch(120);
  
  // draw stick person
  ellipse(100,40,40,40);
  rectMode(CENTER);
  rect(100,80,40,40);
  line(110,100,120,140);
  line(90,100,80,140);
  line(80,80,60,100);
   
  // counter moves ahead 
  x=x+1;
   
  if (x==20) {
    // reset counter
    x=0;
    // change direction of arm
    up=up*-1;
  }
  if (up==1) {
    // arm up
    line(120,80,140,60);
  } else {
    // arm down
    line(120,80,140,100);
  }  
}

void lightning()
{
   int st=round(random(700));
   int end=350;
   int y = 0;
   int y2 = 40;
 
   while ( y2 < 500)
   {
     end = (st-40) + round(random(80));
     stroke (255);
     line ( st, y, end, y2);
     y = y2;
     y2 += round(random(80));
     st = end;
  
     end = (st-40) + round(random(80));
     stroke (255);
     line ( st, y, end, y2);
     y = y2;
     y2 += round(random(80));
     st = end;
  }
}
 
void mouseClicked() 
{
   lightning();
}
 
void mousePressed()
{
  rect(0,0,700,400);
  fill(255,70);
  frameRate(30);
  loop();
}
  
void mouseMoved()
{
   move = true;
}

void branch(float h) 
{
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;
  
  // When the length of the branch is 2 pixels or less,all recursive functions have an exit condition
  if (h > 2) 
  {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       //Call myself to draw two new branches
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
 
}


