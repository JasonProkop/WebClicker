<?php
	require_once('include/functions.php'); //runs session code and gives us access to all functions defined in the file.

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
		echo "<li>".sprintf("%.2f%%", $stats->Percentage * 100)." Total Response Grade</li>";
	}catch(PDOException $e){
		$_SESSION['error'] = $e->getMessage();
		redirectTo('error.php');
	}
}
?>
<!doctype html>
<html>
	<title>WebClicker - About</title>
	<?php boilerPlate(); ?>
<body>
	<div id="homepage" data-role="page" data-title="WebClicker - About Us" data-theme='a'>
		<?php drawHeader(); ?>
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
			<a href="take_poll.php?accessCode=twx29" data-role="button">Feedback Poll</a>
		</div><!-- /links -->
		<div data-role="collapsible" data-collapsed="false">
			<h1>Site Statistics</h1>
			<ul data-role="listview">
				<?php displaySiteStats(); ?>
			</ul>
		</div><!-- /statistics -->
		<?php outputFooter(); ?>
	</div><!-- /page -->
</body>
</html>
