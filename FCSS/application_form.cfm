<cfinclude template="shared/header.cfm">

<cfset APPLICATIONDETAILS = SESSION.Applications[1]>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<form id="application_form">
				<h1>Grant Application Form</h1>
	
				<cfif SESSION.Applications[1].Allocated GT 0>
					<div class="autoreply autoreply-success autoreply-visible">
						<p><strong>Approved!</strong> This Application Form has been approved!. Find out how much was <a href="funds_allocated.cfm">allocated</a>, get access to <a href="surveys.cfm">surveys</a> and fill complete your reqired reports on the <a href="programs.cfm">programs</a> page.</p>
					</div>
				<cfelse>
					<p>
						Please complete all of the following information. The information that you entered in your letter of intent has been copied over, please review and make any changes if necessary.
					</p> 
				</cfif>				

				<div class="accordion clearfix">				
				<!--- PROGRAM INFORMATION --->
					<h3>Program Information</h3>
					<div class="form-group seen">
						<p>
							<label for="program_name">Program Name</label><br />
							<input type="text" id="program_name" placeholder="Please enter the name of your program" class="required value" value="<cfoutput>#XMLFormat(APPLICATIONDETAILS.ProgramName)#</cfoutput>" />
						</p>
						<p>
							<label for="program_statement">Program Statement</label><br />						
							<textarea data-maxlength="1000" id="program_statement" placeholder="Approximately 250 words" class="textarea-large required value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.ProgramStatement)#</cfoutput></textarea>		
						</p>				
						<p>
							<label for="target_audience">Target Audience</label><br />						
							<textarea id="target_audience" placeholder="Please describe the target audience for your program" class="textarea-large required value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.TargetAudience)#</cfoutput></textarea>	
						</p>
						<p>
							<label for="percent_airdrie">What percentage of clients served through this program will be Airdrie residents.</label><br />
							<input type="text" id="percent_airdrie" class="input-half value" placeholder="%" />
						</p>

						<div class="form_buttons clearfix">
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>
					</div>

				<!--- CONTACT INFORMATION --->
					<h3>Program Contact Information</h3>
					<div class="form-group">
						<p>Please update any of the program contact information that is not the same as your agency's contact information</p>
						<p>
							<label for="primary_name">Primary Program Contact Name</label><br />
							<input type="text" id="primary_name" class="input-half required value" placeholder="Please enter the name of the program's primary contact person" value="<cfoutput>#XMLFormat(APPLICATIONDETAILS.PrimaryContactName)#</cfoutput>" />
						</p>
						<p>
							<label for="primary_phone">Primary Program Contact Phone</label><br />
							<input type="text" id="primary_phone" class="input-half required value" placeholder="Please enter the phone number of the program's primary contact person" value="<cfoutput>#XMLFormat(APPLICATIONDETAILS.PrimaryPhone)#</cfoutput>" />
						</p>
						<p>
							<label for="primary_email">Primary Program Contact Email</label><br />
							<input type="text" id="primary_email" class="input-half required value" placeholder="Please enter the email of the program's primary contact person" value="<cfoutput>#XMLFormat(APPLICATIONDETAILS.PrimaryEmail)#</cfoutput>" />
						</p>
						<hr />
						<p>
							<label for="program_address">Program Address </label><br />	
							<span class="label-sub">If different from agency address.</span>					
							<textarea data-maxlength="1000" id="program_address" placeholder="Please enter your physical address including the postal code" class="input-half required value"><!--- TESTING ---><cfif isDefined("APPLICATIONDETAILS.Address")><cfoutput>#XMLFormat(APPLICATIONDETAILS.Address)#</cfoutput></cfif><!--- TESTING ---></textarea>
						</p>	
						<p>
							<label for="program_mailing_address">Program Mailing Address </label><br />	
							<span class="label-sub">If different from agency mailing address.</span>				
							<textarea data-maxlength="1000" id="program_mailing_address" placeholder="Please enter your mailing address including the postal code" class="input-half value"><!--- TESTING ---><cfif isDefined("APPLICATIONDETAILS.MailingAddress")><cfoutput>#XMLFormat(APPLICATIONDETAILS.MailingAddress)#</cfoutput></cfif><!--- TESTING ---></textarea>		
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
							<label for="need_description">Need</label><br />
							<span class="label-sub">The evidence that there is a need for the program in the Airdrie community. You may add footnotes below to cite complete references and data sources.</span>					
							<textarea id="need_description" placeholder="Approximately 250 words" class="textarea-large value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.Need)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="goal_description">Goal</label><br />		
							<span class="label-sub">The long-term outcomes that the program aims to achieve.</span>					
							<textarea id="goal_description" placeholder="Approximately 250 words" class="textarea-large value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.Goal)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="strategies_description">Strategies</label><br />	
							<span class="label-sub">The strategies or the steps/activities that will be undertaken to achieve the desired goal. Details include who the program is aimed at (target audience), what will be done (program content), where and how it will be delivered, and when. This should include information on frequency, duration, program cycle, and evaluation plan. </span>					
							<textarea id="strategies_description" placeholder="Approximately 250 words" class="textarea-large value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.Strategies)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="rationale_description">Rationale</label><br />	
							<span class="label-sub">What is the evidence that the activities selected are the best or most promising practices? A summary of key research findings that support why the strategy that is being used is a best or promising practice for achieving the program goal. </span>
							<textarea id="rationale_description" placeholder="Approximately 250 words" class="textarea-large value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.Rationale)#</cfoutput></textarea>
						</p>
						<p>
							<label for="footnotes_description">Footnotes</label><br />
							<span class="label-sub">Footnotes are used to provide complete references for the research that identifies the need and provides the rationale to support the program strategy. The intention is to facilitate learning among agencies that wish to explore particular program areas in more depth. </span>							
							<textarea id="footnotes_description" placeholder="Approximately 250 words" class="textarea-large value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.Footnotes)#</cfoutput></textarea>
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
							<label for="fcss_prevention_focus">How does the program meet the FCSS prevention focus?</label><br />					
							<textarea id="fcss_prevention_focus" placeholder="Approximately 250 words" class="textarea-large"><cfoutput>#XMLFormat(APPLICATIONDETAILS.PreventionFocus)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="alignment">How does your program align with City of Airdrie's interest in the following:</label><br />		
							<ul class="label-sub">
								<li>Planning for an aging population</li>
								<li>Engaging youth in decision making</li>
								<li>Creating and strengthening a sense of community</li>
								<li>The Provincial goal of poverty prevention</li>
							</ul>					
							<textarea id="alignment" placeholder="Approximately 250 words" class="textarea-large"><cfoutput>#XMLFormat(APPLICATIONDETAILS.Alignment)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="agency_mission_fit">How does this program fit with your agency mission and vision?</label><br />	
							<textarea id="agency_mission_fit" placeholder="Approximately 250 words" class="textarea-large"><cfoutput>#XMLFormat(APPLICATIONDETAILS.MissionFit)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="considered_partnerships">Have you considered partnerships to enhance program efficiency and sustainability?</label><br />
							<span class="label-sub">Please describe your considerations for partnerships </span>							
							<textarea id="considered_partnerships" placeholder="Approximately 250 words" class="textarea-large"><cfoutput>#XMLFormat(APPLICATIONDETAILS.Partnerships)#</cfoutput></textarea>
						</p>

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>				
					</div>						

				<!--- BOARD DETAILS --->
					<h3>Board Members</h3>
					<div class="form-group">
						<p>Please enter your current board members names and titles.</p>

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
							<textarea id="short_term_goals" placeholder="Please tell us about your program's short term goals" class="textarea-large required value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.ShortTermGoals)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="mid_term_goals">Mid Term Goals</label><br />						
							<textarea id="mid_term_goals" placeholder="Please tell us about your program's mid term goals" class="textarea-large required value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.MidTermGoals)#</cfoutput></textarea>		
						</p>
						<p>
							<label for="long_term_goals">Long Term Goals</label><br />						
							<textarea id="long_term_goals" placeholder="Please tell us about your program's long term goals" class="textarea-large required value"><cfoutput>#XMLFormat(APPLICATIONDETAILS.LongTermGoals)#</cfoutput></textarea>		
						</p>			

						<div class="form_buttons clearfix">
							<button type="button" class="nav prev btn btn-primary pull-left">Prev</button> 
							<button type="button" class="nav next btn btn-primary pull-right">Next</button> 
						</div>	
					</div>																	

