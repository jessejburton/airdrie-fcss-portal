"use strict"

$(document).ready(function(){
	var pagename = location.pathname.split("/");
	pagename = pagename[pagename.length - 1];

	if(pagename != "index.cfm"){
		$('#navigation a[href^="' + pagename + '"]').closest("li").addClass('active');
	}

	$(".autoreply-visible").fadeIn("slow");

	$(".not-available").on("click", function(evt){
		evt.preventDefault();
		return false;
	});

	// Handler sliders
	$(".slider").slider({
		slide: function( event, ui ) {
			$(this).next().html(ui.value + "%");
		},
		animate: true
	});
});


// Handle Showing Menus
$(document).on("click", ".menu", function(){
	var menu = $(this).data("menu");

	$(menu).toggleClass("open");
});

// Add the functionality to add more rows
$(document).on("click", ".add-board", function(){
	var sm = $(".board-member").first().clone(false);
	sm.find("input").val("");
	$("#board_list").append(sm);
	sm.find("input").first().focus();
});

function closeResources(){
	$("#resources_container").fadeOut("slow");
}

function showResources(){
	$("#resources_container").fadeIn("slow");
}