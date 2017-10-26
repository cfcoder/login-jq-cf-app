const validate_username = inUserName => {
  const min_len = 1;
  const max_len = 30;
  let success = false;

  console.log('Validating username');
  // must be > or = min_len and < or = max_len
  if(inUserName.length >= min_len && inUserName.length <= max_len) {
    success = true;
  }

  return success;
}


const validate_password = inPassword => {
  const min_len = 8;
  const max_len = 30;
  let success = false;

  console.log('Validating password');
  // must be > or = min_len and < or = max_len
  if(inPassword.length >= min_len && inPassword.length <= max_len) {
    success = true;
  }

  return success;
}
  
$(document).ready(function() {
  $('#signinbtn').prop('disabled', true);
  $("#login").show();
  $("#loggedin").hide();

  // on any keyup event, check if both inputs are non-empty then enable Sign in button
  $("input").keyup(function() {
    let userNameLen = $("#inputUserName").val().length;
    let passwordLen = $("#inputPassword").val().length;

    $("#submitSuccess").text('').hide();
    // check if both inputs have values
    if(userNameLen && passwordLen) {
      $('#signinbtn').prop('disabled', false);
    } else {
      $('#signinbtn').prop('disabled', true);
    } 
  });

  $("#signin").submit(function(e) {
    e.preventDefault();
    // get the form input values
    const inUserName = $("#inputUserName").val();
    const inPassword = $("#inputPassword").val();
    // now clear out the input fields
    $("#inputUserName").val('');
    $("#inputPassword").val('');
    // validate the inputs client side first
    let username_valid = validate_username(inUserName);
    let password_valid = validate_password(inPassword);
    // if either input invalid, flag it
    if(username_valid && password_valid) {
      console.log('Both valid, sending to the server');
      $("#login").hide();
      $("#loggedin").show();
    } else {
      $("#submitSuccess").text("There was a problem... invalid Username or Password.").show();
    }

  });

  $("#signoutbtn").click(function(event) {
    $("#login").show();
    $("#loggedin").hide();
  });

});
