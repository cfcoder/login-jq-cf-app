component {
  /*
  * I am the constructor method
  */
  public DataService function init() output="false" {
    this.AuthService = createObject('component', 'services.auth.AuthService');  
    return this;
  }
  
  public any function addUser(firstName, lastName, username, password) {
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