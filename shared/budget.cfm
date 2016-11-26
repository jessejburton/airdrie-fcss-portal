<script src="assets/js/page/budget.js"></script>

<cfparam name="BUDGETTYPE" default="Program Budget">
<cfinvoke component="#APPLICATION.cfcpath#budget" method="getBudgetByBudgetType" programID="#PROGRAM.PROGRAMID#" budgetType="#BUDGETTYPE#" returnvariable="BUDGET" />
<input type="hidden" id="BudgetID" value="<cfoutput>#BUDGET.BudgetID#</cfoutput>" />

<!--- Get the sources --->
<cfinvoke component="#APPLICATION.cfcpath#budget" method="getSources" returnvariable="SOURCES">
<cfset SOURCEREVENUE = SOURCES["R"]>
<cfset SOURCEEXPENSE = SOURCES["E"]>

<h1 class="form-group-heading">Program Budget Information <a href="assets/documents/Budget-Guide.pdf" target="_blank" class="pull-right link small-text"><i class="fa fa-question-circle"></i> Budget Guide</a></h1>

<h2>Revenues</h2>

<table class="table" id="revenue_table">
	<thead>
		<tr>
			<cfoutput>
				<th width="40%">Source</th>
				<th width="30%">#YEAR(NOW())# Program Budget
				<th width="30%">#YEAR(NOW()) + 1# Revenue Amount</th>								
			</cfoutput>	
		</tr>
	</thead>
	<tbody>
		<tr class="revenue-item airdrie">
			<td class="center-align"><strong>Airdrie FCSS</strong></td>
			<td>
				<span class="input-currency"><input type="number" id="previous_year_budget" class="prev-year" placeholder="Amount" value="<cfoutput>#IIF(BUDGET.PreviousYearBudget GT 0, 'XMLFormat(BUDGET.PreviousYearBudget)', DE(''))#</cfoutput>" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" id="requested_from_airdrie" class="revenue-amount revenue-add-value row-total" placeholder="Amount" value="<cfoutput>#IIF(isNumeric(BUDGET.RequestedFromAirdrie) AND BUDGET.RequestedFromAirdrie GT 0, 'XMLFormat(BUDGET.RequestedFromAirdrie)', DE(''))#</cfoutput>" /></span>
			</td>
		</tr>
		<cfoutput>
			<cfloop array="#BUDGET.Revenues#" index="line">
				<tr class="revenue-item">
					<td>
						<i class="fa fa-minus-circle remove-item"></i>
						<select class="source">
							<option value="">-- Select a revenue item --</option>
							<cfloop array="#SOURCEREVENUE#" index="r">
								<cfif line.SOURCEID IS r.ID>
									<option value="#r.ID#" selected>#r.SOURCE#</option>
								<cfelse>
									<option value="#r.ID#">#r.SOURCE#</option>
								</cfif>
							</cfloop>
						</select>
					</td>
					<td>
						<span class="input-currency"><input type="number" class="prev-year" placeholder="Amount" value="#XMLFormat(line.PreviousYearBudget)#" /></span>
					</td>
					<td>
						<span class="input-currency"><input type="number" class="revenue-amount revenue-add-value row-total" placeholder="Amount" value="#XMLFormat(line.RevenueAmount)#" /></span>
					</td>
				</tr>
			</cfloop>
		</cfoutput>
		<tr class="revenue-item row-template">
			<td>
				<i class="fa fa-minus-circle remove-item"></i>
				<select class="source">
					<option value="">-- Select a revenue item --</option>
					<cfoutput>
						<cfloop array="#SOURCEREVENUE#" index="r">
							<option value="#r.ID#">#r.SOURCE#</option>
						</cfloop>
					</cfoutput>
				</select>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="prev-year" placeholder="Amount" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="revenue-amount revenue-add-value tab-add-row row-total" placeholder="Amount" /></span>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr id="revenue_total_row" class="table-total-row">
			<td><a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a></td>
			<td><span class="row-error-message"></span></td>
			<td colspan="2">
				<strong class="pull-left">Total Revenues</strong>
				<span id="expenditure_total" class="col-total pull-right faded">$ 0.00</span>
				<input type="hidden" id="revenue_total_val" class="table-total">
			</td>
		</tr>
	</tfoot>
