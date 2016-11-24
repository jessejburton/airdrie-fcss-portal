/*********************************************************/
/* 			BUDGET										 */
/*********************************************************/

$(document).ready(function(){
	$(".table").each(function(){
		updateTableColumns($(this));
	});
});

// Show the staffing section if staffind is selected
$(document).on("change", ".expenditure_source", function(){
	// Find out if any of the select boxes have Staffing selected, otherwise hide the staffing section
	$(".expenditure_source").each(function(){
		if(this.options[this.selectedIndex].innerHTML == "Staffing Costs"){
			$("#staffing").removeClass("hidden");
		} else {
			$("#staffing").addClass("hidden");
		}
	});
});

// Add the functionality to add more rows
$(document).on("click", ".add-row", function(){
	var tr = $(this).closest(".table").find("tbody tr.row-template").clone(false);
	tr.find("input").val("");
	$(this).closest(".table").find("tbody").append(tr);
	tr.find("select").focus();
	tr.removeClass("row-template");
});

// Total the expenditures
$(document).on("keyup", ".expenditure-add-value", function(){
	var total = 0;
	$(".expenditure-add-value").each(function(){
		if($(this).val().length > 0 && !isNaN($(this).val())){
			total = total + parseFloat($(this).val());
		}
	});
	$("#expenditure_total").html("$ " + total.toFixed(2));

	updateTableColumns($(this).closest(".table"));
});

// Add the functionality for totaling revenu
$(document).on("keyup", ".revenue-add-value", function(){
	var total = 0;
	var total_div = $(this).closest("tr").find(".row-total");

	$(this).closest("tr").find(".revenue-add-value").each(function(){
		var val = $.trim( $(this).val() );

		if ( val ) {
	        val = parseFloat( val.replace( /^\$/, "" ) );

	        total += !isNaN( val ) ? val : 0;
	    }
	});
	
	total_div.val(total.toFixed(2));
	updateTableColumns($(this).closest(".table"));
});

// Add the functionality for totaling revenu
$(document).on("keyup", ".staffing-add-value", function(){
	updateTableColumns($(this).closest(".table"));
});

// Make tab add a new row if in the last input column
$(document).on("keydown", ".tab-add-row", function(e){
	var add_button = $(this).closest(".table").find(".add-row");

	if (e.which == 9 && $(this).val() != "") {
	  	add_button.trigger("click");
	}
});

// Add ability to remove budget items
$(document).on("click", ".remove-item", function(e){
	var sender = this;
	var table = $(this).closest(".table");

	if(confirm("Are you sure you would like to remove this budget item?")){
		$(sender).closest("tr").remove();
		updateTableColumns(table);
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
	table.find(".table-total").val(total);
	checkTotals();
};

function checkTotals(){
	var expenditures = parseFloat($("#expenditure_total_val").val());
	var revenues = parseFloat($("#revenue_total_val").val());

	// If there are more expenses than revenues let the user know.
	if(expenditures > revenues){
		$("#expenditure_revenue_valid").val(0);
		$(".table-total-row").addClass("error");
	} else {
		$(".table-total-row").removeClass("error");
		$("#expenditure_revenue_valid").val(1);
	}
}

