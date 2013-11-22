<?php
	require_once('include/functions.php');
	include_once('include/db.php'); 
	
	try{
		$db = db_getpdo();
		$groups = groupsOwnedByUser($db);
		$db = null;
	}catch(PDOException $e){
		//echo "Caught PDOException ('{$e->getMessage()}')\n{$e}\n";
		$_SESSION['error'] = $e->getMessage();
		header("location:error.php");
	}
?>
<!DOCTYPE html> 
<html>
<head>
	<title>WebClicker - Create Poll</title>
	<?php boilerPlate(); ?>
	<script src="static/js/magic.js"></script>
	<script>
		$(document).on('load', $('#addNewQuestion').click()); //add a single question right off the start.
	</script>
</head>
	<body>		  
		<div data-role="page" data-theme='a'>
			<?php drawHeader(); ?>
			<form id="createPoll" action="control/poll_create.php" method="POST" data-ajax="false" questions=0>
				<div data-role="content">
					<h1>Poll Title:</h1>
					<h1><input type="text" name="pollname" id="pollName" value="<?php echo randomPollName(); ?>" required></h1>
					<span class="error"><?php echo currentError(); ?></span>
				</div>
				<div data-role="collapsible" data-collapsed="true" data-icon="gear">
					<h1>Poll options...</h1>
					<div data-role="fieldcontain">
						<div class="containing-element">
							<?php
							if (loggedInUser() === 'anonymous') {
								echo "<select name=\"pollactive\" id=\"flip-min\" data-role=\"slider\" disabled>";	
							} else {
								echo "<select name=\"pollactive\" id=\"flip-min\" data-role=\"slider\">";
							}
							?>
								<option value="false">Inactive</option>
								<option value="true" selected="selected">Active</option>
								
							</select>
						</div>
						<label for="select-choice-0" class="select">Group</label>
						<select name="groupname" id="select-choice-0">
							<?php
							foreach($groups as $group){
								echo "<option value=\"$group->Name\">$group->Name</option>";
							}
							?>
						</select>
					</div>
				</div>
				<div id="footer" data-role="content" data-tap-toggle="false">
					<div class="ui-grid-a">
						<div class="ui-block-a"><input type="button" value="Add Question" id="addNewQuestion" data-ajax="false" data-icon ="plus" data-mini="true" ></div>
						<div class="ui-block-b"><input type="button" value="Delete Question" id="deleteQuestion" data-ajax="false" data-icon ="minus" data-mini="true" ></div>
					</div>
					<div class="ui-grid-solo">
						<input type="submit" id="submit" value="All Done!"  data-icon="check" data-iconpos="left" />
					</div>	
				</div>
			</form>
			<?php outputFooter(); ?>
		</div>
	</body>
</html>
<?php $_SESSION['error'] = ''; ?>