<cfinclude template="shared/header.cfm">

<cfif StructKeyExists(URL, 'ID')>
	<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramByID" programID="#URL.ID#" returnvariable="PROGRAM" />
</cfif>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Letter of Intent</h1>

<!--- BEGIN MESSAGES --->
			<cfif REQUEST.AGENCY.ISNEW>
				<div class="autoreply autoreply-info autoreply-visible">
					<p><strong>Get Started!</strong> Tell us about the program you would like to request funding for by completing this Letter of Intent.</p>
				</div>
			</cfif>

			<cfif isDefined('PROGRAM')>
				<cfif PROGRAM.isLOIReady AND PROGRAM.Status IS 'LOI - Saved'>
					<div class="autoreply autoreply-info autoreply-visible">
						<p><strong>Ready!</strong> This Letter of Intent is ready to be submitted, You can click on any section to make final changes, or go straight to the 'Review and Submit' tab to do a final check before submitting the data for review.</p>
					</div>
				</cfif>
				<cfif PROGRAM.Status IS 'LOI - Submitted'>
					<div class="autoreply autoreply-info autoreply-visible">
						<p><strong>Submitted!</strong> This Letter of Intent has already been submitted to the City of Airdrie for review. You can check on the status of this application on the <a href="programs.cfm">programs</a> page.</p>
					</div>
				</cfif>
			</cfif>

			<!--- DEVELOPMENT FEATURE --->
			<cfif APPLICATION.environment IS "sdevelopment">
				<p><input type="button" id="fill" class="btn btn-primary" value="FILL REQUIRED FIELDS" /></p>
			</cfif>
			<!--- DEVELOPMENT FEATURE --->	
<!--- END MESSAGES --->		

<!--- BEGIN FORM --->
			<form id="letter_of_intent_form">
				<!--- Hidden Form Fields --->
				<input type="hidden" id="program_id" value="<cfoutput>#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.ProgramID)', DE(''))#</cfoutput>" />
				<input type="hidden" id="is_loi_ready" value="<cfoutput>#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.isLOIReady)', DE('0'))#</cfoutput>" />
				<input type="hidden" id="program_status" value="<cfoutput>#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.Status)', DE('0'))#</cfoutput>" />

				<p>Please complete all of the following information. You can click on the heading for a section to jump directly to that section of the form</p> 
				<p>
					<a href="javascript:;" id="save" class="save btn btn-primary inline <cfoutput>#iif(isDefined('PROGRAM'), DE(''), DE('disabled'))#</cfoutput>"><i class="fa fa-save"></i> Save Letter of Intent</a>
					<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
					<em class="pull-right small-text" id="last_saved"><cfoutput>#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.FormattedDateUpdated)', DE(''))#</cfoutput></em>
				</p>
				
