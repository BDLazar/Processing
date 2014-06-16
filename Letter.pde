// A class to describe a single Letter
class Letter 
{
  char letter;
  
  // Object " home " location
  float homex,homey;
  
  // Object current location
  float x,y;
  
  Letter(float x_, float y_, char letter_)
  {
    homex = x = x_;
    homey = y = y_;
    letter = letter_;
  }
  
  // Display the letter
  void display() 
  {
    fill(255);
    textAlign(LEFT);
    text(letter,x,y);
  }
  
  // Move the letter randomly
  void shake() 
  {
    x += random(-2,2);
    y += random(-2,2);
  }
  
  // The current location can be set back to the home location 
  void home() 
  { 
    x = homex;
    y = homey;
  }
}
