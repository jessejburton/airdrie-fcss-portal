<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1><cfoutput>#SESSION.Applications[1].ProgramName#</cfoutput></h1>

			<div class="autoreply autoreply-success autoreply-visible">
				<p><strong>Congratulations!</strong> Your application was approved for funding.</p>
			</div>

			<div class="dashboard-panel dashboard-panel-large">
				<div class="dashboard-shadow">
					<h1 class="green-background">Funds Allocated</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#DollarFormat(SESSION.Applications[1].Allocated)#</cfoutput></span>
					</div>
				</div>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">