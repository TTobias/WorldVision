//Main Editor:  [(0px,80px),(1000px,820px)]

//Primary Home Page
public class Home_Page extends Page{
  public Home_Page(){ super("Home"); }
  
  //called once at the initialization of the Page and everytime it is set as active Page
  public void initializePage(){ }
  
  public void draw(){ BtnFunctions(); }
  
  public GuiButton CharacterPageBtn;
  public GuiButton mapListPageBtn;
  public GuiButton timePageBtn;
  public GuiButton eventPageBtn;
  public GuiButton speciesPageBtn;
  public GuiButton nationPageBtn; //+treaty web?
  public GuiButton timeLinePageBtn;
  public GuiButton characterRelationTreePageBtn;
  public GuiButton placePageBtn; //holds unique and generic
  public GuiButton regionPageBtn;
  public GuiButton religionPageBtn;
  public GuiButton buildingPageBtn; //holds unique and generic
  public GuiButton factionPageBtn; //+treaty web?
  public GuiButton mythPageBtn;
  public GuiButton technologyPageBtn;
  public GuiButton documentPageBtn;
  public GuiButton genericTextPageBtn;
  public GuiButton genericImagePageBtn;
  public GuiButton militaryUnitTypePageBtn;
  public GuiButton militaryUnitPageBtn;
  public GuiButton genericAnimalPageBtn;
  public GuiButton vehiclePageBtn;
  public GuiButton professionPageBtn;
  
  public void constructGui(){
    CharacterPageBtn = new GuiButton(new Vector2(15,90), new Vector2(150,65), "Characters", true, true);    gui.addGui( CharacterPageBtn );
    mapListPageBtn = new GuiButton(new Vector2(175,90), new Vector2(150,65), "Maps ", true, true);    gui.addGui( mapListPageBtn );
    timePageBtn = new GuiButton(new Vector2(335,90), new Vector2(150,65), "Time ", false, true);    gui.addGui( timePageBtn );
    eventPageBtn = new GuiButton(new Vector2(495,90), new Vector2(150,65), "Events", false, true);    gui.addGui( eventPageBtn );
    speciesPageBtn = new GuiButton(new Vector2(655,90), new Vector2(150,65), "Species", false, true);    gui.addGui( speciesPageBtn );
    nationPageBtn = new GuiButton(new Vector2(815,90), new Vector2(150,65), "Nations", false, true);    gui.addGui( nationPageBtn );
  }
  
  public void BtnFunctions(){
    if(CharacterPageBtn.getTrigger()){
      project.setMainPage(project.characterListPage);
    }
    if(mapListPageBtn.getTrigger()){
      project.setMainPage(project.mapListPage);
    }
  }
}



//Character List Page                                   ----- [AddNew] -- SortBy<Filters> - [Sort] ----
public class CharacterList_Page extends Page{
  public CharacterList_Page(){ super("CharacterList"); }
  
  //used for displaying
  public ArrayList<Character> listInstance = new ArrayList<Character>();
  public int startIndex;
  public int newStartIndex; //used for changing list-page
  public int objectsPerSite = 45;
  
  //called once at the initialization of the Page and everytime it is set as active Page
  public void initializePage(){
    startIndex = 0;
    refreshList();
  }
  
  public void refreshList(){
    //Variable changes
    startIndex = newStartIndex;
    
    //Change CharacterList
    characterStringTable.clearOptions();
    ArrayList<Character> tmpCharList = characterList.getListPart(startIndex, startIndex      + objectsPerSite);
    for(int i = 0; i<tmpCharList.size(); i++){
      characterStringTable.list.add(tmpCharList.get(i).name+"\n"+tmpCharList.get(i).age+"\n"+tmpCharList.get(i).home);
    }
    
    //Change ListNavigation Button Names
    pageIndicatorTxt.text = floor(1+((float)(startIndex+1) / 45.0)) + " / " + floor((((float)characterList.size()-1) / 45.0)+1);
    elementIndicatorTxt.text = (startIndex+1) + " - " + (startIndex+45) + " of " + characterList.size();
  }
  
  public void draw(){ BtnFunctions(); }
  
  public GuiButton addCharacterBtn;
  public GuiButton generateCharactersBtn; //NOT IMPLEMENTED YET
  public GuiTextInput searchTextIn; //NOT IMPLEMENTED YET
  public GuiButton searchApplyBtn; //NOT IMPLEMENTED YET
  public GuiButton advancedSearchBtn; //NOT IMPLEMENTED YET
  public GuiLine upperSeperatorline;
  
  public GuiStringTable characterStringTable;
  
