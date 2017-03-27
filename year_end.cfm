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
			<h1>Year-End Report</h1>

<!--- Decide whether or not to show the form --->
<cfif ListFindNoCase(PROGRAM.StatusList, 'Year-End Submitted') IS 1>
	<cfset showForm = false>
	<div class="autoreply autoreply-info autoreply-visible">
		<p><strong>Submitted!</strong> You have already completed and sent in your year-end report for this program.
	</div>
</cfif>

<!--- BEGIN FORM --->	
		<cfif showForm>
			<form id="year_end_form">
				<!--- Hidden Form Fields --->
				<input type="hidden" id="program_id" value="<cfoutput>#EncodeForHTML(PROGRAM.ProgramID)#</cfoutput>" />
				<input type="hidden" id="program_status" value="<cfoutput>#EncodeForHTML(PROGRAM.Status)#</cfoutput>" />

				<p>
					<a href="javascript:;" class="save btn btn-primary inline"><i class="fa fa-save"></i> Save</a>
					<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
					<em class="pull-right small-text" id="last_saved">Last Saved: <cfoutput>#EncodeForHTML(PROGRAM.FormattedDateUpdated)#</cfoutput></em>
				</p>
				
			<cfoutput>	
				<cfset BUDGETTYPE = "Year-End Budget">			

				<div class="accordion clearfix">	

					<h3>Surplus <span class="small-text">(funds exceed expenses)</span> / Deficit <span class="small-text">(expenses exceed funds)</span></h3>
					<div class="form-group">
						<p id="isSurplus">
							<label for="is_surplus">Do you anticipate a surplus at the end of the year? </label><br /><span class="label-sub">Please notify Social Planning Unit by September 1, #Year(Now())#. All surplus funds must be returned to Airdrie FCSS.
</span><br /><br />
							<label for="is_surplus_yes">
								<input type="radio" id="is_surplus_yes" name="is_surplus" class="required" #IIF(PROGRAM.isSurplus IS true, DE('checked'), DE(''))# />Yes
							</label>
							<label for="is_surplus_no">
								<input type="radio" id="is_surplus_no" name="is_surplus" class="required" #IIF(PROGRAM.isSurplus IS false, DE('checked'), DE(''))# />No
							</label>	
						</p>	

						<p id="isDeficit">
							<label for="is_deficit">Do you anticipate a deficit at the end of the year? </label><br /><br />
							<label for="is_deficit_yes">
								<input type="radio" id="is_deficit_yes" name="is_deficit" class="required" #IIF(PROGRAM.isDeficit IS true, DE('checked'), DE(''))# />Yes
							</label>
							<label for="is_deficit_no">
								<input type="radio" id="is_deficit_no" name="is_deficit" class="required" #IIF(PROGRAM.isDeficit IS false, DE('checked'), DE(''))# />No
							</label>	
						</p>	

						<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button>
						</div>						
					</div>

					<h3>Program Activities and Statistics</h3>
					<div class="form-group">
						<h4>Number of individuals served by program, by type of contact</h4>
						<table id="actStats" style="width: 100%;">							
							<thead>
								<tr><th></th><th>## Airdrie Residents</th><th>## Other Residents</th></tr>								
							</thead>
							<tbody>
								<tr><td>Face-Face</td><td><input id="face_to_face_airdrie" type="Number" value="#EncodeForHTML(PROGRAM.FaceToFaceAirdrie)#" /></td><td><input id="face_to_face_other" type="Number" value="#EncodeForHTML(PROGRAM.FaceToFaceOther)#" /></td></tr>
								<tr><td>Telephone</td><td><input id="telephone_airdrie" type="Number" value="#EncodeForHTML(PROGRAM.TelephoneAirdrie)#" /></td><td><input id="telephone_other" type="Number" value="#EncodeForHTML(PROGRAM.telephoneOther)#" /></td></tr>
								<tr><td>Email</td><td><input id="email_airdrie" type="Number" value="#EncodeForHTML(PROGRAM.emailAirdrie)#" /></td><td><input id="email_other" type="Number" value="#encodeForHTML(PROGRAM.EmailOther)#" /></td></tr>
							</tbody>
							<tfoot>
								<tr><td><strong>TOTAL</strong></td><td><input id="airdrie_total" type="Number" value="#EncodeForHTML(PROGRAM.totalAirdrieResidents)#" disabled /></td><td><input id="other_total" type="Number" value="#PROGRAM.totalOtherResidents#" disabled /></td></tr>
							</tfoot>
						</table>	

						<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>						
					</div>

					<h3>Year End Financials</h3>
					<div class="form-group">
						<cfinclude template="shared/budget.cfm">

						<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>	
					</div>		

					<h3>Overall Program Assessment</h3>
					<div class="form-group">
						<p>
							<label for="as_expected">Did the program unfold as you had expected? What changes would you make to program delivery, processes, or strategies to improve program design in the future?</label><br />		
							<textarea data-maxlength="1000" id="as_expected" placeholder="Approximately 250 words" class="required value">#EncodeForHTML(PROGRAM.asExpected)#</textarea>
						</p>

						<p>
							<label for="what_changes">What changes would you make to the program outcome measurement process to improve program evaluation in the future?</label><br />		
							<textarea data-maxlength="1000" id="what_changes" placeholder="Approximately 250 words" class="required value">#EncodeForHTML(PROGRAM.asExpected)#</textarea>
						</p>

						<div class="form_buttons clearfix">
							<button type="button" id="application_review" class="btn btn-primary pull-right">Review</button> 
						</div>					
					</div>									

				<!--- REVIEW --->
					<h3 class="ui-state-disabled">Review and Submit</h3>
					<div>
						<div id="application_review_display">	
							<h2>Budget Summary</h2>
							<div class="budget-summary"></div>								
						</div>
						
						<div class="form-buttons clearfix"> 
							<button type="button" id="application_submit_to_airdrie" class="btn btn-primary pull-right submit-button">Send to City of Airdrie</button>
							<button type="button" id="application_save_for_review" class="btn btn-secondary pull-right submit-button">Save for Agency Review</button>  
							<a href="javascript:;" class="pull-right small-text link inline" style="margin-top: 15px;"><i class="fa fa-file-pdf-o"></i> Printable Version</a>
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