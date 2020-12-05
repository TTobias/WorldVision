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
  
  //All Detail Pages
  public HomeDetail_Page homeDetailPage = new HomeDetail_Page();
  public CharacterDetail_Page characterDetailPage = new CharacterDetail_Page();
  
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
  public void show(){         controlBar.show();        navigationBar.show();        mainPage.show();        detailPage.show();         }
  public void onClick(){      controlBar.onClick();     navigationBar.onClick();     mainPage.onClick();     detailPage.onClick();      }
  public void onRelease(){    controlBar.onRelease();   navigationBar.onRelease();   mainPage.onRelease();   detailPage.onRelease();    }
  public void onHover(){      controlBar.onHover();     navigationBar.onHover();     mainPage.onHover();     detailPage.onHover();      }
  public void onDrag(){       controlBar.onDrag();      navigationBar.onDrag();      mainPage.onDrag();      detailPage.onDrag();       }
  public void onKeyDown(){    controlBar.onKeyDown();   navigationBar.onKeyDown();   mainPage.onKeyDown();   detailPage.onKeyDown();    }
  public void onKeyUp(){      controlBar.onKeyUp();     navigationBar.onKeyUp();     mainPage.onKeyUp();     detailPage.onKeyUp();      }
  public void onKey(){        controlBar.onKey();       navigationBar.onKey();       mainPage.onKey();       detailPage.onKey();        }
  public void onScrollUp(){   controlBar.onScrollUp();  navigationBar.onScrollUp();  mainPage.onScrollUp();  detailPage.onScrollUp();   }
  public void onScrollDown(){ controlBar.onScrollDown();navigationBar.onScrollDown();mainPage.onScrollDown();detailPage.onScrollDown(); }
  
  
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
