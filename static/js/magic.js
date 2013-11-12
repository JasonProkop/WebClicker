var MAX_CHECK = 5;
var MAX_RADIO = 5;
var MIN_CHECK = 2;
var MIN_RADIO = 2;
var MAX_QUESTION = 10;
var MIN_QUESTION = 1;

function addCheckbox(fieldset){
	fieldset = fieldset.find(".checkboxcontainer");
	var currentCheckboxes = parseInt(fieldset.attr('checkboxes'));
	if(currentCheckboxes < MAX_CHECK){
		fieldset.attr('checkboxes',  currentCheckboxes + 1);
		var num = fieldset.attr('checkboxes');
		var qindex = parseInt($('#createPoll').attr('questions')) - 1;
		var checkbox = $('<input />', {'class' : 'textb', 'type' : 'checkbox', 'id' : 'checkbox' + num, 'name' : 'questions['+qindex+'][answers]['+ currentCheckboxes +']', 'value' : ''});
		var label = $('<label />', {'for' : 'checkbox' + num});
		var textarea = $('<input />', {'class' : 'texta', 'name' : 'questions['+qindex+'][panswers]['+ currentCheckboxes +']', 'type' : 'text', 'style' : 'position:relative !important;', 'required' : 'required'});
		
		label.html(textarea);
		checkbox.append(label);
		fieldset.append(checkbox);
	}
}

function removeCheckbox(fieldset){
	
	fieldset = fieldset.find(".checkboxcontainer");
	
	var currentCheckboxes = parseInt(fieldset.attr('checkboxes'));
	if(currentCheckboxes > MIN_CHECK){
		fieldset.find("#checkbox" + fieldset.attr('checkboxes')).parent().remove();
		fieldset.attr('checkboxes', currentCheckboxes - 1);
	}
}

function displayCheckbox(content){
	var answersFieldSet = $('<fieldset/>', { 'checkboxes' : 0, 'class': 'checkboxcontainer', 'data-role' : 'controlgroup', 'data-type' : 'vertical'});
	content.append(answersFieldSet);
}
function addRadio(fieldset){
	fieldset = fieldset.find(".radiocontainer");
	var currentRadios = parseInt(fieldset.attr('radios'));
	if(currentRadios < MAX_RADIO){
		fieldset.attr('radios', currentRadios + 1);
		var num = fieldset.attr('radios');
		var qindex = parseInt($('#createPoll').attr('questions')) - 1;
		var radio = $('<input />', {'class' : 'textb', 'type' : 'radio', 'id' : 'radio' + num, 'name' : 'questions['+qindex+'][answers][0]', 'value' : ''});
		var label = $('<label />', {'for' : 'radio' + num});
		var textarea = $('<input />', {'class' : 'texta', 'name' : 'questions['+qindex+'][panswers]['+currentRadios+']', 'type' : 'text', 'style' : 'position:relative !important;', 'required' : 'required'});

		label.html(textarea);
		radio.append(label);
		fieldset.append(radio);
	}
}

function removeRadio(fieldset){
	fieldset = fieldset.find(".radiocontainer");
	var currentRadios = parseInt(fieldset.attr('radios'));
	if(currentRadios > MIN_RADIO){
		fieldset.find("#radio" + fieldset.attr('radios')).parent().remove();
		fieldset.attr('radios', currentRadios - 1);
	}
}

function displayRadio(content){
	var answersFieldSet = $('<fieldset/>', { 'radios' : 0, 'class': 'radiocontainer', 'data-role' : 'controlgroup', 'data-type' : 'vertical'});
	content.append(answersFieldSet);
}
		
