<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Package Builder</h1>

			<label for="package_name">Package Name:</label>
			<input type="text" id="package_name" placeholder="enter the name to use for this package" />

			<div class="form-buttons clearfix">
				<button type="button" id="save_package" class="btn btn-primary pull-right"><i class="fa fa-save"></i> Save</button>
			</div>			

			<div class="clearfix">
				<div id="package_available_elements">
					<h1>Package Elements</h1>
					<ul id="package_available_elements_list">
						<li class="heading">Agency Elements</li>
						<li>Name</li>
						<li>Mission</li>
						<li>Vision</li>
						<li>Agency Phone</li>
						<li>Agency Email</li>
						<li>Agency Fax</li>
						<li>Agency Address</li>
						<li>Agency Mailing Address</li>
						<li>Agency Website</li>
						<li>Board Members</li>
						<li class="heading">Program Elements</li>
						<li>Name</li>
						<li>Statement</li>
						<li>Target Augience</li>
						<li>Mostly Airdrie Residents</li>
						<li>Primary Contact</li>
						<li>Primary Phone</li>
						<li>Primary Email</li>
						<li>Program Address</li>
						<li>Program Mailing Address</li>
						<li>Need</li>
						<li>Goal</li>
						<li>Strategies</li>
						<li>Rationale</li>
						<li>Footnotes</li>
						<li>Prevention Focus</li>
						<li>Alignment</li>
						<li>Fits With Mission?</li>
						<li>Considered Partnerships?</li>
						<li>Estimated From Airdrie</li>
						<li>Estimated From Other</li>
						<li>Budget</li>
						<li>Documents</li>
						<li>Short Term Goals</li>
						<li>Mid Term Goals</li>
						<li>Long Term Goals</li>
						<li>Current Status</li>
						<li>Status List</li>
					</ul>
				</div>

				<div id="package_elements">
					<h1>Current Package</h1>					
					<ul id="package_elements_list">
						<li class="heading">Give this package a name</li>
					</ul>
					<div class="placeholder">Click on elements to add or remove them from this package, drag to re-order elements in the current package.</div>
				</div>
			</div>

			<div class="form-buttons">
				<button type="button" id="save_package" class="btn btn-primary pull-right"><i class="fa fa-save"></i> Save</button>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">