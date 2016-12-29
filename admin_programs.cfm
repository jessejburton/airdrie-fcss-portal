<cfinclude template="shared/header.cfm">

<!--- Get existing programs --->
<cfinvoke component="#APPLICATION.cfcpath#program" method="getAllPrograms" returnvariable="Programs" />
<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramAlerts" returnvariable="Alerts" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div id="program_alerts">
				<h1><i class="fa fa-exclamation-circle"></i> Alerts</h1>
				<!--- TODO - take a look how the email created the link and make that appear here --->
				<cfdump var="#Alerts#">
			</div>

			<h1>Programs</h1>

			<div id="current_programs">
				<cfoutput>
					<cfloop array="#Programs#" index="program">
						<div class="program">
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
								</tbody>
								<tfoot>
									<tr><th colspan="2"><a class="link" target="_blank" href="admin_create_package.cfm?programID=#EncodeForHTMLAttribute(program.PROGRAMID)#"><i class="fa fa-file-pdf-o"></i> View Full Details</a></th></tr>
								</tfoot>
							</table>
						</div>
					</cfloop>
				</cfoutput>
			</div>

		</div>
	</section>	

<cfinclude template="shared/footer.cfm">