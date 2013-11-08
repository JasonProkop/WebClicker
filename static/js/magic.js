var MAX_CHECK = 5;
var MAX_RADIO = 5;
var MIN_CHECK = 2;
var MIN_RADIO = 2;


function addCheckbox(fieldset){
	fieldset = fieldset.find(".checkboxcontainer");
	var currentCheckboxes = parseInt(fieldset.attr('checkboxes'));
	if(currentCheckboxes < MAX_CHECK){
		fieldset.attr('checkboxes',  currentCheckboxes + 1);
		var num = fieldset.attr('checkboxes');
		var qindex = parseInt($('#createPoll').attr('questions')) - 1;
		var checkbox = $('<input />', {'class' : 'textb', 'type' : 'checkbox', 'id' : 'checkbox' + num, 'name' : 'questions['+qindex+'][answers]['+ currentCheckboxes +']', 'value' : ''});
		var label = $('<label />', {'for' : 'checkbox' + num});
		var textarea = $('<textarea />', {'class' : 'texta', 'name' : 'questions['+qindex+'][panswers]['+ currentCheckboxes +']', 'rows' : 4, 'cols' : 30});
		
		label.html(textarea);
		checkbox.append(label);
		fieldset.append(checkbox);
	}
}

function removeCheckbox(fieldset){
	
	fieldset = fieldset.find(".checkboxcontainer");
	
	var currentCheckboxes = parseInt(fieldset.attr('checkboxes'));
	if(currentCheckboxes > MIN_CHECK){
		fieldset.attr('checkboxes', currentCheckboxes - 1);
		fieldset.find("#checkbox" + fieldset.attr('checkboxes')).parent().remove();
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
		var textarea = $('<textarea />', {'class' : 'texta', 'name' : 'questions['+qindex+'][panswers]['+currentRadios+']', 'rows' : 4, 'cols' : 30});
		
		label.html(textarea);
		radio.append(label);
		fieldset.append(radio);
	}
}

function removeRadio(fieldset){
	fieldset = fieldset.find(".radiocontainer");
	var currentRadios = parseInt(fieldset.attr('radios'));
	if(currentRadios > MIN_RADIO){
		fieldset.attr('radios', currentRadios - 1);
		fieldset.find("#radio" + fieldset.attr('radios')).parent().remove();
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
	$('#addNewQuestion').click(
	function (){
		$('#createPoll').attr('questions', parseInt($('#createPoll').attr('questions')) + 1);
		var qindex = parseInt($('#createPoll').attr('questions')) - 1;
		var content = $('<div />', {'class' : 'question', 'data-role' : 'content', 'data-content-theme' : 'c'});
		var textarea = $('<textarea />', { 'name' : 'questions['+qindex+'][question]', 'id' : 'questions['+qindex+'][question]', 'type' : 'text', 'placeholder' : 'Enter your question here...', 'rows' : 4, 'cols' : 50});
		var fieldcontain = $('<div />', {'data-role' : 'fieldcontain'});
		var label = $('<label />', {'for' : 'questions['+qindex+'][type]', 'html' : 'Choose the type of answer:'});
		var select = $('<select />', {'class' : 'type', 'name' : 'questions['+qindex+'][type]', 'id' : 'questions['+qindex+'][type]', 'data-mini':'true'});
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

function deleteQuestion(){

}