component {
  this.name               = 'enviancelogin';
  this.datasource         = 'enviancedb';
  this.applicationTimeout = CreateTimeSpan(0, 0, 10, 0); // 10 min
  this.sessionManagement  = true;
  this.sessionTimeout     = CreateTimeSpan(0, 0, 0, 30); // 30 sec

  function onApplicationStart() {
    structClear(application);
		application.myName     = 'Bruce';
    application.myPosition = 'A Developer';
  
    writeLog(log="Application", text="Application #this.name# started.", type="information");
		return true;
  }

  function onRequestStart(string targetPage){
    if(structKeyExists(url, 'reload')){
      onApplicationStart();
    }
  }

  function onRequest( string targetPage ) {
    try {
      include arguments.targetPage;
    } catch (any e) {
      //handle the exception
      writeOutput("Error: Target Page Not Found!");
    }
  }

}