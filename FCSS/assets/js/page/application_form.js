var _AUTOSAVE = null;
var _APPLICATION_TYPE = "";
var _PROGRAM_STATUS = "";

$(document).ready(function(){
	_APPLICATION_TYPE = $("#application_type").val();
	_PROGRAM_STATUS = $("#program_status").val();

	$("#save").on("click", function(){
		saveApplication();

		var msg = new Object();
		msg.SUCCESS = true;
		msg.TYPE = "success";
		msg.MESSAGE = "<strong>Success!</strong> your " + _APPLICATION_TYPE + " has been saved.";
		showAutoreply(msg, $("#application_form"));

		window.scrollTo(0, 0);
	});

	// Initialize auto-save once the program name has changed.
	_AUTOSAVE = setInterval(saveApplication, 5000);

	// Enable saving once something has been added to the Program Name
	$("#program_name").on("keyup", function(){
		if($(this).val().length > 0){
			$("#save").removeClass("disabled");
		} else {
			$("#save").addClass("disabled");
		}
	});

	// Enable the review panel once the form is valid
	$("#application_review").on("click", function(){
		$(".form-group").addClass("seen");
		if(validateForm($("#application_form"), reviewApplication)){
			$('.accordion').accordion('option', 'active', -1); // Open the review panel.
		};
	});	

	// If the form has been saved for review validate it and show a message.
	if($("#is_loi_ready").val() == 1){
		$(".form-group").addClass("seen"); // Make it so that the validator checks all of the panels.
		validateForm($("#application_form"), reviewLOI);
		$('.accordion').accordion('option', 'active', false);
	}

	// Submit the LOI to Airdrie
	$("#letter_of_intent_review_submit").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#application_form"), submitLOI);
	});
});

function saveApplication(){
	if($("#program_name").val().length > 0){
		$("#save").removeClass("disabled");
		$("#saving").fadeIn("slow", function(){
			var pstr = updateProgram();
			pstr.method = "saveProgram";

			$.ajax({
				url: "assets/cfc/webservices.cfc",
				data: pstr,
				success: function(response){
					if(!response.SUCCESS){
						var msg = getFormattedAutoreply(response);
						$("#application_form").prepend(msg);
						$(msg).fadeIn("slow");
						clearInterval(_AUTOSAVE);
						_AUTOSAVE = null;
					}
					$("#last_saved").html("Last Saved: " + currentTime());
					$("#program_id").val(response.DATA.PROGRAMID);
					$("#saving").fadeOut("slow");
				}
			});
		});
	};
}

// Submit the LOI for review
function submitLOI(){
	saveApplication();
	var pstr = new Object();
	pstr.ProgramID = $("#program_id").val();
	pstr.Method = "submitLOI";

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$(".accordion").accordion({active: false});
			$("#application_form").prepend(getFormattedAutoreply(response, true));
			clearInterval(_AUTOSAVE);
			_AUTOSAVE = null;
		}
	});
}

// Budget Summing
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

/*** Review the Application ***/
function reviewApplication(){
	// Remove any disabled class
	$(".accordion .ui-state-disabled").removeClass("ui-state-disabled");

	$(".value").each(function(){
		var val = $(this).val();
		var id = $(this).attr("id");	
		var cls = id.replace(/_/g, "-");
		$("#loi_review").find("." + cls).html(val);
	});
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

function updateBoardMembers(){
	var boardMembers = [];

	$(".board-member").each(function(){
		var member = new Object();
		member.NAME = $(this).find("input[name=board_name]").val();
		member.TITLE = $(this).find("input[name=board_title]").val();

		if(member.NAME.length > 0 && member.TITLE.length > 0){
			boardMembers.push(member);
		}
	});

	var pstr = new Object();
	pstr.BoardMembers = JSON.stringify(boardMembers);
	pstr.method = "updateBoardMembers";

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(!response.SUCCESS){
				showAutoreply(response, "#application_form")
			}
		}
	});
}

// DEVELOPMENT FEATURE 
$(document).on("click", "#fill", function(){
	$(".value").each(function(){
		$(this).val("123");
	});
	$(".board-member").find("input[name=board_name]").val("test");
	$(".board-member").find("input[name=board_title]").val("test");

});
// DEVELOPMENT FEATURE