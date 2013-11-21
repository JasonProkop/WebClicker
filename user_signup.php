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
<!-- SignUp-->
	<div data-role="page" id="signUpPage" data-title="WebClicker - Sign Up" data-theme='a'>
	  <div data-role="header">
		<h3>
		  Sign Up
		</h3>
		<span class="error"><?php echo currentError(); ?></span>
		<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
	  </div>
	  <div data-role="content">
		<form action="control/user_signup.php" method="POST" data-ajax="false">
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
</body>
</html>