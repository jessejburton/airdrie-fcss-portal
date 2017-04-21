$(document).ready(function(){
	$("#all_agencies").on('change', function(){
		if($(this).is(":checked")){
			$("input[name=agencies]").prop("checked", true);
		} else {
			$("input[name=agencies]").prop("checked", false);
		}
	});

	$("#template").on("change", function(){
		// TODO - Will need to update this in order to work with tinyMCE
		$("#message_txt").val($(this).find("option:selected").data("html"));
	});

	$("#send_message").on("click", sendMessage);
});

/* Sending messages	
******************************************************************************************/
function sendMessage(){
	var pstr = new Object();
		pstr.Method = "sendMessages";
		pstr.Message = $("#message_txt").val(); // TODO - make sure this works with TinyMCE after implementation
		pstr.Subject = $("#message_subject").val();
		pstr.AgencyIDs = [];
		pstr.CSRF = $.cookie("CSRF");

    $('input[name=agencies]:checked').each(function() {
        pstr.AgencyIDs.push($(this).val());
    });
    	pstr.AgencyIDs = pstr.AgencyIDs.toString();
	
	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(response.SUCCESS){
				clearForm();
			}
			showAutoreply(response, ".wrapper");
		}
	});
}

function clearForm(){
	$("#message_txt").val();
	$("input[name=agencies]").prop("checked", false);
	$("#template").find('option:eq(0)').prop("selected", true);
}