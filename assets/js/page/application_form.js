var _AUTOSAVE = null;
var _AUTOSAVE_DURATION = 30000; // Autosave every 30 seconds
var _APPLICATION_TYPE = "";
var _PROGRAM_STATUS = "";
var _REVIEW_STATE = false;
var _SUBMITTED_STATE = false;

$(document).ready(function(){
	_APPLICATION_TYPE = $("#application_type").val();
	_PROGRAM_STATUS = $("#program_status").val();

	// Enable save button if it has already been saved
	if(_PROGRAM_STATUS.length > 0){
		$(".save").removeClass("disabled");
	}

	// Check for states
	if(_PROGRAM_STATUS == "LOI - Saved for Review" || _PROGRAM_STATUS == "APPLICATION - Saved for Review"){
		_REVIEW_STATE = true;
	}
	if(_PROGRAM_STATUS == "LOI - Submitted" || _PROGRAM_STATUS == "APPLICATION - Submitted"){
		_SUBMITTED_STATE = true;
	}

	// Initialize auto-save once the program name has changed. ONLY IF NOT IN REVIEW STATE
	if(_REVIEW_STATE){
		reviewState();
	} else if(_SUBMITTED_STATE) {
		submittedState();
	} else {
		$('.accordion').accordion('option', 'active', 0);
		_AUTOSAVE = setInterval(saveApplication, _AUTOSAVE_DURATION);
	}

	$(".save").on("click", function(){
		saveApplication();

		var msg = new Object();
		msg.SUCCESS = true;
		msg.TYPE = "success";
		msg.MESSAGE = "<strong>Success!</strong> your " + _APPLICATION_TYPE + " has been saved.";
		showAutoreply(msg, $("#application_form"));

		window.scrollTo(0, 0);
	});
	
	// Enable saving once something has been added to the Program Name
	$("#program_name").on("keyup", function(){
		if($(this).val().length > 0){
			$(".save").removeClass("disabled");
		} else {
			$(".save").addClass("disabled");
		}
	});

	// Enable the review panel once the form is valid
	$("#application_review").on("click", function(){
		$(".form-group").addClass("seen");
		if(validateForm($("#application_form"), reviewApplication)){
			$('.accordion').accordion('option', 'active', -1); // Open the review panel.
		};
	});	

	// Mark the Application ready for review
	$("#application_save_for_review").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#application_form"), markApplicationForReview);
	});

	// Submit the Application to Airdrie
	$("#application_submit_to_airdrie").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#application_form"), markApplicationSubmitted);
	});
	
});

/*** Save the Application at whatever state it is in ***/
function saveApplication(){
	reviewApplication(); // Update the review tab to make sure it has all of the most recent information 
	if($("#program_name").val().length > 0){ // Make sure there is atleast a program name
		$("#save").removeClass("disabled");
		$("#saving").fadeIn("slow", function(){
			var pstr = updateProgram();
			pstr.method = "saveProgram";
			pstr.CSRF = $.cookie("CSRF");

			$.ajax({
				url: "assets/cfc/webservices.cfc",
				data: pstr,
				method: "POST",
				success: function(response){
					if(!response.SUCCESS){
						showAutoreply(response, $("#application_form"));
						clearInterval(_AUTOSAVE);
						_AUTOSAVE = null;
					}
					$("#last_saved").html("Last Saved: " + currentTime());
					$("#program_id").val(response.DATA.PROGRAMID);
					$("#saving").fadeOut("slow");
				}
			});
		});
		if(_APPLICATION_TYPE == "Application Form") {
			updateBoardMembers(true);
			saveBudget();
		}
	};
}

// Submit the Application to Airdrie
function submitApplication(){
	saveApplication();
	var pstr = new Object();
	pstr.ProgramID = $("#program_id").val();
	pstr.Method = "submitApplication";
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$(".accordion").accordion({active: false});
			showAutoreply(response, $("#application_form"));
			clearInterval(_AUTOSAVE);
			_AUTOSAVE = null;
			_SUBMITTED_STATE = true;
		}
	});
}

/*** Review the Application ***/
function reviewApplication(){
	// Remove any disabled class
	$(".accordion .ui-state-disabled").removeClass("ui-state-disabled");

	$("input.value, textarea.value").each(function(){
		var val = $(this).val();
		var id = $(this).attr("id");
		console.log(id + ' - ' + val);	
		var cls = id.replace(/_/g, "-");
		$("#application_review_display").find("." + cls).html(val);
	});
}

/*** Mark the LOI/Application ready for review ***/
function markApplicationForReview(){
	var pstr = new Object();
	pstr.Method = "markApplicationForReview";
	pstr.ProgramID = $("#program_id").val();
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$(".accordion").accordion({active: false});
			showAutoreply(response, $("#application_form"));
			clearInterval(_AUTOSAVE);
			_AUTOSAVE = null;
			reviewState();
		}
	});
}

