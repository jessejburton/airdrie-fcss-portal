$(document).ready(function(){
	$(".save_agency").on("click", function(){
		validateForm("#agency_information_form", saveAgencyInformation);
	});
});

// Save the agency information
function saveAgencyInformation(){
	var pstr = new Object();
	pstr.method = "saveAgencyInformation";
	pstr.Name = $("#agency_name").val();
	pstr.Mission = $("#agency_mission").val();
	pstr.Vision = $("#agency_vision").val();

	$.ajax({
		url: "assets/cfc/testing.cfc",
		data: pstr,
		success: function(response){
			var msg = getFormattedAutoreply(response);
			$("#agency_information_form").find(".form-group").first().prepend(msg);
			$(msg).fadeIn(1000);
			$('html, body').animate({scrollTop: $(msg).offset().top -100 }, 'slow');	
		}
	});
}

// Save the agency contact information
function saveAgencyContact(){
	var pstr = new Object();
	pstr.method = "saveAgencyContact";
	pstr.Phone = $("#agency_phone").val();
	pstr.Fax = $("#agency_fax").val();
	pstr.Email = $("#agency_email").val();
	pstr.Address = $("#agency_address").val();
	pstr.MailingAddress = $("#agency_mailing").val();
	pstr.Website = $("#agency_website").val();
	pstr.PrimaryContactNameFirst = $("#primary_name_first").val();
	pstr.PrimaryContactNameLast = $("#primary_name_last").val();
	pstr.PrimaryContactPhone = $("#primary_phone").val();
	pstr.PrimaryContactEmail = $("#primary_email").val();

	$.ajax({
		url: "assets/cfc/testing.cfc",
		data: pstr,
		success: function(response){
			var msg = getFormattedAutoreply(response);
			$("#agency_contact_form").find(".form-group").first().prepend(msg);
			$(msg).fadeIn(1000);
			$('html, body').animate({scrollTop: $(msg).offset().top -100 }, 'slow');
		}
	});
}