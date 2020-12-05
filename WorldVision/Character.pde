public class Character{
  public String name;
  public String species; ///ADD CUSTOM SPECIES CLASS
  public int age;
  public int birthday; ///ADD CUSTOM TIME TABLE FOR CUSTOM DATE SCHEMES
  public String home; ///ADD MAP PLACEMENT OPTION AND POSITION SYSTEM ON MAPS
  
  //new Character
  public Character(){
    name = "NEW CHARACTER";
    species = "HUMAN"; //later replaced by sth like species.default
    age = 30; //maybe also a default option?
    birthday = 0;
    home = "NONE";
    
  }
  
  //load Character from String
  public Character(String[] n){
    name = n[0];
    species = n[1];
    age = int(n[2]);
    birthday = int(n[3]);
    home = n[4];
  }
  
  //save Character as a String (usually called by the CharacterList class)
  public String saveAsString(){
    String tmp = "";
    tmp += name+"\n"+species+"\n"+age+"\n"+birthday+"\n"+home+"\n";
    return tmp;
  }
}

//Class that represents a list of all characters
public CharacterList characterList = new CharacterList();
public class CharacterList{
  public ArrayList<Character> list = new ArrayList<Character>();//Might need a replacements by a sorted tree later on
  
  public void add(Character c){ list.add(c); }
  public void remove(Character c){ list.remove(c); }
  public int size(){ return list.size(); }
  
  //returns a part of the list from s to e
  public ArrayList<Character> getListPart (int s, int e){
    ArrayList<Character> tmp = new ArrayList<Character>();
    for(int i = s; i<e && i<list.size(); i++){
      tmp.add(list.get(i));
    }
    return tmp;
  }
  
  public Character get(int i){
    if(i<0 || i>list.size()){ return null; }
    return list.get(i);
  }
  
  //Recreates the list by reading out a String
  public void overwriteFromStrings(String[] s){
    list = new ArrayList<Character>();
    println("Loading "+s[0]+" Characters");
    for(int i = 0; i<(int(s[0])*int(s[1])); i+=int(s[1])){
      String[] tmp = {s[i+3],s[i+3+1],s[i+3+2],s[i+3+3],s[i+3+4],s[i+3+5]}; //only works for s[1] = 6
      Character c = new Character(tmp);
      add( c );
    }
  }
  //Extends the list by reading out a String
  public void extendFromString(String s){
    ////////////////////////////////////// -- MISSING -- //////////////////////
  }
  //Saves the list as a String
  public String[] saveAsStrings(){
    String[] tmp = new String[1+ list.size()];
    tmp[0] = list.size()+"\n"+/*Amount of Character Attributes +1*/(5+1)+"\n";
    
    for(int i = 0; i<list.size();i++){
      tmp[i+1] = list.get(i).saveAsString();
    }
    return tmp;
  }
}