function addButtons(add, remove){
	var buttonFieldSet = $('<fieldset/>', { 'class': 'ui-grid-a' });
	var buttonDivA = $('<div/>', {'class':'ui-block-a'});
	var buttonDivB = $('<div/>', {'class':'ui-block-b'});
	var buttonAdd = $('<input/>', {
							'type': "button",
							'data-mini' : 'true',
							'value' : 'Add'
						});
	
	var buttonRemove = $('<input/>', {
							'type': "button",
							'data-mini' : 'true',
							'value' : 'Remove'
						});
	buttonAdd.click(add);
	buttonRemove.click(remove);
	buttonDivA.append(buttonAdd);
	buttonDivB.append(buttonRemove);
	buttonFieldSet.append(buttonDivA);
	buttonFieldSet.append(buttonDivB);
	return buttonFieldSet;
}
$(document).on('pageinit', function () {
	$('#deleteQuestion').click(
	function (){
		var questions = parseInt($('#createPoll').attr('questions'));
		if(questions > MIN_QUESTION){
			$('#createPoll').attr('questions',  questions - 1);
			var id = "qc" + (questions - 1);
			$("#" + id).remove();
		}
	}),
	$('#addNewQuestion').click(
	function (){
		var questions = parseInt($('#createPoll').attr('questions'));
		if(questions < MAX_QUESTION){
			$('#createPoll').attr('questions',  questions + 1);
			var content = $('<div />', {'id' : 'qc'+questions+'', 'class' : 'bordered', 'data-role' : 'content', 'data-content-theme' : 'c'});
			var textarea = $('<textarea />', { 'name' : 'questions['+questions+'][question]', 'id' : 'questions['+questions+'][question]', 'type' : 'text', 'placeholder' : 'Enter your question here...', 'rows' : 4, 'cols' : 50, 'required' : 'required'});
			var fieldcontain = $('<div />', {'data-role' : 'fieldcontain'});
			var label = $('<label />', {'for' : 'questions['+questions+'][type]', 'html' : 'Choose the type of answer:'});
			var select = $('<select />', {'class' : 'type', 'name' : 'questions['+questions+'][type]', 'id' : 'questions['+questions+'][type]', 'data-mini':'true'});
			var textbox = $('<option />', {'value' : 'Textbox', 'html' : 'Textbox'});
			var radio = $('<option />', {'value' : 'Radio', 'html' : 'Radio'});
			var checkbox = $('<option />', {'value' : 'Checkbox', 'html' : 'Checkbox'});

			
			select.append(radio);
			select.append(checkbox);
			select.append(textbox);
			fieldcontain.append(label);
			fieldcontain.append(select);
			content.append(textarea);
			content.append(fieldcontain);
			$('#footer').before(content);
			content.find('.type').val('Textbox');
			content.trigger('create');
		}
	})
	$('#addNewQuestion').click();
});

$(document).on('create', function(){
	$('.texta').keyup(function(){
        $(this).parent().parent().parent().parent().find(".textb").attr('value', $(this).val());
    })

    $('.texta').change(function(){
		$(this).parent().parent().parent().parent().find(".textb").attr('value', $(this).val());
    })
});

$(document).on('pageinit click', function () {
	$('.type').change(function (){
		var content = $(this).parent().parent().parent().parent();
		content.find('#answer').remove();
		var fieldContain = $('<div/>', { 'id' : 'answer', 'data-role': 'fieldcontain' });
		content.append(fieldContain);
		switch($(this).val()){
			case "Radio":
				var add = function(){ addRadio(fieldContain); content.trigger('create');}
				var remove = function(){ removeRadio(fieldContain); content.trigger('create');}
				displayRadio(fieldContain);
				fieldContain.append(addButtons(add, remove));
				content.trigger('create');
				add();
				add();
				break;
			case "Checkbox":
				var add = function(){ addCheckbox(fieldContain); content.trigger('create');}
				var remove = function(){ removeCheckbox(fieldContain); content.trigger('create');}
				displayCheckbox(fieldContain);
				fieldContain.append(addButtons(add, remove));
				content.trigger('create');
				add();
				add();
				break;
			case "Textbox":
				break;
			default:
				return;
		}
	})
});