  public GuiLine lowerSeperatorline;
  public GuiButton nextPageBtn;
  public GuiButton previousPageBtn;
  public GuiButton firstPageBtn;
  public GuiButton lastPageBtn;
  public GuiText pageIndicatorTxt;
  public GuiText elementIndicatorTxt;
  public GuiButton reloadListBtn;
  
  
  public void constructGui(){
    addCharacterBtn = new GuiButton(new Vector2(10,90), new Vector2(180,40), "Add Character", true, true);
    generateCharactersBtn = new GuiButton(new Vector2(200,90), new Vector2(160,40), "Generator", false, true);
    searchTextIn = new GuiTextInput(new Vector2(450,95), new Vector2(310,30), "", true);
    searchApplyBtn = new GuiButton(new Vector2(770,95), new Vector2(80,30), "Search", false, true);
    advancedSearchBtn = new GuiButton(new Vector2(860,95), new Vector2(100,30), "Advanced ", false, true);
    gui.addGui( addCharacterBtn );
    gui.addGui( generateCharactersBtn );
    gui.addGui( searchApplyBtn );
    gui.addGui( advancedSearchBtn );
    gui.addGui( searchTextIn );
    
    upperSeperatorline = new GuiLine(new Vector2(20,140), new Vector2(980,140), true);
    gui.addGui ( upperSeperatorline );
    
    characterStringTable = new GuiStringTable(new Vector2(10,150), new Vector2(200,75), 5, 3, true);
    gui.addGui ( characterStringTable );
    
    lowerSeperatorline = new GuiLine(new Vector2(20,830), new Vector2(980,830), true);
    gui.addGui ( lowerSeperatorline );
    
    firstPageBtn = new GuiButton(new Vector2(20,845), new Vector2(90,40), "First", true, true);
    previousPageBtn = new GuiButton(new Vector2(120,845), new Vector2(50,40), "<", true, true);
    pageIndicatorTxt = new GuiText(new Vector2(180,848), new Vector2(130,30), "PAGE", true);
    nextPageBtn = new GuiButton(new Vector2(320,845), new Vector2(50,40), ">", true, true);
    lastPageBtn = new GuiButton(new Vector2(380,845), new Vector2(90,40), "Last", true, true);
    elementIndicatorTxt = new GuiText(new Vector2(480,858), new Vector2(200,25), "ELEMENT", true);
    reloadListBtn = new GuiButton(new Vector2(880,845), new Vector2(100,30), "Reload", true, true);
    gui.addGui ( nextPageBtn );
    gui.addGui ( previousPageBtn );
    gui.addGui ( firstPageBtn );
    gui.addGui ( lastPageBtn );
    gui.addGui ( pageIndicatorTxt );
    gui.addGui ( elementIndicatorTxt );
    gui.addGui( reloadListBtn );
    
    refreshList();
  }
  
  public void BtnFunctions(){
    if(addCharacterBtn.getTrigger()){
      characterList.add(new Character());
      refreshList();
    }
    if(reloadListBtn.getTrigger()){
      refreshList();
    }
    if(characterStringTable.getTrigger() > -1){
      project.characterDetailPage.character = characterList.get(startIndex+characterStringTable.active);
      if(project.characterDetailPage.character != null){ project.setDetailPage(project.characterDetailPage); };
    }
    
    if(firstPageBtn.getTrigger()){
      newStartIndex = 0; 
      refreshList();
    }
    if(previousPageBtn.getTrigger()){
      newStartIndex = startIndex-45 >= 0? startIndex -45 : 0;
      refreshList();
    }
    if(nextPageBtn.getTrigger()){
      newStartIndex = startIndex+45 < characterList.size()? startIndex +45 : startIndex;
      refreshList();
    }
    if(lastPageBtn.getTrigger()){
      newStartIndex = characterList.size()-45 >= 0? characterList.size()-45 : 0;
      refreshList();
    }
  }
}



//Map List Page         
public class MapList_Page extends Page{
  public MapList_Page(){ super("MapList"); }
  
  //used for displaying
  public ArrayList<Map> listInstance = new ArrayList<Map>();
  public int startIndex;
  public int newStartIndex; //used for changing list-page
  public int objectsPerSite = 45;
  
  //called once at the initialization of the Page and everytime it is set as active Page
  public void initializePage(){
    startIndex = 0;
    refreshList();
  }
  
