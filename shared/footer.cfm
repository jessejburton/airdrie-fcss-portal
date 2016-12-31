</div>

<!--- FOOTER --->
	<section id="footer">
		<p><a href="http://www.airdrie.ca" target="_blank"><img src="assets/images/coalogo.svg" id="city_logo" onerror="this.onerror=null; this.src='assets/images/coalogo.png'" /></a></p>
		<p>
			<a href="javascript:;">Terms of Service</a> | <a href="javascript:;">Privacy (FOIP)</a>
		</p>
		<p>
			The FCSS Vision: Alberta's diverse people<br />
			building strong communities<br />
 			through positive, caring interaction and mutual respect.
 		</p>		
		<p>
			&copy 2016 The City of Airdrie
		</p>
	</section>

	<cfif APPLICATION.environment IS "development" OR isDefined('URL.debug')>
		<cfdump var="#APPLICATION#">
		<cfdump var="#SESSION#">
		<cfdump var="#REQUEST#">
		<cfdump var="#FORM#">
	</cfif>

	<div id="resources_container">
		<div id="resources">
			<p><a class="pull-right" href="javascript:;" onclick="closeResources();"><i class="fa fa-close"></i> Close</a></p>
			<cfinclude template="resources.cfm" />
		</div>
	</div>

	<div id="logout_message_container">
		<div id="logout_message_text">
			<p>Your session will expire in <span id="time_display">60</span> seconds.</p>
			<p><button class="btn btn-primary" id="logout_refresh">Stay Logged In</button></p>
		</div>
	</div>

	<div id="saving"><img src="assets/images/saving-gear.gif" /> Saving...</div>
	<div id="loading"><img src="assets/images/saving-gear.gif" /> Loading...</div>

	<!--- Session Timeout --->
	<cfif isDefined('REQUEST.loggedin')>
		<script>
			var timer = 10;
			var session_timeout = 11100000 // 18.5 minutes - gives a 30 second buffer in case of discrepencies with the Coldfusion Session

			setTimeout(logoutRedirect, session_timeout); 

			function logoutRedirect(){
				$("#logout_message_container").fadeIn("slow");
				$("#logout_message #time_display").html(timer);
				setInterval(updateTimer, 1000);
			}

			function updateTimer(){
				timer --;
				$("#time_display").html(timer.toString());
				if(timer == 0){
					window.location = "index.cfm?logout";
				}
			}

			$("#logout_refresh").on("click", function(){
				window.location = window.location;
			});			
		</script>
	</cfif>

</body>
</html>