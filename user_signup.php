<!--  WebClicker.tk/group_manage.php
  Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
Users will be directed to this page if they wish to sign up. They will need to enter
there details and will thne be redirected back to where they came from after they submit
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
	<!-- SignUp-->
		<div data-role="page" id="signUpPage" data-title="WebClicker - Sign Up" data-theme='a'>
			<?php drawHeader(); ?>
		  <div data-role="content">
			<h1>Sign Up</h1>
			<span class="error"><?php currentError(); ?></span>
		  </div>
		  <div data-role="content">
				<form action="control/user_signup.php" method="POST" data-ajax="false">
				   <div data-role="fieldcontain">
						<label for="email">Email</label>
						<input name="email" id="email" placeholder="email@example.com" value=""btype="email" required>
				  </div>
				  <div data-role="fieldcontain">
						<label for="alias">Default Alias (optional)</label>
						<input name="alias" id="alias" placeholder="Your default public name" value="" type="text">
				  </div>
				  <div data-role="fieldcontain">
						<label for="password">Password</label>
						<input name="password" id="password" placeholder="" value="" type="password" required>
				  </div>
				  <div data-role="fieldcontain">
						<label for="passwordconfirmation">Confirm Password</label>
						<input name="passwordconfirmation" id="passwordconfirmation" placeholder="" value="" type="password" oninput="confirmPass(this)" required>
						<script language='javascript' type='text/javascript'>
						// Checks to see if the confirmation password matches the one entered previously
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
		  <?php outputFooter(); ?>
		</div>
	</body>
</html>