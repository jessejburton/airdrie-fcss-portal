$(document).ready(function(){
	var pagename = location.pathname.split("/");
	pagename = pagename[pagename.length - 1];

	if(pagename != "index.cfm"){
		$('#navigation a[href^="' + pagename + '"]').closest("li").addClass('active');
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

function closeResources(){
	$("#resources_container").fadeOut("slow");
}

function showResources(){
	$("#resources_container").fadeIn("slow");
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