<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper-full clearfix">

			<h1>Start a New Survey</h1>
			<button class="btn btn-lg btn-secondary" onclick="window.location='survey.cfm'">BEGIN SURVEY</button>	

			<hr />

			<h1>Find an Existing Participant</h1>		
			<form>
				<p>
					<label for="client_name">Search by Client Name</label><br />
					<input type="text" class="input-half inline" id="client_name" placeholder="Enter an existing clients name" /> 
					<button type="button" class="btn btn-primary inline">Search</button> 
				</p>

				<p class="spaced"><strong>- OR -</strong></p>
				
				<p>
					<label for="client_id">Search by Client ID</label><br />
					<input type="text" class="input-half inline" id="client_id" placeholder="Enter an existing clients ID" />
					<button type="button" class="btn btn-primary inline">Search</button>
				</p>
			</form>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">