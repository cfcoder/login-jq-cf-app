/* 
* I am the webroot Application.cfc file
*/
component 
  hint="I am the Application CFC"
  output="false" 
{
  this.name                   = 'enviancelogin';
  this.datasource             = 'enviance';
  this.applicationTimeout     = CreateTimeSpan(0, 0, 10, 0);  // 10 min
  this.sessionManagement      = true;
  this.sessionTimeout         = CreateTimeSpan(0, 0, 30, 0);  // 30 min
  this.sessioncookie.httponly = true;
  this.loginStorage           = 'Session';
  this.ormEnabled             = true;
  this.ormSettings            = { 
                                  datasource='enviance', 
                                  dialect="MySQL",
                                  logsql = true, 
                                  dbcreate="update",
                                  cfclocation = "entity" 
                                };
  this.invokeImplicitAccessor = true;
  

  /*
  * I fire whenever the application is started/restarted
  */
  public boolean function onApplicationStart() output="false" {
    structClear(application);
    if(isDefined("session")) structClear(session);
    
    // create some component objects
    application.BaseAPI     = createObject('component', 'service.api.BaseAPI');
    application.Security    = createObject('component', 'service.api.Security').init();
    application.userService = createObject('component', 'service.user.userService').init();
    
    writeLog(log="Application", text="Application #this.name# started.", type="information");
		return true;
  }

  /*
  * I fire whenever the session is first created
  */
  public void function onSessionStart() output="false" {
    return;
  }

  /*
  * I fire whenever a new page request is made and it starts to process it
  */
  public boolean function onRequestStart( required string targetPage ) output="false" {
    // whenver a reloat=1 is specified in the url, reload the application
    if(structKeyExists(url, 'reload')){
      onApplicationStart();
    }
    // whenver a reset=1 is specified in the url, reload the application and orm
    else if(structKeyExists(url, 'reset')){
      onApplicationStart();
      ormReload();
    }

    return true;
  }

  // /*
  // * I also fire whenever a new request is made but after onRequestStart has run
  // */
  // public void function onRequest( required string targetPage ) output="true" {
  //   try {
  //     include arguments.targetPage;
  //   } catch (any e) {
  //     //handle the exception
  //     writeOutput("Error: Target Page Not Found!");
  //   }
  // }

}