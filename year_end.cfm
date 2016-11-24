<cfinclude template="shared/header.cfm">

<cfset APPLICATIONDETAILS = SESSION.Applications[1]>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<form id="end_year_form">
				<h1>Year End Report</h1>
	
				<p>
					Please complete the following Year-End report to submit your current program status to the City of Airdrie.
				</p> 		

				<div class="accordion clearfix">				
					<h3>Program Budget</h3>
					<div class="form-group seen">
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
							<button type="button" id="endyear_review_submit" class="btn btn-primary pull-right">Submit</button> 
						</div>
					</div>										
				</div>
			</form>

<!--- Autoreply message when complete --->
			<div id="endyear_form_complete" class="hidden spaced">
				<p><strong>Success!</strong> you have completed and submitted your Year-End report. return to the <a href="programs.cfm">programs</a> page.</p>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">