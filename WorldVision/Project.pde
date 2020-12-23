public Project project = null;
//Project Class where everything is saved in
public class Project{
  
  //Project Definition
  public String name = "TmpProject";
  public String version = "WV-0.1";
  public String path = "projects";
  
  //Static Environment Control UI
  public Page controlBar = new Controlbar_Page();
  public Page navigationBar = new Navigationbar_Page();
  
  //All Main Pages
  public Home_Page homePage = new Home_Page();
  public CharacterList_Page characterListPage = new CharacterList_Page();
  public MapList_Page mapListPage = new MapList_Page();
  public MapEditor_Page mapEditorPage = new MapEditor_Page();
  
  //All Detail Pages
  public HomeDetail_Page homeDetailPage = new HomeDetail_Page();
  public CharacterDetail_Page characterDetailPage = new CharacterDetail_Page();
  public MapDetail_Page mapDetailPage = new MapDetail_Page();
  
  //Flexible Environment Control UI
  public Page mainPage = homePage;
  public Page detailPage = homeDetailPage;
  
  
  //used for creating a new Project
  public Project(){  }
  
  //used for loading a project from a file structure. p should be the path to the main control file of the file structure ("main.wvsn")
  public Project(String p){
    println("LOADED PROJECT");
    String[] stmp = loadStrings(p);
    name = stmp[0];
    version = stmp[1];
    path = stmp[2]; //maybe this needs to be changed
    
    characterList.overwriteFromStrings( loadStrings(path+"/"+name+"/"+"character.txt") );
    mapList.overwriteFromStrings( loadStrings(path+"/"+name+"/"+"map.txt") ); //Actual Images are still missing
  }
  
  
  //sets the Pages
  public void setMainPage(Page p){ mainPage = p; p.initializePage(); }
  public void setDetailPage(Page p){ detailPage = p; p.initializePage(); }
  
  
  public void draw(){ 
    show();
    onHover();
    
    controlBar.draw(); navigationBar.draw(); mainPage.draw();  detailPage.draw();
  }
  
  //  SIZES:
  //Controlbar: [(0px,0px),(1600px,20px)]
  //Navigationbar: [(0px,20px),(1600px,60px)]
  //Main Editor:  [(0px,80px),(1000px,820px)]
  //Secondary Editor:  [(1000px,80px),(600px,820px)]
  public void show(){         mainPage.show();        detailPage.show();         controlBar.show();        navigationBar.show();        }
  public void onClick(){      mainPage.onClick();     detailPage.onClick();      controlBar.onClick();     navigationBar.onClick();     }
  public void onRelease(){    mainPage.onRelease();   detailPage.onRelease();    controlBar.onRelease();   navigationBar.onRelease();   }
  public void onHover(){      mainPage.onHover();     detailPage.onHover();      controlBar.onHover();     navigationBar.onHover();     }
  public void onDrag(){       mainPage.onDrag();      detailPage.onDrag();       controlBar.onDrag();      navigationBar.onDrag();      }
  public void onKeyDown(){    mainPage.onKeyDown();   detailPage.onKeyDown();    controlBar.onKeyDown();   navigationBar.onKeyDown();   }
  public void onKeyUp(){      mainPage.onKeyUp();     detailPage.onKeyUp();      controlBar.onKeyUp();     navigationBar.onKeyUp();     }
  public void onKey(){        mainPage.onKey();       detailPage.onKey();        controlBar.onKey();       navigationBar.onKey();       }
  public void onScrollUp(){   mainPage.onScrollUp();  detailPage.onScrollUp();   controlBar.onScrollUp();  navigationBar.onScrollUp();  }
  public void onScrollDown(){ mainPage.onScrollDown();detailPage.onScrollDown(); controlBar.onScrollDown();navigationBar.onScrollDown();}
  
  
  //used for saving projects as a file structure
  public void saveProject(){
    println("SAVING PROJECT");
    
    //MAIN FILES
    if(path == ""){
      path = "projects";
    }
    String[] tmp = {name, version, path};
    saveStrings(path+"/"+name+"/main.wvsn", tmp);
    
    //CHARACTER FILES
    saveStrings(path+"/"+name+"/character.txt", characterList.saveAsStrings());
    
    //MAP FILES
    saveStrings(path+"/"+name+"/map.txt", mapList.saveAsStrings());
  }
}




/* NO LONGER USED
public ArrayList<Page> preloadPages = new ArrayList<Page>();
public Page loadPage(String n){
  for(int i = 0;i<preloadPages.size();i++){
    if(preloadPages.get(i).name.equals(n)){ return preloadPages.get(i); }
  }
  return null;
}*/
