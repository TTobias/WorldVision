public class Map{
  public String name;
  public String path;
  
  public String format = ".png";
  
  public PImage img;
  
  //new Map by the image path
  public Map(String p){
    name = "NEW MAP";
    loadInMapImage(p);//also sets the path and image
  }
  
  // sets the img variable
  public void loadInMapImage(String p){
    img = loadImage(p);
  }
  
  // creates a local copy of the image
  public void saveLocalCopy(){
    path = project.path +"/"+ project.name +"/map_src/";
    img.save(path+name+format);
  }
  
  //load Character from String
  public Map(String[] n){
    name = n[0];
    path = n[1];
    loadInMapImage(path+name+format);
  }
  
  //save Character as a String (usually called by the CharacterList class)
  public String saveAsString(){
    saveLocalCopy();
    
    String tmp = "";
    tmp += name+"\n"+path+"\n";
    
    return tmp;
    
    //ACTUAL IMAGE HAS TO BE SAVED TOO////////////////////////////////////////////////////////////////
  }
}

//Class that represents a list of all characters
public MapList mapList = new MapList();
public class MapList{
  public ArrayList<Map> list = new ArrayList<Map>();//Might need a replacements by a sorted tree later on
  
  public void add(Map m){ list.add(m); }
  public void remove(Map m){ list.remove(m); }
  public int size(){ return list.size(); }
  
  //returns a part of the list from s to e
  public ArrayList<Map> getListPart (int s, int e){
    ArrayList<Map> tmp = new ArrayList<Map>();
    for(int i = s; i<e && i<list.size(); i++){
      tmp.add(list.get(i));
    }
    return tmp;
  }
  
  public Map get(int i){
    if(i<0 || i>list.size()){ return null; }
    return list.get(i);
  }
  
  //Recreates the list by reading out a String
  public void overwriteFromStrings(String[] s){
    list = new ArrayList<Map>();
    println("Loading "+s[0]+" Maps");
    for(int i = 0; i<(int(s[0])*int(s[1])); i+=int(s[1])){
      String[] tmp = {s[i+3],s[i+3+1],s[i+3+2]}; //only works for s[1] = 3
      Map m = new Map(tmp);
      add( m );
    }
  }
  //Extends the list by reading out a String
  public void extendFromString(String s){
    ////////////////////////////////////// -- MISSING -- //////////////////////
  }
  //Saves the list as a String
  public String[] saveAsStrings(){
    String[] tmp = new String[1+ list.size()];
    tmp[0] = list.size()+"\n"+/*Amount of Character Attributes +1*/(2+1)+"\n";
    
    for(int i = 0; i<list.size();i++){
      tmp[i+1] = list.get(i).saveAsString();
    }
    return tmp;
  }
}
