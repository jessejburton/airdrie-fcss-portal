/* Reviewing a program
*********************************************************************************************/
$(document).on("click", ".program-review", function(){
	var programID = $(this).closest(".program").data("programid");
	window.open("admin_create_package.cfm?ProgramID=" + programID);
});

/* Approving a program
*********************************************************************************************/
$(document).on("click", ".program-approve", function(){
	if(confirm("Are you sure you would like to approve this?")){
	    var program = $(this).closest(".program");
		var pstr = new Object();
			pstr.programID = program.data("programid");
			pstr.Method = "markApplicationApproved";
			pstr.CSRF = $.cookie("CSRF");

		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				if(response.SUCCESS){
					program.remove();
				}
				showAutoreply(response, ".wrapper")
			}
		});
	}
});

/* Funding a program
*********************************************************************************************/
$(document).on("click", ".program-fund", function(){
    var program = $(this).closest(".program");
	var pstr = new Object();
		pstr.programID = program.data("programid");
		pstr.amount = program.find(".allocate-fund-amount").val();
		pstr.Method = "markProgramFunded";
		pstr.CSRF = $.cookie("CSRF");

	// Make sure they have entered a value	
	if(pstr.amount == 0 || pstr.amount.length == 0){
		showAutoreply({"SUCCESS":false,"TYPE":"error","MESSAGE":"Please enter an amount to allocate"}, program.find(".fund-section"));
		return false;
	}

	if(confirm("Are you sure you would like to fund this program?")){
		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				if(response.SUCCESS){
					program.find(".fund-section").html("Funded in the amount of $" + pstr.amount);
				}
				showAutoreply(response, program)
			}
		});
	}
});

/* Hitting enter to allocate funds 
***********************************************************************************************/
$(document).on("keydown", ".allocate-fund-amount", function(e){
	 var code = e.keyCode || e.which;
	 if(code == 13) {
	 	var program = $(this).closest(".program");
	 	program.find(".program-fund").trigger("click");
	 }
});