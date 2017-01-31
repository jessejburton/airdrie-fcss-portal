<cfinclude template="shared/header.cfm">

<cfset showForm = true>

<cfif StructKeyExists(URL, 'ID')>
	<cfset NEW = false>
	<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramByID" programID="#URL.ID#" returnvariable="PROGRAM" />
<cfelse>
	<cfset NEW = true>
	<cfinvoke component="#APPLICATION.cfcpath#program" method="getBlankProgram" returnvariable="PROGRAM" />
</cfif>

<cfif ListFindNoCase(PROGRAM.StatusList, 'LOI - Approved') GT 0>
	<cfset PROGRAM.TYPE = "Application Form">
<cfelse>
	<cfset PROGRAM.TYPE = "Letter Of Intent">
</cfif>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1><cfoutput>#PROGRAM.TYPE#</cfoutput></h1>

			<cfif PROGRAM.TYPE IS "Letter Of Intent" AND NOT REQUEST.SETTINGS.ISENABLEDLETTEROFINTENT>
				<div class="autoreply autoreply-info autoreply-visible"><p>Thank you for your interest in Airdrie FCSS funding for locally-driven preventive social programs. Letters of Intent for funding for the <cfoutput>#Year(Now())#</cfoutput> year have now closed. Please check again in <cfoutput>#Year(Now()) + 1#</cfoutput>.
 				<br /><br />
				<span><i class='fa fa-question-circle'></i> For inquiries, please contact the City of Airdrie Social Planning team at <a href="mailto:<cfoutput>#REQUEST.SETTINGS.AdminEmail#</cfoutput>"><cfoutput>#REQUEST.SETTINGS.AdminEmail#</cfoutput></a> or by phone at <cfoutput>#REQUEST.SETTINGS.SupportNumber#</cfoutput>.</span></p></div>
			<cfelseif PROGRAM.TYPE IS "Application Form" AND NOT REQUEST.SETTINGS.ISENABLEDAPPLICATIONS>
				<div class="autoreply autoreply-info autoreply-visible"><p>Thank you for your interest in Airdrie FCSS funding for locally-driven preventive social programs. Applications for funding for the <cfoutput>#Year(Now())#</cfoutput> year have now closed. Please check again in <cfoutput>#Year(Now()) + 1#</cfoutput>.
 				<br /><br />
				<span><i class='fa fa-question-circle'></i> For inquiries, please contact the City of Airdrie Social Planning team at <a href="mailto:<cfoutput>#REQUEST.SETTINGS.AdminEmail#</cfoutput>"><cfoutput>#REQUEST.SETTINGS.AdminEmail#</cfoutput></a> or by phone at <cfoutput>#REQUEST.SETTINGS.SupportNumber#</cfoutput>.</span></p></div>
			</cfif>
			<!--- DEVELOPMENT FEATURE --->
			<cfif APPLICATION.environment IS "development">
				<p><input type="button" id="fill" class="btn btn-primary" value="FILL REQUIRED FIELDS" /></p>
			</cfif>
			<!--- DEVELOPMENT FEATURE --->	
<!--- END MESSAGES --->		

<!--- Decide whether or not to show the form --->
<cfif PROGRAM.Status IS "APPLICATION - Submitted to Airdrie" OR PROGRAM.Status IS "LOI - Submitted to Airdrie" OR PROGRAM.Status IS "APPLICATION - Reviewed" OR PROGRAM.Status IS "APPLICATION - Approved">
	<cfset showForm = false>
	<div class="autoreply autoreply-info autoreply-visible">
		<p><strong>Submitted!</strong> This form has been submitted to the City of Airdrie, changes can not be made at this time. If you would like to review what was submitted you can download a <a href="admin_create_package.cfm?programID=<cfoutput>#URL.ID#</cfoutput>" class="link" style="margin-top: 15px;" target="_blank"><i class="fa fa-file-pdf-o"></i> printable version</a>.
	</div>
</cfif>

