<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">

		<cfif REQUEST.AGENCY.ISNEW>
			<div class="autoreply autoreply-info autoreply-visible">
				<p><strong>Get Started!</strong> We now have everything we need in order for you to get started applying for grant funding. Click on <a href="programs.cfm">programs</a> in the navigation menu to get started with your first application.</p>
			</div>
		</cfif>

			<h1>Agency Dashboard</h1>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Active Programs</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">0</span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Approved Programs</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">0</span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Surveys Completed</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">0</span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Reports Due</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">0</span>
					</div>
				</div>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">