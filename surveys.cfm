<cfinclude template="shared/header.cfm">

<cfif NOT isDefined('URL.ProgramID') OR NOT isNumeric(URL.ProgramID)>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<cfquery name="qProgram">
	SELECT ProgramName
	FROM Program_tbl
	WHERE ProgramID = <cfqueryparam value="#URL.ProgramID#" cfsqltype="cf_sql_integer">
</cfquery>

<!--- Get the approrpriate survey data --->
<cfinvoke component="#APPLICATION.cfcpath#webservices" method="getSurveysByProgramID" ProgramID="#URL.ProgramID#" returnvariable="response" />
<cfset REQUEST.SURVEYS = response.DATA>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Surveys For <cfoutput>#qProgram.ProgramName#</cfoutput></h1>

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