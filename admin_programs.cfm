<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<!--- Get existing programs --->
<cfinvoke component="#APPLICATION.cfcpath#program" method="getAllPrograms" returnvariable="Programs" />
<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramAlerts" returnvariable="Alerts" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div id="program_alerts">
				<h1><i class="fa fa-exclamation-circle"></i> Notice!</h1>
				<p>The following programs require your attention:</p>
				<cfoutput>
					<cfloop array="#Alerts#" index="alert">
						<div class="program program-alert" data-programid="#alert.PROGRAMID#">
							<cfif alert.STATUS IS 'LOI - Submitted to Airdrie'>
								<p>
									<strong>#alert.PROGRAMNAME#</strong><br />
									LOI has been submitted and is ready for your review and approval.
								</p>
								<div class="clearfix">
									<button type="button" class="btn btn-secondary pull-left program-review"><i class="fa fa-file-text"></i> Review Program</button>
									<button type="button" class="btn btn-primary pull-right program-approve"><i class="fa fa-check-circle"></i> Approve LOI</button>
								</div>	
							</cfif>
							<cfif alert.STATUS IS 'APPLICATION - Submitted to Airdrie'>
								<p>
									<strong>#alert.PROGRAMNAME#</strong><br />
									Application has been submitted and is ready for your review and approval.
								</p>
								<div class="clearfix">
									<button type="button" class="btn btn-secondary pull-left program-review"><i class="fa fa-file-text"></i> Review Program</button>
									<button type="button" class="btn btn-primary pull-right program-approve"><i class="fa fa-check-circle"></i> Approve Application</button>
								</div>								
							</cfif>
						</div>	
					</cfloop>
				</cfoutput>
			</div>

			<h1>Programs</h1>

			<div id="current_programs">
				<cfoutput>
					<cfloop array="#Programs#" index="program">
						<div class="program" data-programid="#program.ProgramID#">
							<table class="table">
								<thead>
									<tr><th colspan="2"><h1>#XMLFormat(program.ProgramName)#</h1></th></tr>
									<tr><td colspan="2">#XMLFormat(program.ProgramStatement)#</td></tr>
								</thead>
								<tbody>
									<tr><th style="width: 200px;">Status:</th><td>#XMLFormat(program.CURRENTSTATUS)#</td></tr>
									<tr><th>Contact Name:</th><td>#XMLFormat(program.PRIMARYCONTACTNAME)#</td></tr>
									<tr><th>Email:</th><td>#XMLFormat(program.PRIMARYEMAIL)#</td></tr>
									<tr><th>Phone:</th><td>#XMLFormat(program.PRIMARYPHONE)#</td></tr>
									<tr><th>Address:</th><td>#XMLFormat(program.PROGRAMADDRESS)#</td></tr>
									<cfif program.PROGRAMADDRESS NEQ program.PROGRAMMAILINGADDRESS AND LEN(program.PROGRAMMAILINGADDRESS) GT 0>
										<tr><th>Mailing Address:</th><td>#XMLFormat(program.PROGRAMMAILINGADDRESS)#</td></tr>
									</cfif>
									<tr><th>Agency:</th><td>#XMLFormat(program.AGENCY)#</td></tr>
									<tr><th>Estimated Budget:</th><td>#XMLFormat(DollarFormat(program.ESTIMATEDFROMAIRDRIE))#</td></tr>
								</tbody>
								<tfoot>
									<tr>
										<th>
											<a class="btn btn-secondary" target="_blank" href="admin_create_package.cfm?programID=#EncodeForHTMLAttribute(program.PROGRAMID)#"><i class="fa fa-file-text"></i> View Full Details</a>
										</th>
										<th style="text-align: right;" class="fund-section">
											<cfif LEN(program.FUNDSALLOCATED) IS 0>
												<input type="number" class="allocate-fund-amount input-currency" placeholder="Amount" style="width: 200px">
												<button class="btn btn-primary program-fund" type="button"><i class="fa fa-check-circle"></i> Allocate Funds</button>
											<cfelse>
												Funded in the amount of #DollarFormat(program.FUNDSALLOCATED)#
											</cfif>
										</th>
									</tr>
								</tfoot>
							</table>
						</div>
					</cfloop>
				</cfoutput>
			</div>
		</div>
	</section>	

	<!--- USED FOR MESSAGE --->
	<div id="superadmin">
		<p>Please enter both your password and the super password to confirm funding this program in the amount of $<span id="fund_amount" style="font-weight: bold;"></span>.</p>
		<p>
			<label for="your_password">Your Password:</label><br />
			<input type="password" is="your_password" placeholder="Your Password" />
		</p>
		<p>
			<label for="super_password">Super Password:</label><br />
			<input type="password" is="super_password" placeholder="Super Password" />
		</p>
		<p class="form-buttons clearfix">
			<button type="button" class="cancel btn btn-secondary pull-left"><i class="fa fa-close"></i> Cancel</button>
			<button type="button" id="confirm_fund_program" class="btn btn-primary pull-right"><i class="fa fa-usd"></i> Fund</button>
		</p>	
	</div>

	<div id="enterpassword">
		<p>Please enter your password to approve this program.</p>
		<p>
			<label for="your_password">Your Password:</label><br />
			<input type="password" is="your_password" placeholder="Your Password" />
		</p>
		<p class="form-buttons clearfix">
			<button type="button" class="cancel btn btn-secondary pull-left"><i class="fa fa-close"></i> Cancel</button>
			<button type="button" id="confirm_approve_program" class="btn btn-primary pull-right"><i class="fa fa-usd"></i> Approve</button>
		</p>	
	</div>

<cfinclude template="shared/footer.cfm">