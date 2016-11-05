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

			<form id="application_form">
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

<!--- DOCUMENTS --->
					<h3>Documents</h3>
					<div class="form-group">

					</div>															

<!--- BUDGET --->
					<h3>Budget</h3>
					<div class="form-group">
						<h1 class="form-group-heading">Budget Information</h1>
						
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

						<p>
							<label for="revenues_description">Revenues Explanation</label><br />						
							<textarea id="revenues_description" placeholder="Please explain your revenues" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="expenditures_description">Expenditures Explanation</label><br />						
							<textarea id="expenditures_description" placeholder="Please explain your expenditures" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="distribution_children" class="inline">Children</label>
							<input id="distribution_children" type="text" class="inline input-half" placeholder="Enter the dollar amount for fund distribution" />
							<span class="inline" id="distribution_children_percent">0%</span><br />
							<label for="distribution_children" class="inline">Youth</label>
							<input id="distribution_children" type="text" class="inline input-half" placeholder="Enter the dollar amount for fund distribution" />
							<span class="inline">0%</span><br />
							<label for="distribution_children" class="inline">Families</label>
							<input id="distribution_children" type="text" class="inline input-half" placeholder="Enter the dollar amount for fund distribution" />
							<span class="inline">0%</span><br />
							<label for="distribution_children" class="inline">Adults</label>
							<input id="distribution_children" type="text" class="inline input-half" placeholder="Enter the dollar amount for fund distribution" />
							<span class="inline">0%</span><br />
							<label for="distribution_children" class="inline">Seniors</label>
							<input id="distribution_children" type="text" class="inline input-half" placeholder="Enter the dollar amount for fund distribution" />
							<span class="inline">0%</span><br />
							<label for="distribution_children" class="inline">Community Dev</label>
							<input id="distribution_children" type="text" class="inline input-half" placeholder="Enter the dollar amount for fund distribution" />
							<span class="inline">0%</span><br />
							<label for="distribution_children" class="inline">Volunteerism</label>
							<input id="distribution_children" type="text" class="inline input-half" placeholder="Enter the dollar amount for fund distribution" />
							<span class="inline">0%</span><br />
						</p>
					</div>									
				</div>
			</form>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">