</table>

<hr />

<h2>Expenditures</h2>
<table class="table" id="expense_table">
	<thead>
		<tr>
			<cfoutput>
				<th width="20%">Source</th>
				<th width="20%">#YEAR(NOW())# Program Budget
				<th width="20%">#YEAR(NOW()) + 1# To be funded by Other Source</th>
				<th width="20%">#YEAR(NOW()) + 1# To be funded by Airdrie</th>				
				<th width="20%">Total</th>	
			</cfoutput>
		</tr>
	</thead>
	<tbody>
		<cfoutput>
			<cfset hasStaffing = false>
			<cfloop array="#BUDGET.Expenses#" index="line">
				<!--- set a variable for staffing so we can show it if needed --->	
				<cfif TRIM(line.SOURCE) IS "Staffing Costs">
					<cfset hasStaffing = true>
				</cfif>
				<tr class="expenditure-item">
					<td>
						<i class="fa fa-minus-circle remove-item"></i>
						<select class="expenditure_source source">
							<option value="">-- Select an expense --</option>															
							<cfloop array="#SOURCEEXPENSE#" index="e">
								<cfif line.SOURCEID IS e.ID>
									<option value="#e.ID#" selected>#e.SOURCE#</option>
								<cfelse>
									<option value="#e.ID#">#e.SOURCE#</option>
								</cfif>
							</cfloop>							
						</select>
					</td>
					<td>
						<span class="input-currency"><input type="number" class="prev-year" placeholder="Amount" value="#XMLFormat(line.PREVYEAR)#" /></span>
					</td>
					<td>
						<span class="input-currency"><input type="number" class="funded-other revenue-add-value" placeholder="Amount" value="#XMLFormat(line.FundedOther)#" /></span>
					</td>
					<td>
						<span class="input-currency"><input type="number" class="funded-airdrie revenue-add-value tab-add-row" placeholder="Amount" value="#XMLFormat(line.FundedAirdrie)#" /></span>
					</td>
					<td>
						<span class="input-currency"><input type="number" class="row-total" disabled placeholder="Total" value="#XMLFormat(line.FundedOther + line.FundedAirdrie)#" /></span>								
					</td>
				</tr>
			</cfloop>
		</cfoutput>
		<tr class="expenditure-item row-template">
			<td>
				<i class="fa fa-minus-circle remove-item"></i>
				<select class="expenditure_source source">
					<option value="">-- Select an expense --</option>
					<cfoutput>
						<cfloop array="#SOURCEEXPENSE#" index="e">
							<option value="#e.ID#">#e.SOURCE#</option>
						</cfloop>
					</cfoutput>
				</select>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="prev-year" placeholder="Amount" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="funded-other revenue-add-value" placeholder="Amount" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="funded-airdrie revenue-add-value tab-add-row" placeholder="Amount" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="row-total" disabled placeholder="Total" /></span>								
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr id="expenditure_total_row" class="table-total-row">
			<td><a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a></td>
			<td colspan="2"><span class="row-error-message"></span></td>
			<td>
				<strong class="pull-right">Total Expenditures</strong>
			</td>
			<td>				
				<span class="col-total pull-right faded">$ 0.00</span>
				<input type="hidden" id="expenditure_total_val" class="table-total">
			</td>
		</tr>
	</tfoot>
</table>
<!--- 	Hidden fields here are used for validation for the form 
		The hidden field gets a class of required-hidden and a data-validate which determines what the value should be
		The form validator will trigger an error (using the message from the data-error of this hidden field) if the value
		does not match what is in the data-validate. --->
<!--- EXPENSE / REVENUE VALID --->
<input type="hidden" id="expenditure_revenue_valid" class="required-hidden" data-validate="1" data-error="Please make sure you have filled out your budget correctly and that your expenditures do not exceed your revenues." value="0">
<!--- STAFF VALID --->
<input type="hidden" id="staff_valid" class="required-hidden" data-validate="1" data-error="Please make sure that the total amount you have entered for staff matches the amount of the staff expense line item." value="1">

