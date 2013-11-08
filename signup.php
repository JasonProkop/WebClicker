<?php
include_once('functions.php');

if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password']) && isset($_POST['alias']) && isset($_POST['account'])){
	try{
		signUp($_POST['email'], $_POST['password'], $_POST['alias']);
		//$message = 'We have sent you an authorization e-mail. Please check your junk/spam folders and follow the link provided in the e-mail to login to your account.';
		header("location:index.php#signInPage");
	}catch(Account $e){
		//echo "Caught Account ('{$e->getMessage()}')\n{$e}\n";
		global $_ERROR = $e->getMessage();
		header("location:index.php#signUpPage");
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		global $_ERROR = $e->getMessage();
		header("location:error.php");
	}
}else{
	header("location:index.php");
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
		<link rel="stylesheet" href="themes/webclicker-usask.min.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>

	</head>
<body>
<section id="homepage" data-role="page" >
	<?php generateHeader(); ?>
	<div>
		<article data-role="content" >
			<h3>
				
			</h3>
	</div>
</section><!-- /page -->
</body>
</html>