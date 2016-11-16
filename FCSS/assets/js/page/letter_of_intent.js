var _AUTOSAVE = null;

$(document).ready(function(){
	$(".save").on("click", function(){
		if($(this).attr("id") == "letter_of_intent_review_save"){
			// Update the saved for review flag and close the accordion
			$("#saved_for_review").val(1);
			$(".accordion").accordion({active: false});
		}

		saveLOI();

		var msg = new Object();
		msg.SUCCESS = true;
		msg.TYPE = "success";
		msg.MESSAGE = "<strong>Success!</strong> your Letter of Intent has been saved.";
		$("#letter_of_intent_form").prepend(getFormattedAutoreply(msg, true));

		window.scrollTo(0, 0);
	});

	// If the LOI has been submitted, hide the form
	if($("#program_status").val() == "LOI - Submitted"){
		$("#letter_of_intent_form").hide();
	}

	// Initialize auto-save once the program name has changed.
	_AUTOSAVE = setInterval(saveLOI, 5000);

	// Enable saving once something has been added to the Program Name
	$("#program_name").on("keyup", function(){
		$("#save").removeClass("disabled");
	});

	// Enable the review panel once the form is valid
	$("#letter_of_intent_submit").on("click", function(){
		$(".form-group").addClass("seen");
		if(validateForm($("#letter_of_intent_form"), reviewLOI)){
			$('.accordion').accordion('option', 'active', -1); // Open the review panel.
		};
	});	

	// If the form has been saved for review validate it and show a message.
	if($("#is_loi_ready").val() == 1){
		$(".form-group").addClass("seen"); // Make it so that the validator checks all of the panels.
		validateForm($("#letter_of_intent_form"), reviewLOI);
		$('.accordion').accordion('option', 'active', false);
	}

	// Submit the LOI to Airdrie
	$("#letter_of_intent_review_submit").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#letter_of_intent_form"), submitLOI);
	});
});

function saveLOI(){
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
						$("#letter_of_intent_form").prepend(msg);
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
	saveLOI();
	var pstr = new Object();
	pstr.ProgramID = $("#program_id").val();
	pstr.Method = "submitLOI";

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$(".accordion").accordion({active: false});
			$("#letter_of_intent_form").prepend(getFormattedAutoreply(response, true));
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

/*** Review the Letter of Intent ***/
function reviewLOI(){
	$("#is_loi_ready").val(1);
	// Remove disabled class
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
	program.isLOIReady = $("#is_loi_ready").val();

	if(!isNaN($("#estimated_from_airdrie").val())) program.EstimatedFromAirdrie = parseFloat($("#estimated_from_airdrie").val());
	if(!isNaN($("#estimated_from_other").val())) program.EstimatedFromOther = parseFloat($("#estimated_from_other").val());

	return program;
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