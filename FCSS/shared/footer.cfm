<!--- FOOTER --->
	<section id="footer">
		<p><a href="http://www.airdrie.ca" target="_blank"><img src="assets/images/coalogo.svg" id="city_logo" /></a></p>
		<p>
			<a href="javascript:;">Terms of Service</a> | <a href="javascript:;">Privacy (FOIP)</a>
		</p>
		<p>
			&copy 2016 The City of Airdrie
		</p>
	</section>

	<cfif APPLICATION.environment IS "development">
		<cfdump var="#SESSION#">
		<cfdump var="#REQUEST#">
		<cfdump var="#FORM#">
	</cfif>

</body>
</html>