<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div class="panels clearfix">
				<ul class="panel_nav_top clearfix">
					<li class="active"><a href="javascript:;" data-show="program_panel"><span>Program Information</span><span class="small-tab">1</span></a></li>
					<li><a href="javascript:;" data-show="priorities_panel"><span>Strategic Link</span><span class="small-tab">2</span></a></li>
					<li><a href="javascript:;" data-show="prevention_panel"><span>Prevention Focus</span><span class="small-tab">3</span></a></li>
					<li><a href="javascript:;" data-show="theory_panel"><span>Theory of Change</span><span class="small-tab">4</span></a></li>
					<li><a href="javascript:;" data-show="outcomes_panel"><span>Outcomes Plan</span><span class="small-tab">5</span></a></li>
					<li><a href="javascript:;" data-show="budget_panel"><span>Budget</span><span class="small-tab">6</span></a></li>	
					<li class="disabled" title="Ensure that all required information has been entered before you can save your application."><a href="javascript:;" data-show="save_panel"><span>Review and Submit</span><span class="small-tab">7</span></a></li>	
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
							<label for="program_description">Program Description</label><br />						
							<textarea id="program_description" placeholder="Please enter the description of your program" class="textarea-large"></textarea>		
						</p>				
						<p>
							<label for="program_audience">Target Audience</label><br />						
							<textarea id="program_audience" placeholder="Please describe the target audience for your program" class="textarea-large"></textarea>	
						</p>
						<p>
							<label for="program_audience">Target Audience</label><br />						
							<textarea id="program_audience" placeholder="Please describe the target audience for your program" class="textarea-large"></textarea>	
						</p>
					</div>

				<!--- STRATEGIC PRIORITIES --->
					<div id="priorities_panel" class="panel">
						<h1 class="form-group-heading">Alignment with Strategic Priorities</h1>
						
						<p>
							<label for="program_description">Program Description</label><br />						
							<textarea id="program_description" placeholder="Please enter the description of your program" class="textarea-large"></textarea>		
						</p>				
						<p>
							<label for="program_audience">Target Audience</label><br />						
							<textarea id="program_audience" placeholder="Please describe the target audience for your program" class="textarea-large"></textarea>	
						</p>
						<p>
							<label for="program_audience">Target Audience</label><br />						
							<textarea id="program_audience" placeholder="Please describe the target audience for your program" class="textarea-large"></textarea>	
						</p>
					</div>		

				<!--- PREVENTION FOCUS --->
					<div id="prevention_panel" class="panel">
						<h1 class="form-group-heading">Prevention Focus</h1>
						
						<p>
							<label for="proactive_description">Proactive</label><br />	
							<span>You can add as much details about how to fill this out as you want.</span>					
							<textarea id="proactive_description" placeholder="Please enter information about your proactive prevention" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="skill_description">Skill-Building</label><br />						
							<textarea id="skill_description" placeholder="Please enter information about your skill-building prevention" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="asset_description">Asset-Based</label><br />						
							<textarea id="asset_description" placeholder="Please enter information about your asset-based prevention" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="community_description">Community Participation</label><br />						
							<textarea id="skill_description" placeholder="Please enter information about your community participation prevention" class="textarea-large"></textarea>		
						</p>				
					</div>

				<!--- THEORY OF CHANGE --->
					<div id="theory_panel" class="panel">
						<h1 class="form-group-heading">Theory of Change</h1>
						
						<p>
							<label for="need_description">Need</label><br />						
							<textarea id="need_description" placeholder="Please enter information about your need" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="goal_description">Goal</label><br />						
							<textarea id="goal_description" placeholder="Please enter information about your goal" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="strategies_description">Strategies</label><br />						
							<textarea id="strategies_description" placeholder="Please enter information about your strategies" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="rationale_description">Rationale</label><br />						
							<textarea id="rationale_description" placeholder="Please enter information about your rationale" class="textarea-large"></textarea>		
						</p>				
					</div>		

				<!--- OUTCOMES PLAN --->
					<div id="outcomes_panel" class="panel">
						<h1 class="form-group-heading">Outcomes Plan</h1>
						
						<p>
							<label for="indicators_description">Alignment with FCSS Indicators</label><br />						
							<textarea id="indicators_description" placeholder="Please describe how your program aligns with FCSS indicators" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="outcomes_description">Alignment with FCSS Outcomes</label><br />						
							<textarea id="outcomes_description" placeholder="Please describe how your program aligns with FCSS outcomes" class="textarea-large"></textarea>		
						</p>
						<p>
							<label for="outcomes_description">Outcomes Evaluation Plan</label><br />						
							<textarea id="outcomes_description" placeholder="Please describe how your outcomes evaluation plan" class="textarea-large"></textarea>		
						</p>				
					</div>											

				<!--- CONTACT INFORMATION --->
					<div id="budget_panel" class="panel">
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

				<!--- PEOPLE --->
					<div id="people_panel" class="panel">
						<h1 class="form-group-heading">People</h1>
						
						<p>This will be where the agencies manage accounts that can access there portal.</p>
					</div>

					<div class="form_buttons clearfix">
						<button type="button" class="btn btn-primary pull-right">Next</button> 
					</div>									
				</form>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">