"use strict"

$(document).ready(function(){
	$("#letter_of_intent_submit").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#letter_of_intent_form"), reviewLOI);
	});

	setInterval(saveLOI, 5000);
});

function saveLOI(){
	$("#saving").fadeIn("slow", function(){
		// TODO - Write the save function
		$(this).fadeOut("slow");
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

$(document).on("click", "#letter_of_intent_review_submit", function(){
	// TODO - should re-validate the form to be safe
	var pstr = new Object();
	pstr = new LOI();
	pstr.method = "saveApplication";

	$.ajax({
		url: "assets/cfc/ApplicationForm.cfc",
		data: pstr,
		success: function(response){
			$("#letter_of_intent_form").hide();
			$("#letter_of_intent_complete").addClass("autoreply autoreply-success").removeClass("hidden").fadeIn("slow");
		}
	});
});

/*** Review the Letter of Intent ***/
function reviewLOI(){
	// Remove disabled class
	$(".accordion .ui-state-disabled").removeClass("ui-state-disabled");
	$('.accordion').accordion('option', 'active', -1);

	$(".value").each(function(){
		var val = $(this).val();
		var id = $(this).attr("id");	
		var cls = id.replace(/_/g, "-");
		$("#loi_review").find("." + cls).html(val);
	});
}

function LOI(){
	this.ProgramName = $("#program_name").val();
	this.ProgramStatement = $("#program_statement").val();
	this.TargetAudience = $("#target_audience").val();
	this.PrimaryContactName = $("#primary_name").val();
	this.PrimaryPhone = $("#primary_phone").val();
	this.PrimaryEmail = $("#primary_email").val();
	this.Address = $("#program_address").val();
	this.MailingAddress = $("#program_mailing_address").val();
	this.Need = $("#need_description").val();
	this.Goal = $("#goal_description").val();
	this.Strategies = $("#strategies_description").val();
	this.Rationale = $("#rationale_description").val();
	this.Footnotes = $("#footnotes_description").val();
	this.PreventionFocus = $("#fcss_prevention_focus").val();
	this.Alignment = $("#alignment").val();
	this.MissionFit = $("#agency_mission_fit").val();
	this.Partnerships = $("#considered_partnerships").val();
	var LocalBoardMembers = [];
		$(".board-member").each(function(){
			var member = {};
			member.name = $(this).find("input[name=board_name]").val();
			member.title = $(this).find("input[name=board_title]").val();
			LocalBoardMembers.push(member);
		});
	this.BoardMembers = LocalBoardMembers;
	this.ShortTermGoals = $("#short_term_goals").val();
	this.MidTermGoals = $("#mid_term_goals").val();
	this.LongTermGoals = $("#long_term_goals").val();
	this.AmountFromAirdrie = $("#amount_from_airdrie").val();
	this.AmountFromOther = $("#amount_from_other").val();
}

// TESTING 
$(document).on("click", "#fill", function(){
	$(".value").each(function(){
		$(this).val("123");
	});
	$(".board-member").find("input[name=board_name]").val("test");
	$(".board-member").find("input[name=board_title]").val("test");

});
// TESTING