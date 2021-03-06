<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">

		<cfif REQUEST.AGENCY.ISNEW>
			<div class="autoreply autoreply-info autoreply-visible">
				<p><strong>Get Started!</strong> We now have everything we need for you to get started on applying for FCSS grants. Click on <a href="programs.cfm">programs</a> in the navigation menu to get started with your first application.</p>
			</div>
		</cfif>

		<cfif isDefined('REQUEST.Agency.ADMIN') AND REQUEST.Agency.ADMIN IS true>
			<cfset STATS = createObject("component", "#APPLICATION.cfcpath#Dashboard")>

			<h1><i class="fa fa-bar-chart"></i> City of Airdrie Dashboard</h1>

			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Active Programs</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumProgramsTotal())#</cfoutput></span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Approved Programs</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumApprovedProgramsTotal())#</cfoutput></span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Surveys Collected</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumClientSurveysTotal())#</cfoutput></span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Active Agencies</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumAgencies())#</cfoutput></span>
					</div>
				</div>
			</div>
		<cfelse>
			<cfset STATS = createObject("component", "#APPLICATION.cfcpath#Dashboard")>

			<h1><i class="fa fa-bar-chart"></i> <cfoutput>#EncodeForHTML(REQUEST.Agency.Name)#</cfoutput> Dashboard</h1>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Active Programs</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumProgramsByAgencyID())#</cfoutput></span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Approved Programs</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumApprovedProgramsByAgencyID())#</cfoutput></span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Number of Clients</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumClientsByAgencyID())#</cfoutput></span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Surveys Completed</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number"><cfoutput>#EncodeForHTML(STATS.getNumClientSurveysByAgencyID())#</cfoutput></span>
					</div>
				</div>
			</div>			
		</cfif>

		
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">