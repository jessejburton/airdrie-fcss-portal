"use strict"

// Add the functionality to add more rows
$(document).on("click", ".add-staff", function(){
	var sm = $(".staff-member").first().clone(false);
	sm.find("input").val("");
	$("#staff_list").append(sm);
	sm.find("input").first().focus();
});

$(document).on("click", ".add-board", function(){
	var sm = $(".board-member").first().clone(false);
	sm.find("input").val("");
	$("#board_list").append(sm);
	sm.find("input").first().focus();
});

// Navigation Buttons
$(document).on("click", "#next_btn", function(){
	$(".panel_nav_top li.active").next().find("a").trigger("click");
});

$(document).on("click", "#previous_btn", function(){
	$(".panel_nav_top li.active").prev().find("a").trigger("click");
});
