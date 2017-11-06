<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Enviance Demo Login</title>
    <link type="text/css" href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link type="text/css" href="css/style.min.css" rel="stylesheet">
  </head>

  <body>

    <div id="submitResponse" class="text-center">&nbsp;</div>

		<div id="login" class="container text-center" data-logged="<cfoutput><cfif isDefined('session.userAuthorized')>#session.userAuthorized#<cfelse>0</cfif></cfoutput>" style="display:none">
      <img src="img/EnvianceLogo.png" />

      <form id="signin" class="form-signin" method="post" action="javascript:alert('success!');">
        <h2 class="form-signin-heading text-center">System Login</h2>
        <div class="form-group">
          <label for="inputUserName" class="sr-only">Username</label>
          <input type="text" id="inputUserName" class="form-control" placeholder="Username" required autofocus>
        </div>
        <div class="form-group">
          <label for="inputPassword" class="sr-only">Password</label>
          <input type="password" id="inputPassword" class="form-control" placeholder="Password" value="" autocomplete="off" required>
        </div>
        <div class="form-group">
          <button id="signinbtn" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        </div>
      </form>
    </div> <!-- end login container -->

    <div id="loggedin" class="container text-center">
      <h2>You are in</h2>
      <div id="signout" class="text-center">
        <button id="signoutbtn" class="btn btn-lg btn-primary btn-block" type="submit">Sign out</button>
      </div>
    </div> <!-- end loggedin container -->

    <!-- jQuery and Bootstrap core JavaScript ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script> -->
    <script src="js/bootstrap.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>


