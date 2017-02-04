<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<cfif REQUEST.AGENCY.ISNEW>
				<div class="autoreply autoreply-info autoreply-visible">
					<p><strong>Get Started!</strong> You are now ready to begin the application process. The first step to every application is the <a href="application_form.cfm">Letter of Intent</a> (LOI). The LOI allows you to sketch out your application and determine your basic eligibility before creating the full application. Your LOI will be reviewed by Social Planning staff before you can complete the full application. 
				</div>
			</cfif>
			
			<cfif REQUEST.SETTINGS.ISENABLEDLETTEROFINTENT>
				<p class="spaced large-text"><a href="application_form.cfm" class="btn btn-primary"><i class="fa fa-plus-circle"></i> Start New Program Application</a></p>
			<cfelse>
				<div class="autoreply autoreply-info autoreply-visible"><p>Thank you for your interest in Airdrie FCSS funding for locally-driven preventive social programs. Letters of Intent for funding for the <cfoutput>#Year(Now())#</cfoutput> year have now closed. Please check again in <cfoutput>#Year(Now()) + 1#</cfoutput>.
 				<br /><br />
				<span><i class='fa fa-question-circle'></i> For inquiries, please contact the City of Airdrie Social Planning team at <a href="mailto:<cfoutput>#REQUEST.SETTINGS.AdminEmail#</cfoutput>"><cfoutput>#REQUEST.SETTINGS.AdminEmail#</cfoutput></a> or by phone at <cfoutput>#REQUEST.SETTINGS.SupportNumber#</cfoutput>.</span></p></div>
			</cfif>

			<!--- Get any existing programs --->
			<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramsByAgencyID" AgencyID="#REQUEST.AGENCY.AGENCYID#" returnvariable="PROGRAMS" />

			<cfif ARRAYLEN(PROGRAMS) GT 0>
				<h1>Current Programs</h1>

				<cfoutput>
					<cfloop array="#PROGRAMS#" index="program">
						<div class="program">
							<h3 class="spaced" title="Program ID #encodeForHTMLAttribute(program.ProgramID)#">#XMLFormat(program.ProgramName)#</h3>
							<cfif ListFind(program.StatusList, "PROGRAM - Funded") IS 0>
								<div>	
									<cfif ListFind(PROGRAM.StatusList, 'LOI - Approved') IS 0>
										<cfset ButtonText = "Letter of Intent">
									<cfelse>
										<cfset ButtonText = "Application Form">
									</cfif>

									<a href="application_form.cfm?ID=#program.ProgramID#" class="btn btn-primary">
										<i class="fa fa-check-circle"></i> <span>#ButtonText#</span>
									</a>							
								</div>
							<cfelse>
								<div>
									<p>
										<a href="outcome_measures.cfm?ProgramID=#URLEncodedFormat(program.ProgramID)#" class="btn btn-primary">
											<i class="fa fa-pie-chart"></i> Outcome Measures
										</a>
										<a href="mid_year.cfm?ID=#program.ProgramID#" class="btn btn-primary">
											<i class="fa fa-file-o"></i> Mid-Year Report
										</a>
										<a href="year_end.cfm?ID=#program.ProgramID#" class="btn btn-primary">
											<i class="fa fa-file-o"></i> Year-End Report
										</a>
									</p>
									<p>
										<a href="admin_create_package.cfm?ProgramID=#URLEncodedFormat(program.ProgramID)#" class="link" style="margin-top: 15px;" target="_blank"><i class="fa fa-file-pdf-o"></i> Printable Program Details</a>
									</p>
								</div>
							</cfif>
							<p class="spaced"><strong>Current Status: </strong> #PROGRAM.CurrentStatus#</p>
						</div>		
					</cfloop>
				</cfoutput>
			</cfif>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">