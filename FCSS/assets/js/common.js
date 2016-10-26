"use strict"

$(document).ready(function(){
	var pagename = location.pathname.split("/");
	pagename = pagename[pagename.length - 1];

	$('#sidebar_navigation a[href^="' + pagename + '"]').closest("li").addClass('active');

	$(".panels ul.panel_nav_top li:not(.disabled)").find("a").on("click", function(){
		// CLear any autoreplies
		$(".autoreply").remove();

		var panels = $(this).closest(".panels");
		var panel = $(this).data("show");
		
		// hide the current panel
		panels.find(".panel.active").stop().hide();
		// remove the active classes
		panels.find(".active").removeClass("active");
		// show the selected panel and add the active classes
		panels.find("#" + panel).stop().fadeIn("slow", function(){
			$(this).addClass("active");
		});
		$(this).closest("li").addClass("active");
	});

	$(".group-error").find("input").addClass("input-error");
	$(".group-error").find("textarea").addClass("input-error");
	$(".group-error").find("select").addClass("input-error");
});

// Handle Other Specifications
$(document).on("change", ".specify", function(){
	var val = $(this).val();
	if(val == "Other"){
		$("#" + $(this).attr("id") + "_other").css("opacity", 1);
	} else {
		$("#" + $(this).attr("id") + "_other").css("opacity", 0);
	}
});

function showMessage(response){
	var div = document.createElement("div");
	$(div).addClass("autoreply autoreply-" + response.TYPE);
	$(div).html(response.MESSAGE);

	$("#main_content").prepend(div);
	$(div).fadeIn("slow");
}