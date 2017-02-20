<cfinclude template="shared/header.cfm"> 

<!--- Make sure there is a specific program to work with --->
<cfif NOT isDefined('URL.ProgramID') OR NOT isNumeric(URL.ProgramID)>
	<cflocation url="index.cfm" addtoken="false">
	<cfabort>
</cfif>

<!--- Check Permission --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="checkProgramAccessByAccountID" ProgramID="#URL.ProgramID#" returnvariable="Check" />
<cfif NOT Check>
	<!--- The user does not have permission --->
	<cflocation url="index.cfm" addtoken="false">
	<cfabort>
</cfif>

<!--- Get the approrpriate survey and program data --->
<cfinvoke component="#APPLICATION.cfcpath#survey" method="getSurveysByProgramID" ProgramID="#URL.ProgramID#" returnvariable="response" />
<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramByID" ProgramID="#URL.ProgramID#" returnvariable="PROGRAM" />
<cfset REQUEST.SURVEYS = response.DATA>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<!--- If they haven't selected indicators yet --->
			<cfif ArrayLen(REQUEST.SURVEYS) IS 0>
				<h1>Outcome Measures</h1>
				<p>Agencies are asked to conduct outcome measurement for each of their FCSS funded programs. Outcome measurement is used to improve accountability, and more importantly, to help programs improve services. Outcome measurement addresses the question: "What difference has this program made in the lives of individuals, families or the community?"</p>

				<p>Before you begin, ensure that you have already met with the City of Airdrie FCSS team to discuss your program's outcomes and indicators. Meetings are usually held in February and March.</p>

				<cfoutput>
					<p><strong class="blue">No, we haven't met with the FCSS team yet.</strong><br />Contact Social Planning at #REQUEST.SETTINGS.SupportNumber# or via email at <a href="mailto:#REQUEST.SETTINGS.AdminEmail#" class="link">#REQUEST.SETTINGS.AdminEmail#</a></p>
				</cfoutput>

				<p><strong class="blue">Yes, we've met with the FCSS team already.</strong><br />Please continue by selecting up to two indicators for your program, keeping in mind what was discussed at your meeting:</p>
				
				<!--- Get the available indicators --->
				<cfinvoke component="#APPLICATION.cfcpath#survey" method="getFullIndicators" returnvariable="Indicators" />
				<div id="indicators" class="clearfix">	
					<cfoutput>
						<cfloop array="#Indicators.AREAS#" index="a">
							<div class="area">
								<h1 style="background-color: #EncodeForHTMLAttribute(a.COLOR)#">#EncodeForHTML(a.AREA)#</h1>			
								<cfloop array="#a.OUTCOMES#" index="o">
									<div class="outcome" style="background-color: #EncodeForHTMLAttribute(a.COLOR)#">
										<h2><strong>Outcome:</strong> #EncodeForHTML(o.OUTCOME)#</h2>
										<h2><strong>Indicators:</strong></h2>
										<ul>
											<cfloop array="#o.INDICATORS#" index="i">
												<li class="indicator" data-id="#EncodeForHTMLAttribute(i.INDICATORID)#" style="background-color: #EncodeForHTMLAttribute(a.COLOR)#">#EncodeForHTML(i.INDICATOR)#</li>
											</cfloop>
										</ul>
									</div>
								</cfloop>
							</div>
						</cfloop>
					</cfoutput>
				</div>

				<div class="form-buttons clearfix">
					<input type="hidden" id="programID" value="<cfoutput>#URL.ProgramID#</cfoutput>" />
					<button type="button" class="save-indicators btn btn-primary pull-right"><i class="fa fa-save"></i> Save</button>
				</div>	
			<cfelse>
				<h1>Surveys For <cfoutput>#PROGRAM.ProgramName#</cfoutput></h1>

				<div class="autoreply autoreply-success" id="imported_message">
					<p><strong>Success!</strong> Your survey data has been imported.</p>
				</div>

				<cfoutput>
					<cfloop array="#REQUEST.SURVEYS#" index="survey">
						<div class="survey" data-id="#EncodeForHTMLAttribute(survey.ID)#">
							<h3>#survey.NAME#</h3>
							<p>#survey.DESCRIPTION#</p>						
							<p class="small-text"><em>#survey.citation#</em></p>
							<div class="form-buttons clearfix">
								<button class="btn btn-secondary pull-left" onclick="selectFile(#EncodeForHTMLAttribute(survey.ID)#);">Import Data</button>
								<a class="btn btn-primary pull-right" href="survey.cfm?SurveyID=#URLEncodedFormat(survey.ID)#&ProgramID=#URLEncodedFormat(URL.ProgramID)#">Begin Survey</a>
							</div>

							<p class="small-text"><a href="survey_import_template.cfm?ProgramID=#URLEncodedFormat(URL.ProgramID)#&SurveyID=#URLEncodedFormat(survey.ID)#" class="link underlined" target="_blank">download</a> the import template for this survey.</p>
						</div>
					</cfloop>
				</cfoutput>
			</cfif>
		</div>
	</section>	

	<form enctype="multipart/form-data" method="post" action="survey_import.cfm" class="hidden" id="survey_import_form">
		<input type="text" id="import_survey_id" name="import_survey_id" />
		<input type="text" id="import_program_id" name="import_program_id" value="<cfoutput>#EncodeForHTML(URL.ProgramID)#</cfoutput>" />
		<input type="file" name="import_file_select" id="import_file_select" /><br />
		<input type="submit" value="Upload File" />
	</form>

<cfinclude template="shared/footer.cfm">