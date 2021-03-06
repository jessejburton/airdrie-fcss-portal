/* Reviewing a program
*********************************************************************************************/
$(document).on("click", ".program-review", function(){
	var programID = $(this).closest(".program").data("programid");
	window.open("admin_create_package.cfm?ProgramID=" + programID);
});

/* Approving a program
*********************************************************************************************/
$(document).on("click", ".program-approve", function(){
	var program = $(this).closest(".program");
	
	$("#message").html($("#enterpassword").clone(false).removeClass("hidden"));
	$("#message").find("#confirm_approve_program").on("click", function(){
		var pstr = new Object();
				pstr.method = "checkAccountPassword";
				pstr.pword = $("#message #your_password").val();
				pstr.CSRF = $.cookie("CSRF");

			$.ajax({
				url: "assets/cfc/webservices.cfc",
				data: pstr,
				async: true,
				success: function(response){
					if(response.SUCCESS){
						markApproved(program);
					} else {
						showAutoreply(response, $("#message"));
					}
				}
			});
	});
	showMessage();
});

/* Funding a program
*********************************************************************************************/
$(document).on("click", ".program-fund", function(){
    var program = $(this).closest(".program");
    	amount = program.find(".allocate-fund-amount").val();

	// Make sure they have entered a value	
	if(amount.length == 0){
		showAutoreply({"SUCCESS":false,"TYPE":"error","MESSAGE":"Please enter an amount to allocate"}, program.find(".fund-section"));
		return false;
	}

	$("#message").html($("#superadmin").clone(false).removeClass("hidden"));
	$("#message").find("#fund_amount").html(program.find(".allocate-fund-amount").val());
	$("#message").find("#confirm_fund_program").on("click", function(){
			var pstr = new Object();
				pstr.method = "checkAccountAndSuperPassword";
				pstr.pword = $("#message #your_account_password").val();
				pstr.spword = $("#message #super_account_password").val();
				pstr.CSRF = $.cookie("CSRF");

			$.ajax({
				url: "assets/cfc/webservices.cfc",
				data: pstr,
				async: true,
				success: function(response){
					if(response.SUCCESS){
						fundProgram(program);
					} else {
						showAutoreply(response, $("#message"));
					}
				}
			});
	});
	showMessage();
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

function markApproved(program){
	var pstr = new Object();
		pstr.programID = program.data("programid");
		pstr.Method = "markApplicationApproved";
		pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(response.SUCCESS){
				hideMessage();
				program.remove();
			}
			showAutoreply(response, ".wrapper")
		}
	});
}


function fundProgram(program){
	var pstr = new Object();
		pstr.programID = program.data("programid");
		pstr.amount = amount;
		pstr.Method = "markProgramFunded";
		pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(response.SUCCESS){
				program.find(".fund-section").html("Funded in the amount of $" + pstr.amount);
				hideMessage();
			}
			showAutoreply(response, program)
		}
	});	
}
	