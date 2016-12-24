$(document).ready(function(){
	$("#select_all_programs").on("change", function(){
		var boxes = $(this).closest(".half-column").find(":checkbox");	
	    if($(this).is(':checked')) {
	        boxes.prop('checked', true);
	    } else {
	        boxes.prop('checked', false);
	    }
	});

	$("#select_all_agencies").on("change", function(){
		var boxes = $(this).closest(".half-column").find(":checkbox");	
	    if($(this).is(':checked')) {
	        boxes.prop('checked', true);
	    } else {
	        boxes.prop('checked', false);
	    }
	});	
});