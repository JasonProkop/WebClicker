<!doctype html>
<html>
<head>
	<title>jQuery Mobile Page</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<link rel="stylesheet" href="themes/webclicker-usask.min.css" />
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.css" />
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.js"></script>
	<script>
	$(document).on('pageinit', '#q1', function () {
		    var current = 2;
		    var x = document.getElementById("questionType").selectedIndex;
		    var y = document.getElementById("questionType").options;
		    var type = y[x].text;

		    $('#remove' ).button('disable');
		    $('#questionType').change(function () {
  			    x = document.getElementById("questionType").selectedIndex;
			    y = document.getElementById("questionType").options;
		    	type = y[x].text;
		    	if (type == "Checkbox") {
		    		$('#q1ar .ui-controlgroup-controls').empty();
		    		current = 0;
		    		$('#add').click();
		    		$('#add').click();
		            $('#add' ).button('enable');
		            $('#remove' ).button('disable');
		        
		    	} else if (type == "Radio"){
		    		$('#q1ar .ui-controlgroup-controls').empty();
		    		current = 0;
		    		$('#add').click();
		    		$('#add').click();
		            $('#add' ).button('enable');
		            $('#remove' ).button('disable');
		    	} else if (type == "Textline") {
		    		$('#q1ar .ui-controlgroup-controls').empty();
		    		$('#add' ).button('disable');
		            $('#remove').button('disable');
		            current = 1;
		    	} else if(type == "Textarea"){
		    		$('#q1ar .ui-controlgroup-controls').empty();
					$('#add' ).button('disable');
					$('#remove').button('disable');
		    	} else if(type == "Slider"){
		    		$('#q1ar .ui-controlgroup-controls').empty();
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

 <div data-role="page" id="q1">
     <div data-role="header" data-theme="b">
         <h1>Poll X2F4</h1>
     </div>
     <div data-role="content">
         <form>
         	<textarea name="q1q" id="q1q" form="createPoll" type="text" placeholder="Enter your question here..." rows="4" cols="50"></textarea>
				<div data-role="fieldcontain">
					<label for="questionType">Choose the type of answer:</label>
					<select name="questionType" id="questionType" data-mini="true">
						<option value="1">Radio</option>
						<option value="2">Checkbox</option>
						<option value="3">Textline</option>
						<option value="4">Textarea</option>
						<option value="5">Slider</option>
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
      <div data-role="footer" data-theme="b" data-position="fixed">
        <fieldset class="ui-grid-b">
                	<div class="ui-block-a"><input type="button"  id="add" value="Return" data-icon="arrow-l" data-iconpos="left"/>   </div> 
                 	<div class="ui-block-b"><input type="button" data-theme="e" id="remove" value="All Done!" data-icon="check" data-iconpos="left"/></div>
					<div class="ui-block-c"><input type="button" id="remove" value="Add Question" /></div>
		</fieldset>
     </div>
 </div>

</body>
</html>