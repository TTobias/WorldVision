//Page class containing a specific set of UI Elements for a specific purpose
public class Page{
  public String name;
  //public int index;
  
  public GUI gui;
  
  public Page(String n){
    name = n;
    
    gui = new GUI();
    
    constructGui();
    initializePage();
  }
  
  //called once at the initialization of the Page and everytime it is set as active Page
  public void initializePage(){ }
  
  //Adds all the necessary GuiElements
  public void constructGui(){ }
  //Used to check for pressed Buttons etc
  public void BtnFunctions(){ }
  
  public void draw(){ }
  
  public void show(){         gui.show();         }
  public void onClick(){      gui.onClick();      }
  public void onRelease(){    gui.onRelease();    }
  public void onHover(){      gui.onHover();      }
  public void onDrag(){       gui.onDrag();       }
  public void onKeyDown(){    gui.onKeyDown();    }
  public void onKeyUp(){      gui.onKeyUp();      }
  public void onKey(){        gui.onKey();        }
  public void onScrollUp(){   gui.onScrollUp();   }
  public void onScrollDown(){ gui.onScrollDown(); }
}


//shown when starting the program
public Startup_Page startup = new Startup_Page();
public class Startup_Page extends Page{
  
  public Startup_Page(){
    super("Startup");
  }
  
  public void draw(){  show(); onHover(); BtnFunctions(); }
  
  public GuiButton newProjectBtn;
  public GuiButton loadProjectBtn;
  public GuiButton exitProgramBtn;
  
  public void constructGui(){
    newProjectBtn = new GuiButton(new Vector2(200,300), new Vector2(350,40), "Create New Project", true, true);
    loadProjectBtn = new GuiButton(new Vector2(200,380), new Vector2(350,40), "Load Project", true, true);
    exitProgramBtn = new GuiButton(new Vector2(300,460), new Vector2(150,30), "Exit", true, true);
    gui.addGui( newProjectBtn );
    gui.addGui( loadProjectBtn );
    gui.addGui( exitProgramBtn );
  }
  
  public void BtnFunctions(){
    if(newProjectBtn.getTrigger()){
      startup = null;//for saving computer Resources
      project = new Project();
    }
    if(loadProjectBtn.getTrigger()){
      String p = waitForInput("Select the main.wvsn file of your project");
      if(p != null/* && p.split(".")[1] != "wvsn"*/){
        //DOES NOT WORK RIGHT NOW
        project = new Project( convertPath(p) );
      }
    }
    if(exitProgramBtn.getTrigger()){
      exit();
    }
  }
}



//Controlbar for the Project UI
public class Controlbar_Page extends Page{
  
  public Controlbar_Page(){
    super("Controlbar");
  }
  
  public void draw(){ BtnFunctions(); }
  
  public GuiPanel background;
  
  //Loads and saves to the "tmp"-project files
  public GuiButton quickSaveProjectBtn;
  public GuiButton quickLoadProjectBtn;
  
  //public GuiButton saveProjectAsBtn;
  //public GuiButton exportProjectBtn;
  //public GuiButton importProjectBtn;
  //public GuiButton exitProgramBtn;
  //public GuiButton helpPageBtn;
  
  public void constructGui(){
    background = new GuiPanel(new Vector2(0,0), new Vector2(width,18), ColorCode.background, true);
    gui.addGui( background );
    
    quickSaveProjectBtn = new GuiButton(new Vector2(1,1), new Vector2(54,18), "QSave", true, true);
    quickLoadProjectBtn = new GuiButton(new Vector2(55,1), new Vector2(55,18), "QLoad", true, true);
    
    gui.addGui( quickSaveProjectBtn );
    gui.addGui( quickLoadProjectBtn );
  }
  
  public void BtnFunctions(){
    if(quickSaveProjectBtn.getTrigger()){
      project.saveProject();
    }
    if(quickLoadProjectBtn.getTrigger()){
      project = new Project(project.path+"/"+project.name+"/"+"main.wvsn");
    }
  }
}




//Navigation Bar for the Project UI
public class Navigationbar_Page extends Page{
  
  public Navigationbar_Page(){
    super("Navigationbar");
  }
  
  public void draw(){ BtnFunctions(); }
  
  public GuiPanel background;
  public GuiButton homeBtn;
  public GuiButton mapBtn;
  public GuiButton characterBtn;
  
  public void constructGui(){
    background = new GuiPanel(new Vector2(0,20), new Vector2(width,60), ColorCode.grey, true);
    gui.addGui( background );
    
    homeBtn = new GuiButton(new Vector2(5,30), new Vector2(55,21), "Home", true, true);
    characterBtn = new GuiButton(new Vector2(65,30), new Vector2(55,21), "Char", true, true);
    mapBtn = new GuiButton(new Vector2(5,55), new Vector2(55,21), "Map", true, true);
    
    gui.addGui( homeBtn );
    //gui.addGui( characterBtn );
    //gui.addGui( mapBtn );
  }
  
  public void BtnFunctions(){
    if(homeBtn.getTrigger()){
      project.setMainPage(project.homePage);
      project.setDetailPage(project.homeDetailPage);
    }
    if(mapBtn.getTrigger()){
      //////////////
    }
    if(characterBtn.getTrigger()){
      //////////////
    }
  }
}
