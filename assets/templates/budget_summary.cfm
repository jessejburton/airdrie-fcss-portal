<cfif StructKeyExists(FORM, "ProgramID")>
	<cfset ATTRIBUTES.ProgramID = FORM.ProgramID>
</cfif>

<!--- Get the Agency ID for the specific program --->
<cfif StructKeyExists(ATTRIBUTES, "ProgramID")>
	<!--- Find out if you need to display the budget or just the LOI summary --->
	<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramByID" ProgramID="#ATTRIBUTES.ProgramID#" returnvariable="PROGRAM" />
	<cfif ListContains(PROGRAM.StatusList, "LOI - Approved")>
		<cfset FullBudget = true>
	<cfelse>
		<cfset FullBudget = false>
	</cfif>

	<!--- Check Permission --->
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkProgramAccessByAccountID" programID="#ATTRIBUTES.ProgramID#" returnvariable="userHasAccess" />

	<cfif userHasAccess>	
		<cfif FullBudget IS true>
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
							<td>#EncodeForHtml(DollarFormat(BUDGET.PreviousYearBudget))#</td>
							<td>#EncodeForHtml(DollarFormat(BUDGET.RequestedFromAirdrie))#</td>
						</tr>
						<cfloop array="#BUDGET.REVENUES#" index="rev">
							<tr>
								<td>#EncodeForHtml(rev.SOURCE)#</td>
								<td>#EncodeForHtml(DollarFormat(rev.PreviousYearBudget))#</td>
								<td>#EncodeForHtml(DollarFormat(rev.RevenueAmount))#</td>
							</tr>
							<cfset revPrev = revPrev + rev.PreviousYearBudget>
							<cfset revTotal = revTotal + rev.RevenueAmount>
						</cfloop>
					</cfoutput>
					</tbody>
					<tfoot>
						<tr>
							<td></td>
							<td><strong><cfoutput>#EncodeForHtml(DollarFormat(revPrev))#</cfoutput></strong></td>
							<td><strong><cfoutput>#EncodeForHtml(DollarFormat(revTotal))#</cfoutput></strong></td>
						</tr>
					</tfoot>
				</table>

				<h3>Revenue Explanation</h3>
				<p><cfoutput>#EncodeForHtml(BUDGET.REVENUESEXPLANATION)#</cfoutput></p>

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
								<td>#EncodeForHtml(exp.SOURCE)#</td>
								<td>#EncodeForHtml(DollarFormat(exp.PrevYear))#</td>
								<td>#EncodeForHtml(DollarFormat(exp.FundedOther))#</td>
								<td>#EncodeForHtml(DollarFormat(exp.FundedAirdrie))#</td>
								<td>#EncodeForHtml(DollarFormat(exp.FundedOther + exp.FundedAirdrie))#</td>
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
							<td><strong>#EncodeForHtml(DollarFormat(expPrev))#</strong></td>
							<td><strong>#EncodeForHtml(DollarFormat(expOther))#</strong></td>
							<td><strong>#EncodeForHtml(DollarFormat(expAirdrie))#</strong></td>
							<td><strong>#EncodeForHtml(DollarFormat(expTotal))#</strong></td>
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
								<td>#EncodeForHtml(staff.TITLE)#</td>
								<td>#EncodeForHtml(DollarFormat(staff.AMOUNT))#</td>
							</tr>
						</cfloop>
					</cfoutput>	
						</tbody>
					</table>
				</cfif>	

				<h3>Expenditure Explanation</h3>
				<p><cfoutput>#EncodeForHtml(BUDGET.EXPENDITURESEXPLANATION)#</cfoutput></p>

				<hr />

				<h3>Target Groups</h3>
				<cfoutput>
				<ul>
					<li><strong>Adults</strong> <i>#EncodeForHtml(BUDGET.PERCENTADULT)#%</i></li>
					<li><strong>Children</strong> <i>#EncodeForHtml(BUDGET.PERCENTCHILD)#%</i></li>
					<li><strong>Family</strong> <i>#EncodeForHtml(BUDGET.PERCENTFAMILY)#%</i></li>
					<li><strong>Seniors</strong> <i>#EncodeForHtml(BUDGET.PERCENTSENIORS)#%</i></li>
					<li><strong>Volunteers</strong> <i>#EncodeForHtml(BUDGET.PERCENTVOLUNTEERS)#%</i></li>
				</ul>
				</cfoutput>
			</div>
		<cfelse>
			<cfoutput>
				<h1>Amount Requested from Airdrie</h1>
				<p>#DollarFormat(EncodeForHtml(PROGRAM.ESTIMATEDFROMAIRDRIE))#</p>
				<h1>Amount Requested from Other</h1>
				<p>#DollarFormat(EncodeForHtml(PROGRAM.ESTIMATEDFROMOTHER))#</p>
			</cfoutput>
		</cfif>
	</cfif>
</cfif>