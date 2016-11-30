/*********************************************************/
/* 			BUDGET										 */
/*********************************************************/

/*****************************************  HANDLERS  ***********************************************/

$(document).ready(function(){
	$(".table").each(function(){
		updateTableColumns($(this));
	});

	// Handle the UI for the sliders, make it so they have to add up to 100%;
	var sliders = $(".slider"),
    smax = 100,
    smin = 0;

	sliders.each(function() {
	    var availableTotal = smax;

	    $(this).empty().slider({
	        value: parseInt($(this).parent().data("value")),
	        // Check - is this the adult slider? 
	        min: (this.id === 'percent_child') ? 0 : smin,
	        max: smax,
	        range: 'min',
	        step: 5,
	        create: function(event, ui){
	        	$(this).siblings().text(parseInt($(this).parent().data("value")) + ' %');
	        },
	        slide: function(event, ui) {
	            // Update display to current value
	            $(this).siblings().text(ui.value + ' %');

	            // Get current total
	            var total = 0;

	            sliders.not(this).each(function() {
	                total += $(this).slider("option", "value");
	            });

	            // Need to do this because apparently jQ UI
	            // does not update value until this event completes
	            total += ui.value;

	            var max = availableTotal - total;

	            // Update each slider
	            sliders.not(this).each(function() {
	                var t = $(this),
	                    value = t.slider("option", "value");

	                t.slider("option", "max", max + value)
	                    .siblings().text(value + ' %');
	                t.slider('value', value);
	            });
	        }
	    });
	});	
});

// Show the staffing section if staffind is selected
$(document).on("change", ".expenditure_source", function(){
	// Find out if any of the select boxes have Staffing selected, otherwise hide the staffing section
	$("#staffing").addClass("hidden");
	$(".expenditure_source").each(function(){
		if(this.options[this.selectedIndex].innerHTML == "Staffing Costs"){
			$("#staffing").removeClass("hidden");
		}
	});
	checkTotals();
});

// Add the functionality to add more rows
$(document).on("click", ".add-row", function(){
	var tr = $(this).closest(".table").find("tbody tr.row-template").clone(false);
	tr.find("input").val("");
	$(this).closest(".table").find("tbody").append(tr);
	tr.find(".source").focus();

	/* 	Removing then adding the row template means the most recently added row will always be the template
		this way the remove row only shows on the bottom row. */
	$(this).closest(".table").find(".row-template").removeClass("row-template");
	tr.addClass("row-template");
});

// Total the expenditures
$(document).on("keyup", ".expenditure-add-value", function(){
	var total = 0;
	var row = $(this).closest("tr");

	$(".expenditure-add-value").each(function(){
		if($(this).val().length > 0 && !isNaN($(this).val())){
			total = total + parseFloat($(this).val());
		}
	});

	$("#expenditure_total").html("$ " + total.toFixed(2));
	row.find(".row-total").val(total);
	
	updateTableColumns($(this).closest(".table"));
});

// Add the functionality for totaling revenue
$(document).on("keyup", ".revenue-add-value", function(){
	var total = 0;
	var row = $(this).closest("tr");

	row.find(".revenue-add-value").each(function(){
		var val = $.trim( $(this).val() );

		if ( val ) {
	        val = parseFloat( val.replace( /^\$/, "" ) );

	        total += !isNaN( val ) ? val : 0;
	    }
	});

	updateTableColumns($(this).closest(".table"));
});

// Add the functionality for totaling revenue
$(document).on("keyup", ".staffing-add-value", function(){
	updateTableColumns($(this).closest(".table"));
});

/* TODO - this needs work, I am trying to get the tab key to add a new row automatically, 
	but only if you are in the bottom row and the row has a value - Have tried a couple different
	ways with no luck so far. */
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

/************************************ FUNCTIONS ********************************************/

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
	$("#revenue_table, #expense_table").find(".row-error-message").html("");
	$(".table-total-row").removeClass("error");
	$("#expenditure_revenue_valid").val(1);

	if(expenditures > revenues){
		$("#expenditure_revenue_valid").val(0);
		$(".table-total-row").addClass("error");
		$("#revenue_table, #expense_table").find(".row-error-message").html("Your expenses exceed your revenues.");
	}

	// Check the totals of the staff
	var staff_total = 0.00;
	$(".staff-expense-row").removeClass("staff-expense-row").removeClass("error");
	$(".expenditure_source").each(function(){
		if(this.options[this.selectedIndex].innerHTML == "Staffing Costs"){
			staff_total = staff_total + parseFloat($(this).closest("tr").find(".row-total").val());
			$(this).closest("tr").addClass("staff-expense-row");
		}
	});
	$("#staffing_total").html(parseFloat(staff_total).toFixed(2).toString());

	// If the Staff total does not match the amount selected for staff in expenses show an error
	$("#staff_table_footer").removeClass("error");
	$(".staff-expense-row").removeClass("error");
	$("#staff_table_footer").find(".row-error-message").html("");
	$("#staff_valid").val(1);
	if(parseFloat(staff_total) != $("#staffing_total_val").val() && !$("#staffing").hasClass("hidden")){
		$("#staff_valid").val(0);
		$("#staff_table_footer, .staff-expense-row").addClass("error");
		$("#staff_table_footer").find(".row-error-message").html("Your staff total does not add up to your expense line items.");
	}
}