<div id="staffing" class="<cfoutput>#iif(hasStaffing IS true, DE(''), DE('hidden'))#</cfoutput>">
	
	<hr />

	<h2>Staffing</h2>
	<!--- Staffing will always display, the data will only be relevant however if staffing has been selected as a source. This way even if they remove staffing or accidently change it nothing gets lost. --->
	<p>Please enter the titles and amount breakdown for the positions relating to the staffing item in your expenditures. Total should add up to the line item you entered above, currently <strong>$ <span id="staffing_total"></span></strong>.
	<table class="table" id="staff_table">
		<thead>
			<tr><th>Title</th><th>Amount</th></tr>
		</thead>
		<tbody>
			<cfoutput>
				<cfloop array="#BUDGET.Staff#" index="line">
					<tr class="staffing-row">
						<td><i class="fa fa-minus-circle remove-item"></i><input type="text" class="staff-title" placeholder="Title" value="#XMLFormat(line.TITLE)#" /></td>
						<td><span class="input-currency"><input type="number" class="staffing-add-value tab-add-row row-total" placeholder="Amount" value="#XMLFormat(line.Amount)#" /></span></td>
					</tr>
				</cfloop>
			</cfoutput>
			<tr class="staffing-row row-template">
				<td><i class="fa fa-minus-circle remove-item"></i><input type="text" class="staff-title" placeholder="Title" /></td>
				<td><span class="input-currency"><input type="number" class="staffing-add-value tab-add-row row-total" placeholder="Amount" /></span></td>
			</tr>
		</tbody>
		<tfoot>
			<tr id="staff_table_footer">
				<td><a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a></td>
				<td>
					<span class="row-error-message"></span>
					<span class="col-total pull-right faded">$ 0.00</span>
					<input type="hidden" id="staffing_total_val" class="table-total">
				</td>
			</tr>
		</tfoot>
	</table>
</div>

<hr />

<div class="budget-bottom">
	<p>
		<label for="revenues_explanation">Revenues Explanation</label><br />						
		<textarea id="revenues_explanation" placeholder="Please explain your revenues" class="textarea-large"><cfoutput>#XMLFormat(BUDGET.REVENUESEXPLANATION)#</cfoutput></textarea>		
	</p>
	<p>
		<label for="expenditures_explanation">Expenditures Explanation</label><br />						
		<textarea id="expenditures_explanation" placeholder="Please explain your expenditures" class="textarea-large"><cfoutput>#XMLFormat(BUDGET.EXPENDITURESEXPLANATION)#</cfoutput></textarea>		
	</p>

	<p>Please provide the percentage of funds that will be applied to each target group below</p>
	<span class="label-sub">Please try to be as accurate as possible but estimates are ok.</span>
	<ul id="#sliders" class="list-no-style">
		<cfoutput>
			<li data-value="#EncodeForHTMLAttribute(BUDGET.PERCENTCHILD)#">
				Children / Youth
				<div class="slider input-half" id="percent_child"></div>
				<span class="value">0%</span>
			</li>
			<li data-value="#EncodeForHTMLAttribute(BUDGET.PERCENTFAMILY)#">
				Family
				<div class="slider input-half" id="percent_family"></div>
				<span class="value">0%</span>
			</li>
			<li data-value="#EncodeForHTMLAttribute(BUDGET.PERCENTADULT)#">
				Adult
				<div class="slider input-half" id="percent_adult"></div>
				<span class="value">0%</span>							
			</li>
			<li data-value="#EncodeForHTMLAttribute(BUDGET.PERCENTSENIORS)#">
				Seniors
				<div class="slider input-half" id="percent_seniors"></div>
				<span class="value">0%</span>
			</li>
			<li data-value="#EncodeForHTMLAttribute(BUDGET.PERCENTVOLUNTEERS)#">
				Volunteers
				<div class="slider input-half" id="percent_volunteers"></div>
				<span class="value">0%</span>							
			</li>
		</cfoutput>
	</ul>
</div>

				