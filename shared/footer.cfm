</div>

<!--- FOOTER --->
	<section id="footer">
		<!---<p><a href="http://www.airdrie.ca" target="_blank"><img src="assets/images/coalogo.svg" id="city_logo" /></a></p>--->
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

			<h1>Resources</h1>

			<ul>
				<li><a href="assets/documents/definitions.pdf" target="_blank">FCSS Definitions</a></li>
				<li><a href="http://www.humanservices.alberta.ca/documents/FCSS-Basic-Guide-to-Outcome-Measurement.pdf" target="_blank">Basic Guide to Outcome Measurement</a></li>
				<li><a href="http://www.humanservices.alberta.ca/documents/FCSS-outcomes-model.pdf" target="_blank">FCSS Outcomes Model</a></li>
				<li><a href="http://www.rockymtnhouse.com/DocumentCenter/view/593" target="_blank">Provincial Priority Measures</a></li>
				<li><a href="http://www.fcssaa.org/sites/default/files/Measures%20Bank%20Instructions%20final.pdf" target="_blank">Measures Bank Instructions</a></li>
			</ul>
		</div>
	</div>

	<div id="logout_message_container">
		<div id="logout_message_text">
			<p>Your session will expire in <span id="time_display">60</span> seconds.</p>
			<p><button class="btn btn-primary" id="logout_refresh">Stay Logged In</button></p>
		</div>
	</div>

	<div id="saving"><img src="assets/images/saving-gear.gif" /> Saving...</div>

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