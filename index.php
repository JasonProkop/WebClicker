<?php
include_once('functions.php');
?>
<!doctype html>
<html>
<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<title>
			WebClicker
		</title>
		<link rel="stylesheet" href="themes/webclicker-usask.min.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>

		<!-- Looks like its deprecated, actually

			touchOverflow: Improved page transitions and true fixed toolbars
			 http://jquerymobile.com/demos/1.2.1/docs/pages/touchoverflow.html 
		<script>
			$(document).bind("mobileinit", function(){
	 		$.mobile.touchOverflowEnabled = true;
		});-->

	</script>
	</head>
<body>
<section id="homepage" data-role="page" >
	<header data-role="header" data-position="fixed">
		<h1>
		Web Clicker
		</h1>
		<?php errorHandler(); ?>
		<a href="#popupMenu" data-rel="popup" data-role="button" class="ui-btn-right" data-inline="true" data-transition="pop" data-icon="gear" data-theme="b" data-position-to="origin">Options...</a>
	<div data-role="popup" id="popupMenu" data-theme="d" data-overlay-theme="b">
        <ul data-role="listview" data-inset="true" style="min-width:160px;" data-theme="d" >
            <li data-role="divider" data-theme="b">Choose an option</li>
            <li><a href="#signUpPage"><h4>Sign Up!</h4></a></li>
            <li><a href="#signInPage">Sign In</a></li>
            <li><a href="#">Feedback</a></li>
        </ul>
	</div>
</header><!-- /header -->
	<div>
		<article data-role="content">
			<h3>
				Create polls and vote in seconds!
			</h3>
		<a href="#" data-role="button" data-theme="b" >
			<h1>
				Create a poll!
			</h1>
		</a>
			<h3>
				Find polls quickly, by name or ID!
			</h3>
		<a href="#" data-role="button" data-theme="b" >
			Search Poll From Here!
		</a>
	</div>
</section><!-- /page -->

<!-- SignUp-->
<div data-role="page" id="signUpPage">
  <div data-theme="a" data-role="header">
    <h3>
      Sign Up
    </h3>
  </div>
  <div data-role="content">
    <form action="signup.php" method="POST" data-ajax="false">
      <div data-role="fieldcontain">
        <label for="textinput1">
          Email / Login Name
        </label>
        <input name="email" id="textinput1" placeholder="email@example.com" value=""
        type="email">
      </div>
      <div data-role="fieldcontain">
        <label for="textinput3">
          Alias
        </label>
        <input name="alias" id="textinput3" placeholder="Your public name" value=""
        type="text">
      </div>
      <div data-role="fieldcontain">
        <label for="textinput2">
          Password
        </label>
        <input name="password" id="textinput2" placeholder="" value="" type="password">
      </div>
      <div id="checkboxes1" data-role="fieldcontain">
        <fieldset data-role="controlgroup" data-type="vertical" data-mini="true">
          <input id="checkbox1" name="subscribe" type="checkbox">
          <label for="checkbox1">
            Subscribe to email updates?
          </label>
        </fieldset>
      </div>
      <input type="submit" value="Submit">
    </form>
  </div>
</div>
  <!-- Sign In -->

<div data-role="page" id="signInPage">
  <div data-theme="a" data-role="header">
    <h3>
      Sign In
    </h3>
    
  </div>
  <div data-role="content">
  	<form action="signin.php" method="POST" data-ajax="false">
      <div data-role="fieldcontain">
        <label for="textinput1">
          Email / Login Name
        </label>
        <input name="email" id="textinput1" placeholder="email@example.com" value=""
        type="email">
      </div>
      <div data-role="fieldcontain">
        <label for="textinput2">
          Password
        </label>
        <input name="password" id="textinput2" placeholder="" value="" type="password">
      </div>
      <div id="checkboxes1" data-role="fieldcontain">
        <fieldset data-role="controlgroup" data-type="vertical" data-mini="true">
          <input id="checkbox1" name="remember" type="checkbox">
          <label for="checkbox1">
            Remember my login
          </label>
        </fieldset>
      </div>
      <input type="submit" value="Submit">
    </form>
  </div>
</div>
</body>
</html>