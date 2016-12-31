$(document).ready(function(){

/* Handle Selecting and deselecting all boxes
**********************************************************************************/
	$("#package_export_form").on("change", "#select_all_programs", function(){
		var boxes = $("#program_list").find(":checkbox");	
	    if($(this).is(':checked')) {
	        boxes.prop('checked', true);
	    } else {
	        boxes.prop('checked', false);
	    }
	});

/* Handle exporting a package
***********************************************************************************/
	$("#export_package").on("click", function(){
		var pstr = new Object();
			pstr.PackageID = $("#package_select").val();
			pstr.Programs = $("input[name=programs]:checked").map(function() {
						    return this.value;
						}).get().toString();

		if(pstr.PackageID == 0 || pstr.Programs.length == 0){
			var msg = new Object();
				msg.SUCCESS = false;
				msg.TYPE = "error";
				msg.MESSAGE = "Please make sure to select a package to export as well as identify which programs to include.";
			showAutoreply(msg, ".wrapper");
			return false;
		} else {
			$("#package_export_form").submit();
		}

		/* 	TODO - Future enhancement
			If generating packages is going to take a long time we may want to look at generating them behind the scenes
			and providing a link to download it after it has been completed but for now we will see if generating them on
			the fly is fast enough.
		*/

	});

});