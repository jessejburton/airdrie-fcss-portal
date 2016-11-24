$(document).on("click", "#verify_submit", function(){
	// Validate a match
	if($("#password").val() != $("#verify_password").val()){
		var response = new Object();
		response.SUCCESS = false;
		response.TYPE = "error";
		response.MESSAGE = "<p>Passwords must match.</p>";
		$("#password_verify_group").prepend(getFormattedAutoreply(response, true));

	} else {
		// Update the users password
		var pstr = new Object();
		pstr.method = "verifyAccountAndSetPassword";
		pstr.GUID = $("#guid").val();
		pstr.EMAILHASH = $("#emailhash").val();
		pstr.PLAINPW = $("#password").val();

		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				$(".autoreply").remove();
				showAutoreply(response, $("#password_verify_group"));
				if(response.SUCCESS){
					$("#verify_password").val("");
					$("#password").val("");
				}
			}
		});
	}
});