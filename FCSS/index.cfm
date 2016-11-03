<cfif REQUEST.NEWAGENCY>
	<cflocation url="new_agency_details.cfm" addtoken="no" />
	<cfabort>
</cfif>

<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper-full clearfix">
			<h1>Agency Dashboard</h1>
			<p>On this page you will be able to view statistics, metrics, visually see the data that you are working with.</p>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">