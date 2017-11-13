<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Enviance Demo User Admin</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link href="css/admin.min.css" rel="stylesheet">
  </head>

  <body>
    <cfscript>
      // create required cfc objects used below
      variables.UserService = new service.user.UserService().init();
      // variables.DataService = new service.user.DataService().init();
    </cfscript>

    <div id="user" class="container text-center">
      <cfscript>
        // If the form is not empty, it has been posted
        if(isDefined("form") and not structIsEmpty(form)) {
          user = variables.UserService.trimUserData(form); // trim leading/trailing spaces from inputs

          userDataValid = variables.UserService.validateUserData(user); // validate the input data
          if( userDataValid ) {
            // variables.DataService.addUser(user.firstname, user.lastname, user.username, user.password);
            retval = invoke('service.user.DataService', 'addUser', {
              firstname = user.firstname,
              lastname = user.lastname,
              username = user.username,
              password = user.password
            });
          }
          else {
            errorMessage = "Invalid input"; // set an error msg
          }
        }
      </cfscript>
  

      <img src="img/EnvianceLogo.png" />
      <!--- If there is an error message, display it --->
      <cfif IsDefined("errorMessage") AND Len(errorMessage)>
        <div id="errormsg">
          <cfoutput>#errorMessage#</cfoutput>
        </div>
      </cfif>

      <form id="user" class="form" method="post" action="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>">
        <h2 class="form-signin-heading text-center">User Admin</h2>
        <div class="form-group">
          <label for="inputFirstName" class="sr-only">First Name</label>
          <input name="firstname" type="text" id="inputFirstName" class="form-control" placeholder="First Name" required autofocus>
        </div>
        <div class="form-group">
          <label for="inputLastName" class="sr-only">Last Name</label>
          <input name="lastname" type="text" id="inputLastName" class="form-control" placeholder="Last Name" required autofocus>
        </div>
        <div class="form-group">
          <label for="inputUserName" class="sr-only">Username</label>
          <input name="username" type="text" id="inputUserName" class="form-control" placeholder="Username" required autofocus>
        </div>
        <div class="form-group">
          <label for="inputPassword" class="sr-only">Password</label>
          <input name="password" type="password" id="inputPassword" class="form-control" placeholder="Password" value="" autocomplete="off" required>
        </div>
        <div class="form-group">
          <!--- <button id="submitbtn" class="btn btn-lg btn-primary btn-block" type="submit">Submit</button> --->
          <input type="submit" id="submitbtn" class="btn btn-lg btn-primary btn-block">
        </div>
      </form>
    </div> <!-- end user container -->

    <!--- <div id="users" class="container text-center">
      <h2>List of users</h2>
      <div id="userlist" class="text-center">
        <cfset users = entityLoad( "users", {})>
        <cfoutput>
        <cfloop array="#users#" index="user">
            <h4>#user.id# #user.firstName# #user.lastname# </h4>
            <cfif user.hasUserAuth()>
                <ul>
                    <cfloop array="#userAuth.getUserAuth()#" index="uAuth">
                        <li>#uAuth.id# #uAuth.username#</li>
                    </cfloop>
                </ul>
            </cfif>
        </cfloop>
        </cfoutput>
      </div>
    </div> ---> <!-- end users container -->

    <!-- jQuery and Bootstrap core JavaScript ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!--- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script> -->
    <script src="js/bootstrap.js"></script> --->
  </body>
</html>