<cfoutput>				
				<div class="accordion clearfix">				
				<!--- PROGRAM INFORMATION --->
					<h3>Program Information</h3>
					<div class="form-group seen">
						<p>
							<label for="program_name">Program Name</label><br />
							<input type="text" id="program_name" placeholder="Please enter the name of your program" class="required value" 
								value="#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.ProgramName)', DE(''))#" />
						</p>
						<p>
							<label for="program_statement">Program Statement</label><br />						
							<textarea data-maxlength="1000" id="program_statement" placeholder="Approximately 250 words" class="textarea-large required value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.ProgramStatement)', DE(''))#</textarea>		
						</p>				
						<p>
							<label for="target_audience">Target Audience</label><br />						
							<textarea id="target_audience" placeholder="Please describe the target audience for your program" class="textarea-large required value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.TargetAudience)', DE(''))#</textarea>	
						</p>
						<p>
							<label>Are the majority of clients served through this program Airdrie residents?</label><br /><br />
							<label for="mostly_airdrie_yes">
								<input type="radio" id="mostly_airdrie_yes" name="mostly_airdrie" class="required" #IIF(isDefined('PROGRAM') AND PROGRAM.MostlyAirdrie IS true, DE('checked'), DE(''))# /> Yes
							</label>
							<label for="mostly_airdrie_no">
								<input type="radio" id="mostly_airdrie_no" name="mostly_airdrie" class="required" #IIF(isDefined('PROGRAM') AND PROGRAM.MostlyAirdrie IS false, DE('checked'), DE(''))# /> No
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
							<input type="text" id="primary_contact_name" class="input-half required value" placeholder="Please enter the name of the program's primary contact person" value="#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.PrimaryContactName)', 'XMLFormat(REQUEST.USER.NAME)')#" />
						</p>
						<p>
							<label for="primary_phone">Primary Program Contact Phone</label><br />
							<input type="text" id="primary_phone" class="input-half required value" placeholder="Please enter the phone number of the program's primary contact person" value="#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.PrimaryPhone)', 'XMLFormat(REQUEST.AGENCY.PHONE)')#" />
						</p>
						<p>
							<label for="primary_email">Primary Program Contact Email</label><br />
							<input type="text" id="primary_email" class="input-half required value" placeholder="Please enter the email of the program's primary contact person" value="#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.PrimaryEmail)', 'XMLFormat(REQUEST.AGENCY.EMAIL)')#" />
						</p>
						<hr />
						<p>
							<label for="program_address">Program Address </label><br />	
							<span class="label-sub">If different from agency address.</span><br />			
							<textarea data-maxlength="1000" id="program_address" placeholder="Please enter your physical address including the postal code" class="input-half required value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.ProgramAddress)', 'XMLFormat(REQUEST.AGENCY.ADDRESS)')#</textarea>
						</p>		
						<p>
							<label for="program_mailing_address">Program Mailing Address </label><br />	
							<span class="label-sub">If different from agency mailing address.</span><br />				
							<textarea data-maxlength="1000" id="program_mailing_address" placeholder="Please enter your mailing address including the postal code" class="input-half value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.ProgramMailingAddress)', 'XMLFormat(REQUEST.AGENCY.MAILINGADDRESS)')#</textarea>		
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
							<textarea id="need" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.Need)', DE(''))#</textarea>		
						</p>
						<p>
							<label for="goal">Goal</label><br />		
							<span class="label-sub">The long-term outcomes that the program aims to achieve.</span>					
							<textarea id="goal" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.Goal)', DE(''))#</textarea>		
						</p>
						<p>
							<label for="strategies">Strategies</label><br />	
							<span class="label-sub">The strategies or the steps/activities that will be undertaken to achieve the desired goal. Details include who the program is aimed at (target audience), what will be done (program content), where and how it will be delivered, and when. This should include information on frequency, duration, program cycle, and evaluation plan. </span>					
							<textarea id="strategies" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.Strategies)', DE(''))#</textarea>		
						</p>
						<p>
							<label for="rationale">Rationale</label><br />	
							<span class="label-sub">What is the evidence that the activities selected are the best or most promising practices? A summary of key research findings that support why the strategy that is being used is a best or promising practice for achieving the program goal. </span>
							<textarea id="rationale" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.Rationale)', DE(''))#</textarea>
						</p>
						<p>
							<label for="footnotes">Footnotes</label><br />
							<span class="label-sub">Footnotes are used to provide complete references for the research that identifies the need and provides the rationale to support the program strategy. The intention is to facilitate learning among agencies that wish to explore particular program areas in more depth. </span>							
							<textarea id="footnotes" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.Footnotes)', DE(''))#</textarea>
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
							<textarea id="prevention_focus" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.PreventionFocus)', DE(''))#</textarea>		
						</p>
						<p>
							<label for="alignment">How does your program align with City of Airdrie's interest in the following:</label><br />		
							<ul class="label-sub">
								<li>Planning for an aging population</li>
								<li>Engaging youth in decision making</li>
								<li>Creating and strengthening a sense of community</li>
								<li>The Provincial goal of poverty prevention</li>
							</ul>					
							<textarea id="alignment" placeholder="Approximately 250 words" class="textarea-large required value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.Alignment)', DE(''))#</textarea>		
						</p>
						<p>
							<label for="agency_mission_fit">How does this program fit with your agency mission and vision?</label><br />	
							<textarea id="mission_fit" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.MissionFit)', DE(''))#</textarea>		
						</p>
						<p>
							<label for="considered_partnerships">Have you considered partnerships to enhance program efficiency and sustainability?</label><br />		
							<span class="label-sub">Please describe your considerations for partnerships </span>						
							<textarea id="considered_partnerships" placeholder="Approximately 250 words" class="textarea-large value">#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.ConsideredPartnerships)', DE(''))#</textarea>
						</p>

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>				
					</div>										

				<!--- BUDGET SUMMARY --->
					<h3>Program Budget Summary</h3>
					<div class="form-group">
						<p>
							<label for="amount_from_airdrie">Amount Requested from the City of Airdrie</label><br />
							<span class="input-currency"><input type="number" id="estimated_from_airdrie" class="input-half sum required value" placeholder="Amount requested from the City of Airdrie" value="#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.EstimatedFromAirdrie)', DE(''))#" /></span>
						</p>
						<p>
							<label for="amount_from_other">Amount from Other Revenue Sources</label><br />
							<span class="input-currency"><input type="number" id="estimated_from_other" class="input-half sum required value" placeholder="Amount from other revenue sources" value="#iif(isDefined('PROGRAM'), 'XMLFormat(PROGRAM.EstimatedFromOther)', DE(''))#" /></span>
						</p>
						<p>
							<label for="budget_total">Total <cfoutput>#Year(DateAdd("yyyy", 1, Now()))#</cfoutput> budget</label><br />
							<span class="input-currency"><input type="number" id="budget_total" class="input-half sum-total value" disabled /></span>
						</p>

						<div class="form_buttons clearfix"> 
							<button type="button" id="letter_of_intent_submit" class="btn btn-primary pull-right">Review</button> 
						</div>
					</div>

				<!--- REVIEW --->
					<h3 class="ui-state-disabled">Review and Submit</h3>
					<div>
						<div id="loi_review">	
							<h2>Program Information</h2>		
								<h3>Program Name</h3><p class="program-name"></p>							
								<h3>Program Statement</h3><p class="program-statement"></p>
								<h3>Target Audience</h3><p class="target-audience"></p>

							<h2>Contact Information</h2>
								<h3>Primary Contact Name</h3><p class="primary-name"></p>
								<h3>Primary Phone</h3><p class="primary-phone"></p>
								<h3>Primary Email</h3><p class="primary-email"></p>
								<h3>Address</h3><p class="program-address"></p>
								<h3>Mailing Address</h3><p class="program-mailing-address"></p>
							
							<h2>Theory of Change</h2>
								<h3>Need</h3><p class="need-description"></p>							
								<h3>Goal</h3><p class="goal-description"></p>							
								<h3>Strategies</h3><p class="strategies-description"></p>		
								<h3>Rationale</h3><p class="rationale-description"></p>
								<h3>Evidence</h3><p class="evidence-description"></p>
							
							<h2>Alignment</h2>
								<h3>How does the program meet the FCSS prevention focus?</h3><p class="fcss-prevention-focus"></p>
								<h3>How does your program align with City of Airdrie's interests</h3><p class="alignment"></p>
								<h3>How does this program fit with your agency mission and vision?</h3><p class="agency-mission-fit"></p>
								<h3>Have you considered partnerships?</h3><p class="considered-partnerships"></p>

							<h2>Outcomes Plan</h2>
								<h3>Short Term Goals</h3><p class="short-term-goals"></p>
								<h3>Mid Term Goals</h3><p class="mid-term-goals"></p>
								<h3>Long Term Goals</h3><p class="long-term-goals"></p>
				
							<h2>Budget Summary</h2>
								<h3>Amount Requested from Airdrie</h3><p class="amount-from-airdrie"></p>
								<h3>Amount from Other Sources</h3><p class="amount-from-other"></p>
								<h3>Budget Total</h3><p class="budget-total"></p>
						</div>

						<div class="form-buttons clearfix"> 
							<button type="button" id="letter_of_intent_review_submit" class="btn btn-primary pull-right">Send to City of Airdrie</button>
							<button type="button" id="letter_of_intent_review_save" class="btn btn-secondary pull-right save">Save for Review</button>  
							<a href="javascript:;" class="pull-right small-text link inline" style="margin-top: 15px;"><i class="fa fa-file-pdf-o"></i> Printable Version</a>
						</div>
					</div>	
				</div>
</cfoutput>				
			</form>
<!--- END FORM --->

			<div id="letter_of_intent_complete" class="hidden spaced">
				<p><strong>Success!</strong> you have completed the first step of the application process. You will be contacted by a representative of the City of Airdrie once your information has been reviewed. You can view the status of your application at any time on the <a href="programs.cfm">programs</a> page.</p>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">