/** 
* This component contains API methods related to login authorization.
*/ 
component displayname="Security API" output="false" extends="BaseAPI" { 
  /* 
  *  the constructor method 
  */
  public Security function init() output="false" {
    this.AuthService = createObject('component', 'service.auth.AuthService');  
    this.DataService = createObject('component', 'service.auth.DataService');  
    return this;
  }

  /*
  * i handle login post submissions and return a JSON response
  */
  remote struct function postLogin(required string uname="", required string pword="") returnformat="json" output="false" {
    var LOCAL            = {};                     // Define the local scope
    var loginDataOK      = false;
    var userAuthorizedOK = false;
    var unameTrim        = trim(arguments.uname);
    var pwordTrim        = trim(arguments.pword);

    // Get a new API resposne
    LOCAL.Response = THIS.GetNewResponse();

    // loginDataOK = this.authService.validateLoginData(username = uname, password = pword);
    loginDataOK = Application.Security.authService.validateLoginData(username=unameTrim, password=pwordTrim);
 
    if( loginDataOK ) {
      userAuthorizedOK = Application.Security.authService.authenticateLoginData(username=unameTrim, password=pwordTrim);
    
      if( userAuthorizedOK ) {
        session.userAuthorized = 1;
        SessionRotate();
      }
      else {
        LOCAL.Response.SUCCESS = false;;
        LOCAL.Response.ERROR = "User is not authorized.";
      }
    }
    else {
      LOCAL.Response.SUCCESS = false;;
      LOCAL.Response.ERROR = "Sign in data is not valid.";
    }

    return LOCAL.Response;
  } // end method

  /*
  * i handle login post submissions and return a JSON response
  */
  remote struct function postLogout() returnformat="json" output="false" {
    var LOCAL            = {};                     // Define the local scope
    var loginDataOK      = false;
    var userAuthorizedOK = false;

    // Get a new API resposne
    LOCAL.Response = THIS.GetNewResponse();

    session.userAuthorized = 0; // set flag to false
    sessionInvalidate(); // invalidate the session
    LOCAL.Response.DATA = "logged-out"; // return a message to the clientside

    return LOCAL.Response;
  } // end method

} // end component
