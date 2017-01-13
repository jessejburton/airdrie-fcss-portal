$(document).on("click", "#verify_submit", function(){
	// Validate password
	var pword = $("#password").val(),
		vpword = $("#verify_password").val();

	if(pword.length == 0 || vpword.length == 0 || pword != vpword){
		showAutoreply({"TYPE":"error","MESSAGE":"Please make sure your passwords match"}, $("#password_verify_group"));
		return false;
	}

	if(!validatePass(pword)){
		showAutoreply({"TYPE":"error","MESSAGE":"Please ensure your password is at least 8 characters and contains at least one of each of the following: uppercase letter, lowercase letter, special character, number"}, $("#password_verify_group"));
		return false;		
	}

	// Update the users password
	var pstr = new Object();
	pstr.method = "verifyAccountAndSetPassword";
	pstr.GUID = $("#guid").val();
	pstr.EMAILHASH = $("#emailhash").val();
	pstr.PLAINPW = $("#password").val();
	pstr.CSRF = $.cookie("CSRF");

	$.ajax({
		url: "assets/cfc/webservices.cfc",
		data: pstr,
		success: function(response){
			$(".autoreply").remove();
			showAutoreply(response, $("#verify_form_container"));
			if(response.SUCCESS){
				$("#verify_form").hide();
				$("#verify_password").val("");
				$("#password").val("");
			}
		}
	});
});

// Validate Password Complexity
function validatePass(p){
    var anUpperCase = /[A-Z]/;
    var aLowerCase = /[a-z]/; 
    var aNumber = /[0-9]/;
    var aSpecial = /[!|@|#|$|%|^|&|*|(|)|-|_]/;

    if(p.length < 8){
        return false;
    }

    var numUpper = 0;
    var numLower = 0;
    var numNums = 0;
    var numSpecials = 0;
    for(var i=0; i<p.length; i++){
        if(anUpperCase.test(p[i]))
            numUpper++;
        else if(aLowerCase.test(p[i]))
            numLower++;
        else if(aNumber.test(p[i]))
            numNums++;
        else if(aSpecial.test(p[i]))
            numSpecials++;
    }

    if(numUpper < 1 || numLower < 1 || numNums < 1 || numSpecials < 1){
        return false;
    }

    return true;
}