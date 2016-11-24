<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<cfif REQUEST.AGENCY.ISNEW>
				<div class="autoreply autoreply-info autoreply-visible">
					<p><strong>Get Started!</strong> You are now ready to begin the application process. The first step to every application is the <a href="application_form.cfm">Letter of Intent</a>.</p>
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
							<cfif ListFind(PROGRAM.StatusList, 'LOI - Approved') IS 0>
								<cfset ButtonText = "Letter of Intent">
							<cfelse>
								<cfset ButtonText = "Application Form">
							</cfif>

							<a href="application_form.cfm?ID=#program.ProgramID#" class="btn btn-primary">
								<i class="fa fa-check-circle"></i> <span>#ButtonText#</span>
							</a>							

							<!--- TODO - Clean this up <ul class="application-process">
								<li><a href="application_form.cfm?ID=#program.ProgramID#" class="#IIF(ListFind(PROGRAM.StatusList, 'LOI - Approved') GT 0, DE('complete'), DE(''))#"><i class="fa fa-check-circle"></i><span>Letter of Intent</span></a></li>
								<li><a href="application_form.cfm?ID=#program.ProgramID#" class="#IIF(ListFind(PROGRAM.StatusList, 'LOI - Approved') GT 0, DE(''), DE('not-available'))# #IIF(ListFind(PROGRAM.StatusList, 'APPLICATION - Approved') GT 0, DE('complete'), DE(''))#"><i class="fa fa-check-circle"></i><span>Application Form</span></a></li>
								<li><a href="mid_year.cfm?ID=#program.ProgramID#" class="#IIF(ListFind(PROGRAM.StatusList, 'APPLICATION - Approved') GT 0, DE(''), DE('not-available'))#"><i class="fa fa-check-circle"></i><span>Mid-Year Report</span></a></li>
								<li><a href="year_end.cfm?ID=#program.ProgramID#" class="#IIF(ListFind(PROGRAM.StatusList, 'APPLICATION - Approved') GT 0, DE(''), DE('not-available'))#"><i class="fa fa-check-circle"></i><span>Final Report</span></a></li>
							</ul>--->

							<p class="spaced"><strong>Current Status: </strong> #PROGRAM.CurrentStatus#</p>
						</div>		
					</cfloop>
				</cfoutput>
			</cfif>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">