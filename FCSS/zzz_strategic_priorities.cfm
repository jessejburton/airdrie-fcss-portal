<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<form id="strategic_priorities_form">
				<div id="strategic_priorities" class="form-group">
					<h1 class="form-group-heading">Strategic Priorities</h1>
					<span class="subtext form-group-heading">The place to manage what strategic priorities appear on the application form.</span>
					
					<p>
						<label for="text_input">Priority</label><br />
						<input type="text" id="text_input" placeholder="Enter the name of the priority to add." />
					</p>
					<p>
						<label for="long_description">Priority Description</label><br />
						<textarea id="long_description" placeholder="Provide some detailed information about what the priority means." class="textarea-large"></textarea>
						
					</p>

					<div class="form_buttons clearfix">
						<button type="button" class="btn btn-secondary pull-left">Cancel</button>
						<button type="button" class="btn btn-primary pull-right">Add</button> 
					</div>	
				</div>
			</form>

			<hr />

			<div id="current_strategic_priorities" class="form-group">
				<h1 class="form-group-heading">Current Strategic Priorities</h1>

				<div style="overflow-x:auto;"> <!--- Added for responsiveness --->
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>Priority</th>
								<th>Actions</th>
							</tr>
						</thead>

						<tbody>
							<tr><td>1</td><td>Poverty Prevention</td><td><a href="javascript:;">edit</a> | <a href="javascript:;">disable</a></td></tr>
							<tr><td>2</td><td>Strengthening Youth Well-Being</td><td><a href="javascript:;">edit</a> | <a href="javascript:;">disable</a></td></tr>
							<tr><td>3</td><td>Social and Community Inclusion</td><td><a href="javascript:;">edit</a> | <a href="javascript:;">disable</a></td></tr>	
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">