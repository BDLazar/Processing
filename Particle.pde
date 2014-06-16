class Particle
{
   
   float x,y;
   float xSpeed,ySpeed;
   float gravity;
   float bounce;
 
   Particle(float inX, float inY)
   {
 
     x = inX;
     y = inY;
   
     gravity = 1;
     bounce = -0.18;
    
    //Positions released  
    xSpeed = random(-10,10);
    ySpeed = random(-15,15);
  
   }
  
   void update()
   {
 
       ySpeed += gravity;
    
       x += xSpeed;
       y += ySpeed;
  
  
       //WIND effect 
      if(mouseButton == LEFT)
      {
         gravity = 1;
      }
   
      if( mouseButton == RIGHT && mouseX<50)
      {
         gravity = -1;
      }
  
      if(mouseButton == RIGHT && mouseX>100)
      {
         gravity = 5;
      }
    
      if((y >= height + 10)&&(ySpeed > 0))
      {
        ySpeed *= bounce;
   
      }
   }
  
   void rain()
   {
      fill(255);
      point(x,y);
 
   }
}
