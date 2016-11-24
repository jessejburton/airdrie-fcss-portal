<cfinclude template="shared/header.cfm">

<cfinvoke component="#APPLICATION.cfcpath#account" method="getAccountsByAgencyID" AgencyID="#REQUEST.Agency.AgencyID#" returnvariable="REQUEST.ACCOUNTS" />

<!--- MAIN CONTENT --->
<section id="main_content">
	<div class="wrapper clearfix">
		<h1>Agency Details</h1>

	<cfoutput>
		<div class="accordion clearfix">
			<!--- AGENCY INFORMATION --->
			<h3>Agency Information</h3>		
			<div class="form-group seen">
				<form id="agency_information_form">		
					<p>
						<label for="agency_name">Agency Name</label><br />
						<input type="text" id="agency_name" placeholder="Please enter the name of your agency." value="#XMLFormat(REQUEST.AGENCY.Name)#" />
					</p>
					<p>
						<label for="agency_mission">Mission</label><br />						
						<textarea id="agency_mission" placeholder="Please enter the mission for your agency" class="textarea-large">#XMLFormat(REQUEST.AGENCY.Mission)#</textarea>						
					</p>
					<p>
						<label for="agency_vision">Vision</label><br />						
						<textarea id="agency_vision" placeholder="Please enter the vision for your agency" class="textarea-large">#XMLFormat(REQUEST.AGENCY.Vision)#</textarea>						
					</p>		

					<div class="spaced"></div>

					<p>
						<label for="agency_phone">Agency Phone Number</label><br />
						<input type="text" id="agency_phone" class="input-half required" placeholder="Please enter the phone number of your agency." value="#XMLFormat(REQUEST.AGENCY.Phone)#"/>
					</p>
					<p>
						<label for="agency_fax">Agency Fax Number</label><br />
						<input type="text" id="agency_fax" class="input-half" placeholder="Please enter the fax number of your agency." value="#XMLFormat(REQUEST.AGENCY.Fax)#" />
					</p>
					<p>
						<label for="agency_email">Agency Email</label><br />
						<input type="text" id="agency_email" class="input-half required" placeholder="Please enter the primary email of your agency." value="#XMLFormat(REQUEST.AGENCY.Email)#" />
					</p>
					<p>
						<label for="agency_address">Agency Address</label><br />
						<textarea data-maxlength="1000" id="agency_address" placeholder="Please enter your agencies physical address. Please include the postal code." class="input-half required">#XMLFormat(REQUEST.AGENCY.Address)#</textarea>
					</p>
					<p>
						<label for="agency_mailing">Agency Mailing Address</label><br />
						<span class="label-sub">if different from your physical address</span><br />	
						<textarea data-maxlength="1000" id="agency_mailing" placeholder="Please enter your agencies mailing address. Please include the postal code." class="input-half">#XMLFormat(REQUEST.AGENCY.MailingAddress)#</textarea>
					</p>
					<p>
						<label for="agency_website">Website</label><br />
						<input type="text" id="agency_website" class="input-half" placeholder="Please enter your agencies website." value="#XMLFormat(REQUEST.AGENCY.Website)#" />
					</p>				
					
					<div class="form_buttons clearfix">
						<button type="button" class="btn btn-primary pull-right save">Save</button>
					</div>			
				</form>
			</div>

<!--- BOARD DETAILS --->
			<h3>Board Members</h3>
			<div class="form-group" id="board_members_panel">
				<p>Please enter your current board members names and titles. Leave spaced blank if you do not have at least 5 members.</p>

				<div id="board_list">
					<cfset atLeastOneRequired = true> <!--- Need to make the first one required in case the delete all of the members --->
					<cfloop array="#REQUEST.AGENCY.BOARDMEMBERS#" index="member">
						<div class="two-cols board-member">
							<p><input type="text" name="board_name" class="inline #iif(atLeastOneRequired, DE('required'), DE(''))#" placeholder="Board member's name" value="#XMLFormat(member.NAME)#" /></p>
							<p><input type="text" name="board_title" class="inline #iif(atLeastOneRequired, DE('required'), DE(''))#" placeholder="Board member's title" value="#XMLFormat(member.TITLE)#" /></p>
						</div>
						<cfset atleastOneRequired = false>
					</cfloop>
						
					<cfif ArrayLen(REQUEST.AGENCY.BOARDMEMBERS) IS 0>
						<cfloop from="1" to="5" index="i">
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline #iif(atLeastOneRequired AND ArrayLen(REQUEST.AGENCY.BOARDMEMBERS) IS 0, DE('required'), DE(''))#" placeholder="Board member's name" /></p>
								<p><input type="text" name="board_title" class="inline #iif(atLeastOneRequired AND ArrayLen(REQUEST.AGENCY.BOARDMEMBERS) IS 0, DE('required'), DE(''))#" placeholder="Board member's title" /></p>
							</div>
						</cfloop>				
					</cfif>
				</div>

				<p><a href="javascript:;" class="add-board"><i class="fa fa-plus"></i> add another</a></p>

				<div class="form_buttons clearfix">
					<button type="button" class="btn btn-primary pull-right" id="save_board_members">Save</button>
				</div>
			</div>		

		<!--- DOCUMENTS --->
			<h3>Documents</h3>
			<div class="form-group">
				<cfinclude template="shared/documents.cfm">

				<div class="form_buttons clearfix">
					<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
					<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
				</div>	
			</div>	

		<!--- ACCOUNTS --->
			<h3>Accounts</h3>
			<div class="form-group" id="account_tab">
				<table class="table" id="account_table">
					<thead>
						<tr>
							<th>Name</th><th>Email</th><th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" placeholder="Name" id="new_account_name" /></td>
							<td><input type="text" placeholder="Email" id="new_account_email" /></td>
							<td><button class="btn btn-primary" id="add_account"><i class="fa fa-plus"></i> Add Account</button></td>
						</tr>

						<cfloop array="#REQUEST.ACCOUNTS#" index="account">
							<tr class="account-row" data-id="#encodeForHTMLAttribute(account.ACCOUNTID)#">
								<td><input type="text" placeholder="Name" class="account-name" value="#XMLFormat(account.NAME)#" /></td>
								<td><input type="text" placeholder="Email address" class="account-email" value="<cfoutput>#XMLFormat(account.EMAIL)#</cfoutput>" /></td>
								<td>
									<button class="btn btn-primary save-account"><i class="fa fa-check"></i> Save Account</button>
									<button class="btn btn-primary password-reset"><i class="fa fa-check"></i> Reset Password</button>
									<label>
										<input type="checkbox" class="account-active" #iif(encodeForHTMLAttribute(account.ISACTIVE), DE('checked'), DE(''))#> Active
									</label>
								</td>
							</tr>
						</cfloop>
					</tbody>
					<tfoot>
						<tr class="account-row template">
							<td><input type="text" placeholder="Name" class="account-name" /></td>
							<td><input type="text" placeholder="Email address" class="account-email" /></td>
							<td>
								<button class="btn btn-primary" class="save-account"><i class="fa fa-check"></i> Save Account</button>
								<button class="btn btn-primary" class="password-reset"><i class="fa fa-check"></i> Reset Password</button>
							</td>
						</tr>
					</tfoot>
				</table>

			</div>	
		</div>
	</cfoutput>

	</div>
</section>

<cfinclude template="shared/footer.cfm">