/*** Submit the LOI/Application to Airdrie ***/
function markApplicationSubmitted(){
	var pstr = new Object();
	pstr.Method = "markApplicationSubmitted";
	pstr.ProgramID = $("#program_id").val();
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			showAutoreply(response, $("#application_form"));
			clearInterval(_AUTOSAVE);
			_AUTOSAVE = null;
			submittedState();
		}
	});
}

function reviewState(){
	_REVIEW_STATE = true;
	reviewApplication();

	$(".accordion .ui-state-disabled").removeClass("ui-state-disabled");

	var autoreply = new Object();
	autoreply.SUCCESS = true;
	autoreply.TYPE = "info";
	autoreply.MESSAGE = "<strong>Saved for Review!</strong> This " + _APPLICATION_TYPE + " is ready for submission. You can click on any section to make final changes, or click 'Review and Submit' to do a final check before submitting your " + _APPLICATION_TYPE + " to City of Airdrie.";
		autoreply.MESSAGE = autoreply.MESSAGE + "<br /><br /><span><i class='fa fa-question-circle'></i> Having difficulties? Contact City of Airdrie Social Planning at 403.948.8800 or social.planning@airdrie.ca.</span>";

	showAutoreply(autoreply, $("#application_form"));	
}

function submittedState(){
	_SUBMITTED_STATE = true; 
	$("#save").remove();
	$(".submit-button").attr("disabled", "disabled");
	$(".accordion").accordion({active: false});
	$(".accordion").accordion({disabled: true});

	var autoreply = new Object();
	autoreply.SUCCESS = true;
	autoreply.TYPE = "info";
	autoreply.MESSAGE = "<strong>Submitted!</strong> This " + _APPLICATION_TYPE + " has been submitted to the City of Airdrie, no changes can be made until it has been reviewed. You will be notified via e-mail of any updates to the status of this program.";

	showAutoreply(autoreply, $("#application_form"));
}

function updateProgram(){
	var program = new Object();

	if($("#program_id").val().length > 0) program.ProgramID = parseInt($("#program_id").val());

	program.ProgramName = $("#program_name").val();
	program.ProgramStatement = $("#program_statement").val();
	program.TargetAudience = $("#target_audience").val();
	program.MostlyAirdrie = $("#mostly_airdrie_yes").is(":checked");
	program.PrimaryContactName = $("#primary_contact_name").val();
	program.PrimaryPhone = $("#primary_phone").val();
	program.PrimaryEmail = $("#primary_email").val();
	program.ProgramAddress = $("#program_address").val();
	program.ProgramMailingAddress = $("#program_mailing_address").val();
	program.Need = $("#need").val();
	program.Goal = $("#goal").val();
	program.Strategies = $("#strategies").val();
	program.Rationale = $("#rationale").val();
	program.Footnotes = $("#footnotes").val();
	program.PreventionFocus = $("#prevention_focus").val();
	program.Alignment = $("#alignment").val();
	program.MissionFit = $("#mission_fit").val();
	program.ConsideredPartnerships = $("#considered_partnerships").val();

	// Handle setting values for Letter of Intent only variables
	if(typeof $("#estimated_from_airdrie").val() !== 'undefined'){
		if(!isNaN($("#estimated_from_airdrie").val())) program.EstimatedFromAirdrie = parseFloat($("#estimated_from_airdrie").val());
		if(!isNaN($("#estimated_from_other").val())) program.EstimatedFromOther = parseFloat($("#estimated_from_other").val());
	}

	// Handle setting values for Application only variables. 
	program.ShortTermGoals = (typeof $("#short_term_goals").val() === 'undefined') ? "" : $("#short_term_goals").val();
	program.MidTermGoals = (typeof $("#mid_term_goals").val() === 'undefined') ? "" : $("#mid_term_goals").val();
	program.LongTermGoals = (typeof $("#long_term_goals").val() === 'undefined') ? "" : $("#long_term_goals").val();

	console.log(JSON.stringify(program));
	return program;
}

/* BUDGET ESTIMATE SUMMING */
$(document).on("keyup", ".sum", function(){
	var total = 0;

	$(".sum").each(function(){
		var val = $.trim( $(this).val() );

		if ( val ) {
	        val = parseFloat( val.replace( /^\$/, "" ) );
	        total += !isNaN( val ) ? val : 0;
	    }
	});
	
	$(".sum-total").val(total.toFixed(2));
});

// DEVELOPMENT FEATURE 
$(document).on("click", "#fill", function(){
	$(".value").each(function(){
		$(this).val("123");
	});
	$(".board-member").find("input[name=board_name]").val("test");
	$(".board-member").find("input[name=board_title]").val("test");

});
// DEVELOPMENT FEATURE