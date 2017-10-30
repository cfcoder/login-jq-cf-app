component {
  /* 
  *  the constructor method 
  */
  public UserService function init() output="false" {
    this.dataService = createObject('component', 'services.user.dataService').init();  
    return this;
  }

  /* 
  * I check a string passed in to make sure it is valid for the USER table names.
  */
  private boolean function checkName(required string name) output="false" {
    var nameMaxLength = 30;
    var nameValid     = false;
    var trimName      = Trim(arguments.name);

    if( Len(trimName) > 0 and Len(trimName) <= nameMaxLength and isValid("string", trimName)) {
      nameValid = true;
    }

    return nameValid;
  }

  /*
  * I check a string passed in to make sure it is valid for the USER table username
  */
  public boolean function checkUsername(required string uname) output="false"{
    var unameMinLength = 5;
    var unameMaxLength = 30;
    var unameValid     = false;
    var unameTrim      = trim(arguments.uname);

    if( Len(unameTrim) > 0 
    and Len(unameTrim) >= unameMinLength 
    and Len(unameTrim) <= unameMaxLength 
    and isValid("string", unameTrim)) {
      unameValid = true;
    }

    return unameValid;
  }

  /*
  * I check a string passed in to make sure it is valid for the USER table password
  */
  public boolean function checkPassword(required string pword) output="false" {
    var pwordMinLength = 8;
    var pwordMaxLength = 30;
    var passwordValid  = false;
    var passwordTrim   = trim(arguments.pword);

    if( Len(passwordTrim) > 0 
    and Len(passwordTrim) >= pwordMinLength 
    and Len(passwordTrim) <= pwordMaxLength 
    and isValid("string", passwordTrim)) {
      passwordValid = true;
    }

    return passwordValid;
  }

  /* 
  * I trim the input user data passed in as a struct,
  */
  public struct function trimUserData(required struct user) output="false" {
    var userTrimmed = structNew();
    // If all form fields are present, check each for valid input
    if( IsDefined("user.firstname") ) userTrimmed.firstname = trim(user.firstname);
    if( IsDefined("user.lastname") )  userTrimmed.lastname  = trim(user.lastname);
    if( IsDefined("user.username") )  userTrimmed.username  = trim(user.username);
    if( IsDefined("user.password") )  userTrimmed.password  = trim(user.password);

    return userTrimmed;
  }


  /* 
  * I validate the user data passed in as a struct,
  */
  public boolean function validateUserData(required struct user) output="false" {
    // trim the input field data
    var userDataValid = false;

    // If all required form fields are present, check each for valid input
    if(   IsDefined("user.firstname") 
      AND IsDefined("user.lastname") 
      AND IsDefined("user.username") 
      AND IsDefined("user.password") 
    ){
      fnameValid = checkName(user.firstname);
      lnameValid = checkName(user.lastname);
      unameValid = checkUsername(user.username);
      pwordValid = checkPassword(user.password);
    }

    // Check to see if a valid user was returned
    if(fnameValid and lnameValid and unameValid and pwordValid) {
      userDataValid = true;
    }
    return userDataValid;
  }

}