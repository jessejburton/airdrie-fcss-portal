<cfinclude template="shared/header.cfm">

<cfset showForm = true>

<!--- Make sure there is a program selected and that it has been approved --->
<cfif StructKeyExists(URL, 'ID')>
	<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramByID" programID="#URL.ID#" returnvariable="PROGRAM" />
<cfelse>
	<cflocation url="index.cfm" addtoken="false">
</cfif>
<cfif ListFindNoCase(PROGRAM.StatusList, 'LOI - Approved') IS 0>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Midyear Progress Report</h1>

<!--- Decide whether or not to show the form --->
<cfif ListFindNoCase(PROGRAM.StatusList, 'MIDYEAR - Submitted') IS 1>
	<cfset showForm = false>
	<div class="autoreply autoreply-info autoreply-visible">
		<p><strong>Submitted!</strong> You have already completed and sent in your mid-year report for this program.
	</div>
</cfif>

<!--- BEGIN FORM --->	
		<cfif showForm>
			<form id="mid_year_form">
				<!--- Hidden Form Fields --->
				<input type="hidden" id="program_id" value="<cfoutput>#EncodeForHTML(PROGRAM.ProgramID)#</cfoutput>" />
				<input type="hidden" id="program_status" value="<cfoutput>#EncodeForHTML(PROGRAM.Status)#</cfoutput>" />

				<p>
					<a href="javascript:;" class="save btn btn-primary inline"><i class="fa fa-save"></i> Save</a>
					<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
					<em class="pull-right small-text" id="last_saved">Last Saved: <cfoutput>#EncodeForHTML(PROGRAM.FormattedDateUpdated)#</cfoutput></em>
				</p>
				
			<cfoutput>
				<cfset BUDGETTYPE = "Mid-Year Budget">				
				
				<div class="accordion clearfix">					
					<h3>Sustainability</h3>
					<div class="form-group seen">
						<p>
							<label for="is_only_funder">Is Airdrie FCSS the only funder for this program?</label><br /><br />
							<label for="is_only_funder_yes">
								<input type="radio" id="is_only_funder_yes" name="is_only_funder" class="required" #IIF(PROGRAM.isOnlyFunder IS true, DE('checked'), DE(''))# /> Yes
							</label>
							<label for="is_only_funder_no">
								<input type="radio" id="is_only_funder_no" name="is_only_funder" class="required" #IIF(PROGRAM.isOnlyFunder IS false, DE('checked'), DE(''))# /> No
							</label>
						</p>

						<p id="if_only_funder">
							<label for="sustain_funding">How do you intend to sustain your program in the longer-term? Will you be seeking other sources of funding?</label><br />
							<textarea data-maxlength="1000" id="sustain_funding" placeholder="Please describe" class="input-half value">#iif(LEN(PROGRAM.sustainFunding) GT 0, 'EncodeForHTML(PROGRAM.sustainFunding)', '')#</textarea>	
						</p>

					<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>	
					</div>


					<h3>Surplus <span class="small-text">(funds exceed expenses)</span> / Deficit <span class="small-text">(expenses exceed funds)</span></h3>
					<div class="form-group">
						<p id="isSurplus">
							<label for="is_surplus">Do you anticipate a surplus at the end of the year? </label><br /><span class="label-sub">Please notify Social Planning Unit by September 1, #Year(Now())#. All surplus funds must be returned to Airdrie FCSS.
