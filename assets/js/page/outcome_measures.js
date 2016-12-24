function selectFile(){
	$("#import_file_select").trigger("click");
}

$(document).on("change", "#import_file_select", function(){
	$("#imported_message").addClass("spaced").fadeIn("slow");
});