<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div class="panels clearfix">
				<ul class="panel_nav_top clearfix">
					<li class="active"><a href="javascript:;" data-show="agency_panel">Agency Information</a></li>
					<li><a href="javascript:;" data-show="contact_panel">Contact Information</a></li>	
					<!---<li><a href="javascript:;" data-show="people_panel">People</a></li>--->	
				</ul>	

				<!--- AGENCY INFORMATION --->
				<form id="agency_information_form" class="panel_form">
					<div id="agency_panel" class="panel active">
						<h1 class="form-group-heading">Agency Information</h1>
						
						<p>
							<label for="agency_name">Agency Name</label><br />
							<input type="text" id="agency_name" placeholder="Please enter the name of your agency." />
						</p>
						<p>
							<label for="agency_mission">Mission</label><br />						
							<textarea id="agency_mission" placeholder="Please enter the mission for your agency" class="textarea-large"></textarea>						
						</p>
						<p>
							<label for="agency_vision">Vision</label><br />						
							<textarea id="agency_vision" placeholder="Please enter the vision for your agency" class="textarea-large"></textarea>						
						</p>		
						
						<div class="form_buttons clearfix">
							<button type="button" class="btn btn-navigation pull-right" id="save_agency_details_btn">Save Agency Information</button> 
						</div>			
					</div>
				</form>

				<!--- CONTACT INFORMATION --->
				<form id="agency_contact_form" class="panel_form">
					<div id="contact_panel" class="panel">
						<h1 class="form-group-heading">Contact Information</h1>
						
						<p>
							<label for="agency_phone">Agency Phone Number</label><br />
							<input type="text" id="agency_phone" class="input-half" placeholder="Please enter the phone number of your agency." />
						</p>
						<p>
							<label for="agency_fax">Agency Fax Number</label><br />
							<input type="text" id="agency_fax" class="input-half" placeholder="Please enter the fax number of your agency." />
						</p>
						<p>
							<label for="agency_email">Agency Email</label><br />
							<input type="text" id="agency_email" class="input-half" placeholder="Please enter the primary email of your agency." />
						</p>
						<p>
							<label for="agency_address">Agency Address</label><br />
							<textarea data-maxlength="1000" id="agency_address" placeholder="Please enter your agencies physical address. Please include the postal code." class="input-half"></textarea>
						</p>
						<p>
							<label for="agency_mailing">Agency Mailing Address</label><br />
							<span class="label-sub">if different from your physical address</span><br />	
							<textarea data-maxlength="1000" id="program_address" placeholder="Please enter your agencies mailing address. Please include the postal code." class="input-half"></textarea>
						</p>
						<p>
							<label for="agency_website">Website</label><br />
							<input type="text" id="agency_website" class="input-half" placeholder="Please enter your agencies website." />
						</p>

						<hr />

						<p>
							<label for="primary_name">Primary Contact Name</label><br />
							<input type="text" id="primary_name" class="input-half" placeholder="Please enter the name of the programs primary contact person." />
						</p>
						<p>
							<label for="primary_phone">Primary Contact Phone</label><br />
							<input type="text" id="primary_phone" class="input-half" placeholder="Please enter the phone number of the primary contact person." />
						</p>
						<p>
							<label for="primary_email">Primary Contact Email</label><br />
							<input type="text" id="primary_email" class="input-half" placeholder="Please enter the email of the primary contact person." />
						</p>

						<div class="form_buttons clearfix">
							<button type="button" class="btn btn-navigation pull-right" id="save_agency_contact_btn">Save Contact Information</button> 
						</div>	
					</div>					
				</form>

				<!--- PEOPLE --->
					<div id="people_panel" class="panel">
						<h1 class="form-group-heading">People</h1>
						
						<p>This will be where the agencies manage accounts that can access their portal.</p>
					</div>													

			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">