$(document).ready(function(){
	$("#package_available_elements_list").on("click", "li:not(.heading)", function(){
		$("#package_elements").find(".placeholder").stop().hide();
		$(this).appendTo($("#package_elements_list"));
	});

	$("#package_elements_list").on("click", "li:not(.heading)", function(){
		$(this).appendTo($("#package_available_elements_list"));
		// Show the placeholder again if needed
		if($("#package_elements_list li:not(.heading)").length == 0){
			$("#package_elements").find(".placeholder").fadeIn("slow");
		}
	});
});
