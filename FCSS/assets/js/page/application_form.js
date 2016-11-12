"use strict"

$(document).ready(function(){
	$("#application_review_submit").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#application_form"), submitApplication);
	});
});

// Add the functionality to add more rows
$(document).on("click", ".add-row", function(){
	var tr = $(this).closest(".table").find("tbody tr").first().clone(false);
	tr.find("input").val("");
	$(this).closest(".table").find("tbody").append(tr);
	tr.find("select").focus();
});

// Add the functionality for totaling rows
$(document).on("keyup", ".add-value", function(){
	var total = 0;
	var total_div = $(this).closest("tr").find(".row-total");

	$(this).closest("tr").find(".add-value").each(function(){
		var val = $.trim( $(this).val() );

		if ( val ) {
	        val = parseFloat( val.replace( /^\$/, "" ) );

	        total += !isNaN( val ) ? val : 0;
	    }
	});
	
	total_div.val(total.toFixed(2));

	updateTableColumns($(this).closest(".table"));
});

// Make tab add a new row if in the last input column
$(document).on("keydown", ".tab-add-row", function(e){
	var add_button = $(this).closest(".table").find(".add-row");

	if (e.which == 9 && $(this).val() != "") {
	  	add_button.trigger("click");
	}
});

// Add the functionality for totaling columns
function updateTableColumns(table){
	var total = 0;
	var total_div = table.find(".col-total");

	table.find(".row-total").each(function(){
		var val = $.trim( $(this).val() );

		if ( val ) {
	        val = parseFloat( val.replace( /^\$/, "" ) );

	        total += !isNaN( val ) ? val : 0;
	    }
	});
	
	total_div.removeClass("faded");
	total_div.html("$ " + total.toFixed(2));
};

function submitApplication(){
	var pstr = new Object();
	pstr.method = "allocateFunds";

	$.ajax({
		url: "assets/cfc/testing.cfc",
		data: pstr,
		success: function(response){
			$("#application_form").hide();
			$("#application_form_complete").addClass("autoreply autoreply-success").removeClass("hidden").fadeIn("slow");
		}
	})	
}