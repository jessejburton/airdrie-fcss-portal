$(document).on("click", "#verify_submit", function(){
	// Validate a match
	if($("#password").val().length > 0 && $("#verify_password").val().length >0){
		if($("#password").val() != $("#verify_password").val()){
			var response = new Object();
			response.SUCCESS = false;
			response.TYPE = "error";
			response.MESSAGE = "<p>Passwords must match.</p>";
			showAutoreply(response, $("#password_verify_group"));
		} else {
			// Update the users password
			var pstr = new Object();
			pstr.method = "verifyAccountAndSetPassword";
			pstr.GUID = $("#guid").val();
			pstr.EMAILHASH = $("#emailhash").val();
			pstr.PLAINPW = $("#password").val();
			pstr.CSRF = $.cookie("CSRF");

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
	} else {
		showAutoreply({"TYPE":"error","MESSAGE":"Please enter your password and verify it."}, $("#password_verify_group"));
	}
});