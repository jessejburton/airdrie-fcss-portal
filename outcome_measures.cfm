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
		<cfdump var="#REQUEST.SURVEYS#">

			<h1>Surveys For <cfoutput>#PROGRAM.ProgramName#</cfoutput></h1>

			<div class="autoreply autoreply-success" id="imported_message">
				<p><strong>Success!</strong> Your survey data has been imported.</p>
			</div>

			<cfoutput>
				<cfloop array="#REQUEST.SURVEYS#" index="survey">
					<div class="survey">
						<h3>#survey.NAME#</h3>
						<p>#survey.DESCRIPTION#</p>						
						<p class="small-text"><em>#survey.citation#</em></p>
						<div class="form-buttons clearfix">
							<button class="btn btn-secondary pull-left" onclick="selectFile();">Import Data</button>
							<a class="btn btn-primary pull-right" href="survey.cfm?SurveyID=#URLEncodedFormat(survey.ID)#&ProgramID=#URLEncodedFormat(URL.ProgramID)#">Begin Survey</a>
							<input type="file" id="import_file_select" class="hidden" />
						</div>

						<p class="small-text"><a href="survey_template.xlsx" class="link underlined" target="_blank">download</a> the import template for this survey.</p>
					</div>
				</cfloop>
			</cfoutput>
			
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">