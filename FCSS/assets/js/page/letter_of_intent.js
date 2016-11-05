"use strict"

$(document).ready(function(){
	$("#letter_of_intent_submit").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#letter_of_intent_form"), reviewLOI);
	});
});

// Add the functionality to add more rows
$(document).on("click", ".add-board", function(){
	var sm = $(".board-member").first().clone(false);
	sm.find("input").val("");
	$("#board_list").append(sm);
	sm.find("input").first().focus();
});

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
	// Remove disabled class
	$(".accordion .ui-state-disabled").removeClass("ui-state-disabled");
	$('.accordion').accordion('option', 'active', -1);
}