<!--- BUDGET --->
					<h3>Program Budget</h3>
					<div class="form-group">
						<h1 class="form-group-heading">Program Budget Information <a href="assets/documents/Budget-Guide.pdf" target="_blank" class="pull-right link small-text"><i class="fa fa-question-circle"></i> Budget Guide</a></h1>
					
						<h2>Revenues</h2>
						<table class="table">
							<thead>
								<tr>
									<th width="25%">Source</th>
									<th width="25%">2016 Funded by Other Source</th>
									<th width="25%">2016 Funded by Airdrie FCSS</th>
									<th width="25%">Total</th>								
								</tr>
							</thead>
							<tbody>
								<tr class="expenditure_item">
									<td>
										<select>
											<option value="">-- Select a revenue item --</option>
											<option value="">Other FCSS</option>
											<option value="">Provincial Grant</option>
											<option value="">Federal Grant</option>
											<option value="">Corporate Donations</option>
											<option value="">Individual Donations</option>
											<option value="">Membership Fees</option>
											<option value="">Fundraising</option>
											<option value="">Foundations / Charity Trusts</option>
											<option value="">Sale of Goods and Services</option>
											<option value="">Other Revenues</option>
										</select>
									</td>
									<td>
										<input type="number" class="inline add-value" placeholder="Amount" />
									</td>
									<td>
										<input type="number" class="inline add-value tab-add-row" placeholder="Amount" />
									</td>
									<td>
										<input type="number" class="row-total" readonly placeholder="Total" /><br />										
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2">
										<a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a>
									</td>
									<td>
										<strong class="pull-right">Total Revenues</strong>
									</td>
									<td>
										<span class="col-total pull-right faded">$ 0.00</span>
									</td>
								</tr>
							</tfoot>
						</table>

						<hr />

						<h2>Expenditures</h2>
						<table class="table">
							<thead>
								<tr>
									<th width="25%">Source</th>
									<th width="25%">2016 Funded by Other Source</th>
									<th width="25%">2016 Funded by Airdrie FCSS</th>
									<th width="25%">Total</th>
								</tr>
							</thead>
							<tbody>
								<tr class="expenditure_item">
									<td>
										<select>
											<option value="">-- Select an expense --</option>
											<option value="">Staffing Costs</option>
											<option value="">General Travel</option>
											<option value="">Training & Travel</option>
											<option value="">Professional Memberships</option>
											<option value="">Administration, Accounting & Legal</option>
											<option value="">Goods & Supplies</option>
											<option value="">Rent</option>
											<option value="">Insurance</option>
											<option value="">Repair & Maintenance</option>
											<option value="">Advertising & Printing</option>
											<option value="">Technology</option>
											<option value="">Program Supplies</option>
											<option value="">Volunteer Development</option>
											<option value="">Volunteer Recognition</option>
											<option value="">Community Development</option>
											<option value="">Program Evaluation</option>
											<option value="">Other</option>
										</select>
									</td>
									<td>
										<input type="number" class="inline add-value" placeholder="Amount" />
									</td>
									<td>
										<input type="number" class="inline add-value tab-add-row" placeholder="Amount" />
									</td>
									<td>
										<input type="number" class="row-total" readonly placeholder="Total" /><br />										
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2">
										<a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a>
									</td>
									<td>
										<strong class="pull-right">Total Expenditures</strong>
									</td>
									<td>
										<span class="col-total pull-right faded">$ 0.00</span>
									</td>
								</tr>
							</tfoot>
						</table>

						<hr />

						<div class="budget-bottom">
							<p>
								<label for="revenues_description">Revenues Explanation</label><br />						
								<textarea id="revenues_description" placeholder="Please explain your revenues" class="textarea-large"></textarea>		
							</p>
							<p>
								<label for="expenditures_description">Expenditures Explanation</label><br />						
								<textarea id="expenditures_description" placeholder="Please explain your expenditures" class="textarea-large"></textarea>		
							</p>

							<p>Please provide the percentage of funds that will be applied to each target group below</p>
							<span class="label-sub">Please try to be as accurate as possible but estimates are ok.</span>
							<p>
								<label for="distribution_children">Children / Youth</label>
								<div class="slider input-half" id="distribution_children_slider"></div>
								<span class="percent">0%</span>
								<input id="distribution_children" type="hidden" />
							</p>
							<p>
								<label for="distribution_youth">Family</label>
								<div class="slider input-half" id="distribution_youth_slider"></div>
								<span class="percent">0%</span>
								<input id="distribution_youth" type="hidden" />
							</p>
							<p>
								<label for="distribution_adult">Adult</label>
								<div class="slider input-half" id="distribution_adult_slider"></div>
								<span class="percent">0%</span>
								<input id="distribution_adult" type="hidden" />								
							</p>
							<p>
								<label for="distribution_seniors">Seniors</label>
								<div class="slider input-half" id="distribution_seniors_slider"></div>
								<span class="percent">0%</span>
								<input id="distribution_seniors" type="hidden" />
							</p>
							<p>
								<label for="distribution_volunteers">Volunteers</label>
								<div class="slider input-half" id="distribution_volunteers_slider"></div>
								<span class="percent">0%</span>
								<input id="distribution_volunteers" type="hidden" />							
							</p>
						</div>

						<div class="form_buttons clearfix">
							<button type="button" id="application_review_submit" class="btn btn-primary pull-right">Submit</button> 
						</div>
					</div>					

				<!--- REVIEW 
					<h3 class="ui-state-disabled">Review and Submit</h3>
					<div>
						<p>This is where the agency will be able to review all of their information.</p>
					</div>		--->						
				</div>
			</form>


<!--- Autoreply message when complete --->
			<div id="application_form_complete" class="hidden spaced">
				<p><strong>Success!</strong> you have completed the second step of the application process. You will be contacted by a representative of the City of Airdrie once the fund allocation process has been completed. You can view the status of your application at any time on the <a href="programs.cfm">programs</a> page.</p>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">