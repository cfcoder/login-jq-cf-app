component {
  /*
  * I get a UserAuth record from the database for the provided username.
  */
  public array function getUserAuth(username) output="false" {
    var usernameTrim = trim(arguments.username);

    transaction {
      userAuth = entityLoad( "userAuth", { 
        username : usernameTrim
      });
    } // end transaction

    return userAuth;
  }
}