Target t;


void settings() 
{ 
  size(displayWidth/2, displayHeight/2);
}

void setup()
{
  frameRate(-1);
  t = new Target();
}

void draw()
{
  background(204, 204, 204);
  t.display();
}

void mousePressed()
{
  t.hitTargetCheck();
}
