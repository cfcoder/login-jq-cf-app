/*
* I am the DataService component for the user services
*/
component displayname="Data Service" output="false" {
  // create object in the service/auth 
  variables.AuthService = new service.auth.AuthService();

  /*
  * I am the constructor method
  */
  public DataService function init() output="false" {
    return this;
  }
  
  /*
  * I add a user record to the database. containing their firstname, lastname, username and hashed password and hashed salt.
  * @firstName the first name of the user
  * @lastName the last name of the user
  * @username the username for the user
  * @password the password for the user
  */
  public any function addUser(required string firstName, required string lastName, required string username, required string password) output="false" {
    var randSalt     = variables.AuthService.generateRandSalt();
    var passwordHash = variables.AuthService.hashPassword(password=arguments.password, salt=randSalt);

    transaction {
      user = entityNew( "user", { 
        firstName : arguments.firstname,
        lastName  : arguments.lastname
      });
      entitySave( user );

      userAuth = entityNew( "userAuth", { 
        username: arguments.username,
        password: passwordHash,
        salt    : randSalt
      });

      userAuth.setUser( user );
      entitySave( userAuth );

    } // end transaction

  }
}