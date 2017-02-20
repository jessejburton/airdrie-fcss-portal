/****************************************************/
/*		Survey.js 									*/
/****************************************************/

$(document).ready(function(){
	// Open the first panel
	$('.accordion').accordion('option', 'active', 0);

	var autocompleteURL = "assets/cfc/webservices.cfc?method=getParticipantSuggestBySurveyID&csrf=" + $.cookie("CSRF") + "&SurveyID=" + parseInt($("#SurveyID").val());

	$("#participant_name").autocomplete({
	    source: autocompleteURL,
	    minLength: 2,
	    select: function(event, ui) {
	        loadClientSurveyData($("#SurveyID").val(), ui.item.id);
	    }
	});	
})

$(document).on("change", ".specify", function(){
	var val = $(this).val();
	var id = $(this).closest("select").attr("id");
	var div = $("#" + id + "_other");
	if(val.substr(0,5) == "Other"){
		div.css("opacity", 1);
	} else {
		div.css("opacity", 0);
	}
});

$(document).on("click", ".begin", function(){
	// Clear any existing errors 
	$("#participant").find(".autoreply").remove();

	// if the name is blank show an error 
	if($("#participant_name").val() == ""){
		var msg = new Object();
		msg.SUCCESS = false;
		msg.MESSAGE = "Please enter a name.";
		msg.TYPE = "error";
		showAutoreply(msg, $("#participant"));
		return false;
	}

	$("#participant_name").attr("disabled", "disabled");
	$("#generate").addClass("hidden");
	$("#new").removeClass("hidden");
	$("#client_data").removeClass("hidden");
	$("#begin_buttons").addClass("hidden");
});


// Make enter trigger the continue button when adding a new client
$(document).on("keydown", "#participant_name", function(e){
	if (e.which == 13 && $(this).val() != "" && $("#client_id").val() == "") {
	  	$(".begin").trigger("click");
	}
});

// Show Post Survey after pre-survey is collected
$(document).on("change", "input[type=radio]", function(){
	var post = $(this).closest(".pre").next();
	post.css("opacity", 1);
});

// Save participant 
$(document).on("click", ".save-participant", function(){
	savePersonData(false);
});

// post-survey button
$(document).on("click", ".post-survey", function(){
	$('.accordion').accordion('option', 'active', -1);
});

$(document).on("click", "#new", function(){
	// TODO - Clear the form without refreshing
	if(confirm("Are you sure you would like to start a new client?")){
		window.location = window.location;
	}
});

$(document).on("click", ".complete-survey", function(){
	saveSurvey();
});

// Generate a unique ID (i.e. get the next available id number from the database)
$(document).on("click", "#generate", function(){
	var pstr = new Object();
	pstr.method = "getNextClientID",
	pstr.ProgramID = $("#ProgramID").val();
	pstr.SurveyID = $("#SurveyID").val();
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(response.SUCCESS){
				$("#client_id").val(""); // Need to reset this in case there was one selected, forces this to be a new client
				$("#participant_name").val(response.DATA);
			} else {
				showAutoreply(response, $("#participant"));
			}
		}
	})
});


/*************** FUNCTIONS *****************/
function saveSurvey(){
	// First save the person data to make sure it is valid and up to date.
	savePersonData();

	var preData = [];
	var postData = [];
	// Get the Pre and Post Survey Results
	$(".pre").each(function(){
		$(this).find(".answer").each(function(){
			if($(this).is(":checked")) preData.push($(this).val());
		});
	});
	$(".post").each(function(){
		$(this).find(".answer").each(function(){
			if($(this).is(":checked")) postData.push($(this).val());
		});
	});

	var pstr = new Object();
	pstr.method = "saveSurveyData";
	pstr.SurveyID = $("#SurveyID").val();
	pstr.ClientID = $("#client_id").val();	
	pstr.preData = preData.toString();
	pstr.postData = postData.toString();
	pstr.CSRF = $.cookie("CSRF");

	if(pstr.ClientID.length == 0 || $("#participant_name").val().length == 0){
		var msg = new Object();
		msg.SUCCESS = false;
		msg.MESSAGE = "Please make sure you have entered client information before collecting the survey data.";
		msg.TYPE = "error";
		showAutoreply(msg, $("#participant"));
		return false;
	}

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			showAutoreply(response, $("#survey"));
			if(response.SUCCESS){
				$('.accordion').accordion('option', 'active', 0);
				clearForm();
			}
		}
	})
}