  public void refreshList(){
    //Variable changes
    startIndex = newStartIndex;
    
    //Change CharacterList
    //characterStringTable.clearOptions();
    //ArrayList<Character> tmpCharList = characterList.getListPart(startIndex, startIndex      + objectsPerSite);
    //for(int i = 0; i<tmpCharList.size(); i++){
    //  characterStringTable.list.add(tmpCharList.get(i).name+"\n"+tmpCharList.get(i).age+"\n"+tmpCharList.get(i).home);
    //}
    
    //Change ListNavigation Button Names
    //pageIndicatorTxt.text = floor(1+((float)(startIndex+1) / 45.0)) + " / " + floor((((float)characterList.size()-1) / 45.0)+1);
    //elementIndicatorTxt.text = (startIndex+1) + " - " + (startIndex+45) + " of " + characterList.size();
  }
  
  public void draw(){ BtnFunctions(); }
  
  public GuiButton addMapBtn; //NOT IMPLEMENTED YET
  public GuiTextInput searchTextIn; //NOT IMPLEMENTED YET
  public GuiButton searchApplyBtn; //NOT IMPLEMENTED YET
  public GuiButton advancedSearchBtn; //NOT IMPLEMENTED YET
  public GuiLine upperSeperatorline;
  
  public GuiStringTable characterStringTable;
  
  public GuiLine lowerSeperatorline;
  public GuiButton nextPageBtn;
  public GuiButton previousPageBtn;
  public GuiButton firstPageBtn;
  public GuiButton lastPageBtn;
  public GuiText pageIndicatorTxt;
  public GuiText elementIndicatorTxt;
  public GuiButton reloadListBtn;
  
  
  public void constructGui(){
    addMapBtn = new GuiButton(new Vector2(10,90), new Vector2(180,40), "Add Map", false, true);
    searchTextIn = new GuiTextInput(new Vector2(450,95), new Vector2(310,30), "", true);
    searchApplyBtn = new GuiButton(new Vector2(770,95), new Vector2(80,30), "Search", false, true);
    advancedSearchBtn = new GuiButton(new Vector2(860,95), new Vector2(100,30), "Advanced ", false, true);
    gui.addGui( addMapBtn );
    gui.addGui( searchApplyBtn );
    gui.addGui( advancedSearchBtn );
    gui.addGui( searchTextIn );
    
    upperSeperatorline = new GuiLine(new Vector2(20,140), new Vector2(980,140), true);
    gui.addGui ( upperSeperatorline );
    /*
    characterStringTable = new GuiStringTable(new Vector2(10,150), new Vector2(200,75), 5, 3, true);
    gui.addGui ( characterStringTable );
    
    lowerSeperatorline = new GuiLine(new Vector2(20,830), new Vector2(980,830), true);
    gui.addGui ( lowerSeperatorline );
    
    firstPageBtn = new GuiButton(new Vector2(20,845), new Vector2(90,40), "First", true, true);
    previousPageBtn = new GuiButton(new Vector2(120,845), new Vector2(50,40), "<", true, true);
    pageIndicatorTxt = new GuiText(new Vector2(180,848), new Vector2(130,30), "PAGE", true);
    nextPageBtn = new GuiButton(new Vector2(320,845), new Vector2(50,40), ">", true, true);
    lastPageBtn = new GuiButton(new Vector2(380,845), new Vector2(90,40), "Last", true, true);
    elementIndicatorTxt = new GuiText(new Vector2(480,858), new Vector2(200,25), "ELEMENT", true);
    reloadListBtn = new GuiButton(new Vector2(880,845), new Vector2(100,30), "Reload", true, true);
    gui.addGui ( nextPageBtn );
    gui.addGui ( previousPageBtn );
    gui.addGui ( firstPageBtn );
    gui.addGui ( lastPageBtn );
    gui.addGui ( pageIndicatorTxt );
    gui.addGui ( elementIndicatorTxt );
    gui.addGui( reloadListBtn );
    
    refreshList();*/
  }
  
  public void BtnFunctions(){
    if(addMapBtn.getTrigger()){
      //characterList.add(new Character());
      refreshList();
    }/*
    if(reloadListBtn.getTrigger()){
      refreshList();
    }
    if(characterStringTable.getTrigger() > -1){
      project.characterDetailPage.character = characterList.get(startIndex+characterStringTable.active);
      if(project.characterDetailPage.character != null){ project.setDetailPage(project.characterDetailPage); };
    }
    
    if(firstPageBtn.getTrigger()){
      newStartIndex = 0; 
      refreshList();
    }
    if(previousPageBtn.getTrigger()){
      newStartIndex = startIndex-45 >= 0? startIndex -45 : 0;
      refreshList();
    }
    if(nextPageBtn.getTrigger()){
      newStartIndex = startIndex+45 < characterList.size()? startIndex +45 : startIndex;
      refreshList();
    }
    if(lastPageBtn.getTrigger()){
      newStartIndex = characterList.size()-45 >= 0? characterList.size()-45 : 0;
      refreshList();
    }*/
  }
}
