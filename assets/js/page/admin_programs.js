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