$(document).ready(function(){
	$("#endyear_review_submit").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#end_year_form"), submitEndYear);
	});
});

function submitEndYear(){
	var pstr = new Object();
	pstr.method = "endYear";

	$.ajax({
		url: "assets/cfc/testing.cfc",
		data: pstr,
		success: function(response){
			$("#end_year_form").hide();
			$("#endyear_form_complete").addClass("autoreply autoreply-success").removeClass("hidden").fadeIn("slow");
		}
	})	
}