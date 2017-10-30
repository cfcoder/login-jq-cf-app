component {
  /*
  * I am the constructor method
  */
  // public DataService function init() output="false" {
  //   this.authService = createObject('component', 'services.auth.AuthService');  
  //   return this;
  // }
  
  public array function getUserAuth(username) {
    var usernameTrim = trim(arguments.username);

    transaction {
      userAuth = entityLoad( "userAuth", { 
        username : usernameTrim
      });
    } // end transaction

    return userAuth;
  }
}