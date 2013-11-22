<?php
	require_once('include/functions.php');
	include_once('include/db.php');
	
	$user = loggedInUser();
	if($user === 'anonymous'){
		$icon = 'alert';
		$header = '<h1>You are not logged in.</h1>';
		$content = '<h4>Any polls you create or take will be public and anonymous.</h4>';
		$links = '<a href="user_signup.php" data-role="button" data-mini="true" data-ajax="false">Sign Up</a><a href="user_signin.php" data-role="button" data-mini="true" data-ajax="false">Sign In</a>';
	}else{
		$icon = 'star';
		$header = '<h1>You are logged in as: '.$user.'</h1>';
		$content = '<h4>Polls you create will not be listed on the main page and you may only take a poll once.</h4>';
		$links = '<a href="group_manage.php" data-role="button" data-mini="true" data-ajax="false">Poll/Group Management</a>';
		$links .= '<a href="group_feed.php" data-role="button" data-mini="true" data-ajax="false">Group Subscriptions</a>';
		$links .= '<a href="control/user_signout.php" data-role="button" data-mini="true" data-ajax="false">Sign Out</a>';
	}
?>
<!doctype html>
<html>
	<head>
	  <title>WebClicker</title>
	  <?php outputHeader(); ?>
	</head>
	<body>
		<div id="homepage" data-role="page" data-title="WebClicker - homepage" data-theme='a'>
			<header data-role="header" data-position="fixed" data-tap-toggle="false">
				<img border="0" src="<?php $gravURL = getGravatarURL(42); echo $gravURL; ?>" alt="gravatar" style="float:right;display:inline"/>
				<h1>Web Clicker</h1>
			</header><!-- /header -->
			<div data-role="collapsible">
				<?php 
					echo $header;
					echo $content;
					echo $links;
				?>
				
			</div>
			<div data-role="content" style="margin:0 auto;margin-left:auto;margin-right:auto;align:center;text-align:center;width:70%">
				<a href="poll_create.php" data-role="button" data-icon="check" data-ajax="false" >
					<h1>Create a Poll</h1>
				</a>
			</div>
			<div data-role="collapsible" data-collapsed="false">
				<h3>Find poll by Access Code</h3>
				<form action="poll_search.php" method="POST" data-ajax="false">
					  <input name="accessCode" id="accessCode" placeholder="Eg: axd21" data-inline="true">
				</form>
			</div>
			<div data-role="collapsible" data-collapsed="false">
			  <h3>Latest Public Polls</h3>
				<ul data-role="listview" data-filter="true" data-inset="true">
					<?php displayRecentPolls(db_getpdo()); ?>
				</ul>
			</div>
			<div data-role="collapsible">
			  <h3>Feedback</h3>
				<div class="ui-grid-a">
					<div class="ui-block-a"><a href="poll_take.php?accessCode=twx29" data-role="button" data-ajax="false">Feedback Poll</a></div>
					<div class="ui-block-b"><a href="about.php" data-role="button" data-ajax="false">About us</a></div>
				</div>
			</div>
			<div data-role="footer" data-position="fixed" data-tap-toggle="false">		
		<div data-role="navbar" data-iconpos="top">
			<ul>
				<li><a href="index.php" data-icon="home">Home</a></li>
				<li><a href="create.php" data-icon="plus">Create New Poll</a></li>
				<li><a href="#" data-icon="gear">Edit Profile</a></li>
				<li><a href="groupfeed.php" data-icon="grid">Manage Groups</a></li>
				<li><a href="about.php" data-icon="home">About Us</a></li>
			</ul>
		</div><!-- /navbar -->
		</div><!-- /page -->
	</body>
</html>
<?php $_SESSION['error'] = ''; ?>
