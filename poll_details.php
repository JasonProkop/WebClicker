<?php
	require_once('include/functions.php');

	if(isset($_GET['accessCode'])){
		try{
			validAccessCode($_GET['accessCode']);
			$poll = searchPoll($_GET['accessCode']);
			$total_responses = 0;
			foreach($poll->Questions as $question){
				$total_responses += sizeof($question->Responses);
			}
		}catch (PollNotFound $e) {
			//echo "Poll Not Found";
			$_SESSION['error'] = $e->getMessage();
			header("location:error.php");
		}catch(PDOException $e){
			//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
			$_SESSION['error'] = $e->getMessage();
			header("location:error.php");
		}catch(MalformedAccessCode $e){
			//echo "Caught MalformedAccessCode ('{$e->getMessage()}')\n{$e}\n";
			$_SESSION['error'] = $e->getMessage();
			header("location:error.php");
		}
	}else{
		header("location:index.php");
	}
?>
<!doctype html>
<html>
<head>
	<title>
		WebClicker - Poll Details
	</title>
	<?php outputHeader(); ?>
</head>
<body>
	<div id="homepage" data-role="page" data-title="WebClicker - <?php echo $poll->Name; ?> - Poll Details" data-theme='a'>
		<header data-role="header"  data-tap-toggle="false">
			<h1><?php echo $poll->Name; ?> - Poll Details</h1>
			<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home" data-ajax="false">Home</a>
		</header><!-- /header -->
		<ul data-role="listview">
			<li>Access Code: <?php echo $poll->AccessCode; ?></li>
			<li>Share: http://webclicker.tk/<?php echo $poll->AccessCode; ?></li>
			<li>Questions: <?php echo sizeof($poll->Questions); ?></li>
			<li>Responses: <?php echo $total_responses; ?></li>
			<li>Created On: <?php echo date("F j, Y, g:i a", strtotime($poll->DateCreated)); ?></li>
			<li>Active: <?php echo var_export($poll->Active, true); ?>
		</ul>
			<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://webclicker.tk/<?php echo $poll->AccessCode;?>" data-text="WebClicker - <?php echo $poll->Name;?> -Take this poll at" data-via="Webclickertk" data-size="large">Tweet</a>
			<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
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
	</div>
</body>
</html>
