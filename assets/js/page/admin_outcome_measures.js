$(document).ready(function(){
	// Add question sorting
	$("#question_container").sortable({
		handle: ".question-handle",
		revert: true
	});

	// New Survey
	$("#new_survey").on("click", function(){
		clearForm();		
		$("#survey_form").fadeIn("slow");
	});

	// Edit Survey
	$("#edit_survey").on("click", function(){
		clearForm();		
		$("#survey_select").fadeIn("slow");
	});	

	// Select Survey to Edit
	$("#surveyid").on("change", function(){
		var id = $(this).val();

		if(id.length > 0){
			loadSurvey(id);
		} else {
			$("#survey_form").hide();
		}
	});

});

/* Ability to add more questions
********************************************************************/
$(document).on("click", ".add-question", function(){
	var q = $(".question").first().clone(false);
	
	$(q).find("textarea").val("");
	$("#question_container").append(q);
});

/* Ability to remove questions
********************************************************************/
$(document).on("click", ".remove-question", function(){
	if(confirm("Are you sure you want to remove this question?")){
		$(this).closest(".question").remove();
	}
});

function clearForm(){
	// Hide the forms
	$("#survey_select").hide();
	$("#survey_form").hide();

	// Set values to blank
	$("input").val("");
	$("textarea").val("");

	// clear the questions then add just one empty one back.
	var q = $(".question").first().clone();
	$("#question_container").html("");
	$("#question_container").append(q);
}

/* Save a survey
**********************************************************************/
function saveSurvey(){
	// TODO - add the code to save a survey 
}

/* Load a survey to edit
**********************************************************************/
function loadSurvey(surveyid){
	// TODO - add the code to get the survey data and load it

	$("#survey_form").fadeIn("slow");
}