<!--- BEGIN FORM --->	
		<cfif showForm>
			<form id="application_form">
				<!--- Hidden Form Fields --->
				<input type="hidden" id="program_id" value="<cfoutput>#XMLFormat(PROGRAM.ProgramID)#</cfoutput>" />
				<input type="hidden" id="application_type" value="<cfoutput>#XMLFormat(PROGRAM.Type)#</cfoutput>" />
				<input type="hidden" id="program_status" value="<cfoutput>#XMLFormat(PROGRAM.Status)#</cfoutput>" />

				<p>Please complete all of the following information. You can click on the heading for a section to jump directly to that section of the form</p> 
				<p>
					<a href="javascript:;" class="save btn btn-primary inline disabled"><i class="fa fa-save"></i> Save</a>
					<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
					<em class="pull-right small-text" id="last_saved"><cfoutput>#IIF(NOT NEW, DE('Last Saved: #XMLFormat(PROGRAM.FormattedDateUpdated)#'), DE(''))#</cfoutput></em>
				</p>
				
			<cfoutput>				
				<div class="accordion clearfix">				
				<!--- PROGRAM INFORMATION --->
					<h3>Program Information</h3>
					<div class="form-group seen">
						<p>
							<label for="program_name">Program Name</label><br />
							<input type="text" id="program_name" placeholder="Please enter the name of your program" class="required value" 
								value="#XMLFormat(PROGRAM.ProgramName)#" />
						</p>
						<p>
							<label for="program_statement">Program Statement</label><br />						
							<textarea data-maxlength="1000" id="program_statement" placeholder="Approximately 250 words" class="textarea-large required value">#XMLFormat(PROGRAM.ProgramStatement)#</textarea>		
						</p>				
						<p>
							<label for="target_audience">Target Audience</label><br />		
							<span class="label-sub">Please describe your target population for this program and estimate the number of people to be served. Why did you choose this population?</span>				
							<textarea id="target_audience" placeholder="Please describe the target audience for your program" class="textarea-large required value">#XMLFormat(PROGRAM.TargetAudience)#</textarea>	
						</p>
						<p>
							<label>Are the majority of clients served through this program Airdrie residents?</label><br /><br />
							<label for="mostly_airdrie_yes">
								<input type="radio" id="mostly_airdrie_yes" name="mostly_airdrie" class="required" #IIF(PROGRAM.MostlyAirdrie IS true, DE('checked'), DE(''))# /> Yes
							</label>
							<label for="mostly_airdrie_no">
								<input type="radio" id="mostly_airdrie_no" name="mostly_airdrie" class="required" #IIF(PROGRAM.MostlyAirdrie IS false, DE('checked'), DE(''))# /> No
							</label>
						</p>

					<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>

				<!--- CONTACT INFORMATION --->
					<h3>Program Contact Information</h3>
					<div class="form-group">
						<p>Please update any of the program contact information that is not the same as your agency's contact information</p>
						<p>
							<label for="primary_contact_name">Primary Program Contact Name</label><br />
							<input type="text" id="primary_contact_name" class="input-half required value" placeholder="Please enter the name of the program's primary contact person" value="#iif(LEN(PROGRAM.PrimaryContactName) GT 0, 'XMLFormat(PROGRAM.PrimaryContactName)', 'XMLFormat(REQUEST.USER.NAME)')#" />
						</p>
						<p>
							<label for="primary_phone">Primary Program Contact Phone</label><br />
							<input type="text" id="primary_phone" class="input-half required value" placeholder="Please enter the phone number of the program's primary contact person" value="#iif(LEN(PROGRAM.PrimaryPhone) GT 0, 'XMLFormat(PROGRAM.PrimaryPhone)', 'XMLFormat(REQUEST.AGENCY.PHONE)')#" />
						</p>
						<p>
							<label for="primary_email">Primary Program Contact Email</label><br />
							<input type="text" id="primary_email" class="input-half required value" placeholder="Please enter the email of the program's primary contact person" value="#iif(LEN(PROGRAM.PrimaryEmail) GT 0, 'XMLFormat(PROGRAM.PrimaryEmail)', 'XMLFormat(REQUEST.AGENCY.EMAIL)')#" />
						</p>
						<hr />
						<p>
							<label for="program_address">Program Address </label><br />	
							<span class="label-sub">If different from agency address.</span><br />			
							<textarea data-maxlength="1000" id="program_address" placeholder="Please enter your physical address including the postal code" class="input-half required value">#iif(LEN(PROGRAM.ProgramAddress) GT 0, 'XMLFormat(PROGRAM.ProgramAddress)', 'XMLFormat(REQUEST.AGENCY.ADDRESS)')#</textarea>
						</p>		
						<p>
							<label for="program_mailing_address">Program Mailing Address </label><br />	
							<span class="label-sub">If different from agency mailing address.</span><br />				
							<textarea data-maxlength="1000" id="program_mailing_address" placeholder="Please enter your mailing address including the postal code" class="input-half value">#iif(LEN(PROGRAM.ProgramMailingAddress) GT 0, 'XMLFormat(PROGRAM.ProgramMailingAddress)', '')#</textarea>		
						</p>
						
						<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>					

				<!--- THEORY OF CHANGE --->
					<h3>Theory of Change</h3>	
					<div class="form-group">
						<p>
							A Theory of Change is the cornerstone of FCSS Airdrie's contract with an agency for delivering a specific program. For each funded program, FCSS requires a Theory of Change, which includes: 
						</p>

						<p>
							<label for="need">Need</label><br />
							<span class="label-sub">The evidence that there is a need for the program in the Airdrie community. You may add footnotes below to cite complete references and data sources.</span>					
							<textarea id="need" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.Need)#</textarea>		
						</p>
						<p>
							<label for="goal">Goal</label><br />		
							<span class="label-sub">The long-term outcomes that the program aims to achieve.</span>					
							<textarea id="goal" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.Goal)#</textarea>		
						</p>
						<p>
							<label for="strategies">Strategies</label><br />	
							<span class="label-sub">The strategies or the steps/activities that will be undertaken to achieve the desired goal. Details include who the program is aimed at (target audience), what will be done (program content), where and how it will be delivered, and when. This should include information on frequency, duration, program cycle, and evaluation plan. </span>					
							<textarea id="strategies" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.Strategies)#</textarea>		
						</p>
						<p>
							<label for="rationale">Rationale</label><br />	
							<span class="label-sub">What is the evidence that the activities selected are the best or most promising practices? A summary of key research findings that support why the strategy that is being used is a best or promising practice for achieving the program goal. </span>
							<textarea id="rationale" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.Rationale)#</textarea>
						</p>
						<p>
							<label for="footnotes">Footnotes</label><br />
							<span class="label-sub">Footnotes are used to provide complete references for the research that identifies the need and provides the rationale to support the program strategy. The intention is to facilitate learning among agencies that wish to explore particular program areas in more depth. </span>							
							<textarea id="footnotes" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.Footnotes)#</textarea>
						</p>	

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>			
					</div>	

				<!--- ALIGNMENT --->
					<h3>Program Alignment</h3>
					<div class="form-group">
						<p>
							<label for="prevention_focus">How does the program meet the FCSS prevention focus?</label><br />					
							<textarea id="prevention_focus" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.PreventionFocus)#</textarea>		
						</p>
						<p>
							<label for="alignment">How does your program align with City of Airdrie's interest in the following:</label><br />		
							<ul class="label-sub">
								<li>Planning for an aging population</li>
								<li>Engaging youth in decision making</li>
								<li>Creating and strengthening a sense of community</li>
								<li>The Provincial goal of poverty prevention</li>
							</ul>					
							<textarea id="alignment" placeholder="Approximately 250 words" class="textarea-large required value">#XMLFormat(PROGRAM.Alignment)#</textarea>		
						</p>
						<p>
							<label for="mission_fit">How does this program fit with your agency mission and vision?</label><br />	
							<textarea id="mission_fit" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.MissionFit)#</textarea>		
						</p>
						<p>
							<label for="considered_partnerships">Have you considered partnerships to enhance program efficiency and sustainability?</label><br />		
							<span class="label-sub">Please describe your considerations for partnerships </span>						
							<textarea id="considered_partnerships" placeholder="Approximately 250 words" class="textarea-large value">#XMLFormat(PROGRAM.ConsideredPartnerships)#</textarea>
						</p>

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 							
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>				
					</div>		

				<!--- BOARD DETAILS --->
				<cfif PROGRAM.TYPE IS "Application Form">
					<h3>Board Members</h3>
					<div class="form-group">
						<p>Please enter your current board members names and titles. Leave spaced blank if you do not have at least 5 members.</p>

						<div id="board_list">
							<cfset atLeastOneRequired = true> <!--- Need to make the first one required in case the delete all of the members --->
							<cfloop array="#REQUEST.AGENCY.BOARDMEMBERS#" index="member">
								<div class="two-cols board-member">
									<p><input type="text" name="board_name" class="inline #iif(atLeastOneRequired, DE('required'), DE(''))#" placeholder="Board member's name" value="#XMLFormat(member.NAME)#" /></p>
									<p><input type="text" name="board_title" class="inline #iif(atLeastOneRequired, DE('required'), DE(''))#" placeholder="Board member's title" value="#XMLFormat(member.TITLE)#" /></p>
								</div>
								<cfset atleastOneRequired = false>
							</cfloop>
							<!--- Show at least 5 spots --->
							<cfset numRowsToAdd = 5 - ArrayLen(REQUEST.AGENCY.BOARDMEMBERS)>							
							<cfif numRowsToAdd GT 0>
								<cfset atLeastOneRequired = true><!--- Make the first row required so they need at least one board member --->
								<cfloop from="1" to="#numRowsToAdd#" index="i">
									<div class="two-cols board-member">
										<p><input type="text" name="board_name" class="inline #iif(atLeastOneRequired AND ArrayLen(REQUEST.AGENCY.BOARDMEMBERS) IS 0, DE('required'), DE(''))#" placeholder="Board member's name" /></p>
										<p><input type="text" name="board_title" class="inline #iif(atLeastOneRequired AND ArrayLen(REQUEST.AGENCY.BOARDMEMBERS) IS 0, DE('required'), DE(''))#" placeholder="Board member's title" /></p>
									</div>
									<cfset atleastOneRequired = false>
								</cfloop>				
							</cfif>
						</div>

						<p><a href="javascript:;" class="add-board"><i class="fa fa-plus"></i> add another</a></p>

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>	

				<!--- OUTCOMES PLAN --->
					<h3>Outcomes Plan</h3>
					<div class="form-group">
						<p>
							<label for="short_term_goals">Short Term Goals</label><br />						
							<textarea id="short_term_goals" placeholder="Please tell us about your program's short term goals" class="textarea-large required value">#XMLFormat(PROGRAM.ShortTermGoals)#</textarea>		
						</p>
						<p>
							<label for="mid_term_goals">Mid Term Goals</label><br />						
							<textarea id="mid_term_goals" placeholder="Please tell us about your program's mid term goals" class="textarea-large required value">#XMLFormat(PROGRAM.MidTermGoals)#</textarea>		
						</p>
						<p>
							<label for="long_term_goals">Long Term Goals</label><br />						
							<textarea id="long_term_goals" placeholder="Please tell us about your program's long term goals" class="textarea-large required value">#XMLFormat(PROGRAM.LongTermGoals)#</textarea>		
						</p>			

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>	
					</div>
				</cfif>					

				<!--- BUDGET SUMMARY --->
				<cfif PROGRAM.TYPE IS "Letter Of Intent">
					<h3>Program Budget Summary</h3>
					<div class="form-group">
						<p>
							<label for="estimated_from_airdrie">Amount Requested from the City of Airdrie</label><br />
							<span class="input-currency"><input type="number" id="estimated_from_airdrie" class="input-half sum required value" placeholder="Amount requested from the City of Airdrie" value="#XMLFormat(PROGRAM.EstimatedFromAirdrie)#" /></span>
						</p>
						<p>
							<label for="estimated_from_other">Amount from Other Revenue Sources</label><br />
							<span class="input-currency"><input type="number" id="estimated_from_other" class="input-half sum required value" placeholder="Amount from other revenue sources" value="#XMLFormat(PROGRAM.EstimatedFromOther)#" /></span>
						</p>
						<p>
							<label for="budget_total">Total #Year(DateAdd("yyyy", 1, Now()))# budget</label><br />
							<span class="input-currency"><input type="number" id="budget_total" class="input-half sum-total value" disabled value="#XMLFormat(PROGRAM.EstimatedFromOther + PROGRAM.EstimatedFromAirdrie)#" /></span>
						</p>

						<div class="form_buttons clearfix"> 
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" id="application_review" class="btn btn-primary pull-right">Review</button> 
						</div>
					</div>		
				</cfif>				
			</form>
				<!--- BUDGET --->
				<cfif PROGRAM.TYPE IS "Application Form">
					<!--- DOCUMENTS --->
					<h3>Documents</h3>
						<div class="form-group">
							<cfinclude template="shared/documents.cfm">

							<div class="form_buttons clearfix">
								<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
								<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
							</div>	
						</div>										

					<h3>Program Budget</h3>
					<div class="form-group">
						<cfinclude template="shared/budget.cfm">

						<div class="form_buttons clearfix">
							<button type="button" id="application_review" class="btn btn-primary pull-right">Review</button> 
						</div>
					</div>											
				</cfif>

				<!--- REVIEW --->
					<h3 class="ui-state-disabled">Review and Submit</h3>
					<div>
						<div id="application_review_display">	
							<h1>Program Information</h1>		
								<h3>Program Name</h3><p class="program-name"></p>							
								<h3>Program Statement</h3><p class="program-statement"></p>
								<h3>Target Audience</h3><p class="target-audience"></p>

							<h1>Contact Information</h1>
								<h3>Primary Contact Name</h3><p class="primary-contact-name"></p>
								<h3>Primary Phone</h3><p class="primary-phone"></p>
								<h3>Primary Email</h3><p class="primary-email"></p>
								<h3>Address</h3><p class="program-address"></p>
								<h3>Mailing Address</h3><p class="program-mailing-address"></p>
							
							<h1>Theory of Change</h1>
								<h3>Need</h3><p class="need"></p>							
								<h3>Goal</h3><p class="goal"></p>							
								<h3>Strategies</h3><p class="strategies"></p>		
								<h3>Rationale</h3><p class="rationale"></p>
								<h3>Footnotes</h3><p class="footnotes"></p>
							
							<h1>Alignment</h1>
								<h3>How does the program meet the FCSS prevention focus?</h3><p class="prevention-focus"></p>
								<h3>How does your program align with City of Airdrie's interests</h3><p class="alignment"></p>
								<h3>How does this program fit with your agency mission and vision?</h3><p class="mission-fit"></p>
								<h3>Have you considered partnerships?</h3><p class="considered-partnerships"></p>

						<cfif PROGRAM.TYPE IS "Letter of Intent">
							<h1>Budget Summary</h1>
								<h3>Amount Requested from Airdrie</h3><p class="estimated-from-airdrie"></p>
								<h3>Amount from Other Sources</h3><p class="estimated-from-other"></p>
								<h3>Budget Total</h3><p class="budget-total"></p>
						</cfif>								
												
						<cfif PROGRAM.TYPE IS "Application Form">
						<!--- Placeholder for board members --->
							<div id="board-members-display"></div>

							<h1>Outcomes Plan</h1>
								<h3>Short Term Goals</h3><p class="short-term-goals"></p>
								<h3>Mid Term Goals</h3><p class="mid-term-goals"></p>
								<h3>Long Term Goals</h3><p class="long-term-goals"></p>

						<!--- Placeholder for Documents --->
							<div id="documents-display"></div>

						<!--- Placeholder for Budget Summary --->
							<div id="budget-summary-display"></div>
													
						</cfif>		

						</div>
						
						<div class="form-buttons clearfix"> 
							<cfif (PROGRAM.TYPE IS "Letter Of Intent" AND REQUEST.SETTINGS.ISENABLEDLETTEROFINTENT) OR (PROGRAM.TYPE IS "Application" AND REQUEST.SETTINGS.ISENABLEDAPPLICATIONS)>
								<button type="button" id="application_submit_to_airdrie" class="btn btn-primary pull-right submit-button">Send to City of Airdrie</button>
							</cfif>
							<button type="button" id="application_save_for_review" class="btn btn-secondary pull-right submit-button">Save for Agency Review</button>  
							<a href="admin_create_package.cfm?programID=#encodeForHTMLAttribute(URL.ID)#" class="pull-right small-text link inline" style="margin-top: 15px;" target="_blank"><i class="fa fa-file-pdf-o"></i> Printable Version</a>
						</div>
					</div>	
				</div>
			</cfoutput>				

			<p>
				<a href="javascript:;" class="save btn btn-primary inline disabled"><i class="fa fa-save"></i> Save</a>
				<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
				<em class="pull-right small-text" id="last_saved"><cfoutput>#IIF(NOT NEW, DE('Last Saved: #XMLFormat(PROGRAM.FormattedDateUpdated)#'), DE(''))#</cfoutput></em>
			</p>
		</cfif>
<!--- END FORM --->
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">