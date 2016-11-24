$(document).ready(function(){
	//$('.accordion').accordion('option', 'active', 0); // Open the first panel - Had it open but I think it makes more sense to be closed.

	$(".save").on("click", function(){
		validateForm("#agency_information_form", saveAgencyInformation);
	});

	$("#save_board_members").on("click", function(e){
		updateBoardMembers();
	});

	$("#add_account").on("click", function(e){
		var pstr = new Object();
		pstr.method = "addAccount";
		pstr.Name = $("#new_account_name").val();
		pstr.Email = $("#new_account_email").val();

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
	$(document).on("click", ".save-account", function(e){
		var row = $(this).closest(".account-row");
		$(row).removeClass("input-error"); // If there were any previous errors

		var pstr = new Object();
		pstr.method = "updateAccount";
		pstr.AccountID = $(row).data("id");
		pstr.Name = $(row).find(".account-name").val();
		pstr.Email = $(row).find(".account-email").val();
		pstr.isActive = $(row).find(".account-active").is(":checked");

		// Validation TODO - validate email
		if(pstr.Name.length == 0 || pstr.Email.length == 0){
			var autoreply = new Object();
			autoreply.TYPE = "error";
			autoreply.SUCCESS = false;
			autoreply.MESSAGE = "Please make sure to enter a name and a valid email address.";

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
	});

// RESET PASSWORD
	$(document).on("click", ".password-reset", function(e){
		var row = $(this).closest(".account-row");
		$(row).removeClass("input-error"); // If there were any previous errors

		var pstr = new Object();
		pstr.method = "resetPassword";
		pstr.AccountEmail = $(row).find(".account-email").val();

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
	});	
});

// Save the agency information
function saveAgencyInformation(){
	var pstr = new Object();
	pstr.method = "updateAgency";
	pstr.Name = $("#agency_name").val();
	pstr.Mission = $("#agency_mission").val();
	pstr.Vision = $("#agency_vision").val();
	pstr.Phone = $("#agency_phone").val();
	pstr.Fax = $("#agency_fax").val();
	pstr.Email = $("#agency_email").val();
	pstr.Address = $("#agency_address").val();
	pstr.MailingAddress = $("#agency_mailing").val();
	pstr.Website = $("#agency_website").val();	

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(!response.SUCCESS){
				$(".heading-success").removeClass("heading-success").addClass("heading-error");
			}
			$('.accordion').accordion('option', 'active', 0); // Open the first panel
			showAutoreply(response, $("#agency_information_form"));
			window.scrollTo(0, 0);
		}
	});
}