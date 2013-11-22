<?php 
	require_once('include/functions.php');
	signOut(); 
?>
<!doctype html>
<html>
<head>
  <title>
    WebClicker
  </title>
  <?php outputHeader(); ?>
</head>
<body>
<div data-role="page" id="signInPage"  data-title="WebClicker - Sign In" data-theme='a'>
  <div data-role="header">
    <h3>
      Sign In
    </h3>
    <span class="error"><?php currentError(); ?></span>
	<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
  </div>
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
</div><!-- Sign In -->
</body>
</html>