//Class containing all GuiElements assigned to it. Is contained in every Scene
public class GUI{
  public ArrayList<GuiElement> list = new ArrayList<GuiElement>();
  
  public void addGui(GuiElement g){ 
    g.connectedGui = this;
    list.add(g); 
  }
  //public Vector2 expanse;
  
  //Redirects all InputCalls etc to the specific GuiElements
  public void show(){         for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).show();           } }}
  public void onClick(){      for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onClick();        } }}
  public void onRelease(){    for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onRelease();      } }}
  public void onHover(){      for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onHover();        } }}
  public void onDrag(){       for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onDrag();         } }}
  public void onKeyDown(){    for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onKeyDown();      } }}
  public void onKeyUp(){}{    for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onKeyUp();        } }}
  public void onKey(){        for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onKey();          } }}
  public void onScrollUp(){   for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onScrollUp();     } }}
  public void onScrollDown(){ for(int i = 0; i<list.size() ;i++){ if(list.get(i).enabled){ list.get(i).onScrollDown();   } }}
}




//All GuiElements Types used:

//Base class
public class GuiElement{
  public boolean enabled = false;
  public Vector2 position;
  
  public GUI connectedGui;
  
  public GuiElement(Vector2 pos, boolean e){
    position = pos; 
    enabled = e;
    connectedGui = null;
  }
  
  public GuiElement(){
    position = new Vector2(0,0);
    enabled = true;
    connectedGui = null;
  }  
  
  public void show(){}
  
  public void onClick(){}
  public void onRelease(){}
  public void onHover(){}
  public void onDrag(){}
  public void onKeyDown(){}
  public void onKeyUp(){}
  public void onKey(){}
  public void onScrollUp(){}
  public void onScrollDown(){}
  
  public void delete(){
    //Try avoiding this for a better runtime
    for(int i = 0; i<connectedGui.list.size() ;i++){
      if(connectedGui.list.get(i) == this){
        connectedGui.list.remove(i);
        break;
      }
    }
  }
  
  public void disable(){ enabled = false; }
  public void enable(){ enabled = true; }
}




//Panel / Canvas
public class GuiPanel extends GuiElement{
  public Vector2 expanse;
  public color tint;
  
  public GuiPanel(Vector2 pos, Vector2 exp, color t, boolean e){
    super(pos, e);
    expanse = exp;
    tint = t;
  }
  
  public void show(){
    fill(tint);
    rect(position.x, position.y, expanse.x, expanse.y);
  }
}

//Button
public class GuiButton extends GuiElement{
  public Vector2 expanse;
  public boolean active;
  public String text;
  public float textSize;
  public color normalTint;
  public color inactiveTint;
  public color hoverTint;
  public color triggerTint;
  
  public boolean triggered;
  public boolean hovering;
  
  //(position, expanse, text, active, enabled)
  public GuiButton(Vector2 pos, Vector2 exp, String txt, boolean a, boolean e){
    super(pos, e);
    expanse = exp;
    normalTint = ColorCode.guiBackground;
    inactiveTint = ColorCode.guiInactive;
    hoverTint = ColorCode.guiHighlight;
    triggerTint = ColorCode.guiTriggered;
    active = a;
    text = txt;
    
    //println(text, (float)expanse.x / (float)text.length(), expanse.x, text.length());
    textSize = expanse.y-2 > (expanse.x / (float)text.length())*1.5? (expanse.x / (float)text.length())*1.8 : expanse.y-2;
  }
  
  public void show(){
    if(!active){
      fill(inactiveTint);
    }else if(triggered){
      fill(triggerTint);
    }else if(hovering){
      fill(hoverTint);
    }else{
      fill(normalTint);
    }
    stroke(ColorCode.guiBorder);
    stroke(0);
    rect(position.x, position.y, expanse.x, expanse.y);
    
    fill(ColorCode.guiText);
    textSize(textSize);
    //text(text,position.x+1, position.y-4+expanse.y);
    text(text,position.x+1, position.y+0.5*expanse.y+textSize*0.3);
  }
  
  public void onClick(){
    if(hovering){
      triggered = true;
      //needRedraw = true;
    }
  }
  
  public void onHover(){
    hovering = mouseX > position.x && mouseY > position.y && mouseX < position.x+expanse.x && mouseY < position.y+expanse.y;
  }
  
