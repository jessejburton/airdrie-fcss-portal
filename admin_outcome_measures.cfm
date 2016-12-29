<cfinclude template="shared/header.cfm">

<cfinvoke component="#APPLICATION.cfcpath#webservices" method="getOutcomeMeasures" ProgramID="1" returnvariable="response" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Surveys</h1>
			<p>Will become the place to manage survey questions and responses</p>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">