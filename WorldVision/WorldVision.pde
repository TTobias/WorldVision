public final String version = "WV-0.1";

//Called once when the program starts
public void setup(){
  size(1600,900);
}

//Called every frame
public void draw(){
  background(ColorCode.background);
  mouse();
  
  if(project == null){
    startup.draw();
  }else{
    project.draw();
  }
}



//Called when using the MouseWheel
public void mouseWheel(MouseEvent ev){
  float e = ev.getCount();
  if(e < 0){
    if(project == null){
      startup.onScrollDown();
    }else{
      project.onScrollDown();
    }
  }
  else if (e > 0){
    if(project == null){
      startup.onScrollUp();
    }else{
      project.onScrollUp();
    }
  }
}



//Called when a key is pressed or released
public void keyPressed(){
  if(project == null){
    startup.onKeyDown();
  }else{
    project.onKeyDown();
  }
}
public void keyReleased(){
  if(project == null){
    startup.onKeyUp();
  }else{
    project.onKeyUp();
  }
}

//Called every frame by draw(), checks for mouse Input
public static boolean pmouse = false;
public void mouse(){
  //OnMouseDown: any
  if(!pmouse && mousePressed){
    if(project == null){
      startup.onClick();
    }else{
      project.onClick();
    }
  }
  
  //OnMouse: any
  if(pmouse && mousePressed){
    if(project == null){
      startup.onDrag();
    }else{
      project.onDrag();
    }
  }
  
  //OnMouseUp: any
  if(pmouse && !mousePressed){
    if(project == null){
      startup.onRelease();
    }else{
      project.onRelease();
    }
  }
  
  pmouse = mousePressed;
}




public String selectionPath = "";
public String waitForInput(String msg){
  selectionPath = "";
  println("Waiting for Input");
  selectInput(msg, "fileSelected");
  while(selectionPath != null && selectionPath.equals("")){ print(""); }
  println("Input Selection finished");
  return selectionPath;
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectionPath = null;
  } else {
    println("User selected " + selection.getAbsolutePath());
    selectionPath = selection.getAbsolutePath();
  }
}

public String convertPath(String p){ //needed because the file input backslashes "\" have to be replaced by normal slashes "/" for processing being able to read it
  String[] p2 = split(p,"\\");
  String p3 = "";
  p3 += p2[0];
  for(int i = 1; i<p2.length; i++){
    p3 += "/"+p2[i];
  }
  return p3;
}

public String getFileFormat(String p){
  String[] p2 = split(p,".");
  return p2[p2.length-1];
}






//Simple Vector2 Class
public class Vector2{
  public float x,y;
  
  public Vector2(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void Add(Vector2 a){
    x += a.x;
    y += a.y;
  }
  
  public float distanceTo(Vector2 a){
    return new Vector2(x-a.x,y-a.y).getLength();
  }
  
  public float getLength(){
    return sqrt(x*x + y*y);
  }
}


//Quickly accesible Colors
public static class ColorCode{
  public static color background = #444444;
  public static color guiBackground = #d4da9f;
  public static color guiTextBackground = #afafaf;
  public static color guiBorder = #161616;
  public static color guiText = #323232;
  public static color guiHighlight = #eeff53;
  public static color guiTriggered = #d67c2e;
  public static color guiInactive = #4b4b4b;
  public static color guiEnabled = #4eff4b;
  public static color guiDisabled = #ff461a;
  
  public static color black = #111111;
  public static color grey = #7b7b7b;
  public static color white = #f3f3f3;
  public static color red = #ff0000;
  public static color blue = #0000ff;
  public static color green = #00ff00;
  public static color yellow = #fff600;
  public static color orange = #ff8500;
  public static color purple = #d000ff;
  public static color cyan = #00ffb2;
}
