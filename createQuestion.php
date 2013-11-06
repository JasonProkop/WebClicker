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
      <div data-role="footer" data-theme="c" data-position="fixed">
			<h1> </h1>
    	<input type="submit" data-theme="b" id="submit" value="All Done!" data-icon="check" class="ui-btn-left" data-iconpos="left"/>
    	 <div data-role="controlgroup" data-type="horizontal" class="ui-btn-right">
			<input type="button"  id="prevq"  data-icon="arrow-l" data-iconpos="notext" value="Prev Question" />
			<input type="submit"  id="submit" value="Question List" data-icon="bars" data-iconpos="left"/>
			<input type="button" id="nextq"   data-icon="arrow-r" data-iconpos="notext" value="Next Question" />
		</div>
     </div>
 </div>

</body>
</html>