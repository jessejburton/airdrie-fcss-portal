var interval; 	// Used for timeout after password try

$(document).ready(function(){	
	// Show the registration form if clicking on the register button
	$("#register_btn").on("click", function(){
		$("#login").fadeOut("slow", function(){
			$("#register").fadeIn("slow");
		});
	});

	$("#login_form").submit(function(){
		return login();
	});

	$("#register_agency_submit").on("click", function(){
		validateForm($("#register_form"), register);
	});

	$("#forgot_btn").on("click", function(){
		clearAutoreply();
		var pstr = new Object();
		pstr.method = "resetPassword";
		pstr.AccountEmail = $("#login_email").val();
		pstr.CSRF = $.cookie("CSRF");

		if(pstr.AccountEmail.length == 0) {
			var autoreply = new Object();
			autoreply.SUCCESS = false;
			autoreply.TYPE = "error";
			autoreply.MESSAGE = "<strong>Error!</strong> Please enter the email address associated with the account.";
			$("#login_email").addClass("input-error");
			showAutoreply(autoreply, $("#login_form_group"));
		} else {
			// Update Account
			$.ajax({
				url: "assets/cfc/webservices.cfc",
				data: pstr,
				success: function(response){
					clearAutoreply();
					showAutoreply(response, $("#login_form_group"));
					if(!response.SUCCESS){
						$(row).addClass("input-error");
					}
				}
			});
		}
	});
});

// Login Function
function login(){
	// disable the login button
	$("#login_submit").prop("disabled", true);

	var pstr = new Object();
	pstr.method = "loginAccount";
	pstr.email = $("#login_email").val();
	pstr.plainpw = $("#login_password").val();
	pstr.CSRF = $.cookie("CSRF");

	$("#login_form_group").find(".autoreply").remove();

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		method: "POST",
		success: function(response){
			if(response.SUCCESS){
				window.location = "index.cfm";
			} else {
				$("#timeleft").find("span").text(3);			// Set the time to 3 seconds
				$("#timeleft").show();
				interval = setInterval(showTimeLeft, 1000); 	// Start the countdown
				var msg = getFormattedAutoreply(response, true);
				$("#login_form_group").prepend(msg);
			}
		}
	});

	return false;
}

// Register the Agency
function register(){
	var pstr = new Object();
	pstr.method = "addAgency";
	pstr.Name = $("#agency_name").val();
	pstr.Mission = $("#agency_mission").val();
	pstr.Vision = $("#agency_vision").val();
	pstr.Phone = $("#agency_phone").val();
	pstr.Fax = $("#agency_fax").val();
	pstr.Email = $("#agency_email").val();
	pstr.Address = $("#agency_address").val();
	pstr.MailingAddress = $("#agency_mailing").val();
	pstr.Website = $("#agency_website").val();
	pstr.AccountName = $("#account_name").val();
	pstr.AccountEmail = $("#account_email").val();
	pstr.CSRF = $.cookie("CSRF");
	
	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$("#register").html(getFormattedAutoreply(response, true));
		}
	});
}

function showTimeLeft(){
	$("#timeleft").show();
	var timeleft = parseInt($("#timeleft").find("span").text());
		timeleft = timeleft-1;
	$("#timeleft").find("span").html(timeleft);
	console.log(timeleft);
	
	if(timeleft == 0){
		clearInterval(interval);
		$("#timeleft").hide();
		$("#login_submit").prop("disabled", false);
	}
}