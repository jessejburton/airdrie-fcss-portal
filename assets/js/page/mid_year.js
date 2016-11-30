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
	saveBudget();

	var msg = new Object();
	msg.SUCCESS = true;
	msg.TYPE = "success";
	msg.MESSAGE = "<strong>Success!</strong> your work has been saved.";
	showAutoreply(msg, $("#mid_year_form"));

	window.scrollTo(0, 0);
});