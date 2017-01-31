<cfif StructKeyExists(FORM, "ProgramID")>
	<cfset ATTRIBUTES.ProgramID = FORM.ProgramID>
</cfif>

<!--- Get the Agency ID for the specific program --->
<cfif StructKeyExists(ATTRIBUTES, "ProgramID")>
	<!--- Check Permission --->
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkProgramAccessByAccountID" programID="#ATTRIBUTES.ProgramID#" returnvariable="userHasAccess" />

	<cfif userHasAccess>
	<div class="budget-display">
		<cfinvoke component="#APPLICATION.cfcpath#budget" method="getBudgetByBudgetType" programID="#ATTRIBUTES.ProgramID#" budgetType="Program Budget" returnvariable="BUDGET" />

		<h1>Program Budget Summary</h1>

		<cfset revTotal = BUDGET.RequestedFromAirdrie>
		<cfset revPrev = BUDGET.PreviousYearBudget>
	
		<h2>Revenues</h2>
		<table class="table">
			<thead>
				<tr>
					<cfoutput>
						<th width="40%">Source</th>
						<th width="30%">#YEAR(NOW())# Program Budget</th>
						<th width="30%">#YEAR(NOW()) + 1# Revenue Amount</th>								
					</cfoutput>	
				</tr>
			</thead>
			<tbody>
			<cfoutput>
				<tr>
					<td>Airdrie FCSS</td>
					<td>#XMLFormat(DollarFormat(BUDGET.PreviousYearBudget))#</td>
					<td>#XMLFormat(DollarFormat(BUDGET.RequestedFromAirdrie))#</td>
				</tr>
				<cfloop array="#BUDGET.REVENUES#" index="rev">
					<tr>
						<td>#XMLFormat(rev.SOURCE)#</td>
						<td>#XMLFormat(DollarFormat(rev.PreviousYearBudget))#</td>
						<td>#XMLFormat(DollarFormat(rev.RevenueAmount))#</td>
					</tr>
					<cfset revPrev = revPrev + rev.PreviousYearBudget>
					<cfset revTotal = revTotal + rev.RevenueAmount>
				</cfloop>
			</cfoutput>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td><strong><cfoutput>#XMLFormat(DollarFormat(revPrev))#</cfoutput></strong></td>
					<td><strong><cfoutput>#XMLFormat(DollarFormat(revTotal))#</cfoutput></strong></td>
				</tr>
			</tfoot>
		</table>

		<h3>Revenue Explanation</h3>
		<p><cfoutput>#XMLFormat(BUDGET.REVENUESEXPLANATION)#</cfoutput></p>

		<hr />

		<cfset expAirdrie = 0>
		<cfset expOther = 0>
		<cfset expPrev = 0>
		<cfset expTotal = 0>

		<h2>Expenditures</h2>
		<table class="table">
			<thead>
				<tr>
					<cfoutput>
						<th width="20%">Source</th>
						<th width="18%">#YEAR(NOW())# Program Budget</th>
						<th width="22%">#YEAR(NOW()) + 1# To be funded by Other Source</th>
						<th width="22%">#YEAR(NOW()) + 1# To be funded by Airdrie</th>				
						<th width="18%">Total</th>								
					</cfoutput>	
				</tr>
			</thead>
			<tbody>
			<cfoutput>
				<cfloop array="#BUDGET.EXPENSES#" index="exp">
					<tr>
						<td>#XMLFormat(exp.SOURCE)#</td>
						<td>#XMLFormat(DollarFormat(exp.PrevYear))#</td>
						<td>#XMLFormat(DollarFormat(exp.FundedOther))#</td>
						<td>#XMLFormat(DollarFormat(exp.FundedAirdrie))#</td>
						<td>#XMLFormat(DollarFormat(exp.FundedOther + exp.FundedAirdrie))#</td>
					</tr>
					<cfset expAirdrie = expAirdrie + exp.FundedAirdrie>
					<cfset expOther = expOther + exp.FundedOther>
					<cfset expPrev = expPrev + exp.PrevYear>
					<cfset expTotal = expTotal + (exp.FundedOther + exp.FundedAirdrie)>
				</cfloop>
			</cfoutput>
			</tbody>
			<tfoot>
				<cfoutput>
				<tr>
					<td></td>
					<td><strong>#XMLFormat(DollarFormat(expPrev))#</strong></td>
					<td><strong>#XMLFormat(DollarFormat(expOther))#</strong></td>
					<td><strong>#XMLFormat(DollarFormat(expAirdrie))#</strong></td>
					<td><strong>#XMLFormat(DollarFormat(expTotal))#</strong></td>
				</tr>
				</cfoutput>
			</tfoot>
		</table>	

		<cfif StructKeyExists(BUDGET, "Staff") AND ArrayLen(BUDGET.Staff) GT 0>
			<h3>Staff</h3>
			<table class="table">
				<thead>
					<tr><th>Title</th><th>Amount</th></tr>
				</thead>
				<tbody>
				<cfoutput>
				<cfloop array="#BUDGET.STAFF#" index="staff">
					<tr>
						<td>#XMLFormat(staff.TITLE)#</td>
						<td>#XMLFormat(DollarFormat(staff.AMOUNT))#</td>
					</tr>
				</cfloop>
			</cfoutput>	
				</tbody>
			</table>
		</cfif>	

		<h3>Expenditure Explanation</h3>
		<p><cfoutput>#XMLFormat(BUDGET.EXPENDITURESEXPLANATION)#</cfoutput></p>

		<hr />

		<h3>Target Groups</h3>
		<cfoutput>
		<ul>
			<li><strong>Adults</strong> <i>#XMLFormat(BUDGET.PERCENTADULT)#%</i></li>
			<li><strong>Children</strong> <i>#XMLFormat(BUDGET.PERCENTCHILD)#%</i></li>
			<li><strong>Family</strong> <i>#XMLFormat(BUDGET.PERCENTFAMILY)#%</i></li>
			<li><strong>Seniors</strong> <i>#XMLFormat(BUDGET.PERCENTSENIORS)#%</i></li>
			<li><strong>Volunteers</strong> <i>#XMLFormat(BUDGET.PERCENTVOLUNTEERS)#%</i></li>
		</ul>
		</cfoutput>
	</div>
	</cfif>
</cfif>