  public boolean getTrigger(){
    if(triggered){
      triggered = false;
      return true;
    }
    return false;
  }
}

//Layer
public class GuiLayer extends GuiElement{
  public ArrayList<GuiElement> elements;
  public String name;
  
  public GuiLayer(GuiElement[] e, String n){
    elements = new ArrayList<GuiElement>();
    for(int i = 0; i<e.length; i++){
      elements.add(e[i]);
      e[i].delete();
    }
    name = n;
  }
  
  public GuiLayer(String n){
    elements = new ArrayList<GuiElement>();
    name = n;
  }
  
  public void addToLayer(GuiElement e){
    elements.add(e);
    e.delete();
  }
  
  public void addToLayer(GuiElement[] e){
    for(int i = 0; i<e.length; i++){
      elements.add(e[i]);
      e[i].delete();
    }
  }
  
  public void show(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).show();
    }
  }
  
  public void onClick(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).onClick();
    }
  }
  public void onRelease(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).onRelease();
    }
  }
  public void onHover(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).onHover();
    }
  }
  public void onDrag(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).onDrag();
    }
  }
  public void onKeyDown(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).onKeyDown();
    }
  }
  public void onKeyUp(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).onKeyUp();
    }
  }
  public void onKey(){
    for(int i = 0; i<elements.size(); i++){
      elements.get(i).onKey();
    }
  }
}

//LayerSwitch
public class GuiLayerSwitch extends GuiElement{
  public ArrayList<GuiLayer> layer;
  public int activeLayer = 0;
  public Vector2 expanse;
  
  public boolean hoverLeft = false;
  public boolean hoverRight = false;
  
  public GuiLayerSwitch(Vector2 p, Vector2 exp, GuiLayer[] l, int start, boolean e){
    super(p,e);
    layer = new ArrayList<GuiLayer>();
    for(int i = 0; i<l.length;i++){
      layer.add(l[i]);
      l[i].delete();
    }
    activeLayer = start;
    expanse = exp;
  }
  
  public GuiLayerSwitch(Vector2 p, Vector2 exp, int start, boolean e){
    super(p,e);
    layer = new ArrayList<GuiLayer>();
    activeLayer = start;
    expanse = exp;
  }
  
  public void addLayer(GuiLayer g){
    layer.add(g);
    g.delete();
  }
  
  public void show(){
    //LeftButton
    stroke(ColorCode.guiBorder);
    if(hoverLeft){
      fill(ColorCode.guiHighlight);
    }else{
      fill(ColorCode.guiBackground);
    }
    rect(position.x, position.y, expanse.x*0.15, expanse.y);
    fill(ColorCode.guiText);
    textSize(expanse.y);
    text("<",position.x+expanse.x*0.03, position.y+expanse.y-4);
    
    //RightButton
    stroke(ColorCode.guiBorder);
    if(hoverRight){
      fill(ColorCode.guiHighlight);
    }else{
      fill(ColorCode.guiBackground);
    }
    rect(position.x + expanse.x - expanse.x*0.15, position.y, expanse.x*0.15, expanse.y);
    fill(ColorCode.guiText);
    textSize(expanse.y);
    text(">",position.x + expanse.x - expanse.x*0.15 +expanse.x*0.03, position.y+expanse.y-4);
    
    //TextField
    fill(ColorCode.guiTextBackground);
    rect(position.x + expanse.x*0.18, position.y, expanse.x*0.64, expanse.y);
    fill(ColorCode.guiText);
    textSize(expanse.y-5);
    if(layer != null && activeLayer < layer.size() && activeLayer >= 0 && layer.get(activeLayer) != null){
      text(layer.get(activeLayer).name,position.x + expanse.x*0.2 +2, position.y+expanse.y-4);
    }else{
      text("NONE",position.x + expanse.x*0.2, position.y+expanse.y-4);
    }  
    textSize(expanse.y*0.5);
    text(str(activeLayer),position.x +expanse.x - expanse.x*0.18 - expanse.x*0.07, position.y+expanse.y-1);
    
    //Child Layer Call
    if(layer != null && activeLayer < layer.size() && activeLayer >= 0){
      layer.get(activeLayer).show();
    }
  }
  
