<!-- 	WebClicker.tk/about.php
	Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
	This page contains information about website statistics and the developers.
--> 

<?php
	require_once('include/functions.php'); //runs session code and gives us access to all functions defined in the file.	
	
	/* Displays a list of our site date which includes: Number of Users, Polls, Questions, and Responses.
	Authored by: Dylan */
	
	function displaySiteStats()
	{
	  try
	  {
	    $db    = db_getpdo();
	    $stats = new SiteStats($db);
	    echo "<li>$stats->Users Users</li>";
	    echo "<li>$stats->Polls Polls</li>";
	    echo "<li>$stats->Questions Questions</li>";
	    echo "<li>$stats->Responses Responses</li>";
	    echo "<li>$stats->Groups Groups</li>";
	    echo "<li>" . sprintf("%.2f%%", $stats->Percentage * 100) . " Total Response Grade</li>";
	  }
	  catch (PDOException $e)
	  {
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
			<?php drawHeader(); ?> <!-- Page - About page contains information about the website and its developers -->
			<div data-role="collapsible" data-collapsed="true">
				<h1>Members - Group 04</h1> <!-- Members - List all the developers with their gravatars -->
				<ul data-role="listview">
					<li><a href="https://github.com/MaxGoo"><img src="<?php
							$url = getGravatar(80, "maxgooding@gmail.com");
							echo $url; ?>" alt="Max Gooding"/><h3>Max Gooding</h3><p>Github</p></a></li>
					<li><a href="https://github.com/BradySmith"><img src="<?php
							$url = getGravatar(80, "brady_smith87@hotmail.com");
							echo $url; ?>" alt="Brady Smith"/><h3>Brady Smith</h3><p>Github</p></a></li>
					<li><a href="https://github.com/JasonProkop"><img src="<?php
							$url = getGravatar(80, "jasonprokop@gmail.com");
							echo $url; ?>" alt="Jason Prokop"/><h3>Jason Prokop</h3><p>Github</p></a></li>
					<li><a href="https://github.com/fafmaster"><img src="<?php
							$url = getGravatar(80, "fafmaster@hotmail.com");
							echo $url; ?>" alt="Dylan Fafard"/><h3>Dylon Fafard</h3><p>Github</p></a></li>
					<li><a href="https://github.com/zillionk"><img src="<?php
							$url = getGravatar(80, "zillionk1973@gmail.com");
							echo $url; ?>" alt="Bo Dong"/><h3>Bo Dong</h3><p>Github</p></a></li>
				</ul>
			</div><!-- /Members End -->
			<div data-role="collapsible" data-collapsed="true">
				<h1>Project Plan</h1> <!-- Project Plan - States the plan in the sccope of the CMPT370 project -->
					Our plan is to make an accessible, easy to use online polling system to allow presenters to interact with their audience. The idea came from the desire to replace the clicker system that is used by most universities at the present time. Our polling system will differ from the current system by two main factors. Firstly, our design will be implemented through online services meaning it will be accessible from any online capable device. Second, because our interface will be implemented through a programmable graphical interface, we have more options when it comes to input. For example, instead of using hardware with limited input, our interface will allow text answers, drop down menus, sliding opinion polls, and always allow new interfaces to be designed. This system has obvious uses in the lecture setting, and can also be used on a wider scale for polls or surveys that concern a larger population.
			</div><!-- /Project Plan End -->
			<div data-role="collapsible" data-collapsed="false">
				<h1>Links</h1> <!-- Links - links that user may be interested in regarding the developers and the website. -->
					<a href="https://github.com/JasonProkop/cmpt370/" data-role="button" data-ajax="false">Our GitHub</a>
					<a href="poll_take.php?accessCode=twx29" data-role="button" data-ajax="false">Feedback Poll</a>
			</div><!-- /Links End -->
			<div data-role="collapsible" data-collapsed="false">
				<h1>Site Statistics</h1> <!-- Statistics - displays the statistics for the site, such as number of users, polls, responses etc. -->
				<ul data-role="listview">
					<?php displaySiteStats(); ?>
				</ul>
			</div><!-- /Statistics -->
			<img src="themes/images/wizardhat.gif">
			<?php outputFooter(); ?>
		</div><!-- /Page End -->
	</body>
</html>
