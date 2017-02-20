/************************************************/
/*												*/
/*	FORMS										*/
/*	This file handles all form validation and 	*/
/*	user interfaces								*/
/*												*/
/************************************************/

// DOCUMENT READY FUNCTIONS
$(document).ready(function(){

// Add Accordion Support 
	$(".accordion").accordion({
      	heightStyle: "content",
		collapsible: true,
		active: false,
		activate: function( event, ui ) {
			// Add a seen class when a panel is opened so that the form validator only validates if it has been seen.
			$(".ui-accordion-content-active").addClass("seen");

			if(!$.isEmptyObject(ui.newHeader.offset())) {
			    $('html:not(:animated), body:not(:animated)').animate({ scrollTop: ui.newHeader.offset().top - 47 }, 'slow');
			}
		}
    });
    $('.accordion button.nav').click(function(e) {
        e.preventDefault();

        if(validateForm($(this).closest("form"))){
	        var delta = ($(this).is('.next') ? 1 : -1);
	        $('.accordion').accordion('option', 'active', (
	             $('.accordion').accordion('option','active') + delta  ));
	    }
    });

// Handle Other Specifications
	$("form").on("change", ".specify", function(){
		var val = $(this).val();
		if(val == "Other"){
			$("#" + $(this).attr("id") + "_other").css("opacity", 1);
		} else {
			$("#" + $(this).attr("id") + "_other").css("opacity", 0);
		}
	});

});

/********************* FORM VALIDATION ************************/
function validateForm(form, callback){
	clearAutoreply(); // Clear up any existing validation

	// Loop through each of the form groups within the form and show the appropriate errors
	$(".form-group.seen:not(.application-only):not(.loi-only)").each(function(){
		var errors = [];

		var group = $(this);
		var section_heading = $(this).prev("h3");

		// Handle required fields
		group.find("input[type=text].required, input[type=password].required, textarea.required").each(function(){
			var length = $(this).val().length;
			var label = $(form).find('label[for=' + $(this).attr("id") + ']').html();

			// Use the ID if the field doesn't have a label
			if(label === undefined){
				label = $(this).attr("placeholder");
			}

			if(length == 0){
				$(this).addClass("input-error");
				errors.push("Please enter a value for <strong>" + label + "</strong>");
			}
		});

		group.find(".required-hidden").each(function(){
			var valRequired = $(this).data("validate");

			if($(this).val() != valRequired){
				$(this).addClass("input-error");
				errors.push($(this).data("error"));
			}
		});

		if(errors.length > 0){
			var response = new Object();
			response.TYPE = "error";
			response.MESSAGE = getFormattedErrors(errors);

			var autoreply = getFormattedAutoreply(response);
			$(this).prepend(autoreply);
			$(autoreply).fadeIn("slow");
			$(this).addClass("hasErrors");

			// Add an error class to the section title
			$(section_heading).addClass("heading-error");
		} else {
			$(section_heading).addClass("heading-success");
		}
	});

	if($(form).find(".hasErrors").length == 0){
		if(callback !== undefined){
			callback();
		}
		return true;
	}

	$('.accordion').accordion('option', 'active', false);
	var index = $(".input-error").first().closest(".ui-accordion-content").index(".ui-accordion-content");
	$('.accordion').accordion('option', 'active', index);	
	
	return false;
}

/* UTILITY FUNCTIONS */

/********************* CLEAR THE AUTOREPLY MESSAGES ************************/
function clearAutoreply(){
	$(".autoreply:not(.autoreply-visible)").remove();
	$(".input-error").removeClass("input-error");
	$(".hasErrors").removeClass("hasErrors");
	$(".heading-error").removeClass("heading-error");
	$(".heading-success").removeClass("heading-success");
}

function showAutoreply(autoreply, div){
	div = $(div); // should accommodate for being passed in as "#id" or $("#id")
	console.log(JSON.stringify(autoreply));
	
	div.find(".autoreply").remove(); // remove existing autoreply from the specific form
	
	var a = getFormattedAutoreply(autoreply);
	div.prepend(a);
	fadeDuration = 1000;
	if(!isScrolledIntoView($(div))){
		$('html, body').animate({ scrollTop: $(div).offset().top - 100 }, 500);
		fadeDuration = 1500; // Allows extra time so the user can still see the fade after the div is scrolled to.
	}
	$(a).fadeIn(fadeDuration);
}

/********************* GET A FORMATTED AUTOREPLY ************************/
function getFormattedAutoreply(response, show){
	var autoreply = document.createElement("div");
	$(autoreply).addClass("autoreply autoreply-" + response.TYPE);
	$(autoreply).html(response.MESSAGE);

	if(show !== undefined && show){
		$(autoreply).addClass("autoreply-visible");
	}

	return autoreply;
}

/********************* GET A FORMATTED ERRORS LIST ************************/
function getFormattedErrors(errors){
	var errorlist = document.createElement("ul");

	for(var e in errors){
		var li = document.createElement("li");
		$(li).html(errors[e]);
		$(errorlist).append(li);
	}

	return errorlist;
}

/********************* VALIDATE VALUE IS AN EMAIL ADDRESS ***********************/
function validateEmail(email){
	var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}