  public void deleteLayer(GuiLayer l){
    for(int i = 0;i<layer.size();i++){
      if(layer.get(i) == l){
        layer.get(i).delete();
        layer.remove(i);
        break;
      }
    }
  }
  
  public void onClick(){
    if(hoverLeft){
      activeLayer--;
    }
    if(hoverRight){
      activeLayer++;
    }
    
    if(layer != null){
      if(activeLayer < 0){ activeLayer = layer.size() -1; }
      if(activeLayer >= layer.size()){ activeLayer = 0; }
    }
    
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onClick();
    }
  }
  
  public void onHover(){
    hoverLeft = mouseX > position.x && mouseY > position.y && mouseX < position.x+expanse.x*0.15 && mouseY < position.y+expanse.y;
    hoverRight = mouseX > position.x + expanse.x - expanse.x*0.15 && mouseY > position.y && mouseX < position.x + expanse.x - expanse.x*0.15 +expanse.x && mouseY < position.y+expanse.y;
    
    //Child Layer Call
    if(layer != null && activeLayer < layer.size() && activeLayer >= 0){
      layer.get(activeLayer).onHover();
    }
  }
  
  public void onRelease(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onRelease();
    }
  }
  
  public void onDrag(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onDrag();
    }
  }
  public void onKeyDown(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onKeyDown();
    }
  }
  public void onKeyUp(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onKeyUp();
    }
  }
  public void onKey(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onKey();
    }
  }
}

//Technical LayerSwitch
public class GuiTechnicalLayerSwitch extends GuiElement{
  public ArrayList<GuiLayer> layer;
  public int activeLayer = 0;
  
  public GuiTechnicalLayerSwitch(GuiLayer[] l, int start){
    super();
    layer = new ArrayList<GuiLayer>();
    for(int i = 0; i<l.length;i++){
      layer.add(l[i]);
      l[i].delete();
    }
    activeLayer = start;
  }
  
  public GuiTechnicalLayerSwitch(int start){
    super();
    layer = new ArrayList<GuiLayer>();
    activeLayer = start;
  }
  
  public void addLayer(GuiLayer g){
    layer.add(g);
    g.delete();
  }
  
  public void show(){
    //Child Layer Call
    if(layer != null && activeLayer < layer.size() && activeLayer >= 0){
      layer.get(activeLayer).show();
    }
  }
  
  public void deleteLayer(GuiLayer l){
    for(int i = 0;i<layer.size();i++){
      if(layer.get(i) == l){
        layer.get(i).delete();
        layer.remove(i);
        break;
      }
    }
  }
  
  public void onClick(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onClick();
    }
  }
  
  public void onHover(){
    //Child Layer Call
    if(layer != null && activeLayer < layer.size() && activeLayer >= 0){
      layer.get(activeLayer).onHover();
    }
  }
  
  public void onRelease(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onRelease();
    }
  }
  
  public void onDrag(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onDrag();
    }
  }
  public void onKeyDown(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onKeyDown();
    }
  }
  public void onKeyUp(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onKeyUp();
    }
  }
  public void onKey(){
    //Child Layer Call
    if(layer != null && activeLayer >= 0 && activeLayer < layer.size()){
      layer.get(activeLayer).onKey();
    }
  }
}

//Checkbox
public class GuiCheckbox extends GuiElement{
  public Vector2 expanse;
  public String text;
  public color inactiveTint;
  public color activeTint;
  
  public boolean active;
  public boolean hovering;
  
  public GuiCheckbox(Vector2 pos, Vector2 exp, String txt, boolean a, boolean e){
    super(pos, e);
    expanse = exp;
    inactiveTint = ColorCode.guiDisabled;
    activeTint = ColorCode.guiEnabled;
    active = a;
    text = txt;
  }
  
  public GuiCheckbox(Vector2 pos, Vector2 exp, String txt, boolean a, boolean e, color c){
    super(pos, e);
    expanse = exp;
    inactiveTint = ColorCode.guiDisabled;
    activeTint = c;
    active = a;
    text = txt;
  }
  
