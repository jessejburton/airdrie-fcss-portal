<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<cfinvoke component="#APPLICATION.cfcpath#survey" method="getIndicators" returnvariable="qIndicators" />
<cfinvoke component="#APPLICATION.cfcpath#survey" method="getAllSurveys" returnvariable="qSurveys" />
<cfinvoke component="#APPLICATION.cfcpath#agency" method="GetAgencyList" returnvariable="aAgencies" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1><i class="fa fa-pie-chart"></i> Outcome Measures</h1>
			
			<!--- TODO - Future Enhancement - ability to copy an existing survey --->
			<p class="spaced border-bottom" style="padding-bottom: 25px;">
				<button type="button" id="new_survey" class="btn btn-secondary"><i class="fa fa-plus"></i> Create New Survey</button>
				<button type="button" id="edit_survey" class="btn btn-secondary"><i class="fa fa-file-text"></i> Edit an Existing Survey</button>
			</p>

			<p id="survey_select" class="hidden">
				<label for="surveyid">Select a survey to edit</label><br />
				<select id="surveyid" class="input-half">
					<option value="">--- Select a survey to edit ---</option>
					<cfoutput query="qSurveys">
						<option value="#qSurveys.SurveyID#">#qSurveys.Name#</option>
					</cfoutput>
				</select>
			</p>

			<div id="survey_form" class="hidden">
				<p>
					<label for="survey_name">Survey Name</label><br />
					<input type="text" id="survey_name" placeholder="Enter a name for the survey" />
				</p>

				<p>
					<label for="PostOnly">
					<input type="checkbox" id="PostOnly" value="true" /> Make this survey a Post Only survey</label>
				</p>				

				<p>
					<label for="survey_description">Survey Description (optional)</label><br />
					<textarea id="survey_description" placeholder="Enter a description for the survey" style="height: 80px;"></textarea>
				</p>

				<p>
					<label for="survey_citation">Citation (optional)</label><br />
					<input type="text" id="survey_citation" placeholder="Enter the citation if needed" />
				</p>

				<p>
					<label for="indicatorID">What indicator is this survey for?</label><br />
					<cfset currentMeasure = "">
					<select id="indicatorID" class="input-half required">
						<option value="">--- Select an indicator ---</option>
						<cfoutput query="qIndicators">
							<option value="#qIndicators.IndicatorID#">#qIndicators.Indicator#</option>
						</cfoutput>
					</select>
				</p>

				<h3>Survey Options</h3>
				<p>
					<label for="Agency">Is this survey for a specific Agency?</label><br />
					<select id="Agency" class="input-half">
						<option value="0">All Agencies</option>
						<cfoutput>
							<cfloop array="#aAgencies#" index="agency">
								<option value="#agency.AgencyID#">#agency.Name#</option>
							</cfloop>
						</cfoutput>
					</select>
				</p>

				<h3>Questions</h3>
				<div id="question_container" class="clearfix">
					<div class="question">
						<div class="question-handle pull-left"></div>
						<textarea class="full-width" placeholder="Enter the question text."></textarea>
						<div class="remove-question pull-right"><i class="fa fa-close"></i></div>
					</div>
				</div>

				<a href="javascript:;" class="add-question"><i class="fa fa-plus"></i> add another</a>

				<div class="form-buttons clearfix">
					<button type="button" class="save-survey btn btn-primary pull-right"><i class="fa fa-save"></i> Save</button>
				</div>					
			</div>

		</div>
	</section>	

<cfinclude template="shared/footer.cfm">