component {
  /*
  * I am the constructor method
  */
  public DataService function init() output="false" {
    this.AuthService = createObject('component', 'service.auth.AuthService');  
    return this;
  }
  
  /*
  * I add a user record to the database. containing their firstname, lastname, username and hashed password and hashed salt.
  */
  public any function addUser(firstName, lastName, username, password) output="false" {
    var randSalt     = this.AuthService.generateRandSalt();
    var passwordHash = this.AuthService.hashPassword(password=arguments.password, salt=randSalt);

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