  public void show(){
    if(active){
      fill(activeTint);
    }else{
      fill(inactiveTint);
    }
    stroke(ColorCode.guiBorder);
    rect(position.x, position.y, expanse.x, expanse.y);
    
    fill(ColorCode.guiText);
    textSize(expanse.y-2);
    text(text,position.x+1, position.y-4+expanse.y);
  }
  
  public void onClick(){
    if(hovering){
      active = !active;
      //needRedraw = true;
    }
  }
  
  public void onHover(){
    hovering = mouseX > position.x && mouseY > position.y && mouseX < position.x+expanse.x && mouseY < position.y+expanse.y;
  }
}

//Multicheckbox
public class GuiMulticheckbox extends GuiElement{
  public Vector2 expanse;
  public String mainText;
  public ArrayList<String> text;
  public color inactiveTint;
  public color activeTint;
  
  public int active;
  public int hovering;
  
  public GuiMulticheckbox(Vector2 p, Vector2 exp, String mt, int a, boolean e){
    super(p,e);
    expanse = exp;
    mainText = mt;
    inactiveTint = ColorCode.guiDisabled;
    activeTint = ColorCode.guiEnabled;
    
    active = a;
    hovering = -1;
    
    text = new ArrayList<String>();
  }
  
  public void addOption(String t){
    text.add(t);
  }
  
  public void addOptions(String[] t){
    for(int i = 0; i<t.length;i++){
      text.add(t[i]);
    }
  }
  
  public void show(){
    fill(ColorCode.guiTextBackground);
    stroke(ColorCode.guiBorder);
    rect(position.x, position.y, expanse.x, expanse.y);
    fill(ColorCode.guiText);
    textSize(expanse.y-2);
    text(mainText, position.x+2, position.y+expanse.y-4);
    
    for(int i = 0; i<text.size(); i++){
      if(i == active){
        fill(activeTint);
      }else{
        fill(inactiveTint);
      }
      stroke(ColorCode.guiBorder);
      rect(position.x+expanse.x*0.1, position.y+expanse.y+expanse.y*0.8*(i), expanse.x*0.7, expanse.y*0.8);
      fill(ColorCode.guiText);
      textSize(expanse.y*0.8-2);
      text(text.get(i), position.x+expanse.x*0.1+2, position.y+expanse.y+expanse.y*0.8*(i)+expanse.y-8);
    }
  }
  
  public void onClick(){
    if(hovering != active && hovering >= 0){ active = hovering; }
  }
  
  public void onHover(){
    boolean tmp = mouseX > position.x+expanse.x*0.1 && mouseY > position.y+expanse.y && mouseX < position.x+expanse.x*0.1+expanse.x*0.7 && mouseY < position.y+expanse.y+expanse.y*0.8*text.size();
    if(tmp){
      //println(  mouseY, position.y+expanse.y, (mouseY - (position.y+expanse.y )) , expanse.y*0.8 );
      hovering = int( floor( (mouseY - (position.y+expanse.y )) / (expanse.y*0.8) ) );
    }else{
      hovering = -1;
    }
  }
}

//ColorField
public class GuiColor extends GuiElement{
  public Vector2 expanse;
  public color tint;
  
  public GuiColor(Vector2 p, Vector2 exp, color c, boolean e){
    super(p, e);
    expanse = exp;
    tint = c;
  }
  
  public void show(){
    fill(tint);
    stroke(ColorCode.guiBorder);
    rect(position.x, position.y, expanse.x, expanse.y);
  }
}

//Text
public class GuiText extends GuiElement{
  public Vector2 expanse;
  public String text;
  
  public GuiText(Vector2 pos, Vector2 exp, String txt, boolean e){
    super(pos, e);
    expanse = exp;
    text = txt;
  }
  
  public void show(){
    fill(ColorCode.white);
    stroke(ColorCode.guiBorder);
    rect(position.x, position.y, expanse.x, expanse.y);
    
    fill(ColorCode.guiText);
    textSize(expanse.y-2);
    text(text,position.x+1, position.y-4+expanse.y);
  }
}

//TextInput
public class GuiTextInput extends GuiElement{
  public Vector2 expanse;
  public String text;
  public String tmpText;
  
  public boolean active;
  public boolean hovering;
  
  public GuiTextInput(Vector2 pos, Vector2 exp, String t, boolean e){
    super(pos, e);
    expanse = exp;
    text = t;
    tmpText = "";
    active = false;
  }
  
