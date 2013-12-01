<!-- 	WebClicker.tk/group_details.php
	Developers: Dylan Fafard, Brady Smith, Jason Prokop, Bo Don, Max Gooding
	shows all the information about a poll and including x3489, number of questions
	number of responses, date created and if its actived or not.
--> 

<?php
	require_once('include/functions.php');
	include_once('include/db.php'); 
	
	if(isset($_GET['accessCode'])){
		try{
			$db = db_getpdo();
			validAccessCode($_GET['accessCode']);
			$poll = searchPoll($db, $_GET['accessCode']);
			$total_responses = 0;
			foreach($poll->Questions as $question){
				$total_responses += sizeof($question->Responses);
			}
		}catch (PollNotFound $e) {
			setError($e->getMessage());
			header("location:error.php");
		}catch(PDOException $e){
			setError($e->getMessage());
			header("location:error.php");
		}catch(MalformedAccessCode $e){
			setError($e->getMessage());
			header("location:error.php");
		}
	}else{
		header("location:index.php");
	}
?>

<!doctype html>
<html>
	<head>
		<title>WebClicker - Poll Details</title>
		<?php boilerPlate(); ?>
	</head>
	<body>
		<div id="homepage" data-role="page" data-title="WebClicker - <?php echo $poll->Name; ?> - Poll Details" data-theme='a'>
			<?php drawHeader(); ?> <!-- Poll Details Page -->
			<h1><?php echo $poll->Name; ?> - Poll Details</h1>
			<ul data-role="listview">
				<li>Access Code: <?php echo $poll->AccessCode; ?></li>
				<li>Share: http://webclicker.tk/<?php echo $poll->AccessCode; ?></li>
				<li>Questions: <?php echo sizeof($poll->Questions); ?></li>
				<li>Responses: <?php echo $total_responses; ?></li>
				<li>Created On: <?php echo date("F j, Y, g:i a", strtotime($poll->DateCreated)); ?></li>
				<li>Active: <?php echo var_export($poll->Active, true); ?>
			</ul>
			<!-- addind a twitter button so you can share polls -->
			<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://webclicker.tk/<?php echo $poll->AccessCode;?>" 
				data-text="WebClicker - <?php echo $poll->Name;?> -Take this poll at" data-via="Webclickertk" data-size="large">Tweet
			</a>
			<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';
				if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
			</script>
			<!-- \Twitter end -->
			<div data-role="content" class="ui-grid-b">
				<div class="ui-block-b">
					<a href="poll_results.php?accessCode=<?php echo $poll->AccessCode; ?>" data-role="button" data-ajax="false">Results</a>
				</div>
				<?php
					if($poll->Active){
						echo '<div class="ui-block-b">
						<a href="poll_take.php?accessCode='.$poll->AccessCode.'" data-role="button" data-ajax="false">Take</a>
					</div>';
					}
				?>
				<?php
					if($_SESSION['email'] != 'anonymous@anonymous.com' && $_SESSION['email'] == $poll->Creator){
						if($poll->Active){
							echo '<div class="ui-block-c">
							<a href="control/poll_deactivate.php?accessCode='.$poll->AccessCode.'" data-role="button" data-ajax="false">Deactivate</a>
						</div>';
						}else{
							echo '<div class="ui-block-c">
							<a href="control/poll_activate.php?accessCode='.$poll->AccessCode.'" data-role="button" data-ajax="false">Activate</a>
						</div>';
						}
					}
				?>
			</div>
			<?php outputFooter(); ?>
		</div> <!-- \Page end -->
	</body>
</html>
