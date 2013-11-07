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

		<style type='text/css'>
		/* Style sheet to restrict the page on large browsers */

		html { background-color: #333; }
		/* this line detects browsers which have a minimum width of 600
		 * pixels and only applies the changes to them */
		@media only screen and (min-width: 600px){
		    .ui-page {
			width: 600px !important;
			margin: 0 auto !important;
			position: relative !important;
			border-right: 5px #666 outset !important;
			border-left: 5px #666 outset !important;
		    }
        }
</style>

	<script>
	$(document).on('pageinit', '#question', function () {
			//currentRespondsNum is the number of responds in Question. 
		    var currentRespondsNum = 2;

		    var x = document.getElementById("questionType").selectedIndex;
		    var y = document.getElementById("questionType").options;
		    var type = y[x].text;

		    $('#remove' ).button('disable');
		    //when user change the type of question.
		    $('#questionType').change(function () {
		    	//get the type of user choose.
  			    x = document.getElementById("questionType").selectedIndex;
			    y = document.getElementById("questionType").options;
		    	type = y[x].text;
		    	//if user choosed checkbox
		    	if (type == "Checkbox") {
		    		//empty all content.
		    		$('#questionar .ui-controlgroup-controls').empty();
		    		currentRespondsNum = 0;
		    		//add two new responds.
		    		$('#add').click();
		    		$('#add').click();
		    		//adjust the button situation.
		            $('#add' ).button('enable');
		            $('#remove' ).button('disable');
		        
		    	} else if (type == "Radio"){
		    		//empty all content.
		    		$('#questionar .ui-controlgroup-controls').empty();
		    		currentRespondsNum = 0;
		    		//add two new responds.
		    		$('#add').click();
		    		$('#add').click();
		    		//adjust the button situation.
		            $('#add' ).button('enable');
		            $('#remove' ).button('disable');
		    	} else if(type == "Textarea"){
		    		//empty all content.
		    		$('#questionar .ui-controlgroup-controls').empty();
		    		//disable buttons.
					$('#add' ).button('disable');
					$('#remove').button('disable');
		    	};
		    })

		    $('#add').click(function addRespond() {
		    		//add one respond into list.
		            currentRespondsNum++;        
		            $('#questionar .ui-controlgroup-controls')
		            .append(
		                $('<input/>', {
		                        'type': type,
		                        'name': 'questiona',
		                        'id': 'questiona' + currentRespondsNum,
		                        'value': currentRespondsNum,
		                    })
		                    .append(
		                        $('<label/>', {
		                            'for': 'questiona' + currentRespondsNum,
		                        })
		                        .html(
		                            $('<textarea/>', {
		                                'id': 'questionr' + currentRespondsNum,
		                                'name': 'questionr' + currentRespondsNum,
		                                'rows': 4,
		                                'cols': 20
		                            })
		                        )
		                )
		            );
		     
		        $("#question").trigger('create')
		        //after modify the number of responds,
		     	//check if need to adjust the situation of buttons.   
		        if (currentRespondsNum >= 5) {
		            // Disable Add
		            $('#add' ).button('disable');
		        } else if (currentRespondsNum <= 2 ) {
		            // Disable Remove
		            $('#remove' ).button('disable');
		        } else {
		            // Enable Add
		            $('#add' ).button('enable');
		            // Enable Remove
		            $('#remove' ).button('enable');
		        }
		    });
		    
		    $('#remove').click(function deleteRespond() {
		    	//delete the last respond.
		        $('#questionr' + currentRespondsNum).parent().remove();       
		        $('#questiona' + currentRespondsNum).parent().remove();
		        
		        currentRespondsNum--;
		        
		        $("#question").trigger('create')
		        //after modify the number of responds,
		     	//check if need to adjust the situation of buttons.  
		        if (currentRespondsNum >= 5) {
		            // Disable Add
		            $('#add' ).button('disable');
		        } else if (currentRespondsNum <= 2 ) {
		            // Disable Remove
		            $('#remove' ).button('disable');
		        } else {
		            // Enable Add
		            $('#add' ).button('enable');
		            // Enable Remove
		            $('#remove' ).button('enable');
		        }
		    });

		    $('#Qlistbtn').click(function () {
				//TODO
			})
		});

	</script>

</head>
<body>

 <div data-role="page" id="question" data-add-back-btn="true">
     <div data-role="header" data-theme="c" >
		<h1>Poll X2F4</h1>
		<a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home</a>
     </div>

     <form>
     <div data-role="content">    
         	<textarea name="questionq" id="questionq" form="createPoll" type="text" placeholder="Enter your question here..." rows="4" cols="50"></textarea>
				<div data-role="fieldcontain">
					<label for="questionType">Choose the type of answer:</label>
					<select name="questionType" id="questionType" data-mini="true">
						<option value="1">Radio</option>
						<option value="2">Checkbox</option>
						<option value="3">Textarea</option>
		    		</select>
				</div>
            <div data-role="fieldcontain">
                <fieldset id="questionar" data-role="controlgroup" data-type="vertical">
                     <input type="radio" id="questiona1" name="questiona" value="1" />
                     <label for="questiona1"><textarea id="questionr1" name="questionr1" rows=4 cols=30></textarea></label>
                     <input type="radio" id="questiona2" name="questiona" value="2" />
                     <label for="questiona2"><textarea id="questionr2" name="questionr2" rows=4 cols=30></textarea></label>
                </fieldset>
                <fieldset class="ui-grid-a">
                	<div class="ui-block-a"><input type="button" data-mini="true" id="add" value="Add response" />   </div> 
                	<div class="ui-block-b"><input type="button" data-mini="true" id="remove" value="Remove response" /></div>
				</fieldset>
            </div>     
    </div>

    <div data-role="footer" data-theme="c" data-position="fixed">
		<h1> </h1>
    	<input type="submit" data-theme="b" id="submit" value="All Done!" data-icon="check" class="ui-btn-left" data-iconpos="left"/>
    	<div data-role="controlgroup" data-type="horizontal" class="ui-btn-right">
    	 	<input type="submit" id= "prevq" data-icon ="arrow-l" data-iconpos="notext" value="Prev Question"  data-iconpos="notext"/>
			<a href="#popQlist" id="Qlistbtn" data-rel="popup" data-role="button" data-transition="pop" data-icon="bars">Question List</a>
			<input type="submit" id= "nextq" data-icon ="arrow-r" data-iconpos="notext" value="Next Question"  data-iconpos="notext"/>
		</div>
    </div>

    <div data-role="popup" id="popQlist" data-theme="d" data-overlay-theme="b">
	        <fieldset data-role="controlgroup" id="inQList" data-type="vertical" data-inset="true">
	        	<input type="button" id="q1btn" value="Question 1" onclick="jumpTo()">
	        </fieldset>
	        <ul data-role="listview"  style="min-width:160px;">
	        	<li><input type="button" value="Add New Question" id="Qlistbtn" data-ajax="false" data-icon ="plus" data-mini="true"></li>
	        </ul>
        	
	</div>
	</form>
 </div>

</body>
</html>