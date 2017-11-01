const validate_username = inUserName => {
  const min_len = 1;
  const max_len = 30;
  let success = false;

  // must be > or = min_len and < or = max_len
  if(inUserName.length >= min_len && inUserName.length <= max_len) {
    success = true;
  }
  return success;
};


const validate_password = inPassword => {
  const min_len = 8;
  const max_len = 30;
  let success = false;

  // must be > or = min_len and < or = max_len
  if(inPassword.length >= min_len && inPassword.length <= max_len) {
    success = true;
  }
  return success;
};

const post_login = (username, pword) => {

  $.ajax({
    type: 'POST',
    url: './service/api/Security.cfc',
    dataType: 'JSON',
    data: {
        'method':'postLogin',
        'uname': (username),
        'pword': (pword)
    },
    success: function(response, status, jqXHR) {
      // console.log(response);
      if(response.ERROR.length) {
        $("#submitResponse").html("There was a problem... " + response.ERROR).show();
      }
      else {
        // now clear out the input fields
        $("#inputUserName").val('');
        $("#inputPassword").val('');

        // set data attr for logged in ok and change page content displayed
        $('#login').attr('data-logged', '1');
        $("#login").hide();
        $("#loggedin").show();
      }
    }
    // ,
    // error: function(xhr, textStatus, errorThrown) {
    //   console.log(errorThrown);
    // }
  });
};

const post_logout = () => {
  console.log('posting to logout');
  
  $.ajax({
    type: 'POST',
    url: './service/api/Security.cfc',
    dataType: 'JSON',
    data: {'method':'postLogout'},
    success: function(response, status, jqXHR) {
      // check if we got the logged in string back from the server
      if(response.DATA === 'logged-out') {
        $('#login').attr('data-logged', '0');
        // change page content displayed
        $("#login").show();
        $("#loggedin").hide();
      }
      else {
        $("#submitResponse").html("There was a problem... " + response.ERROR).show();
      }
    }
  });
};

$(document).ready(function() {
  $('#signinbtn').prop('disabled', true);

  if( $('#login').attr('data-logged') === '1') {
    $("#login").hide();
    $("#loggedin").show();
  }
  else {
    $("#login").show();
    $("#loggedin").hide();
  }

  // on any keyup event, check if both inputs are non-empty then enable Sign in button
  $("input").keyup(function(e) {
    let userNameLen = $("#inputUserName").val().length;
    let passwordLen = $("#inputPassword").val().length;
    let code = e.which;
    
    // clear out the response message if any when keys other than enter are pressed
    if($("#submitResponse").html() !== '&nbsp;' && code !== 13) {
      $("#submitResponse").html('&nbsp;');
    }

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
    // validate the inputs client side first
    let userNameOK = validate_username(inUserName);
    let passwordOK = validate_password(inPassword);

    // if either input invalid, flag it
    if(userNameOK && passwordOK) {
      // send a post request
      post_login(inUserName, inPassword);

    } else {
      $("#submitResponse").html("There was a problem... invalid Username or Password.<br />Username max length: 30<br />Password min length: 8").show();
    }

  });

  $("#signoutbtn").click(function(event) {
    post_logout();
  });

});
