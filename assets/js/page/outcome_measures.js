function selectFile(){
	$("#import_file_select").trigger("click");
}

$(document).on("change", "#import_file_select", function(){
	$("#imported_message").addClass("spaced").fadeIn("slow");
});

$(document).on("click", ".save-indicators", function(){
	// First make sure no more than 2 indicators have been selected
	if($(".indicator-checkbox:checked").length > 2 || $(".indicator-checkbox:checked").length == 0){
		showAutoreply({"SUCCESS":false,"TYPE":"error","MESSAGE":"Please select up to 2 indicators"}, "#indicators");
		return false;
	} 

	var pstr = new Object();
		pstr.Method = "saveProgramIndicators";
		pstr.ProgramID = $("#programID").val();
		pstr.Indicators = [];
		pstr.CSRF = $.cookie("CSRF");
	var indicators = [];

	$(".indicator-checkbox:checked").each(function(){
		pstr.Indicators.push($(this).val());
		indicators.push($("label[for=" + $(this).attr("id") + "]").text());
	});
	pstr.Indicators = pstr.Indicators.toString();

	if(confirm("You have chosen the following indicators:\n\n" + indicators.toString() + "\n\nis this correct?")){
		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				if(response.SUCCESS){
					window.location = window.location;
				} else {
					showAutoreply(response, "#indicators");
				}
			}
		});
	};
});