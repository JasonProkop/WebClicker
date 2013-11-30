<!--  WebClicker.tk/group_manage.php
  Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
This page is where a signed up user would go to sign 
--> 

<?php 
	require_once('include/functions.php');
?>

<!doctype html>
<html>
  <head>
    <title>WebClicker</title>
    <?php boilerPlate(); ?>
  </head>
  <body>
  <div data-role="page" id="signInPage"  data-title="WebClicker - Sign In" data-theme='a'>
  	<?php drawHeader(); ?>
    <div data-role="content">
    	<form action="control/user_signin.php" method="POST" data-ajax="false">
        <div data-role="fieldcontain">
          <label for="textinput1">
            Email / Login Name
          </label>
          <input name="email" id="textinput1" placeholder="email@example.com" value="">
        </div>
        <div data-role="fieldcontain">
          <label for="textinput2">
            Password
          </label>
          <input name="password" id="textinput2" placeholder="" value="" type="password">
        </div>
        <input type="submit" value="Submit">
      </form>
    </div>
    <?php outputFooter(); ?>
  </div><!-- Sign In -->
  </body>
</html>