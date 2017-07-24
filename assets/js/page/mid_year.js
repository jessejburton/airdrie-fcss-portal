/*********************************************************/
/* 			MID-YEAR Budget								 */
/*********************************************************/

/*****************************************  VARIABLES  ***********************************************/

var _AUTOSAVE = null;
var _AUTOSAVE_DURATION = 30000; // Autosave every 30 seconds

/*****************************************  HANDLERS  ***********************************************/

$(document).ready(function(){
	$('.accordion').accordion('option', 'active', 0);
	_AUTOSAVE = setInterval(saveBudget, _AUTOSAVE_DURATION);

// Enable the review panel once the form is valid
	$("#midyear_submit_to_airdrie").on("click", function(){
		$(".form-group").addClass("seen");

		// Ensure checkboxes are checked if needed
		if($("#auth1").length > 0){
			if(!$("#auth1").is(":checked") || !$("#auth2").is(":checked")){
				$(".auth-group").addClass("error");
				alert("Please make sure to read and check the agreements");
				return false;
			} else {
				$(".auth-group").removeClass("error");
			}
		}

		if(validateForm($("#mid_year_form"), submitMidYear)){
			$('.accordion').accordion('option', 'active', -1); // Open the review panel.
		};
	});	

	$(".show-other").on("click", function(){
		var checked = $(this).is(":checked");
		if(checked){
			$("#evaluation_activities_other").slideDown();
		} else {
			$("#evaluation_activities_other").slideUp();
		}
	});

	// Show if the Other is checked
	if($(".show-other").is(":checked")){
		$("#evaluation_activities_other").show();
	}

	// REMOVE DOCUMENT
	$(document).on("click", ".remove-document", function(){
		if(confirm("Are you sure you would like to remove this document?")){
			var pstr = new Object();
				pstr.method = "removeDocument";
				pstr.documentID = $(this).data("id");
				pstr.CSRF = $.cookie("CSRF");

            $.ajax({
                url: "assets/cfc/webservices.cfc",
                data: pstr,
                success: function(response){
                    if(response.SUCCESS){         
	                    $("#logic_upload_select").show();
	                    $(".document:not(.template)").remove();   
	                    $("#no_documents").show();           
                        $("#plm_container").show();
                        $("#upload_logic_model_form").trigger("reset");
                    } else {
                        showAutoreply(response, $("#program_logic_model"));
                    }
                }
            });
		};
	});

	// UPLOAD DOCUMENT
	$(document).on("change", ".upload-logic", function(e) {
		$("#program_logic_model").find(".autoreply").remove();
        var sender = this;
        //var n = $(sender).parents("#upload_logic_model_form").clone(false);
        //$("#logic_upload_select").append(n);
        //$(sender).hide();
        var n = $(sender).val().lastIndexOf('\\');
        var file = $(sender).val().substring(n + 1);

        // Validate file type. This also gets checked Coldfusion side in document_upload.cfm 
        // so if you ever need to add any valid types it needs to be changed there.
        var ext = file.substr(file.lastIndexOf('.') + 1);
        var valid = "pdf, doc, docx";

        if(valid.indexOf(ext) == -1){
            showAutoreply({"TYPE":"error","MESSAGE":"Document must be one of the following types: " + valid.toString()}, $("#program_logic_model"));
            return false;            
        }

        var status = $(".progress.template").clone(false);
        $(status).removeClass("template").appendTo("#current_documents");
        var bar = $(status).find(".bar");
        var percent = $(status).find(".percent");
        var display = $(status).find(".display-progress");        

        $("#no_documents").hide();

        $("#upload_logic_model_form").ajaxSubmit({
            beforeSend: function() {
                var percentVal = '0%';
                bar.width(percentVal);
                percent.html(percentVal + " (" + file + ")");
            },
            uploadProgress: function(event, position, total, percentComplete){
                var percentVal = percentComplete + '%';
                bar.width(percentVal);
                percent.html(percentVal + " (" + file + ")");
            },
            error: function(response){
				alert(reseponse);
			},
            success: function(response){
                if(response.SUCCESS == false){
                    showAutoreply(response, $("#program_logic_model").closest(".form-group"));
                } else {
                    var d = $(".document.template").clone(false);
                    $(d).removeClass("template");
                    $(status).replaceWith(d);
                    $(d).find(".document-filename").html(response.FILENAME);
                    $(d).find(".document-filename").attr("href", $(d).find(".document-filename").attr("href") + response.FILENAME);
                    $(d).find(".remove-document").data("id", response.DOCUMENTID);

                    // Update Document Type and ProgramID
                    var pstr = new Object();
			        pstr.method = "setDocumentType";
			        pstr.documentID = response.DOCUMENTID;
			        pstr.ProgramID = $("#program_id").val();
			        pstr.documentType = "Program Logic Model";
			        pstr.CSRF = $.cookie("CSRF");

			        $.ajax({
			            url: "assets/cfc/webservices.cfc",
			            data: pstr,
			            success: function(response){
			                if(!response.SUCCESS){
			                    showAutoreply(response, $("#program_logic_model"));			    
			                } else {
			                	$("#logic_upload_select").hide();
			                }
			            }
			        });
                }
            }
        });
    });
});

$(document).on("click", ".save", function(){
	saveMidYear();
	saveBudget();

	var msg = new Object();
	msg.SUCCESS = true;
	msg.TYPE = "success";
	msg.MESSAGE = "<strong>Success!</strong> your work has been saved.";
	showAutoreply(msg, $("#mid_year_form"));

	window.scrollTo(0, 0);
});

function saveMidYear(){
	var pstr = new Object();
	pstr.Method = "saveMidYear";
	pstr.ProgramID = $("#program_id").val();
	pstr.isOnlyFunder = $("input[name=is_only_funder]:checked").val();
	pstr.sustainFunding = $("#sustain_funding").val();
	pstr.isSurplus = $("input[name=is_surplus]:checked").val();
	pstr.isDeficit = $("input[name=is_deficit]:checked").val();
	pstr.howDeal = $("#how_deal").val();
	pstr.programActivities = $("#program_activities").val();
	pstr.notYetStarted = $("#not_yet_started").val();
	pstr.programChallenges = $("#program_challenges").val();
	pstr.requireReportAssistance = $("#require_report_assistance").val();
	pstr.noActivities = $("#no_activities").val();
	pstr.evaluationChallenges = $("#evaluation_challenges").val();
	pstr.requireResearchAssistance = $("#require_research_assistance").val();
	pstr.CSRF = $.cookie("CSRF");

	// Get evaluation activities 
	pstr.evaluationActivities = "";
	$("input[name=evaluation_activities").each(function(){
		if($(this).is(":checked")){
			pstr.evaluationActivities += $(this).val() + ",";
		}
	});
	pstr.evaluationActivities = pstr.evaluationActivities + $("#evaluation_activities_other").val();
	
	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		method: "POST",
		success: function(response){
			if(!response.SUCCESS){	
				showAutoreply(response, $("#mid_year_form"));			
				clearInterval(_AUTOSAVE);
				_AUTOSAVE = null;
				return false;
			}
			return true;
		}
	});
}

// Submit the Mid Year report to Airdrie
function submitMidYear(){
	saveMidYear();
	var pstr = new Object();
	pstr.ProgramID = $("#program_id").val();
	pstr.Method = "submitMidYear";
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$(".accordion").accordion({active: false});
			showAutoreply(response, $(".wrapper"));
			clearInterval(_AUTOSAVE);
			_AUTOSAVE = null;
			if(response.SUCCESS){
				$("#mid_year_form").hide();
			}
		}
	});
}