// let chai = require('chai');
// // let $ = require('jquery');
// //let jsdom = 
// require('jsdom-global')();
// global.$ = global.jQuery = require('jquery');

// // let tf = require('../js/main.js');

// // in the browser
// window.module = {}; 
// jQuery.extend(window, module.exports);
// // or 
// if (typeof exports !== 'undefined'){ exports.testFunction = testFunction }



let assert = chai.assert;
let should = chai.should();

describe('Tests for main.js', function() {

  describe('validate_username function', function() {
    it('should return a value that is of type boolean', function() {
      var uname = 'joecool';
      var unameOk = validate_username(uname);
      assert(typeof(unameOk) === 'boolean', 'type ' + typeof(unameOk) + ' returned');
    });

    it('should return true when username is of type string', function() {
      var uname = 'abc';
      var unameOk = validate_username(uname);
      assert.isTrue(unameOk, 'username is of type ' + typeof(uname));
    });  

    it('should return false when username contains invalid chars', function() {
      var uname = ['a', 'b', 'c'];
      var unameOk = validate_username(uname);
      assert.isFalse(unameOk, 'username ' + uname + ' is of type ' + typeof(uname));
    });

    it('should return false when the length of username is 0', function() {
      var unameOk = validate_username('');
      assert.isFalse(unameOk, 'length is non-zero');
    });

    it('should return false when the length of username is > 30', function() {
      var uname = 'abcdefghijklmnopqrstuvwxyz12345';
      var unameOk = validate_username(uname);
      assert.isFalse(unameOk, 'length is ' + uname.length);
    });

    it('should return true when the length of username is between 1 and 30', function() {
      var uname = 'abcdefghijklmnopqrstuvwxyz1234';
      var unameOk = validate_username(uname);
      assert.isTrue(unameOk, 'length is ' + uname.length);
    });
  });

  describe('validate_password function', function() {
    it('should return a value that is of type boolean', function() {
      var pw = 'bondathon';
      var pwOk = validate_password(pw);
      assert(typeof(pwOk) === 'boolean', 'type ' + typeof(pwOk) + ' returned');
    });

    it('should return true when password is of type string', function() {
      var pw = 'bellyjelly';
      var pwOk = validate_password(pw);
      assert.isTrue(pwOk, 'password is of type ' + typeof(pw));
    });  

    it('should return false when password contains invalid chars', function() {
      var pw = {pw:'foobarbaby'};
      var pwOk = validate_password(pw);
      assert.isFalse(pwOk, 'password ' + pw + ' is of type ' + typeof(pw));
    });

    it('should return false when the length of password is 0', function() {
      var pwOk = validate_password('');
      assert.isFalse(pwOk, 'length is non-zero');
    });

    it('should return false when the length of password is > 30', function() {
      var pw = 'abcdefghijklmnopqrstuvwxyz12345';
      var pwOk = validate_password(pw);
      assert.isFalse(pwOk, 'length is ' + pw.length);
    });

    it('should return true when the length of password is between 1 and 30', function() {
      var pw = 'abcdefghijklmnopqrstuvwxyz1234';
      var pwOk = validate_password(pw);
      assert.isTrue(pwOk, 'length is ' + pw.length);
    });
  });

  describe('post_login function', function() {
    beforeEach(function() {
      this.xhr = sinon.useFakeXMLHttpRequest();

      this.requests = [];
      this.xhr.onCreate = function(xhr) {
        this.requests.push(xhr);
      }.bind(this);
    });

    afterEach(function() {
      this.xhr.restore();
    });

    if('should parse fetched data as JSON', function(done) {
      var data = {
        'method':'postLogin',
        'uname': 'opportunities@ourholm.com',
        'pword': 'asdfasdf'
      };
      var dataJson = JSON.stringify(data);

      // post_login()

    });


    // it('', function(done) {
    //   setTimeout(function() {
    //     console.log("timeout!");
    //     done();
    //   }, 3000);
    // });



  });    

});