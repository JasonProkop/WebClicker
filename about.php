<?php
require_once('functions.php'); //runs session code and gives us access to all functions defined in the file.

/*
	Displays a list of our site date which includes: Number of Users, Polls, Questions, and Responses.
	Authored by: Dylan
*/
function displaySiteStats(){
	try{
		$stats = new SiteStats(db_getpdo());
		echo "<li>$stats->Users Users</li>";
		echo "<li>$stats->Polls Polls</li>";
		echo "<li>$stats->Questions Questions</li>";
		echo "<li>$stats->Responses Responses</li>";
		echo "<li>$stats->Groups Groups</li>";
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		redirectTo('error.php');
	}
}
?>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<title>WebClicker</title>
		<link rel="stylesheet" href="themes/webclicker-usask.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
	</head>
<body>
	<div id="homepage" data-role="page" data-title="WebClicker - About Us">
		<header data-role="header"  data-tap-toggle="false">
			<h1>Web Clicker - About Us</h1>
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
		</header><!-- /header -->
		<div data-role="collapsible" data-collapsed="true">
			<h1>Members - Group 04</h1>
			<ul data-role="listview">
				<li>Max Gooding</li>
				<li>Brady Smith</li>
				<li>Jason Prokop</li>
				<li>Dylan Fafard</li>
				<li>Bo Dong</li>
			</ul>
		</div><!-- /members -->
		<div data-role="collapsible" data-collapsed="true">
			<h1>Project Plan</h2>
			Our plan is to make an accessible, easy to use online polling system to allow presenters to interact with their audience. The idea came from the desire to replace the clicker system that is used by most universities at the present time. Our polling system will differ from the current system by two main factors. Firstly, our design will be implemented through online services meaning it will be accessible from any online capable device. Second, because our interface will be implemented through a programmable graphical interface, we have more options when it comes to input. For example, instead of using hardware with limited input, our interface will allow text answers, drop down menus, sliding opinion polls, and always allow new interfaces to be designed. This system has obvious uses in the lecture setting, and can also be used on a wider scale for polls or surveys that concern a larger population.
		</div><!-- /plan -->
		<div data-role="collapsible" data-collapsed="false">
			<h1>Links</h2>
			<a href="https://github.com/JasonProkop/cmpt370/" data-role="button">Our Gitub</a>
		</div><!-- /links -->
		<div data-role="collapsible" data-collapsed="false">
			<h1>Site Statistics</h1>
			<ul data-role="listview">
				<?php displaySiteStats(); ?>
			</ul>
		</div><!-- /statistics -->
	</div><!-- /page -->
</body>
</html>
