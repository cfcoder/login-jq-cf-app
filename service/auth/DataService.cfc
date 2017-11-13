/*
* I am the DataService component for auth services
*/
component displayname="DataService" output="false" {
  /*
  * I get a UserAuth record from the database for the provided username.
  * @username This is a username
  */
  public array function getUserAuth(required string username) output="false" {
    var usernameTrim = trim(arguments.username);

    transaction {
      userAuth = entityLoad( "userAuth", { 
        username : usernameTrim
      });
    } // end transaction

    return userAuth;
  }
}