function savePersonData(silent){
	var pstr = new Object();
	pstr.Method = "savePersonData";
	pstr.SurveyID = $("#SurveyID").val();
	pstr.ProgramID = $("#ProgramID").val();
	pstr.ClientID = $("#client_id").val();
	pstr.NAME = $("#participant_name").val();
	pstr.GENDER = $("#gender").val();
	pstr.AGE = $("#age").val();
	pstr.NUMPEOPLE = $("#numpeople").val();
	pstr.RESIDENCE = $("#residence").val();
	pstr.LANGUAGE = $("#language").val();
	pstr.INCOME = $("#income").val();
	pstr.CSRF = $.cookie("CSRF");

	// Set the default to silent, do not switch accordion tabs and show the success message
	if(typeof silent == "undefined"){
		silent = true;
	}

	// Handle OTHER selections - TODO - these aren't required or validated in any way.
	if(pstr.RESIDENCE == "Other (specify)"){
		pstr.RESIDENCE = $("#residence_specify").val();
	}
	if(pstr.LANGUAGE == "Other (specify)"){
		pstr.LANGUAGE = $("#language_specify").val();
	}
	if(pstr.ClientID.length == 0) pstr.ClientID = 0;

	if(pstr.NAME.length == 0){
		var msg = new Object();
		msg.SUCCESS = false;
		msg.MESSAGE = "Please enter a name.";
		msg.TYPE = "error";
		showAutoreply(msg, $("#participant"));
		return false;
	} else {
		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				$("#participant").prev().removeClass("heading-error"); // incase it has one
				if(!response.SUCCESS){
					$("#participant").prev().addClass("heading-error");
					showAutoreply(response, $("#participant"));
					var div = $(".autoreply").first();
					if(!isScrolledIntoView(div)){
						$('html, body').animate({ scrollTop: $(div).offset().top - 100 }, 500);
					}
					return false;
				} else {
					if(!silent){
						$("#participant").prev().addClass("heading-success");
						$("#client_id").val(response.DATA.CLIENTID);
						$(".accordion .ui-state-disabled").removeClass("ui-state-disabled");
						var activeAccordion = $('.accordion').accordion('option', 'active');
						$('.accordion').accordion('option', 'active', activeAccordion + 1);
					}
				}
			}
		});
	}
}

function clearForm(){
	$("#client_data").addClass("hidden");
	$("#begin_buttons").removeClass("hidden");
	$("input[type=radio].default").trigger("click"); // selects all of the default responses
	$("#participant_name").val("").removeAttr("disabled");
	$("select").each(function(){
		// selects the first responses of each select box and trigger the change so that the OTHER boxes disapear if needed
		$(this).find("option:first").attr("selected","selected").trigger("change");
	}); 
	$(".heading-error").removeClass("heading-error");
	$(".heading-success").removeClass("heading-success");
	$("#pre_survey_data").addClass("ui-state-disabled");
	$("#post_survey_data").addClass("ui-state-disabled");
	$("#new").addClass("hidden");
	$("#generate").removeClass("hidden");
}

function loadClientSurveyData(surveyID, clientID){
	var pstr = new Object();
	pstr.method = "getClientSurveyData";
	pstr.SurveyID = surveyID;
	pstr.ClientID = clientID;
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(response.SUCCESS){
				var person = response.DATA.PERSON;
				var predata = response.DATA.PREDATA;
				var postdata = response.DATA.POSTDATA;

				// Update the client variables
				$("#client_id").val(clientID);
				$("#participant_name").val(person.NAME);
				$("#gender").val(person.GENDER);
				$("#age").val(person.AGE);
				$("#numpeople").val(person.NUMPEOPLE);
				$("#residence").val(person.RESIDENCE);
				$("language").val(person.LANGUAGE);
				$("#income").val(person.INCOME);

				// Update the pre and post data
				for(var pre in predata){
					console.log("#pre_" + pre + "_" + predata[pre]);
					$("#pre_" + pre + "_" + predata[pre]).prop("checked", true);
				}
				for(var post in postdata){
					console.log("#post_" + post + "_" + postdata[post]);
					$("#post_" + post + "_" + postdata[post]).prop("checked", true);
				}
				$(".post").css("opacity", 1);

				// Update the display
				$("#participant_name").attr("disabled", "disabled");
				$("#generate").addClass("hidden");
				$("#new").removeClass("hidden");
				$("#client_data").removeClass("hidden");
				$("#begin_buttons").addClass("hidden");
				$(".accordion .ui-state-disabled").removeClass("ui-state-disabled");
			}
		}
	});
}