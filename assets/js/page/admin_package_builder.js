$(document).ready(function(){

/* Update the package name display when you enter it	
******************************************************************************************/
	$("#package_name").on("keyup", function(){
		if($(this).val().length > 0){
			$("#package_name_display").text($(this).val());
		} else {
			$("#package_name_display").text("Give this package a name");
		}
	});

/* Handle adding the content item to the package
******************************************************************************************/
	$("#package_available_elements_list").on("click", "li:not(.heading)", function(){
		var newElm = $(this).clone(false);

		// Add options
		var opts = $(".package-options.template").clone(false);
			$(opts).removeClass("template");
			$(newElm).append(opts);

		// Add the sortable handle 
		var hndl = document.createElement("div");
			$(hndl).addClass("package-sortable-handle");
			$(hndl).html('<i class="fa fa-arrows-v"></i>');
			$(newElm).prepend(hndl);

		$("#package_elements").find(".placeholder").stop().hide();

		// Make sure it has everything it needs
		// If we don't do this here then each item has to have all of the necessary data- elements in the markup
		if(!$(newElm)[0].hasAttribute("data-template")) $(newElm).data("template", "");
		if(!$(newElm)[0].hasAttribute("data-column")) $(newElm).data("column", "");
		if(!$(newElm)[0].hasAttribute("data-tableview")) $(newElm).data("tableview", "");

		$(newElm).appendTo($("#package_elements_list"));
	});

/* Handle removing the content item to the package
******************************************************************************************/
	$(document).on("click", ".remove-package-content", function(){
		var li = $(this).closest("li").remove();

		// Show the placeholder again if needed
		if($("#package_elements_list li:not(.heading)").length == 0){
			$("#package_elements").find(".placeholder").fadeIn("slow");
		}
	});
});

/* Handle re-ording the package content
******************************************************************************************/	
	$(document).ready(function(){
		$("#package_elements_list").sortable({
			handle: ".package-sortable-handle",
			revert: true
		});
	});

/* Saving a Package
*******************************************************************************************/
	$(document).on("click", ".save-package", function(){
		// Make sure the package has a name
		if($("#package_name").val().length == 0){
			showAutoreply({"TYPE":"error","MESSAGE":"Please make sure to enter a name for your package."}, "#package_builder_form")
		}

		var pstr = new Object();
			pstr.PackageName = $("#package_name").val();
			pstr.Method = "savePackage";
			if($("#package_select").val() != 0){
				pstr.PackageID = $("#package_select").val();
			}
			pstr.PackageContent = [];
			pstr.CSRF = $.cookie("CSRF");

		// Create the package array
		$("#package_elements_list li:not(.heading)").each(function(){
			var c = new Object();
				c.SectionTitle = $(this).find("span").text();
				c.isSectionHeading = $(this).find(".section-heading-checkbox").is(":checked");
				c.TemplateFile = $(this).data("template");
				c.TableView = $(this).data("tableview");
				c.ColumnName = $(this).data("column");

			pstr.PackageContent.push(JSON.stringify(c));
		});
		pstr.PackageContent = JSON.stringify(pstr.PackageContent); 	// Needs to be a string for Coldfusion
		pstr.CSRF = $.cookie("CSRF");

		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			Method: "POST",
			success: function(response){	
				showAutoreply(response, $(".wrapper"));
				if(response.SUCCESS){
					resetForm();
				}
			}
		});	
	});

/* Select a package to edit
*******************************************************************************************/
	$(document).on("change", "#package_select", function(){
		loadPackage($(this).val());
	});

/* Handle editing or creating a new package
*******************************************************************************************/
	// New Package
	$(document).on("click", "#new_package", function(){
		$(".autoreply").remove();  	// Clear up any messages that may still be around
		resetForm();

		$("#package_builder_form").fadeIn("slow");
	});

	// Edit Package
	$(document).on("click", "#edit_package", function(){
		$(".autoreply").remove();  			// Clear up any messages that may still be around
		$("#package_builder_form").hide();	// Hide the editor until a package is selected
		$(".edit-package").show(); 			// Show the package selector
	});

/* FUNCTIONS
*********************************************************************************************/

// Load a package to edit
function loadPackage(packageID){
	$("#loading").fadeIn("fast");

	// if there is no package selected
	if(packageID === "undefined" || packageID == 0){
		$("#package_name_display").text("Give this package a name");
		$("#package_builder_form").hide();
		return false;
	}

	var pstr = new Object();
		pstr.Method = "getPackageByID";
		pstr.PackageID = packageID;
		pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$("#loading").hide();
			if(response.SUCCESS){
				$("#package_name").val(response.DATA.PACKAGENAME);		// Display the package name
				$("#package_name_display").text(response.DATA.PACKAGENAME);
				// Loop through the elements
				for(var elm in response.DATA.PACKAGECONTENTS){
					var item = response.DATA.PACKAGECONTENTS[elm],
						li = document.createElement("li");

					$(li).html("<span>" + item.SECTIONTITLE + "</span>");			// Add the section title
					$(li).data("template", item.TEMPLATEFILE);
					$(li).data("column", item.COLUMNNAME);
					$(li).data("tableview", item.TABLEVIEW);

					// Handle the options and drag handle
						// Add options
						var opts = $(".package-options.template").clone(false);
							$(opts).removeClass("template");
							$(opts).find(".section-heading-checkbox").prop("checked", item.ISSECTIONHEADING);
							$(li).append(opts);

						// Add the sortable handle 
						var hndl = document.createElement("div");
							$(hndl).addClass("package-sortable-handle");
							$(hndl).html('<i class="fa fa-arrows-v"></i>');
							$(li).prepend(hndl);								

					$("#package_elements_list").append(li);

					// Hide the placeholder
					$("#package_elements .placeholder").hide();
				}

				// Show the package builder
				$("#package_builder_form").fadeIn("slow");				
			} else {
				showAutoreply(response, ".wrapper");
			}
		}
	})
}

function resetForm(){
	$("#package_elements_list").find("li:not(.heading)").remove();
	$("#package_elements").find(".placeholder").show();
	$("#package_builder_form").hide();
	$(".edit-package").find('option:eq(0)').prop('selected', true);
	$(".edit-package").hide(); 											// In case you were editing, some things need to be reset and or hidden
	$("#package_name_display").text("Give this package a name");		
	$("#package_name").val("");
}