<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Letter of Intent</h1>

			<p>
				Please complete all of the following information. You can click on the heading for a section to jump directly to that section of the form
			</p> 
			<p>
				Click on <strong>"Program Information"</strong> below to get started.
			</p>

			<form id="letter_of_intent_form">
				<div class="accordion clearfix">				
				<!--- PROGRAM INFORMATION --->
					<h3>Program Information</h3>
					<div class="form-group seen">
						<p>
							<label for="program_name">Program Name</label><br />
							<input type="text" id="program_name" placeholder="Please enter the name of your program" class="required" />
						</p>
						<p>
							<label for="program_description">Program Statement</label><br />						
							<textarea data-maxlength="1000" id="program_description" placeholder="Please enter a short summary of your program (1-2 sentences)" class="textarea-large required"></textarea>		
						</p>				
						<p>
							<label for="target_audience">Target Audience</label><br />						
							<textarea id="target_audience" placeholder="Please describe the target audience for your program" class="textarea-large required"></textarea>	
						</p>

					<!--- Panel Buttons --->
						<div class="form_buttons clearfix">
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>

				<!--- CONTACT INFORMATION --->
					<h3>Contact Information</h3>
					<div class="form-group">
						<p>
							<label for="primary_name">Primary Contact Name</label><br />
							<input type="text" id="primary_name" class="input-half required" placeholder="Please enter the name of the program's primary contact person" />
						</p>
						<p>
							<label for="primary_phone">Primary Contact Phone</label><br />
							<input type="text" id="primary_phone" class="input-half required" placeholder="Please enter the phone number of the program's primary contact person" />
						</p>
						<p>
							<label for="primary_email">Primary Contact Email</label><br />
							<input type="text" id="primary_email" class="input-half required" placeholder="Please enter the email of the program's primary contact person" />
						</p>
						<hr />
						<p>
							<label for="program_address">Program Address </label><br />
							<span class="label-sub">if different from your agency's address</span><br />					
							<textarea data-maxlength="1000" id="program_address" placeholder="Please enter your physical address including the postal code" class="input-half required"></textarea>		
						</p>	
						<p>
							<label for="program_mailing_address">Program Mailing Address </label><br />
							<span class="label-sub">if different from your agency's mailing address</span><br />					
							<textarea data-maxlength="1000" id="program_mailing_address" placeholder="Please enter your mailing address including the postal code" class="input-half"></textarea>		
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
							<label for="need_description">Need</label><br />	
							<span class="label-sub">The evidence that there is a need for the program in the Airdrie community.</span>					
							<textarea id="need_description" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="goal_description">Goal</label><br />		
							<span class="label-sub">Goal that the program aims to achieve.</span>					
							<textarea id="goal_description" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="strategies_description">Strategies</label><br />	
							<span class="label-sub">The strategies or the steps/activities that will be undertaken to achieve the desired goal.</span>					
							<textarea id="strategies_description" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="rationale_description">Rationale</label><br />	
							<span class="label-sub">The rationale for the selected approach</span>						
							<textarea id="rationale_description" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>
						</p>
						<p>
							<label for="evidence_description">Evidence</label><br />
							<span class="label-sub">What is the evidence that the activities selected are the best or most promising practices?</span>							
							<textarea id="evidence_description" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>
						</p>	

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>			
					</div>	

				<!--- ALIGNMENT --->
					<h3>Alignment</h3>
					<div class="form-group">
						<p>
							<label for="fcss_prevention_focus">How does the program meet the FCSS prevention focus?</label><br />					
							<textarea id="fcss_prevention_focus" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="alignment">How does your program align with City of Airdrie's interest in the following:</label><br />		
							<ul class="label-sub">
								<li>Planning for an aging population</li>
								<li>Engaging youth in decision making</li>
								<li>Creating and strengthening a sense of community</li>
								<li>The Provincial goal of poverty prevention</li>
							</ul>					
							<textarea id="alignment" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="agency_mission_fit">How does this program fit with your agency mission and vision?</label><br />	
							<textarea id="agency_mission_fit" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="considered_partnerships">Have you considered partnerships?</label><br />							
							<textarea id="considered_partnerships" placeholder="Maximum 1,000 characters" class="textarea-large"></textarea>
						</p>

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>				
					</div>						

				<!--- BOARD DETAILS --->
					<h3>Board Members</h3>
					<div class="form-group">
						<div id="board_list">
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
							</div>
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
							<textarea id="short_term_goals" placeholder="Please tell us about your program's short term goals" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="mid_term_goals">Mid Term Goals</label><br />						
							<textarea id="mid_term_goals" placeholder="Please tell us about your program's mid term goals" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="long_term_goals">Long Term Goals</label><br />						
							<textarea id="long_term_goals" placeholder="Please tell us about your program's long term goals" class="textarea-large"></textarea>		
						</p>			

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>	
					</div>											

				<!--- BUDGET SUMMARY --->
					<h3>Budget Summary</h3>
					<div class="form-group">
						<p>
							<label for="amount_from_airdrie">Amount Requested from the City of Airdrie</label><br />
							<span class="input-currency"><input type="number" id="amount_from_airdrie" class="input-half sum" placeholder="Amount requested from the City of Airdrie" /></span>
						</p>
						<p>
							<label for="amount_from_other">Amount from Other Revenue Sources</label><br />
							<span class="input-currency"><input type="number" id="amount_from_other" class="input-half sum" placeholder="Amount from other revenue sources" /></span>
						</p>
						<p>
							<label for="budget_total">Total <cfoutput>#Year(DateAdd("yyyy", 1, Now()))#</cfoutput> budget</label><br />
							<span class="input-currency"><input type="number" id="budget_total" class="input-half sum-total" disabled /></span>
						</p>

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>

				<!--- PEOPLE --->
					<h3 class="ui-state-disabled">Review and Submit</h3>
					<div>
						<p>This is where the agency will be able to review all of their information.</p>
					</div>
								
				</div>
			</form>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">