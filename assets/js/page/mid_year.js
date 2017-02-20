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
	pstr.midyearvalue = $("#midyearvalue").val();
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