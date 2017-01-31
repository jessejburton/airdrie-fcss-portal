function selectFile(){
	$("#import_file_select").trigger("click");
}

$(document).on("change", "#import_file_select", function(){
	$("#imported_message").addClass("spaced").fadeIn("slow");
});

$(document).on("click", ".area li", function(){
	if($(this).hasClass("selected")){
		$(this).removeClass("selected");
	} else {
		$(this).addClass("selected");
	}

	var selected = $(".area .selected").length;
	if(selected > 2){
		$(this).removeClass("selected");

		var indicators = [];
		$(".indicator.selected").each(function(){
			indicators.push($(this).text());
		});
		indicators = indicators.toString();

		alert("You have already chosen the following indicators:\n\n" + indicators.toString() + "\n\n. Please only select 2 indictors");	
	}

	if(selected == 2){
		$(".save-indicators").trigger("click");
	}
});

$(document).on("click", ".save-indicators", function(){
	// First make sure no more than 2 indicators have been selected
	if($(".indicator.selected").length > 2 || $(".indicator.selected").length == 0){
		showAutoreply({"SUCCESS":false,"TYPE":"error","MESSAGE":"Please select up to 2 indicators"}, "#indicators");
		return false;
	} 

	var pstr = new Object();
		pstr.Method = "saveProgramIndicators";
		pstr.ProgramID = $("#programID").val();
		pstr.Indicators = [];
		pstr.CSRF = $.cookie("CSRF");
	var indicators = [];

	$(".indicator.selected").each(function(){
		pstr.Indicators.push($(this).data("id"));
		indicators.push($(this).text());
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