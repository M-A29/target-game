class Target
{
  float xPos;
  float yPos;
  float diameter;
  color colour;
  color hoverColour;
  float xSpeed;
  float ySpeed;
  int speedFactor;
  int lastTimeStamp;
  int lastReactionTime;

  Target()
  {
    diameter = random(50, 300);
    xPos = width/2;
    yPos = height/2;
    colour = color(255, 165, 0); // Orange
    hoverColour = color(240, 200, 120); // Light orange
    xSpeed = 0;  
    ySpeed = 0;      
    speedFactor = 1;
    lastTimeStamp = millis();
    lastReactionTime = 1;
  }

  void display() // runs 60times pser sec
  {
    moveTarget();
    
    drawText();
    
    drawTarget();
  }
  
  void moveTarget()
  {
    if (xPos - diameter/2 + xSpeed < 0) // target edge will go beyond left border in next tick
    {
      xPos = diameter/2; // make the target touch the edge on this tick
      xSpeed = xSpeed * -1;
    }
    else if (xPos + diameter/2 + xSpeed > width)
    {
      xPos = width - diameter/2; 
      xSpeed = xSpeed * -1;
    }
    else
    {
      xPos = xPos + xSpeed;
    }
   
    if (yPos - diameter/2 + ySpeed < 0) // target edge will go beyond left border in next tick
    {
      yPos = diameter/2; // make the target touch the edge on this tick
      ySpeed = ySpeed * -1;
    }
    else if (yPos + diameter/2 + ySpeed > height)
    {
      yPos = height - diameter/2; 
      ySpeed = ySpeed * -1;
    }
    else
    {
      yPos = yPos + ySpeed;
    }
  }
  
  void drawTarget()
  {    
    fill(getTargetColor());
    noStroke();
    circle(xPos, yPos, diameter);
  }
  
  void drawText()
  {
    fill(0,0,0);
    textAlign(BOTTOM, LEFT);
    text(nf(frameRate, 0, 1) + " FPS;  " + nf((xSpeed + ySpeed)/2) + " PPS;  " + nf(speedFactor) + " SF", 0, height);
  }

  color getTargetColor()
  {
    if (mouseInTarget())
    {
      return hoverColour;
    }
    else
    {
      return colour;
    }
    
  }

  boolean mouseInTarget()
  {
    return (dist(mouseX, mouseY, xPos, yPos) < diameter/2);
  }
  
  void hitTargetCheck()
  {
    if (mouseInTarget())
    {
      diameter = random(50, 200);
      xPos = random(diameter/2, width - diameter/2);
      yPos = random(diameter/2, height - diameter/2);
      
      
      if (millis() - lastTimeStamp < lastReactionTime) // check if reaction time was quicker than last time
      {
        speedFactor = speedFactor + 1;
      }
      else if (speedFactor != 1)
      {
        speedFactor = speedFactor - 1;
      }
      lastReactionTime = millis() - lastTimeStamp; // reset values
      lastTimeStamp = millis();
      
      xSpeed = random(-5 * speedFactor, 5 * speedFactor);  
      ySpeed = random(-5 * speedFactor, 5 * speedFactor);      
    }
  }
}
