<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div class="panels clearfix">
				<ul class="panel_nav_top clearfix">
					<li class="active"><a href="javascript:;" data-show="program_panel"><span>Program Information</span><span class="small-tab">1</span></a></li>
					<li><a href="javascript:;" data-show="contact_panel"><span>Contact</span><span class="small-tab">2</span></a></li>				
					<li><a href="javascript:;" data-show="board_panel"><span>Board</span><span class="small-tab">4</span></a></li>
					<li><a href="javascript:;" data-show="theory_panel"><span>Theory of Change</span><span class="small-tab">5</span></a></li>
					<li><a href="javascript:;" data-show="alignment_panel"><span>Alignment</span><span class="small-tab">6</span></a></li>
					<li><a href="javascript:;" data-show="outcomes_panel"><span>Outcomes Plan</span><span class="small-tab">7</span></a></li>
					<li><a href="javascript:;" data-show="budget_panel"><span>Budget</span><span class="small-tab">8</span></a></li>	
					<li class="disabled" title="Ensure that all required information has been entered before you can save your application."><a href="javascript:;" data-show="save_panel"><span>Review and Submit</span><span class="small-tab">9</span></a></li>	
				</ul>	

				<form id="panel_display" class="panel_form">
				<!--- PROGRAM INFORMATION --->
					<div id="program_panel" class="panel active">
						<h1 class="form-group-heading">Program Information</h1>
						
						<p>
							<label for="program_name">Program Name</label><br />
							<input type="text" id="program_name" placeholder="Please enter the name of your program." />
						</p>
						<p>
							<label for="program_description">Program Statement</label><br />						
							<textarea data-maxlength="1000" id="program_description" placeholder="Please enter a short summary of your program. (1-2 sentences)" class="textarea-large"></textarea>		
						</p>				
						<p>
							<label for="target_audience">Target Audience</label><br />						
							<textarea id="target_audience" placeholder="Please describe the target audience for your program" class="textarea-large"></textarea>	
						</p>
					</div>

				<!--- CONTACT INFORMATION --->
					<div id="contact_panel" class="panel">
						<h1 class="form-group-heading">Contact Information</h1>
						
						<p>
							<label for="primary_name">Primary Contact Name</label><br />
							<input type="text" id="primary_name" class="input-half" placeholder="Please enter the name of the programs primary contact person." />
						</p>
						<p>
							<label for="primary_phone">Primary Contact Phone</label><br />
							<input type="text" id="primary_phone" class="input-half" placeholder="Please enter the phone number of the primary contact person." />
						</p>
						<p>
							<label for="primary_email">Primary Contact Email</label><br />
							<input type="text" id="primary_email" class="input-half" placeholder="Please enter the email of the primary contact person." />
						</p>
						<hr />
						<p>
							<label for="program_address">Program Address </label><br />
							<span class="label-sub">if different from your agencies address</span><br />					
							<textarea data-maxlength="1000" id="program_address" placeholder="Please enter your physical address. Please include the postal code." class="input-half"></textarea>		
						</p>	
						<p>
							<label for="program_mailing_address">Program Mailing Address </label><br />
							<span class="label-sub">if different from your agencies mailing address</span><br />					
							<textarea data-maxlength="1000" id="program_mailing_address" placeholder="Please enter your mailing address. Please include the postal code." class="input-half"></textarea>		
						</p>
						
					</div>					

				<!--- THEORY OF CHANGE --->
					<div id="theory_panel" class="panel">
						<h1 class="form-group-heading">Theory of Change</h1>
						
						<p>
							<label for="need_description">Need</label><br />	
							<span class="label-sub">The evidence that there is a need for the program in the Airdrie community.</span>					
							<textarea id="need_description" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="goal_description">Goal</label><br />		
							<span class="label-sub">Goal that the program aims to achieve.</span>					
							<textarea id="goal_description" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="strategies_description">Strategies</label><br />	
							<span class="label-sub">The strategies or the steps/activities that will be undertaken to achieve the desired goal.</span>					
							<textarea id="strategies_description" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="rationale_description">Rationale</label><br />	
							<span class="label-sub">The rationale for the selected approach</span>						
							<textarea id="rationale_description" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>
						</p>
						<p>
							<label for="evidence_description">Evidence</label><br />
							<span class="label-sub">What is the evidence that the activities selected are the best or most promising practices?</span>							
							<textarea id="evidence_description" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>
						</p>				
					</div>	

				<!--- ALIGNMENT --->
					<div id="alignment_panel" class="panel">
						<h1 class="form-group-heading">Alignment</h1>
						
						<p>
							<label for="fcss_prevention_focus">How does the program meet the FCSS prevention focus?</label><br />					
							<textarea id="fcss_prevention_focus" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="alignment">How does your program align with City of Airdrie's interests in the following:</label><br />		
							<ul class="label-sub">
								<li>In planning for an aging population</li>
								<li>Engaging youth in decision making</li>
								<li>Creating and strengthening a sense of community</li>
								<li>And/Or the provincial goal of poverty prevention?</li>
							</ul>					
							<textarea id="alignment" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="agency_mission_fit">How does this program fit with your agency mission and vision?</label><br />	
							<textarea id="agency_mission_fit" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="considered_partnerships">Have you considered partnerships?</label><br />							
							<textarea id="considered_partnerships" placeholder="Please provide up to a 1000 character answer." class="textarea-large"></textarea>
						</p>				
					</div>						

				<!--- BOARD DETAILS --->
					<div id="board_panel" class="panel">
						<h1 class="form-group-heading">Board Members</h1>
						
						<div id="board_list">
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board members name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board members job title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board members name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board members job title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board members name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board members job title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board members name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board members job title" /></p>
							</div>
							<div class="two-cols board-member">
								<p><input type="text" name="board_name" class="inline" placeholder="Board members name" /></p>
								<p><input type="text" name="board_title" class="inline" placeholder="Board members job title" /></p>
							</div>
						</div>
						<p><a href="javascript:;" class="add-board"><i class="fa fa-plus"></i> add another</a></p>
					</div>						

				<!--- OUTCOMES PLAN --->
					<div id="outcomes_panel" class="panel">
						<h1 class="form-group-heading">Outcomes Plan</h1>
						
						<p>
							<label for="short_term_goals">Short Term Goals</label><br />						
							<textarea id="short_term_goals" placeholder="Please tell us about your programs short term goals." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="mid_term_goals">Mid Term Goals</label><br />						
							<textarea id="mid_term_goals" placeholder="Please tell us about your programs mid term goals." class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="long_term_goals">Long Term Goals</label><br />						
							<textarea id="long_term_goals" placeholder="Please tell us about your programs long term goals." class="textarea-large"></textarea>		
						</p>				
					</div>											

				<!--- BUDGET SUMMARY --->
					<div id="budget_panel" class="panel">
						<h1 class="form-group-heading">Budget Summary</h1>
						
						<p>
							<label for="amount_from_airdrie">Amount Requested from the City of Airdrie</label><br />
							<input type="text" id="amount_from_airdrie" class="input-half" placeholder="Amount requested from the City of Airdrie." />
						</p>
						<p>
							<label for="amount_from_other">Amount from Other Revenue Sources</label><br />
							<input type="text" id="amount_from_other" class="input-half" placeholder="Amount from other revenue sources." />
						</p>
						<p>
							<label for="budget_total">Total <cfoutput>#Year(DateAdd("yyyy", 1, Now()))#</cfoutput> budget</label><br />
							<input type="text" id="budget_total" class="input-half" placeholder="Total budget for <cfoutput>#Year(DateAdd("yyyy", 1, Now()))#</cfoutput>." />
						</p>
					</div>

				<!--- PEOPLE --->
					<div id="people_panel" class="panel">
						<h1 class="form-group-heading">People</h1>
						
						<p>This will be where the agencies manage accounts that can access there portal.</p>
					</div>

					<div class="form_buttons clearfix">
						<button id="previous_btn" type="button" class="btn btn-primary pull-left">Prev</button>
						<button id="next_btn" type="button" class="btn btn-primary pull-right">Next</button> 
					</div>									
				</form>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">