// Get an array with all of the Revenue's
function getRevenueArray(){
 	var revenues = [];

	$(".revenue-item:not(.airdrie)").each(function(){
		var i = new Object();
		i.SOURCEID = $(this).find(".source").val();
		if(i.SOURCEID != ""){ // Only save the item if the source has been selected
			i.PREVIOUSYEARBUDGET = $(this).find(".prev-year").val();
			i.REVENUEAMOUNT = $(this).find(".revenue-amount").val();

			if(i.PREVIOUSYEARBUDGET.length == 0) i.PREVIOUSYEARBUDGET = 0;
			if(i.REVENUEAMOUNT.length == 0) i.REVENUEAMOUNT = 0;

			revenues.push(i);
		}
	});

	return revenues;
}

// Get an array with all of the expenses
function getExpenseArray(){
 	var expenses = [];

	$(".expenditure-item").each(function(){
		var i = new Object();
		i.SOURCEID = $(this).find(".source").val();
		if(i.SOURCEID != ""){ // Only save the item if the source has been selected
			i.PREVIOUSYEARBUDGET = $(this).find(".prev-year").val();
			i.FUNDEDOTHER = $(this).find(".funded-other").val();
			i.FUNDEDAIRDRIE= $(this).find(".funded-airdrie").val();

			if(i.PREVIOUSYEARBUDGET.length == 0) i.PREVIOUSYEARBUDGET = 0;
			if(i.FUNDEDOTHER.length == 0) i.FUNDEDOTHER = 0;
			if(i.FUNDEDAIRDRIE.length == 0) i.FUNDEDAIRDRIE = 0;

			expenses.push(i);
		}
	});

	return expenses;
}

/* 	Get an array with all of the staff members (This will be updated regardless of if they have staffing as a source)
	the system will ignore the values if they don't have items - TODO Might want to update this to delete them if 
	staffing is not selected if it causes problems. */
function getStaffArray(){
	var staff = [];

	$(".staffing-row").each(function(){
		var i = new Object();
		i.TITLE = $(this).find(".staff-title").val();
		i.AMOUNT = $(this).find(".staffing-add-value").val();

		if(i.AMOUNT.length == 0) i.AMOUNT = 0;

		if(i.TITLE.length > 0){
			staff.push(i);
		}
	});

	return staff;
}

function getDistributionTotals(){
	var totals = [];

	$(".slider").each(function(){
		var i = new Object();
		i.type = "Percent" + $(this).attr("id").split("_")[1];
		i.value = $(this).slider('option', 'value');
		totals.push(i);
	});

	return totals;
}

function saveBudget(){
	var pstr = new Object();
	pstr.method = "saveBudget";
	pstr.BUDGETID = $("#BudgetID").val();
	pstr.REVENUES = JSON.stringify(getRevenueArray());
	pstr.EXPENSES = JSON.stringify(getExpenseArray());
	pstr.STAFF = JSON.stringify(getStaffArray());
	pstr.PREVIOUSYEARBUDGET = $("#previous_year_budget").val();
	pstr.REQUESTEDFROMAIRDRIE = $("#requested_from_airdrie").val();
	pstr.REVENUESEXPLANATION = $("#revenues_explanation").val();
	pstr.EXPENDITURESEXPLANATION = $("#expenditures_explanation").val();
	pstr.DISTRIBUTIONTOTALS = JSON.stringify(getDistributionTotals());

	if(pstr.PREVIOUSYEARBUDGET.length == 0) pstr.PREVIOUSYEARBUDGET = 0;
	if(pstr.REQUESTEDFROMAIRDRIE.length == 0) pstr.REQUESTEDFROMAIRDRIE = 0;	
	
	$("#saving").fadeIn("slow", function(){
		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				console.log(response);
				$("#last_saved").html("Last Saved: " + currentTime());
				$("#saving").fadeOut("slow");
			}
		});		
	});
}