  public void show(){
    if(active){
      fill(ColorCode.guiTriggered);
    }else{
      fill(ColorCode.guiTextBackground);
    }
    stroke(ColorCode.guiBorder);
    rect(position.x, position.y, expanse.x, expanse.y);
    
    fill(ColorCode.guiText);
    textSize(expanse.y-2);
    if(active){
      text(tmpText,position.x+1, position.y-4+expanse.y);
    }else{
      text(text,position.x+1, position.y-4+expanse.y);
    }
  }
  
  public void onClick(){
    if(active){
      if(hovering){
        tmpText = text;
      }else{
        active = false;
        tmpText = "";
      }
    }else{
      if(hovering){ active = true; }
    }
  }
  
  public void onHover(){
    if(active){
      hovering = mouseX > position.x && mouseY > position.y && mouseX < position.x+expanse.x && mouseY < position.y+expanse.y;
    }else{
      hovering = mouseX > position.x && mouseY > position.y && mouseX < position.x+expanse.x && mouseY < position.y+expanse.y;
    }
  }
  
  public void onKeyDown(){
    if(active){
      if(key != CODED && key != BACKSPACE){
        tmpText += key;
      }
      if(key == ENTER){
        updateText();
      }
      if(key == BACKSPACE){
        if(tmpText.length() > 0)
        tmpText = new String(shorten(tmpText.toCharArray()));
      }
    }
  }
  
  public void updateText(){
    active = false;
    text = trim(tmpText);
    tmpText = "";
  }
}


//NamedTextInput
public class GuiNamedTextInput extends GuiElement{
  public Vector2 expanse;
  public String name;
  public color nameColor;
  
  public String text;
  public String tmpText;
  
  public boolean active;
  public boolean hovering;
  
  public GuiNamedTextInput(Vector2 pos, Vector2 exp, String n, String t, boolean e){
    super(pos, e);
    expanse = exp;
    text = t;
    tmpText = "";
    active = false;
    name = n;
    nameColor = ColorCode.guiText;
  }
  
  public GuiNamedTextInput(Vector2 pos, Vector2 exp, String n, color nc, String t, boolean e){
    super(pos, e);
    expanse = exp;
    text = t;
    tmpText = "";
    active = false;
    name = n;
    nameColor = nc;
  }
  
  public void show(){
    if(active){
      fill(ColorCode.guiTriggered);
    }else{
      fill(ColorCode.guiTextBackground);
    }
    stroke(ColorCode.guiBorder);
    rect(position.x+expanse.x*0.4, position.y, expanse.x*0.6, expanse.y);
    
    fill(ColorCode.guiText);
    textSize(expanse.y-2);
    if(active){
      text(tmpText,position.x+1+expanse.x*0.4, position.y-4+expanse.y);
    }else{
      text(text,position.x+1+expanse.x*0.4, position.y-4+expanse.y);
    }
    
    fill(nameColor);
    textSize(expanse.y-2);
    text(name,position.x+1, position.y-4+expanse.y);
  }
  
  public void onClick(){
    if(active){
      if(hovering){
        tmpText = text;
      }else{
        active = false;
        tmpText = "";
      }
    }else{
      if(hovering){ active = true; }
    }
  }
  
  public void onHover(){
    if(active){
      hovering = mouseX > position.x+expanse.x*0.4 && mouseY > position.y && mouseX < position.x+expanse.x && mouseY < position.y+expanse.y;
    }else{
      hovering = mouseX > position.x+expanse.x*0.4 && mouseY > position.y && mouseX < position.x+expanse.x && mouseY < position.y+expanse.y;
    }
  }
  
  public void onKeyDown(){
    if(active){
      if(key != CODED && key != BACKSPACE){
        tmpText += key;
      }
      if(key == ENTER){
        updateText();
      }
      if(key == BACKSPACE){
        tmpText = new String(shorten(tmpText.toCharArray()));
      }
    }
  }
  
  public void updateText(){
    active = false;
    text = trim(tmpText);
    tmpText = "";
  }
}

//Vector2Inspector
public class GuiVector2 extends GuiElement{
  public Vector2 expanse;
  public String text;
  public Vector2 v2;
  String tmpX;
  String tmpY;
  
