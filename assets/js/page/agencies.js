$(document).on("change", "#agency_select", function(){
	getAgencyDetails($(this).val());
});

function getAgencyDetails(agencyID){
	var pstr = new Object();
	pstr.method = "getAgencyByID";
	pstr.AgencyID = agencyID;

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(!response.SUCCESS){
				showAutoreply(response, $(".wrapper"));
			} else {
				$("#agency_display").hide();

				// Handle most of the data
				for(var i in response.DATA){
					var val = response.DATA[i];
					var selector = ".agency_" + i.toLowerCase();
					if($(selector).length > 0){ // To handle properties that come back that don't get displayed
						$(selector).html(val);
						if($(selector)[0].tagName == "A"){
							// Add http:// if needed
							if (!val.match(/^[a-zA-Z]+:\/\//)){ 
							    var link = 'http://' + val;
							} else {
								var link = val;
							}
							$(selector).attr("href", link);
						}
					}
				}
				
				// Handle the board members
				$(".boardmembers").html("");
				for(var b in response.DATA.BOARDMEMBERS){
					var member = response.DATA.BOARDMEMBERS[b];
					var l = document.createElement("li");
					$(l).html(member.NAME + " - " + member.TITLE);					
					$(".boardmembers").append(l);
				}
				// Handle the documents
				$(".agency_documents").html("");
				for(var d in response.DATA.DOCUMENTS){
					var doc = response.DATA.DOCUMENTS[d];
					var l = document.createElement("li");
					var a = document.createElement("a");
					$(a).attr("href", $("#document_path") + "/" + doc.FILENAME);
					$(a).attr("target", "_blank").addClass("link");
					$(a).html(doc.FILENAME + " (" + doc.DOCUMENTTYPE + ")");
					$(l).append(a);
					$(".agency_documents").append(l);
				}

				$("#agency_display").fadeIn("slow");
			}
		}
	})
}