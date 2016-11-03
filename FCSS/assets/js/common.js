"use strict"

$(document).ready(function(){
	var pagename = location.pathname.split("/");
	pagename = pagename[pagename.length - 1];

	$('#navigation a[href^="' + pagename + '"]').closest("li").addClass('active');

	$(".autoreply-visible").fadeIn("slow");
});


// Handle Showing Menus
$(document).on("click", ".menu", function(){
	var menu = $(this).data("menu");

	$(menu).toggleClass("open");
});