  public boolean activeX;
  public boolean hoveringX;
  public boolean activeY;
  public boolean hoveringY;
  
  public GuiVector2(Vector2 pos, Vector2 exp, String t, Vector2 v, boolean e){
    super(pos, e);
    expanse = exp;
    text = t;
    v2 = v;
    tmpX = "";
    tmpY = "";
    
    activeX = false;
    activeY = false;
    hoveringX = false;
    hoveringY = false;
  }
  
  public void show(){
    //Text
    fill(ColorCode.guiTextBackground);
    stroke(ColorCode.guiBorder);
    rect(position.x, position.y, expanse.x*0.38, expanse.y);
    fill(ColorCode.guiText);
    textSize(expanse.y-3);
    text(text,position.x+1, position.y+expanse.y-4);
    
    //X
    if(activeX){
      fill(ColorCode.guiTriggered);
    }else{
      fill(ColorCode.guiTextBackground);
    }
    stroke(ColorCode.guiBorder);
    rect(position.x+expanse.x*0.4, position.y, expanse.x*0.29, expanse.y);
    
    fill(ColorCode.guiText);
    textSize(expanse.y-2);
    if(activeX){
      text(tmpX,position.x+1+expanse.x*0.4, position.y-4+expanse.y);
    }else{
      text(str(v2.x),position.x+1+expanse.x*0.4, position.y-4+expanse.y);
    }
    
    //Y
    if(activeY){
      fill(ColorCode.guiTriggered);
    }else{
      fill(ColorCode.guiTextBackground);
    }
    stroke(ColorCode.guiBorder);
    rect(position.x+expanse.x*0.71, position.y, expanse.x*0.29, expanse.y);
    
    fill(ColorCode.guiText);
    textSize(expanse.y-2);
    if(activeY){
      text(tmpY,position.x+1+expanse.x*0.71, position.y-4+expanse.y);
    }else{
      text(str(v2.y),position.x+1+expanse.x*0.71, position.y-4+expanse.y);
    }
  }
  
  public void onClick(){
    //X
    if(activeX){
      if(hoveringX){
        tmpX = str(v2.x);
      }else{
        activeX = false;
        tmpX = "";
      }
    }else{
      if(hoveringX){ activeX = true; }
    }
    
    //Y
    if(activeY){
      if(hoveringY){
        tmpY = str(v2.y);
      }else{
        activeY = false;
        tmpY = "";
      }
    }else{
      if(hoveringY){ activeY = true; }
    }
  }
  
  public void onHover(){
    hoveringX = mouseX > position.x+expanse.x*0.4 && mouseY > position.y && mouseX < position.x+expanse.x*0.69 && mouseY < position.y+expanse.y;
    hoveringY = mouseX > position.x+expanse.x*0.71 && mouseY > position.y && mouseX < position.x+expanse.x && mouseY < position.y+expanse.y;
  }
  
  public void onKeyDown(){
    //X
    if(activeX){
      if(key != CODED && key != BACKSPACE && keyIsNumber()){
        tmpX += key;
      }
      if(key == ENTER){
        updateX();
      }
      if(key == TAB){
        updateX();
        activeY = true;
      }
      if(key == BACKSPACE){
        tmpX = new String(shorten(tmpX.toCharArray()));
      }
    }
    
    //Y
    if(activeY){
      if(key != CODED && key != BACKSPACE && keyIsNumber()){
        tmpY += key;
      }
      if(key == ENTER){
        updateY();
      }
      if(key == BACKSPACE){
        tmpY = new String(shorten(tmpY.toCharArray()));
      }
    }
  }
  
  boolean keyIsNumber(){ return (key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '-'); }
  
  public void updateX(){
    activeX = false;
    if(tmpX.toCharArray().length > 0){
      v2.x = float(trim(tmpX));
    }
    tmpX = "";
  }
  
  public void updateY(){
    activeY = false;
    if(tmpY.toCharArray().length > 0){
      v2.y = float(trim(tmpY));
    }
    tmpY = "";
  }
}


//ColorSelection
public class GuiColorSelection extends GuiElement{
  public Vector2 expanse;
  public color tint;
  
  public boolean activeR;
  public boolean hoveringR;
  
  public boolean activeG;
  public boolean hoveringG;
  
