<?php
	require_once('functions.php');
	$user = loggedInUser();
	if($user === 'anonymous'){
		$icon = 'alert';
		$header = '<h1>You are not logged in.</h1>';
		$content = '<h4>Any polls you create or take will be public and anonymous.</h4>';
		$links = '<a href="#signUpPage" data-role="button" data-mini="true">Sign Up</a><a href="#signInPage" data-role="button" data-mini="true">Sign In</a>';
	}else{
		$icon = 'star';
		$header = '<h1>You are logged in as: '.$user.'</h1>';
		$content = '<h4>Polls you create will not be listed on the main page and you may only take a poll once.</h4>';
		$links = '<a href="user.php" data-role="button" data-mini="true" data-ajax="false">Poll/Group Management</a>';
		$links .= '<a href="groupfeed.php" data-role="button" data-mini="true" data-ajax="false">Group Subscriptions</a>';
		$links .= '<a href="signout.php" data-role="button" data-mini="true" data-ajax="false">Sign Out</a>';
	}
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
		<link rel="stylesheet" href="themes/WebClicker_main.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
	</head>
<body>

<section id="homepage" data-role="page" data-title="WebClicker - homepage" data-theme='a'>
	<header data-role="header"  data-tap-toggle="false">
		<h1>Web Clicker</h1>
	</header><!-- /header -->
	<div data-role="collapsible">
		<?php 
			echo $header;
			echo $content;
			echo $links;
		?>
		
	</div>
	<div data-role="content">
		<a href="create.php" data-role="button" data-icon="check" data-ajax="false" >
			<h1>Create a Poll</h1>
		</a>
	</div>
	<div data-role="collapsible">
		<h3>Find poll by Access Code</h3>
		<form action="search.php" method="POST" data-ajax="false">
			  <input name="accessCode" id="accessCode" placeholder="Eg: axd21" data-inline="true">
		</form>
	</div>
	<div data-role="collapsible">
	  <h3>Latest Public Polls</h3>
		<ul data-role="listview" data-filter="true" data-inset="true">
			<?php displayRecentPolls(); ?>
		</ul>
	</div>
	<div data-role="collapsible">
	  <h3>Feedback</h3>
		<div class="ui-grid-a">
			<div class="ui-block-a"><a href="poll.php?accessCode=amo24" data-role="button" data-ajax="false">Feedback Poll</a></div>
			<div class="ui-block-b"><a href="about.php" data-role="button" data-ajax="false">About us</a></div>
		</div>
	</div>
</section><!-- /page -->

<!-- SignUp-->
<div data-role="page" id="signUpPage" data-title="WebClicker - Sign Up" data-theme='a'>
  <div data-theme="a" data-role="header">
    <h3>
      Sign Up
    </h3>
	<span class="error"><?php echo currentError(); ?></span>
	<a href="index.php#homepage"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home</a>
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
	  <input type="submit" value="Submit">
    </form>
  </div>
</div>
  <!-- Sign In -->

<div data-role="page" id="signInPage"  data-title="WebClicker - Sign In" data-theme='a'>
  <div data-theme="a" data-role="header">
    <h3>
      Sign In
    </h3>
    <span class="error"><?php echo currentError(); ?></span>
	<a href="index.php#homepage"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home</a>
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
      <input type="submit" value="Submit">
    </form>
  </div>
</div>
</body>
</html>
<?php $_SESSION['error'] = ''; ?>