<?php
	require_once('include/functions.php');
	include_once('include/db.php');
	try{
		$db = db_getpdo();
	}catch(PDOException $e){
		$_SESSION['error'] = $e->getMessage();
		header('Location:error.php');
	}
?>
<!doctype html>
<html>
	<head>
	  <?php boilerPlate(); ?>
	  
	</head>
	<body>
		<div id="homepage" data-role="page" data-title="WebClicker - homepage" data-theme='a'>
			<?php drawHeader(); ?>
			<div data-role="content">
 		
			<div data-role"content" div id="center_box" div style="margin:0 auto;margin-left:auto;margin-right:auto;align:center;text-align:center;width:75%">
				<h2>Welcome to Web Clicker!</h2>
				<p>Use the buttons at the bottom of the page to get started or check out one of these recently created polls.</p>
			</div>
			<div data-role="collapsible" data-collapsed="false">
			  <h3>Latest Public Polls</h3>
				<ul data-role="listview" data-inset="true">
					<?php displayRecentPolls($db); ?>
				</ul>
			</div>
				
			 <?php outputSearchPanel(); ?>
			
			</div>
			  <?php outputFooter(); ?>
			</div>
		
		 	
		<!-- defaultpanel  -->
			 
		
	</body>
</html>