  public boolean activeB;
  public boolean hoveringB;
  
  public float tmpC;
  
  public GuiColorSelection(Vector2 p, Vector2 exp, color c, boolean e){
    super(p, e);
    expanse = exp;
    tint = c;
    
    activeR = false;
    hoveringR = false;
    activeG = false;
    hoveringG = false;
    activeB = false;
    hoveringB = false;
    
    tmpC = 0;
  }
  
  public void show(){
    //preview
    if(activeR){
      fill(tmpC,green(tint),blue(tint));
    }else if(activeG){
      fill(red(tint),tmpC,blue(tint));
    }else if(activeB){
      fill(red(tint),green(tint),tmpC);
    }else{
      fill(tint);
    }
    stroke(ColorCode.guiBorder);
    rect(position.x, position.y, expanse.x*0.5, expanse.y);
      
    //red
    if(activeR){
      fill(255);
      stroke(ColorCode.guiBorder);
      rect(position.x+expanse.x*0.56, position.y+expanse.y, expanse.x*0.14, -257);
      strokeWeight(2);
      for(int i = 0;i<255;i++){
        stroke(i,0,0);
        line(position.x+expanse.x*0.56+1,position.y+expanse.y-1-i,position.x+expanse.x*0.56+expanse.x*0.14-1,position.y+expanse.y-1-i);
      }
      calculateColorChange(position.x+expanse.x*0.56+1);
    }else{
      fill(red(tint),0,0);
      stroke(ColorCode.guiBorder);
      rect(position.x+expanse.x*0.56, position.y, expanse.x*0.14, expanse.y);
    }
    strokeWeight(1);
    
    //green
    if(activeG){
      fill(255);
      stroke(ColorCode.guiBorder);
      rect(position.x+expanse.x*0.71, position.y+expanse.y, expanse.x*0.14, -257);
      strokeWeight(2);
      for(int i = 0;i<255;i++){
        stroke(0,i,0);
        line(position.x+expanse.x*0.71+1,position.y+expanse.y-1-i,position.x+expanse.x*0.71+expanse.x*0.14-1,position.y+expanse.y-1-i);
      }
      calculateColorChange(position.x+expanse.x*0.71+1);
    }else{
      fill(0,green(tint),0);
      stroke(ColorCode.guiBorder);
      rect(position.x+expanse.x*0.71, position.y, expanse.x*0.14, expanse.y);
    }
    strokeWeight(1);
    
    //blue
    if(activeB){
      fill(255);
      stroke(ColorCode.guiBorder);
      rect(position.x+expanse.x*0.86, position.y+expanse.y, expanse.x*0.14, -257);
      strokeWeight(2);
      for(int i = 0;i<255;i++){
        stroke(0,0,i);
        line(position.x+expanse.x*0.86+1,position.y+expanse.y-1-i,position.x+expanse.x*0.86+expanse.x*0.14-1,position.y+expanse.y-1-i);
      }
      calculateColorChange(position.x+expanse.x*0.86+1);
    }else{
      fill(0,0,blue(tint));
      stroke(ColorCode.guiBorder);
      rect(position.x+expanse.x*0.86, position.y, expanse.x*0.14, expanse.y);
    }
    strokeWeight(1);
  }
  
  public void calculateColorChange(float posX){
    if(onChangeScale(posX)){
      tmpC = position.y+expanse.y - mouseY;
    }
    strokeWeight(2);
    stroke(255);
    line(posX,position.y+expanse.y-1-tmpC,posX+expanse.x*0.14-2,position.y+expanse.y-1-tmpC);
  }
  
  public boolean onChangeScale(float posX){
    return (mouseX > posX && mouseX < posX+expanse.x*0.14-2 && mouseY > position.y+expanse.y-256 && mouseY < position.y+expanse.y-1);
  }
  
  public void onClick(){
    if(hoveringR){
      activeR = true;
      tmpC = red(tint);
    }
    if(hoveringG){
      activeG = true;
      tmpC = green(tint);
    }
    if(hoveringB){
      activeB = true;
      tmpC = blue(tint);
    }
  }
  