</span><br /><br />
							<label for="is_surplus_yes">
								<input type="radio" id="is_surplus_yes" name="is_surplus" class="required" #IIF(PROGRAM.isSurplus IS true, DE('checked'), DE(''))# />#PROGRAM.isSurplus# Yes
							</label>
							<label for="is_surplus_no">
								<input type="radio" id="is_surplus_no" name="is_surplus" class="required" #IIF(PROGRAM.isSurplus IS false, DE('checked'), DE(''))# /> No
							</label>	
						</p>	

						<p id="isDeficit">
							<label for="is_deficit">Do you anticipate a deficit at the end of the year? </label><br /><br />
							<label for="is_deficit_yes">
								<input type="radio" id="is_deficit_yes" name="is_deficit" class="required" #IIF(PROGRAM.isDeficit IS true, DE('checked'), DE(''))# />#PROGRAM.isDeficit# Yes
							</label>
							<label for="is_deficit_no">
								<input type="radio" id="is_deficit_no" name="is_deficit" class="required" #IIF(PROGRAM.isDeficit IS false, DE('checked'), DE(''))# /> No
							</label>	
						</p>	

						<p id="if_deficit">
							<label for="how_deal">Please describe how you will deal with the deficit.</label><br />
							<textarea data-maxlength="1000" id="how_deal" placeholder="Please describe" class="input-half value">#iif(LEN(PROGRAM.howDeal) GT 0, 'EncodeForHTML(PROGRAM.howDeal)', '')#</textarea>	
						</p>

						<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>						
					</div>

					<h3>Mid Year Financials</h3>
					<div class="form-group">
						<cfinclude template="shared/budget.cfm">

						<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>	

					<h3>Program Activities Progress</h3>
					<div class="form-group">
						<p>
							<label for="evaluation_activities">What evaluation activities have you implemented to measure the impact of your program?</label><br /><span class="label-sub">(Check all that apply, and add others not listed).</span><br />
							<textarea data-maxlength="1000" id="evaluation_activities" placeholder="Please list" class="input-half value">#iif(LEN(PROGRAM.programActivities) GT 0, 'EncodeForHTML(PROGRAM.evaluationActivities)', '')#</textarea>	
						</p>

						<p>
							<label for="no_activities">If you have NOT yet undertaken any of the above activities?</label><br />
							<textarea data-maxlength="1000" id="no_activities" placeholder="Please explain" class="input-half value">#iif(LEN(PROGRAM.notYetStarted) GT 0, 'EncodeForHTML(PROGRAM.noActivities)', '')#</textarea>	
						</p>

						<p>
							<label for="evaluation_challenges">Have you run into any challenges implementing program evaluation activities?</label>
							<textarea data-maxlength="1000" id="evaluation_challenges" placeholder="Please describe the challenges and how you plan to deal with the situation" class="input-half value">#iif(LEN(PROGRAM.evaluationChallenges) GT 0, 'EncodeForHTML(PROGRAM.evaluationChallenges)', '')#</textarea>	
						</p>

						<p>
							<label for="require_research_assistance">Do you require any assistance from Airdrie FCSS Researcher to help you implement program evaluation activities or to report your data?</label><br />
							<textarea data-maxlength="1000" id="require_research_assistance" placeholder="Please describe" class="input-half value">#iif(LEN(PROGRAM.requireResearchAssistance) GT 0, 'EncodeForHTML(PROGRAM.requireResearchAssistance)', '')#</textarea>	
						</p>

						<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>	

					<h3>Program Activities Progress</h3>
					<div class="form-group">
						<p>
							<label for="program_activities">What program activities have taken place (completed or currently underway)?</label><br /><span class="label-sub">Please list each separately, with an estimate of the number of individuals served from January 1 to June 30, #Year(Now())#.</span><br />
							<textarea data-maxlength="1000" id="program_activities" placeholder="Please list" class="input-half value">#iif(LEN(PROGRAM.programActivities) GT 0, 'EncodeForHTML(PROGRAM.programActivities)', '')#</textarea>	
						</p>

						<p>
							<label for="not_yet_started">What activities scheduled to begin by June 30, #Year(Now())# have NOT yet started?</label><br />
							<textarea data-maxlength="1000" id="not_yet_started" placeholder="Please explain" class="input-half value">#iif(LEN(PROGRAM.notYetStarted) GT 0, 'EncodeForHTML(PROGRAM.notYetStarted)', '')#</textarea>	
						</p>

						<p>
							<label for="program_challenges">Have you run into any challenges implementing your program?</label>
							<span class="label-sub">If yes, please describe the challenges and how you plan to deal with the situation.<br />
							<textarea data-maxlength="1000" id="program_challenges" placeholder="Please describe" class="input-half value">#iif(LEN(PROGRAM.programChallenges) GT 0, 'EncodeForHTML(PROGRAM.programChallenges)', '')#</textarea>	
						</p>

						<p>
							<label for="require_report_assistance">Do you require any assistance from Airdrie FCSS to help you report on program activities?</label><br />
							<textarea data-maxlength="1000" id="require_report_assistance" placeholder="Please describe" class="input-half value">#iif(LEN(PROGRAM.requireReportAssistance) GT 0, 'EncodeForHTML(PROGRAM.requireReportAssistance)', '')#</textarea>	
						</p>

						<div class="form_buttons clearfix">
							<button type="button" id="midyear_submit_to_airdrie" class="btn btn-primary pull-right submit-button">Send to City of Airdrie</button> 
							<!---<a href="javascript:;" class="pull-right small-text link inline" style="margin-top: 15px;"><i class="fa fa-file-pdf-o"></i> Printable Version</a>--->
						</div>
					</div>														
				</div>
			</cfoutput>				

			<p>
				<a href="javascript:;" class="save btn btn-primary inline"><i class="fa fa-save"></i> Save</a>
				<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
				<em class="pull-right small-text" id="last_saved">Last Saved: <cfoutput>#EncodeForHTML(PROGRAM.FormattedDateUpdated)#</cfoutput></em>
			</p>
		</cfif>
<!--- END FORM --->
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">