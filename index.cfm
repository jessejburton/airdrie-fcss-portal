<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">

		<cfif REQUEST.AGENCY.ISNEW>
			<div class="autoreply autoreply-info autoreply-visible">
				<p><strong>Get Started!</strong> We now have everything we need for you to get started on applying for FCSS grants. Click on <a href="programs.cfm">programs</a> in the navigation menu to get started with your first application.</p>
			</div>
		</cfif>

		<h1>Dashboard</h1>

<!--- TODO - Add dashboard items 
		<cfif isDefined('REQUEST.Agency.ADMIN') AND REQUEST.Agency.ADMIN IS true>
			<h1>City of Airdrie Dashboard</h1>
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
		<cfelse>
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
		</cfif>
--->
		
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">