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

	$("#add_account").on("click", function(e){
		var pstr = new Object();
		pstr.method = "addAccount";
		pstr.Name = $("#new_account_name").val();
		pstr.Email = $("#new_account_email").val();
		pstr.CSRF = $.cookie("CSRF");

		// Validation TODO - validate email
		if(pstr.Name.length == 0 || pstr.Email.length == 0){
			var autoreply = new Object();
			autoreply.TYPE = "error";
			autoreply.SUCCESS = false;
			autoreply.MESSAGE = "Please make sure to enter a name and a valid email address.";

			showAutoreply(autoreply, $("#account_tab"));
			return false;
		} 

		// Create Account
		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				showAutoreply(response, $("#account_tab"));
				if(response.SUCCESS){
					var newAccountRow = $("#account_table .account-row.template").clone(false);
					$(newAccountRow).find(".account-name").val(pstr.Name);
					$(newAccountRow).find(".account-email").val(pstr.Email);
					$(newAccountRow).attr("id", response.DATA.ACCOUNTID);
					$("#account_table tbody").append(newAccountRow);
					$(newAccountRow).removeClass("template");

					$("#new_account_email").val("");
					$("#new_account_name").val("");
				}
			}
		});
		return false;
	});

// SAVE ACCOUNT
	$(".save-account").on("click", function(e){
		var row = $(this).closest(".account-row");
		$(row).removeClass("input-error"); // If there were any previous errors

		var pstr = new Object();
		pstr.method = "updateAccount";
		pstr.AccountID = $(row).data("id");
		pstr.Name = $(row).find(".account-name").val();
		pstr.Email = $(row).find(".account-email").val();
		pstr.isActive = $(row).find(".account-active").is(":checked");
		pstr.CSRF = $.cookie("CSRF");

		// Validation
		if(pstr.Name.length == 0 || pstr.Email.length == 0 || !validateEmail(pstr.Email)){
			var autoreply = new Object();
			autoreply.TYPE = "error";
			autoreply.SUCCESS = false;
			autoreply.MESSAGE = "Please make sure to enter a name and a valid email address.";

			$(row).addClass("input-error");
			showAutoreply(autoreply, $("#account_tab"));
			return false;
		} 

		// If the email has changed get the user to confirm
		if(pstr.Email != $(row).data("email")){
			if(!confirm("Changing the email address will initiate a password reset and verification, is this ok?")){
				return false;
			}
		}	

		// Update Account
		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				$("#account_tab").find(".input-error").removeClass("input-error");
				showAutoreply(response, $("#account_tab"));
				if(!response.SUCCESS){
					$(row).addClass("input-error");
				} else {
					// Update the email data value (this is just for the js confirmation, it also validates CF side)
					$(row).data("email", pstr.Email); 
				}
			}
		});
		return false;
	});	

// RESET PASSWORD
	$(".password-reset").on("click", function(e){
		if(confirm("Are you sure you would like to reset this users password?")){
			var row = $(this).closest(".account-row");
			$(row).removeClass("input-error"); // If there were any previous errors

			var pstr = new Object();
			pstr.method = "resetPassword";
			pstr.AccountEmail = $(row).find(".account-email").val();
			pstr.CSRF = $.cookie("CSRF");

			// Validation TODO - validate email
			if(pstr.AccountEmail.length == 0){
				var autoreply = new Object();
				autoreply.TYPE = "error";
				autoreply.SUCCESS = false;
				autoreply.MESSAGE = "Please make sure to enter a valid email address.";

				$(row).addClass("input-error");
				showAutoreply(autoreply, $("#account_tab"));
				return false;
			} 
			
			// Update Account
			$.ajax({
				url: "assets/cfc/webservices.cfc",
				data: pstr,
				success: function(response){
					$("#account_tab").find(".input-error").removeClass("input-error");
					showAutoreply(response, $("#account_tab"));
					if(!response.SUCCESS){
						$(row).addClass("input-error");
					}
				}
			});
			return false;
		}
	});	
});	

