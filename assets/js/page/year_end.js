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
		if(validateForm($("#year_end_form"), submitEndYear)){
			$('.accordion').accordion('option', 'active', -1); // Open the review panel.
		};
	});	
});

$(document).on("click", ".save", function(){
	saveEndYear();
	saveBudget();

	var msg = new Object();
	msg.SUCCESS = true;
	msg.TYPE = "success";
	msg.MESSAGE = "<strong>Success!</strong> your work has been saved.";
	showAutoreply(msg, $("#year_end_form"));

	window.scrollTo(0, 0);
});

function saveEndYear(){
	var pstr = new Object();
	pstr.Method = "saveEndYear";
	pstr.ProgramID = $("#program_id").val();
	pstr.FaceToFaceAirdrie = $("#face_to_face_airdrie").val();
	pstr.FaceToFaceOther = $("#face_to_face_other").val();
	pstr.telephoneAirdrie = $("#telephone_airdrie").val();
	pstr.telephoneOther = $("#telephone_other").val();
	pstr.emailAirdrie = $("#email_airdrie").val();
	pstr.emailOther = $("#email_other").val();
	pstr.asExpected = $("#as_expected").val();
	pstr.whatChanges = $("#what_changes").val();
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		method: "POST",
		success: function(response){
			if(!response.SUCCESS){	
				showAutoreply(response, $("#year_end_form"));			
				clearInterval(_AUTOSAVE);
				_AUTOSAVE = null;
				return false;
			}
			return true;
		}
	});
}

// Submit the End Year report to Airdrie
function submitEndYear(){
	saveEndYear();
	var pstr = new Object();
	pstr.ProgramID = $("#program_id").val();
	pstr.Method = "submitEndYear";
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
				$("#year_end_form").hide();
			}
		}
	});
}