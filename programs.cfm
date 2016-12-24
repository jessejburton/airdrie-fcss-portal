<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<cfif REQUEST.AGENCY.ISNEW>
				<div class="autoreply autoreply-info autoreply-visible">
					<p><strong>Get Started!</strong> You are now ready to begin the application process. The first step to every application is the <a href="application_form.cfm">Letter of Intent</a> (LOI). The LOI allows you to sketch out your application and determine your basic eligibility before creating the full application. Your LOI will be reviewed by Social Planning staff before you can complete the full application. 
				</div>
			</cfif>
				
			<p class="spaced large-text"><a href="application_form.cfm" class="btn btn-primary"><i class="fa fa-plus-circle"></i> Start New Program Application</a></p>

			<!--- Get any existing programs --->
			<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramsByAgencyID" AgencyID="#REQUEST.AGENCY.AGENCYID#" returnvariable="PROGRAMS" />

			<cfif ARRAYLEN(PROGRAMS) GT 0>
				<h1>Current Programs</h1>

				<cfoutput>
					<cfloop array="#PROGRAMS#" index="program">
						<div class="program">
							<h3 class="spaced">#program.ProgramName#</h3>

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
										<a href="javascript:;" class="link" style="margin-top: 15px;"><i class="fa fa-file-pdf-o"></i> print application form</a>
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