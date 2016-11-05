<cfinclude template="shared/header.cfm">

<!--- TESTING --->
	<cfset Agency = SESSION.Agency>
<!--- TESTING --->

<!--- MAIN CONTENT --->
<section id="main_content">
	<div class="wrapper clearfix">
		<h1>Agency Details</h1>

	<cfoutput>
		<div class="accordion clearfix">
		<!--- AGENCY INFORMATION --->
			<h3 class="open">Agency Information</h3>
			<form id="agency_information_form">
				<div class="form-group seen">		
						<p>
							<label for="agency_name">Agency Name</label><br />
							<input type="text" id="agency_name" placeholder="Please enter the name of your agency." value="#AGENCY.Name#" />
						</p>
						<p>
							<label for="agency_mission">Mission</label><br />						
							<textarea id="agency_mission" placeholder="Please enter the mission for your agency" class="textarea-large">#AGENCY.Mission#</textarea>						
						</p>
						<p>
							<label for="agency_vision">Vision</label><br />						
							<textarea id="agency_vision" placeholder="Please enter the vision for your agency" class="textarea-large">#AGENCY.Vision#</textarea>						
						</p>		
						
						<div class="form_buttons clearfix">
							<button type="button" class="btn btn-primary pull-right" id="save_agency_information_btn">Save</button>
						</div>			
				</div>
			</form>

		<!--- CONTACT INFORMATION --->
			<h3>Contact Information</h3>
			<form id="agency_contact_form">
				<div class="form-group seen">
					<p>
						<label for="agency_phone">Agency Phone Number</label><br />
						<input type="text" id="agency_phone" class="input-half required" placeholder="Please enter the phone number of your agency." value="#AGENCY.Phone#"/>
					</p>
					<p>
						<label for="agency_fax">Agency Fax Number</label><br />
						<input type="text" id="agency_fax" class="input-half required" placeholder="Please enter the fax number of your agency." value="#AGENCY.Fax#" />
					</p>
					<p>
						<label for="agency_email">Agency Email</label><br />
						<input type="text" id="agency_email" class="input-half required" placeholder="Please enter the primary email of your agency." value="#AGENCY.Email#" />
					</p>
					<p>
						<label for="agency_address">Agency Address</label><br />
						<textarea data-maxlength="1000" id="agency_address" placeholder="Please enter your agencies physical address. Please include the postal code." class="input-half required">#AGENCY.Address#</textarea>
					</p>
					<p>
						<label for="agency_mailing">Agency Mailing Address</label><br />
						<span class="label-sub">if different from your physical address</span><br />	
						<textarea data-maxlength="1000" id="agency_mailing" placeholder="Please enter your agencies mailing address. Please include the postal code." class="input-half required">#AGENCY.MailingAddress#</textarea>
					</p>
					<p>
						<label for="agency_website">Website</label><br />
						<input type="text" id="agency_website" class="input-half" placeholder="Please enter your agencies website." value="#AGENCY.Website#" />
					</p>

					<div class="spaced"></div>

					<div class="two-cols half clearfix">
						<p>
							<label for="primary_name">Primary Contact First Name</label><br />
							<input type="text" id="primary_name_first" placeholder="Please enter the primary contacts first name." value="#AGENCY.PRIMARYCONTACT.NAMEFIRST#" />
						</p>
						<p>
							<label for="primary_name">Primary Contact Last Name</label><br />
							<input type="text" id="primary_name_last" placeholder="Please enter the primary contacts last name." value="#AGENCY.PRIMARYCONTACT.NAMELAST#"  />
						</p>
					</div>
					<p>
						<label for="primary_phone">Primary Contact Phone</label><br />
						<input type="text" id="primary_phone" class="input-half" placeholder="Please enter the phone number of the primary contact person." value="#AGENCY.PRIMARYCONTACT.PHONE#"  />
					</p>
					<p>
						<label for="primary_email">Primary Contact Email</label><br />
						<input type="text" id="primary_email" class="input-half" placeholder="Please enter the email of the primary contact person." value="#AGENCY.PRIMARYCONTACT.EMAIL#"  />
					</p>

					<div class="form_buttons clearfix">
						<button type="button" class="btn btn-primary pull-right" id="save_agency_contact_btn">Save</button>
					</div>	
				</div>		
			</form>			

		<!--- ACCOUNTS --->
			<h3>Accounts</h3>
			<form id="agency_accounts_form">
				<div class="form-group">
					<table class="table">
						<thead>
							<tr>
								<th>First Name</th><th>Last Name</th><th>Email</th><th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" placeholder="First name" id="new_account_fname" /></td>
								<td><input type="text" placeholder="Last name" id="new_account_lname" /></td>
								<td><input type="text" placeholder="Email address" id="new_account_email" /></td>
								<td><button class="btn btn-primary" id="add_account"><i class="fa fa-plus"></i> Add Account</button></td>
							</tr>
							<!--- TESTING --->
								<tr class="account-row">
									<form class="account-form">
										<td><input type="text" placeholder="First name" class="new-account-fname" value="" /></td>
										<td><input type="text" placeholder="Last name" class="new-account-lname" value="" /></td>
										<td><input type="text" placeholder="Email address" class="new-account-email" value="<cfoutput>#SESSION.USER.EMAIL#</cfoutput>" /></td>
										<td><button class="btn btn-primary" class="save-account"><i class="fa fa-check"></i> Save Account</button></td>
									</form>
								</tr><tr>
									<form class="account-form">
										<td><input type="text" placeholder="First name" class="new-account-fname" value="<cfoutput>#AGENCY.PRIMARYCONTACT.NAMEFIRST#</cfoutput>" /></td>
										<td><input type="text" placeholder="Last name" class="new-account-lname" value="<cfoutput>#AGENCY.PRIMARYCONTACT.NAMELAST#</cfoutput>" /></td>
										<td><input type="text" placeholder="Email address" class="new-account-email" value="<cfoutput>#AGENCY.PRIMARYCONTACT.EMAIL#</cfoutput>" /></td>
										<td><button class="btn btn-primary" class="save-account"><i class="fa fa-check"></i> Save Account</button></td>
									</form>
								</tr>
							<!--- TESTING --->
						</tbody>
					</table>
				</div>	
			</form>												
		</div>
		
	</cfoutput>

	</div>
</section>

<cfinclude template="shared/footer.cfm">