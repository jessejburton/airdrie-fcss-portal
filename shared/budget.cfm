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

<table class="table">
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
				<span class="input-currency"><input type="number" class="prev-year" placeholder="Amount" value="<cfoutput>#IIF(BUDGET.PreviousYearBudget GT 0, 'XMLFormat(BUDGET.PreviousYearBudget)', DE(''))#</cfoutput>" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="revenue-amount revenue-add-value row-total" placeholder="Amount" value="<cfoutput>#IIF(BUDGET.RequestedFromAirdrie GT 0, 'XMLFormat(BUDGET.RequestedFromAirdrie)', DE(''))#</cfoutput>" /></span>
			</td>
		</tr>
		<cfoutput>
			<cfloop array="#BUDGET.Revenues#" index="line">
				<tr class="revenue-item">
					<td>
						<i class="fa fa-minus-circle remove-item"></i>
						<select>
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
						<span class="input-currency"><input type="number" class="expenditure-add-value tab-add-row row-total" placeholder="Amount" value="#XMLFormat(line.RevenueAmount)#" /></span>
					</td>
				</tr>
			</cfloop>
		</cfoutput>
		<tr class="revenue-item row-template">
			<td>
				<i class="fa fa-minus-circle remove-item"></i>
				<select>
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
				<span class="input-currency"><input type="number" class="expenditure-add-value tab-add-row row-total" placeholder="Amount" /></span>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr id="revenue_total_row" class="table-total-row">
			<td>
				<a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a>
			</td>
			<td>
				<strong class="pull-right">Total Revenues</strong>
			</td>
			<td>
				<span id="expenditure_total" class="col-total pull-right faded">$ 0.00</span>
				<input type="hidden" id="revenue_total_val" class="table-total">
			</td>
		</tr>
	</tfoot>
</table>

<hr />

<h2>Expenditures</h2>
<table class="table">
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
		<tr class="expenditure-item row-template">
			<td>
				<i class="fa fa-minus-circle remove-item"></i>
				<select class="expenditure_source">
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
				<span class="input-currency"><input type="number" class="revenue-add-value" placeholder="Amount" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="revenue-add-value tab-add-row" placeholder="Amount" /></span>
			</td>
			<td>
				<span class="input-currency"><input type="number" class="row-total" disabled placeholder="Total" /></span>								
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr id="expenditure_total_row" class="table-total-row">
			<td colspan="3">
				<a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a>
			</td>
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

<input type="hidden" id="expenditure_revenue_valid" class="required-hidden" data-validate="1" data-error="Please make sure you have filled out your budget correctly and that your expenditures do not exceed your revenues." value="0">

<div id="staffing" class="hidden">
	<h2>Staffing</h2>
	<table class="table">
		<thead>
			<tr><th>Title</th><th>Amount</th></tr>
		</thead>
		<tbody>
			<tr class="row-template">
				<td><i class="fa fa-minus-circle remove-item"></i><input type="text" class="staff-title" placeholder="Title" />
				<td><span class="input-currency"><input type="number" class="staffing-add-value tab-add-row row-total" placeholder="Amount" /></span></td>
			</td>
		</tbody>
		<tfoot>
			<tr>
				<td><a href="javascript:;" class="add-row"><i class="fa fa-plus"></i> add another</a></td>
				<td>
					<span class="col-total pull-right faded">$ 0.00</span>
					<input type="text" id="staffing_total_val" class="table-total">
				</td>
		</tfoot>
	</table>
</div>

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

				