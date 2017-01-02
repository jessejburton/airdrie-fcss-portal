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

	// Save Survey
	$(".save-survey").on("click", function(){
		saveSurvey();
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
	$("select").val("");

	// clear the questions then add just one empty one back.
	var q = $(".question").first().clone();
	$("#question_container").html("");
	$("#question_container").append(q);
}

/* Save a survey
**********************************************************************/
function saveSurvey(){
	var pstr = new Object();
		pstr.Method = "saveSurvey";
		if($("#surveyid").val().length > 0){
			pstr.SurveyID = $("#surveyid").val();
		}
		pstr.Name = $("#survey_name").val();
		pstr.Description = $("#survey_description").val();
		pstr.Citation = $("#survey_citation").val();
		pstr.IndicatorID = $("#indicatorID").val();
		pstr.CSRF = $.cookie("CSRF");

		pstr.Questions = [];

		$(".question").each(function(){
			var q = new Object();
				q.Question = $(this).find("textarea").val();
			if($(this).data("questionid") !== "undefined"){
				q.QuestionID = $(this).data("questionid");
			}

			if(q.Question.length > 0){
				pstr.Questions.push(JSON.stringify(q));
			}
		});

		pstr.Questions = JSON.stringify(pstr.Questions);

		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				if(response.SUCCESS){
					clearForm();
				}
				showAutoreply(response, ".wrapper");
			}
		});
}

/* Load a survey to edit
**********************************************************************/
function loadSurvey(surveyid){
	var pstr = new Object();
		pstr.Method = "getSurvey";
		pstr.SurveyID = $("#surveyid").val();
		pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			var survey = response.DATA;
			$("#survey_name").val(survey.NAME);
			$("#survey_description").val(survey.DESCRIPTION);
			$("#survey_citation").val(survey.CITATION);
			$("#indicatorID").val(survey.INDICATORID);
			$("#survey_form").fadeIn("slow");

			// Display Questions
			var q = $(".question").first().clone();
			$("#question_container").html("");			// Clear existing questions
			$("#question_container").append(q);

			for(var q in survey.QUESTIONS){
				var question = $(".question").first().clone();
				$(question).find("textarea").val(survey.QUESTIONS[q].QUESTION);
				$(question).data("questionid", survey.QUESTIONS[q].QUESTIONID);

				$("#question_container").append(question);
			}

			$(".question").first().remove(); 	// remove the blank one
		}
	});
}
