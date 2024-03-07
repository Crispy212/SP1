//In this tap i want to increase and decrase the size of our pixels with a buttonpress i also want to change the color with buttonpresses

void keyPressed() {
  if (key == 'a' || key == 'A') {
    green += 5;
    println("Color gren incresed to: " + green);
  } else if (key == 'd' || key == 'D') {
    green -= 5;
    println("Color green deincresed to: " + green);
  }
  else if (key == 'w' || key == 'W') {
    blue += 5;
    println("Color blue incresed to: " + blue);
  }
  else if (key == 's' || key == 'S') {
    blue -= 5;
    println("Color blue deincresed to: " + blue);
  }
}
