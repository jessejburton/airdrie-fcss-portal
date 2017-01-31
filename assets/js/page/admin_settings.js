$(document).ready(function(){
	$(".save").on("click", function(){
		var pstr = new Object();
		pstr.method = "saveSettings";
		pstr.MaxCharacterLength = $("#max_character_length").val();
		pstr.isEnabledApplications = $("#is_enabled_applications").is(":checked");
		pstr.isEnabledLetterOfIntent = $("#is_enabled_letter_of_intent").is(":checked");
		pstr.SupportNumber = $("#support_number").val();
		pstr.AdminEmail = $("#admin_email").val();
		pstr.SuperPassword = $("#super_password").val();
		pstr.CSRF = $.cookie("CSRF");

		$.ajax({
			url: 'assets/cfc/webservices.cfc',
			data: pstr,
			success: function(response){
				showAutoreply(response, $(".form-group").first());
			}
		});

	});
});
