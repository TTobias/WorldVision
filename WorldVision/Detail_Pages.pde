//Secondary Editor:  [(1000px,80px),(600px,820px)]

//Detail Home Page
public class HomeDetail_Page extends Page{
  public HomeDetail_Page(){ super("Project Details"); }
  
  //called once at the initialization of the Page and everytime it is set as active Page
  public void initializePage(){ }
  
  public void draw(){ BtnFunctions();
    if(projectNameIn.text.equals("") && project.name != null){ projectNameIn.text = project.name; }
  }
  
  public GuiPanel background;
  public GuiText pageNameText;
  
  public GuiNamedTextInput projectNameIn;
  
  public void constructGui(){
    background = new GuiPanel(new Vector2(1000,80), new Vector2(600,820), ColorCode.background, true);
    pageNameText = new GuiText(new Vector2(1040,85), new Vector2(400, 30), name, true);
    gui.addGui( background ); gui.addGui( pageNameText );
    
    projectNameIn = new GuiNamedTextInput(new Vector2(1010,125), new Vector2(550,30), "ProjectName:", ColorCode.white, "", true);
    //BTN = new GuiButton(new Vector2(20,90), new Vector2(360,120), "Create New Project", true, true);
    gui.addGui( projectNameIn );
    //gui.addGui(BTN );
  }
  
  public void BtnFunctions(){
    if(!projectNameIn.text.equals("") && !project.name.equals(projectNameIn.text)){
      project.name = projectNameIn.text; println("Changed projectname to: "+project.name);
    }
    /*if(CharacterPageBtn.getTrigger()){
      //BTN ACTION
    }*/
  }
}


//Detail Character Page
public class CharacterDetail_Page extends Page{
  public CharacterDetail_Page(){ super("Character Details"); }
  
  public Character character = null;
  
  //called once at the initialization of the Page and everytime it is set as active Page
  public void initializePage(){
    if(nameIn != null){ nameIn.text = ""; }
  }
  
  public void draw(){ BtnFunctions();
    if(nameIn.text.equals("") && character != null){ nameIn.text = character.name; }
  }
  
  public GuiPanel background;
  public GuiText pageNameText;
  
  public GuiNamedTextInput nameIn;
  
  public void constructGui(){
    background = new GuiPanel(new Vector2(1000,80), new Vector2(600,820), ColorCode.background, true);
    pageNameText = new GuiText(new Vector2(1040,85), new Vector2(400, 30), name, true);
    gui.addGui( background ); gui.addGui( pageNameText );
    
    nameIn = new GuiNamedTextInput(new Vector2(1010,125), new Vector2(550,30), "Name:", ColorCode.white, "", true);
    //BTN = new GuiButton(new Vector2(20,90), new Vector2(360,120), "Create New Project", true, true);
    gui.addGui( nameIn );
    //gui.addGui(BTN );
  }
  
  public void BtnFunctions(){
    if(!nameIn.text.equals("") && !character.name.equals(nameIn.text)){
      character.name = nameIn.text;
      project.characterListPage.refreshList();
    }
    /*if(CharacterPageBtn.getTrigger()){
      //BTN ACTION
    }*/
  }
}
