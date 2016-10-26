<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper-full clearfix">
			<div class="dashboard-panel dashboard-panel-medium">
				<div class="dashboard-shadow">
					<h1 class="green-background">Gender</h1>
					<div class="dashboard-panel-body">
						<div id="scatter_chart_div" style="width: 100%;"></div>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-medium">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Age</h1>
					<div class="dashboard-panel-body">
						<div id="piechart" style="width: 100%;"></div>
					</div>
				</div>
			</div>				

			<div class="dashboard-panel dashboard-panel-large">
				<div class="dashboard-shadow">
					<h1 class="green-background">Last 7 Days of Survey Completions</h1>
					<div class="dashboard-panel-body">
						<div id="chart_div" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
			</div>


			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Current Applications</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">23</span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Accounts</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">15</span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="green-background">Agencies</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">42</span>
					</div>
				</div>
			</div>
			<div class="dashboard-panel dashboard-panel-small">
				<div class="dashboard-shadow">
					<h1 class="blue-background">Priorities</h1>
					<div class="dashboard-panel-body">
						<span class="dashboard-number">3</span>
					</div>
				</div>
			</div>

		</div>
	</section>	

<cfinclude template="shared/footer.cfm">