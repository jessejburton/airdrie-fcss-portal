$(document).ready(function(){
	var pagename = location.pathname.split("/");
	pagename = pagename[pagename.length - 1];

	if(pagename != "index.cfm"){
		$('#navigation a[href^="' + pagename + '"]').closest("li").addClass('active');
	} else {
		$('#navigation a[href^="index.cfm"]').closest("li").addClass('active');
	}

	$(".autoreply-visible").fadeIn("slow");

	$(".not-available").on("click", function(evt){
		evt.preventDefault();
		return false;
	});

	// Board Member Autocomplete
	var commonBoardTitles = [
      "President",
      "Vice President",
      "Chairman of the Board",
      "Vice Chair",
      "Secretary",
      "Treasurer",
      "Member",
      "Board Member"
    ];
    $( "input[name=board_title]" ).autocomplete({
      source: commonBoardTitles
    });	

    $("textarea").on("keyup", function(){
    	var val = $(this).val();
    	var len = val.length;
    	if(len > MaxCharacterLength){
    		$(this).val(val.substring(0, MaxCharacterLength));
    	}
    });
});

// function to slide down the next sibling of a DOM element with a class of "show-next"
$(document).on("click", ".show-next", function(){
	$(this).next().slideDown("slow");
	$(this).hide();
});

/* Resources
***************************************************************************************/ 
$(document).on("click", ".resource-link", showResources);

// Adding Resources
$(document).on("click", ".add-resource", function(){
	var pstr = new Object(),
		frm = $(this).closest("form");
	pstr.Title = frm.find(".resource-title").val();
	pstr.URL = frm.find(".resource-url").val();
	pstr.ResourceType = frm.find(".resource-type").val();
	pstr.method = "addResource";
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(response.SUCCESS){
				var resource = $(".resource-link.template").clone(false);
				resource.find("a").attr("href", response.DATA.URL).html(response.DATA.TITLE);
				resource.removeClass("template");
				resource.data("id", response.DATA.RESOURCEID);

				// Add it to the appropriate list	
				if(response.DATA.RESOURCETYPE == "A"){
					console.log("Agency");
					 $("#agency_resource_list").append(resource);
				} else {
					console.log("Internal");
					$("#internal_resource_list").append(resource);
				}

				$("#resources input[type=text]").val("");
			} else {
				showAutoreply(response, frm);
			}
		}
	});
});

// Removing Resources
$(document).on("click", ".remove-resource", function(){
	if(confirm("Are you sure you would like to remove this resource?")){
		var resource = $(this).closest(".resource-link"),
			ul = $(this).closest("ul"),
			pstr = new Object();
		
		pstr.ResourceID = resource.data("id");
		pstr.method = "removeResource";
		pstr.CSRF = $.cookie("CSRF");

		$.ajax({
			url: "assets/cfc/webservices.cfc",
			data: pstr,
			success: function(response){
				if(response.SUCCESS){
					resource.remove();
				} else {
					showAutoreply(response, ul);
				}
			}
		});
	}
});

// Handle Showing Menus
$(document).on("click", ".menu", function(){
	var menu = $(this).data("menu");

	$(menu).toggleClass("open");
});

// Add the functionality to add more rows
$(document).on("click", ".add-board", function(){
	var sm = $(".board-member").first().clone(false);
	sm.find("input").val("");
	$("#board_list").append(sm);
	sm.find("input").first().focus();
});

function showMessage(){
	$("#message").animate({"top":0}, 350);
	$("#message").find(".cancel").on("click", hideMessage);
}

function hideMessage(){
	$("#message").animate({"top": -(50+$("#message").height())}, 350, function(){
		$("#message").html("");
	});
}

function closeResources(){
	$("#resources_container").fadeOut("slow");	
	enableScroll();														// Enable Scrolling
}

function showResources(){
	$("#resources_container").fadeIn("slow");
	disableScroll();													// Disable Scrolling
}

function currentTime(){
	var currentdate = new Date(); 
	var datetime = currentdate.getDate() + "/"
	    + (currentdate.getMonth()+1)  + "/" 
	    + currentdate.getFullYear() + " @ "  
	    + currentdate.getHours() + ":"  
	    + currentdate.getMinutes() + ":" 
	    + currentdate.getSeconds();
	return datetime;
}

function updateBoardMembers(silent){
	var boardMembers = [];

	$(".board-member").each(function(){
		var member = new Object();
		member.NAME = $(this).find("input[name=board_name]").val();
		member.TITLE = $(this).find("input[name=board_title]").val();

		if(member.NAME.length > 0 && member.TITLE.length > 0){
			boardMembers.push(member);
		}
	});

	var pstr = new Object();
	pstr.BoardMembers = JSON.stringify(boardMembers);
	pstr.method = "updateBoardMembers";
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			if(!response.SUCCESS){
				showAutoreply(response, "#application_form");
			} else {
				if(typeof silent == 'undefined' || !silent){
					showAutoreply(response, $("#board_members_panel"));
				}
			}
		}
	});
}

function isScrolledIntoView(elem)
{
	if(typeof elem != 'undefined'){
	    var docViewTop = $(window).scrollTop();
	    var docViewBottom = docViewTop + $(window).height();

	    var elemTop = $(elem).offset().top;
	    var elemBottom = elemTop + $(elem).height();

	    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
	}
}

/*** UTILITY FUNCTIONS ***/
String.prototype.inList = function(list){
   return ( list.indexOf(this.toString()) != -1)
}

function disableScroll(){
	$('html, body').css({ overflow: 'hidden', height: '100%' });
}

function enableScroll(){
	$("html, body").css({ overflow: 'auto', height: 'auto' });
}

