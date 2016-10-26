"use strict"

$(document).on("click", "#save_agency_details_btn", function(){
	// Just put a message on the current page saying that the data has been saved for now.
	var response = new Object();
	response.TYPE = "success";
	response.MESSAGE = "Agency details have been updated.";

	showMessage(response);
});

$(document).on("click", "#save_agency_contact_btn", function(){
	// Just put a message on the current page saying that the data has been saved for now.
	var response = new Object();
	response.TYPE = "success";
	response.MESSAGE = "Agency contact information has been updated.";

	showMessage(response);
});

function validateForm(form){
	// need to write the form validator
}

function showError(input){
	
}