/** 
* This component contains API methods related to login authorization.
*/ 
component displayname="Security API" output="false" extends="BaseAPI" {
  // create objects in the service/auth 
  variables.AuthService = new service.auth.AuthService();

  /* 
  *  the constructor method 
  */
  public Security function init() output="false" {
    return this;
  }

  /*
  * i handle login post submissions and return a JSON response
  */
  remote struct function postLogin(required string uname="", required string pword="") returnformat="json" output="false" {
    var local            = {};                    // Define the local scope
    var loginDataOK      = false;
    var userAuthorizedOK = false;
    var unameTrim        = trim(arguments.uname);
    var pwordTrim        = trim(arguments.pword);

    // Get a new API resposne
    local.Response = variables.GetNewResponse();

    // loginDataOK = this.authService.validateLoginData(username = uname, password = pword);
    loginDataOK = variables.AuthService.validateLoginData(username=unameTrim, password=pwordTrim);
 
    if( loginDataOK ) {
      userAuthorizedOK = variables.AuthService.authenticateLoginData(username=unameTrim, password=pwordTrim);
    
      if( userAuthorizedOK ) {
        session.userAuthorized = 1;
        SessionRotate();
      }
      else {
        local.Response.SUCCESS = false;;
        local.Response.ERROR = "User is not authorized.";
      }
    }
    else {
      local.Response.SUCCESS = false;;
      local.Response.ERROR = "Sign in data is not valid.";
    }

    return local.Response;
  } // end method

  /*
  * i handle login post submissions and return a JSON response
  */
  remote struct function postLogout() returnformat="json" output="false" {
    var local            = {};                     // Define the local scope
    var loginDataOK      = false;
    var userAuthorizedOK = false;

    // Get a new API resposne
    local.Response = variables.GetNewResponse();

    session.userAuthorized = 0; // set flag to false
    sessionInvalidate(); // invalidate the session
    local.Response.DATA = "logged-out"; // return a message to the clientside

    return local.Response;
  } // end method

} // end component
