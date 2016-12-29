$(document).ready(function(){
    $(document).on("change", ".upload-document", function(e) {
        var sender = this;
        var n = $(sender).parents("#upload_document_form").clone(false);
        $("#document_upload_select").append(n);
        $(sender).hide();

        var status = $(".progress.template").clone(false);
        $(status).removeClass("template").appendTo("#current_documents");
        var bar = $(status).find(".bar");
        var percent = $(status).find(".percent");
        var display = $(status).find(".display-progress");
        var n = $(sender).val().lastIndexOf('\\');
        var file = $(sender).val().substring(n + 1);

        $("#no_documents").remove();

        $(this).closest("#upload_document_form").ajaxSubmit({
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
            success: function(response){
                var d = $(".document.template").clone(false);
                $(d).removeClass("template");
                $(status).replaceWith(d);
                $(d).find(".document-filename").html(response.FILENAME);
                $(d).find(".document-filename").attr("href", $(d).find(".document-filename").attr("href") + response.FILENAME);
                $(d).data("id", response.DOCUMENTID);
            }
        });
    });

    $(document).on("change", ".document-type", function(){
        var pstr = new Object();
        pstr.method = "setDocumentTypeByDocumentID";
        pstr.documentID = $(this).closest(".document").data("id");
        pstr.documentTypeID = $(this).val();
        pstr.CSRF = $.cookie("CSRF");

        $.ajax({
            url: "assets/cfc/webservices.cfc",
            data: pstr,
            success: function(response){
                if(response.SUCCESS){
                    updateDocumentTypeDisplay();
                } else {
                    showAutoreply(response, $("#document_type_display"));
                }
            }
        });
    });

    $(document).on("click", ".remove-document", function(e){
        if(confirm("Are you sure you would like to remove this document?")){
            var sender = this;
            var documentrow = $(sender).closest(".document");

            var pstr = new Object();
            pstr.method = "removeDocument";
            pstr.documentID = $(this).closest(".document").data("id");
            pstr.CSRF = $.cookie("CSRF");

            $.ajax({
                url: "assets/cfc/webservices.cfc",
                data: pstr,
                success: function(response){
                    if(response.SUCCESS){                        
                        $(documentrow).fadeOut("slow", function(){
                            $(this).remove();
                            updateDocumentTypeDisplay();
                        });
                    } else {
                        showAutoreply(response, $("#document_type_display"));
                    }
                }
            });
        }
    });
});

function updateDocumentTypeDisplay(){
    $("#document_type_display").find(".hidden").removeClass("hidden"); 
    $(".document:not(.template)").find(".document-type").each(function(){
        var doctypeToHide = "#ID_" + $(this).val().toString(); 
        $(doctypeToHide).addClass("hidden");
    });

    if($("#document_type_display").find(".required-document-type").length == $("#document_type_display").find(".required-document-type.hidden").length){
        $("#has_documents").html("You have uploaded all required documents.");
        $("#agency_has_documents").val(1);
    } else {
        $("#has_documents").html("Please upload the following documents:");
        $("#agency_has_documents").val(0);
    }
}