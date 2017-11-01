# login-jq-cf-app

## Description:
This is a simple login authentication app made with Coldfusion (2016) but using jQuery to manage the authentication of the login information submission. It sends the login and logout form data to a ColdFusion component (CFC) for authentication against a mySQL database. The built-in CF ORM (Hibernate) is used for all database communication.

This is a coding exercise I worked on for Enviance, hence you will see their name in a couple of places.

## Features:
* Integration of a CFM/JavaScript/jQuery frontend with a CFC backend
* MySQL database used for storing of the User and Authentication details
* ORM used for database transactions
* Form posts (login and logout) handled by jQuery listeners and AJAX for posting to the backend
* A unique (per user) random 128 character Salt generated for the password Hash
* Password Hash (SHA-512) conversion with hashed Salt repeated many times for added security
* Hashed password and salt are stored for each user in the database
* Front and back end data validation of both username and password
* Once user login details are authenticated a session variable maintains the logged in state.
* User admin page for entry of new users and their login credentials.
* Index page contains both login form and the post-authenticated stub page with a logout button.

## Files:
* Enviance_full_10-31-17.sql - the MySQL file dump containing both the schema and data (2 records)
* index.cfm - the login page that contains both login and logout HTML content
* user_admin.cfm - a form for entering additional minimal user accounts
* service (dir) - contains the web service CFCs
	* api - contains a Base API and the main security API
	* user - contains the user and data services related to users
	* security - contains the auth and data services related to security
* js (dir) - contains both the bootstrap JS and my own JS file (main.js)
* css (dir) - contains the stylesheets files for the user_admin page (admin.css), login/logout page (style.css) and bootstrap
* entity (dir) - contains the CFC objects that define the ORM table properties

## Usage Notes:
* *It is imperative that the server this is placed on be configured to use SSL (https://) encrypted server requests for security of the password being transferred as plain text. If this is not done, all entered login passwords are vulnerable to compromise!*
* Login input requirements:
	* Username length: min 1 char, max 30 chars
	* Password length: min 8 chars, max 30 chars
* Database data max length restrictions:
	* NOTE: This was outside the scope of this project and so no validation is made to enforce this currently.
	* First and Lastname: 30 chars
	* Username: 80 chars
	* Hashed Password and Salt: 160  (SHA512 returns 128 char string, so room to grow if needed
	* Unique record IDs: 11 digit integer

## Credits:
Thanks to some dated but still excellent articles on the topic of login security:
* Jason Dean's blog posting of a CF example for implementing password security: http://www.12robots.com/index.cfm/2008/6/2/User-Login-with-Salted-and-Hashed-passwords--Security-Series-45
* StackExchange Security posting on hashing passwords securely: https://security.stackexchange.com/questions/211/how-to-securely-hash-passwords/31846
* StackOverflow  post on login security: https://stackoverflow.com/questions/549/the-definitive-guide-to-form-based-website-authentication/477578
