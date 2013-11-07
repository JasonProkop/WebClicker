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
	$(document).on('pageinit', '#q1', function () {
			//current is the number of responds in Question. 
		    var current = 2;

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
		    		$('#q1ar .ui-controlgroup-controls').empty();
		    		current = 0;
		    		//add two new responds.
		    		$('#add').click();
		    		$('#add').click();
		    		//adjust the button situation.
		            $('#add' ).button('enable');
		            $('#remove' ).button('disable');
		        
		    	} else if (type == "Radio"){
		    		//empty all content.
		    		$('#q1ar .ui-controlgroup-controls').empty();
		    		current = 0;
		    		//add two new responds.
		    		$('#add').click();
		    		$('#add').click();
		    		//adjust the button situation.
		            $('#add' ).button('enable');
		            $('#remove' ).button('disable');
		    	} else if(type == "Textarea"){
		    		//empty all content.
		    		$('#q1ar .ui-controlgroup-controls').empty();
		    		//disable buttons.
					$('#add' ).button('disable');
					$('#remove').button('disable');
		    	};
		    })
		    $('#add').click(function createAnswer() {
		            current++;        
		            $('#q1ar .ui-controlgroup-controls')
		            .append(
		                $('<input/>', {
		                        'type': type,
		                        'name': 'q1a',
		                        'id': 'q1a' + current,
		                        'value': current,
		                    })
		                    .append(
		                        $('<label/>', {
		                            'for': 'q1a' + current,
		                        })
		                        .html(
		                            $('<textarea/>', {
		                                'id': 'q1r' + current,
		                                'name': 'q1r' + current,
		                                'rows': 4,
		                                'cols': 20
		                            })
		                        )
		                )
		            );
		        
		        $("#q1").trigger('create')
		        
		        if (current >= 5) {
		            // Disable Add
		            $('#add' ).button('disable');
		        } else if (current <= 2 ) {
		            // Disable Remove
		            $('#remove' ).button('disable');
		        } else {
		            // Enable Add
		            $('#add' ).button('enable');
		            // Enable Remove
		            $('#remove' ).button('enable');
		        }
		    });
		    
		    $('#remove').click(function () {
		        $('#q1r' + current).parent().remove();       
		        $('#q1a' + current).parent().remove();
		        
		        current--;
		        
		        $("#q1").trigger('create')
		        
		        if (current >= 5) {
		            // Disable Add
		            $('#add' ).button('disable');
		        } else if (current <= 2 ) {
		            // Disable Remove
		            $('#remove' ).button('disable');
		        } else {
		            // Enable Add
		            $('#add' ).button('enable');
		            // Enable Remove
		            $('#remove' ).button('enable');
		        }
		    });
		});
	</script>

</head>
<body>

 <div data-role="page" id="q1" data-add-back-btn="true">
     <div data-role="header" data-theme="c" >
        <h1>Poll X2F4</h1>
       <a href="index.php"  data-role="button" class="ui-btn-left" data-inline="true" data-icon="home">Home</a>

     </div>
     <div data-role="content">
         <form>
         	<textarea name="q1q" id="q1q" form="createPoll" type="text" placeholder="Enter your question here..." rows="4" cols="50"></textarea>
				<div data-role="fieldcontain">
					<label for="questionType">Choose the type of answer:</label>
					<select name="questionType" id="questionType" data-mini="true">
						<option value="1">Radio</option>
						<option value="2">Checkbox</option>
						<option value="3">Textarea</option>
		    		</select>
				</div>
             <div data-role="fieldcontain">
                <fieldset id="q1ar" data-role="controlgroup" data-type="vertical">
                     <input type="radio" id="q1a1" name="q1a" value="1" />
                     <label for="q1a1"><textarea id="q1r1" name="q1r1" rows=4 cols=30></textarea></label>
                     <input type="radio" id="q1a2" name="q1a" value="2" />
                     <label for="q1a2"><textarea id="q1r2" name="q1r2" rows=4 cols=30></textarea></label>
                </fieldset>
                <fieldset class="ui-grid-a">
                	<div class="ui-block-a"><input type="button" data-mini="true" id="add" value="Add response" />   </div> 
                	<div class="ui-block-b"><input type="button" data-mini="true" id="remove" value="Remove response" /></div>
				</fieldset>
             </div>
         </form>
     </div>
      <div data-role="footer" data-theme="c" data-position="fixed">
			<h1> </h1>
    	<input type="submit" data-theme="b" id="submit" value="All Done!" data-icon="check" class="ui-btn-left" data-iconpos="left"/>
    	 <div data-role="controlgroup" data-type="horizontal" class="ui-btn-right">
			<a href="#" data-role="button" id= "prevq" data-icon ="arrow-l" data-iconpos="notext">Prev Question</a>
		<a href="#QuestionList" data-rel="popup" data-role="button" data-transition="pop" data-icon="bars">Question List</a>
			<a href="#" data-role="button" id= "nextq" data-icon ="arrow-r" data-iconpos="notext">Next Question</a>
		</div>
		
     </div>
    <div data-role="popup" id="QuestionList" data-theme="d" data-overlay-theme="b">
	        <ul data-role="listview"  style="min-width:160px;" >
	            <li data-role="divider" data-theme="b">Choose an option</li>
	            <li><a href="#q1"> Question 1 </a></li>
	        </ul>
	        <ul data-role="listview"  style="min-width:160px;">
	        	<li><a href="#" data-ajax="false" data-role="button" data-icon ="plus" data-mini="true" >Add New Question</a></li>
	        </ul>
        	
	</div>
 </div>

</body>
</html>