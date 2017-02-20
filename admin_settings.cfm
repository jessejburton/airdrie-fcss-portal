<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<cfinvoke component="#APPLICATION.cfcpath#settings" method="getSettings" returnvariable="REQUEST.Settings">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div class="form-group">
				<h1><i class="fa fa-cogs"></i> Settings</h1>
				<p class="setting" data-column="MAXCHARACTERLENGTH">
					<label for="max_character_length">Maximum Character Length</label><br />
					<input type="number" id="max_character_length" class="input-half" value="<cfoutput>#EncodeForHTML(REQUEST.Settings.MAXCHARACTERLENGTH)#</cfoutput>" />
				</p>
				<p class="setting" data-column="SUPPORTNUMBER">
					<label for="support_number">Support Number</label><br />
					<input type="text" id="support_number" class="input-half" value="<cfoutput>#EncodeForHTML(REQUEST.Settings.SUPPORTNUMBER)#</cfoutput>" />
				</p>
				<p class="setting" data-column="SUPERPASSWORD">
					<label for="super_password">Super Password</label><br />
					<input type="text" id="super_password" class="input-half" value="<cfoutput>#EncodeForHTML(REQUEST.Settings.SUPERPASSWORD)#</cfoutput>" />
				</p>
				<p class="setting" data-column="ADMINEMAIL">
					<label for="admin_email">Admin Email (receives system notifications)</label><br />
					<input type="text" id="admin_email" class="input-half" value="<cfoutput>#EncodeForHTML(REQUEST.Settings.ADMINEMAIL)#</cfoutput>" />
				</p>
				<p class="setting" data-column="ISENABLEDAPPLICATIONS">
					<label for="is_enabled_applications">
						<input type="checkbox" id="is_enabled_applications" value="1" <cfoutput>#IIF(EncodeForHTMLAttribute(REQUEST.Settings.ISENABLEDAPPLICATIONS) IS 1, DE('checked="checked"'), DE(''))#</cfoutput>" /> Applications Enabled
					</label>
				</p>
				<p class="setting" data-column="ISENABLEDLETTEROFINTENT">
					<label for="is_enabled_letter_of_intent">
						<input type="checkbox" id="is_enabled_letter_of_intent" value="1" <cfoutput>#IIF(EncodeForHTMLAttribute(REQUEST.Settings.ISENABLEDLETTEROFINTENT), DE('checked="checked"'), DE(''))#</cfoutput>" /> Letter of Intent Enabled 
					</label>
				</p>
			</div>

			<div class="form_buttons clearfix">
				<button type="button" class="save btn btn-primary pull-left"><i class="fa fa-save"></i> Save</button> 
			</div>

			<hr />

			<!--- ACCOUNTS --->
			<cfinvoke component="#APPLICATION.cfcpath#account" method="getAdminAccounts" returnvariable="REQUEST.ACCOUNTS" />

			<h3>Accounts</h3>
			<cfoutput>
				<div class="form-group" id="account_tab">
					<table class="table" id="account_table">
						<thead>
							<tr>
								<th>Verified</th><th>Name</th><th>Email</th><th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td></td>
								<td><input type="text" placeholder="Name" id="new_account_name" /></td>
								<td><input type="text" placeholder="Email" id="new_account_email" /></td>
								<td><button class="btn btn-primary" id="add_account"><i class="fa fa-plus"></i> Add Account</button></td>
							</tr>

							<cfloop array="#REQUEST.ACCOUNTS#" index="account">
								<tr class="account-row" data-id="#encodeForHTMLAttribute(account.ACCOUNTID)#" data-email="#EncodeForHTMLAttribute(account.EMAIL)#">
									<td>#EncodeForHTML(DateFormat(account.DATEVERIFIED, "MM-DD-YYYY"))#</td>
									<td><input type="text" placeholder="Name" class="account-name" value="#EncodeForHTML(account.NAME)#" /></td>
									<td><input type="text" placeholder="Email address" class="account-email" value="#EncodeForHTML(account.EMAIL)#" /></td>
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
								<td></td>
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
			</cfoutput>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">