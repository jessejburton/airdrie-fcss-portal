/*********************************************************/
/* 			MID-YEAR Budget								 */
/*********************************************************/

/*****************************************  VARIABLES  ***********************************************/

var _AUTOSAVE = null;
var _AUTOSAVE_DURATION = 30000; // Autosave every 30 seconds

/*****************************************  HANDLERS  ***********************************************/

$(document).ready(function(){
	$('.accordion').accordion('option', 'active', 0);
	_AUTOSAVE = setInterval(saveBudget, _AUTOSAVE_DURATION);

// Enable the review panel once the form is valid
	$("#midyear_submit_to_airdrie").on("click", function(){
		$(".form-group").addClass("seen");
		if(validateForm($("#mid_year_form"), submitMidYear)){
			$('.accordion').accordion('option', 'active', -1); // Open the review panel.
		};
	});	

});

$(document).on("click", ".save", function(){
	saveMidYear();
	saveBudget();

	var msg = new Object();
	msg.SUCCESS = true;
	msg.TYPE = "success";
	msg.MESSAGE = "<strong>Success!</strong> your work has been saved.";
	showAutoreply(msg, $("#mid_year_form"));

	window.scrollTo(0, 0);
});

function saveMidYear(){
	var pstr = new Object();
	pstr.Method = "saveMidYear";
	pstr.ProgramID = $("#program_id").val();
	pstr.isOnlyFunder = $("input[name=is_only_funder]").is(":checked");
	pstr.sustainFunding = $("#sustain_funding").val();
	pstr.isSurplus = $("input[name=is_surplus]").is(":checked");
	pstr.isDeficit = $("input[name=is_deficit]").is(":checked");
	pstr.howDeal = $("#how_deal").val();
	pstr.programActivities = $("#program_activities").val();
	pstr.notYetStarted = $("#not_yet_started").val();
	pstr.programChallenges = $("#program_challenges").val();
	pstr.requireReportAssistance = $("#require_report_assistance").val();
	pstr.evaluationActivities = $("#evaluation_activities").val();
	pstr.noActivities = $("#no_activities").val();
	pstr.evaluationChallenges = $("#evaluation_challenges").val();
	pstr.requireResearchAssistance = $("#require_research_assistance").val();
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		method: "POST",
		success: function(response){
			if(!response.SUCCESS){	
				showAutoreply(response, $("#mid_year_form"));			
				clearInterval(_AUTOSAVE);
				_AUTOSAVE = null;
				return false;
			}
			return true;
		}
	});
}

// Submit the Mid Year report to Airdrie
function submitMidYear(){
	saveMidYear();
	var pstr = new Object();
	pstr.ProgramID = $("#program_id").val();
	pstr.Method = "submitMidYear";
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$(".accordion").accordion({active: false});
			showAutoreply(response, $(".wrapper"));
			clearInterval(_AUTOSAVE);
			_AUTOSAVE = null;
			if(response.SUCCESS){
				$("#mid_year_form").hide();
			}
		}
	});
}