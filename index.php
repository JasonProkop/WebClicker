<?php
	require_once('functions.php');
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

		<style type='text/css'>
		/* Style sheet to restrict the page on large browsers */

		html { background-color: #333; }
		/* this line detects browsers which have a minimum width of 600
		 * pixels and only applies the changes to them */
		@media only screen and (min-width: 600px){
		    .ui-page {
			width: 600px !important;
			margin: 0 auto !important;
			position: relative !important;
			border-right: 5px #666 outset !important;
			border-left: 5px #666 outset !important;
		    }
        }
</style>
	</head>
<body>

<section id="homepage" data-role="page" >
	<header data-role="header" data-position="fixed">
		<h1>
		Web Clicker
		</h1>
		<a href="#popupMenu" data-rel="popup" data-role="button" class="ui-btn-right" data-inline="true" data-transition="pop" data-icon="gear" data-theme="b" data-position-to="origin">Options...</a>
	<div data-role="popup" id="popupMenu" data-theme="d" data-overlay-theme="b">
        <ul data-role="listview" data-inset="true" style="min-width:160px;" data-theme="d" >
            <li data-role="divider" data-theme="b">Choose an option</li>
            <li><a href="#signUpPage">Sign Up!</a></li>
            <li><a href="#signInPage">Sign In</a></li>
            <li><a href="toy.php" data-ajax="false">Feedback</a></li>
        </ul>
	</div>
</header><!-- /header -->
		<div data-role="popup" id="popupMenu" data-theme="d" data-overlay-theme="b">
			<ul data-role="listview" data-inset="true" style="min-width:160px;" data-theme="d" >
				<li data-role="divider" data-theme="b">Choose an option</li>
				<?php
				$user = loggedInUser();
				if($user === 'anonymous'){
					echo '<li><a href="#signUpPage"><h4>Sign Up!</h4></a></li>
						<li><a href="#signInPage">Sign In</a></li>
						<li><a href="#">Feedback</a></li>';
				}else{
					echo '<li>Welcome '.$user.'!</li>
						<li><a href="signout.php" data-ajax="false"><h4>Sign Out</h4></a></li>
						<li><a href="#">Feedback</a></li>';
				}
				?>
			</ul>
		</div>
	</header><!-- /header -->
	<div>
		<article data-role="content" >
			<h3>
				Create polls and vote in seconds!
			</h3>
		<a href="createQuestion.php" data-role="button" data-icon="check" data-ajax="false" >
			<h1>
				Create a poll!
			</h1>
		</a>
		<h3>
			Find polls quickly, by name or ID!
		</h3>
    <a href="#searchMenu" data-rel="popup" data-role="button" data-icon="search" data-transition="pop" data-theme="b" >
    Search Poll From Here!
		</a>
    
	<div data-role="popup" id="searchMenu" data-theme="a" data-overlay-theme="b">
		<form action="search.php" method="POST" data-ajax="false">
			<h3>Input the ID of Poll, </h3>
			<h3>It is a 5 character string of numbers/letters.</h3>
		  <div data-role="fieldcontain">
			<label for="textinput1">
			  Access Code:
			</label>
			<input name="accessCode" id="textinput1" placeholder="49d2" value="">
		  </div>
		</form>
          <p> </p>
	</div>
    
    <a href="toy.php" data-role="button" data-icon="edit" data-ajax="false">
      Poll Example/FeedBack
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
        <label for="email">
          Email
        </label>
        <input name="email" id="email" placeholder="email@example.com" value=""
        type="email" required>
      </div>
      <div data-role="fieldcontain">
        <label for="account">
          Account Name (optional)
        </label>
        <input name="account" id="account" placeholder="Alternative to email for sign in" value=""
        type="text">
      </div>
      <div data-role="fieldcontain">
        <label for="alias">
          Default Alias (optional)
        </label>
        <input name="alias" id="alias" placeholder="Your default public name" value=""
        type="text">
      </div>
      <div data-role="fieldcontain">
        <label for="password">
          Password
        </label>
        <input name="password" id="password" placeholder="" value="" type="password" required>
      </div>
      <div data-role="fieldcontain">
        <label for="passwordconfirmation">
          Confirm Password
        </label>
        <input name="passwordconfirmation" id="passwordconfirmation" placeholder="" value="" type="password" oninput="confirmPass(this)" required>
        <script language='javascript' type='text/javascript'>
          function confirmPass(input) {
              if (input.value != document.getElementById('password').value) {
                  input.setCustomValidity('The two passwords must match.');
              } else {
                  // input is valid -- reset the error message
                  input.setCustomValidity('');
             }
          }
        </script>
      </div>
      <div id="checkboxes1" data-role="fieldcontain">
        <fieldset data-role="controlgroup" data-type="vertical" data-mini="true">
          <input id="checkbox1" name="subscribe" type="checkbox">
          <label for="checkbox1">
            Subscribe to email updates?
          </label>
        </fieldset>
      </div>
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
        <input name="email" id="textinput1" placeholder="email@example.com" value="">
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