  public void onRelease(){
    if(activeR){
      activeR = false;
      if(onChangeScale(position.x+expanse.x*0.56+1)){
        tint = color(tmpC,green(tint),blue(tint));
      }
    }
    if(activeG){
      activeG = false;
      if(onChangeScale(position.x+expanse.x*0.71+1)){
        tint = color(red(tint),tmpC,blue(tint));
      }
    }
    if(activeB){
      activeB = false;
      if(onChangeScale(position.x+expanse.x*0.86+1)){
        tint = color(red(tint),green(tint),tmpC);
      }
    }
  }
  
  public void onHover(){
    hoveringR = mouseX > position.x+expanse.x*0.56 && mouseY > position.y && mouseX < position.x+expanse.x*0.56+expanse.x*0.14 && mouseY < position.y+expanse.y;    
    hoveringG = mouseX > position.x+expanse.x*0.71 && mouseY > position.y && mouseX < position.x+expanse.x*0.71+expanse.x*0.14 && mouseY < position.y+expanse.y;    
    hoveringB = mouseX > position.x+expanse.x*0.86 && mouseY > position.y && mouseX < position.x+expanse.x*0.86+expanse.x*0.14 && mouseY < position.y+expanse.y;
  }
}

//Line
public class GuiLine extends GuiElement{
  public Vector2 expanse;
  public String text;
  
  public GuiLine(Vector2 pos, Vector2 exp, boolean e){
    super(pos, e);
    expanse = exp;
  }
  
  public void show(){
    stroke(ColorCode.black);
    line(position.x, position.y, expanse.x, expanse.y);
  }
}

//String Table
public class GuiStringTable extends GuiElement{
  public Vector2 expanse;
  public ArrayList<String> list;
  
  public int textLines; //amount of lines every text elements contains
  
  public int gridX; //amount of boxes in one line
  
  public int active;
  public int hovering;
  public boolean triggered = false;
  
  public GuiStringTable(Vector2 p, Vector2 exp, int x, int tl, boolean e){
    super(p,e);
    expanse = exp;
    
    gridX = x;
    textLines = tl;
    
    active = -1;
    hovering = -1;
    
    list = new ArrayList<String>();
  }
  
  public void addOption(String t){
    list.add(t);
  }
  
  public void addOptions(String[] t){
    for(int i = 0; i<t.length;i++){
      list.add(t[i]);
    }
  }
  
  public void clearOptions(){
    list = new ArrayList<String>();
  }
  
  
  public void show(){
    float tmpX = 0, tmpY = 0;
    
    textSize((expanse.y-2)*0.65 / (float)textLines );
    textLeading( ((expanse.y-2)*0.8 / (float)textLines)*1.1);
      
    for(int i = 0; i<list.size(); i++){
      tmpY = floor((float)i / (float)gridX);
      tmpX = i%(float)gridX;
      
      if(active == i){
        if(triggered){
          fill(ColorCode.guiEnabled);
        }else{
          fill(ColorCode.guiDisabled);
        }
      }else if(hovering == i){
        fill(ColorCode.guiHighlight);
      }else{
        fill(ColorCode.guiTextBackground);
      }
      stroke(ColorCode.guiBorder);
      rect(position.x +tmpX*expanse.x, position.y +tmpY*expanse.y, expanse.x*0.9, expanse.y*0.9);
      
      fill(ColorCode.guiText);
      text(list.get(i), position.x+2 +tmpX*expanse.x, position.y+expanse.y*0.25 +tmpY*expanse.y);
    }
  }
  
  public void onClick(){
    if(hovering != active && hovering >= 0){ active = hovering; triggered = true; }
  }
  
  public void onHover(){
    float tmpX = 0, tmpY = 0;
    hovering = -1;
    
    for(int i = 0; i<list.size(); i++){
      tmpY = floor((float)i / (float)gridX);
      tmpX = i%(float)gridX;
      
      if(mouseX > position.x +tmpX*expanse.x && mouseY > position.y +tmpY*expanse.y && mouseX < (position.x +tmpX*expanse.x)+ expanse.x*0.9 && mouseY < (position.y +tmpY*expanse.y)+ expanse.y*0.9){
        hovering = i;
        break;
      }
    }
  }
  
  public int getTrigger(){
    if(triggered){
      triggered = false;
      return active;
    }
    return -1;
  }
}

//Slider
public class GuiSlider extends GuiElement{
  
}
