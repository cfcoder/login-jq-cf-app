/** 
* This is the AuthService component for the auth services
*/ 
component displayname="AuthService" output="false" {
  // create additional cfc objects used below
  variables.DataService = new service.auth.DataService();
  variables.UserService = new service.user.UserService().init();

  /* 
  * I validate the user data passed in as a struct.
  * @username this is the username
  * @password this is the password
  */
  public boolean function validateLoginData(required string username, required string password) output="false" {
    // trim the input field data
    var authDataValid = false;
    var unameOK       = false;
    var pwOK          = false;

    // check username and password are valid
    unameOK = variables.UserService.checkUsername(arguments.username);
    pwOK    = variables.UserService.checkPassword(arguments.password);

    // Check to see if a valid user was returned
    if(unameOK and pwOK) {
      authDataValid = true;
    }
    return authDataValid;
  }


  /*
  * This method will authenticate the login username and password comparing with the database USER_AUTH table.
  * @username this is the username
  * @password this is the password
  */ 
  public boolean function authenticateLoginData(required string username='', required string password='') output="true" {
  
    // Set local var for query
    var usernameInput       = arguments.username;
    var passwordInput       = arguments.password;
    var authenticationOK    = false;
    var passwordInputHashed = '';
    var userAuth            = variables.DataService.getUserAuth(usernameInput); // get a USER_AUTH user record for the given username
    
    // Using the username, get the hashed password and the salt (If the username is invalid, then nothing will be returned)

    // if the query finds a record for the username, lets look at the passwords
    if( not arrayIsEmpty(userAuth) ) {
      // generate a hash for the input password and using the salt stored in the database for this user
      passwordInputHashed = hashPassword(password=passwordInput, salt=userAuth[1].salt);

      // Compare the inputHash with the hash we pulled from the db if they match, then the correct password was passed in
      if (Compare(passwordInputHashed, userAuth[1].password) eq 0) {
        authenticationOK = true;
      }
    } // end if empty userAuth

    return authenticationOK;
  } // end method


  /** 
  * This method generates a salt value to be used in hashing strings such as passwords
  */ 
  public string function generateRandSalt() output="false" {
    // var salt = CreateUUID();
    // or
    // alternate method for generating salt
    var lowerAlphabets = "abcdefghijklmnopqrstuvwxyz";
    var upperAlphabets = uCase(lowerAlphabets);
    var numbers = "0123456789";
    var saltLength = 128; // 128 bit salt
      
    var saltBase = lowerAlphabets & upperAlphabets & numbers;
    var salt = "";

    for(var i = 0; i < saltLength; i++) {
      salt = salt & saltBase.charAt(RandRange(0, Len(saltBase) - 1, "SHA1PRNG"));
    }
    return salt;
  }


  /*
  * This method creates a hash of the password string passed in
  * @password this is the password
  * @salt this is the salt used in the hash of the password
  */ 
  public string function hashPassword(required string password, string salt='') output="false" {
    return Hash(arguments.password & arguments.salt, 'SHA-512', 'UTF-8', 1024);
  }




//   /** 
//   * This method will validate a user
//   */ 
//   public boolean function validateUser(string username="", string password="")
//     output="false"
//     hint="I will validate the login username and password"
//   {
    
//     // Set local var for query
//     var qGetUserInfo = "";
//     var inputHash = "";
            
//     // Using the username, get the hashed password and the salt (If the username is invalid, then nothing will be returned)
//     qGetUserInfo = queryExecute(
//       "SELECT u.password, us.salt
//        FROM users u
//            JOIN user_salts us ON u.userid = us.userid
//        WHERE u.username = :uname",
//        {uname = { value=arguments.username, cfsqltype="VARCHAR" }}, 
//        {datasource = "#variables.dsn#"} 
//      );
// writeDump(myQuery);
    
//     // if the query returns a record then the username was legit, lets look at the passwords
//     if( qGetUserInfo.recordcount ) {
//       // Set the input hash by concatenating the password that was passed in to the salt from the DB and hashing it witht he same hash function as when it was stored.
//       inputHash = Hash(arguments.password & qGetUserInfo.salt, 'SHA-512');
        
//       // Compare the inputHash with the hash we pulled from the db if they match, then the correct password was passed in
//       return NOT Compare(inputHash, qGetUserInfo.password);
//     } else {
//       // if no user info found, then it's a bad username and return false
//       return false;
//     }
//   } // end method


//   /** 
//   * This method will get the user authorization record for a given username from the db
//   */ 
//   public boolean function getUserAuth(required string username) 
//   output="false"
//   hint="I will add a new login username and password to the database"
// {
//   // Set local var for query
//   var qGetUserAuth = "";
          
//   // Using the username, get the hashed password and the salt (If the username is invalid, then nothing will be returned)
//   qGetUserAuthInfo = queryExecute(
//     "SELECT ua.username, ua.password, ua.salt
//     FROM UserAuth ua
//       JOIN User u ON ua.userid = u.id
//     WHERE ua.username = :uname",
//     {uname = { value=arguments.username, cfsqltype="VARCHAR" }}, 
//     {datasource = "#variables.dsn#"} 
//   );
// writeDump(myQuery);
  
//   return qGetUserAuthInfo;
// } // end method



  // /** 
  // * This method will add a new user authorization into the db
  // */ 
  // public boolean function addUserAuth(required string username, required string password)
  //   output="false"
  //   hint="I will add a new login username and password to the database"
  // {
  //   // Set local var for query
  //   var qSaveUserAuth = "";
  //   var inputHash = "";
            
  //   // Using the username, get the hashed password and the salt (If the username is invalid, then nothing will be returned)
  //   qGetUserInfo = queryExecute(
  //     "SELECT u.password, us.salt
  //     FROM users u
  //         JOIN user_salts us ON u.userid = us.userid
  //     WHERE u.username = :uname",
  //     {uname = { value=arguments.username, cfsqltype="VARCHAR" }}, 
  //     {datasource = "#variables.dsn#"} 
  //   );
  // writeDump(qGetUserInfo);
    
  //   // if the query returns a record then the username was legit, lets look at the passwords
  //   if( qGetUserInfo.recordcount ) {
  //     // Set the input hash by concatenating the password that was passed in to the salt from the DB and hashing it witht he same hash function as when it was stored.
  //     inputHash = Hash(arguments.password & qGetUserInfo.salt, 'SHA-512');
        
  //     // Compare the inputHash with the hash we pulled from the db if they match, then the correct password was passed in
  //     return NOT Compare(inputHash, qGetUserInfo.password);
  //   } else {
  //     // if no user info found, then it's a bad username and return false
  //     return false;
  //   }
  // } // end method

} // end component
