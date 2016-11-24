$(document).ready(function(){
	$("#midyear_review_submit").on("click", function(){
		$(".form-group").addClass("seen");
		validateForm($("#mid_year_form"), submitMidYear);
	});
});

function submitMidYear(){
	var pstr = new Object();
	pstr.method = "midYear";

	$.ajax({
		url: "assets/cfc/testing.cfc",
		data: pstr,
		success: function(response){
			$("#mid_year_form").hide();
			$("#midyear_form_complete").addClass("autoreply autoreply-success").removeClass("hidden").fadeIn("slow");
		}
	})	
}