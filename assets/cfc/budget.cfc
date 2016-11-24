<cfcomponent displayname="Budget" extends="Core"
	hint="All functions relating to the budget">
	<cffunction name="getBudgetByBudgetType" access="public" returntype="struct" returnformat="JSON"
		hint="Returns a structure with the details of a programs budget, creates one if one does not exist.">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="BudgetType" type="string" default="Program Budget">
		<cfargument name="AccountID" type="numeric" default="#REQUEST.USER.AccountID#">

		<cfset LOCAL.BUDGET = StructNew()>

		<!--- Get the budget details --->
		<cfquery name="LOCAL.qBudget">
			SELECT 	BudgetID, [PreviousYearBudget],[RequestedFromAirdrie] 
			FROM 	Budget_tbl 
			WHERE 	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
			AND		BudgetTypeID = (SELECT BudgetTypeID FROM BudgetType_tbl WHERE BudgetType = <cfqueryparam value="#ARGUMENTS.BudgetType#" cfsqltype="cf_sql_varchar">)
		</cfquery>

		<cfif LOCAL.qBudget.recordcount IS 1>
			<cfset LOCAL.BUDGET.BudgetID = LOCAL.qBudget.BudgetID>
			<cfset LOCAL.BUDGET.PreviousYearBudget = LOCAL.qBudget.PreviousYearBudget>
			<cfset LOCAL.BUDGET.RequestedFromAirdrie = LOCAL.qBudget.RequestedFromAirdrie> 
		<cfelse>
			<cfquery result="LOCAL.qBudget">
				INSERT INTO Budget_tbl
				( BudgetTypeID, ProgramID, AccountID )
				VALUES 
				(
					(SELECT BudgetTypeID FROM BudgetType_tbl WHERE BudgetType = <cfqueryparam value="#ARGUMENTS.BudgetType#" cfsqltype="cf_sql_varchar">),
					<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
				)
			</cfquery>
			
			<cfset LOCAL.BUDGET.BudgetID = LOCAL.qBudget.GeneratedKey>
			<cfset LOCAL.PreviousYearBudget = 0>
			<cfset LOCAL.RequestedFromAirdrie = 0>
		</cfif>

		<cfset LOCAL.BUDGET.REVENUES = getRevenuesByBudgetID(LOCAL.BUDGET.BudgetID)>
		<cfset LOCAL.BUDGET.EXPENSES = getExpensesByBudgetID(LOCAL.BUDGET.BudgetID)>

		<cfreturn LOCAL.BUDGET>
	</cffunction>

	<cffunction name="getSources" access="public" returnformat="JSON" returntype="struct"
		hint="Returns a structure with arrays containing the sources for each type">

		<cfset LOCAL.response = StructNew()>

		<cfquery name="LOCAL.qSources">
			SELECT 	SourceID, Source, SourceType
			FROM 	BudgetSource_tbl
			ORDER BY SourceType, isOrder
		</cfquery>

		<cfset LOCAL.response["S"] = ArrayNew(1)>
		<cfset LOCAL.response["R"] = ArrayNew(1)>
		<cfset LOCAL.response["E"] = ArrayNew(1)>

		<cfloop query="LOCAL.qSources">
			<cfset LOCAL.source = StructNew()>
			<cfset LOCAL.source.ID = LOCAL.qSources.SourceID>
			<cfset LOCAL.source.SOURCE = LOCAL.qSources.Source>

			<cfset ArrayAppend(LOCAL.response[LOCAL.qSources.SourceType], LOCAL.source)>
		</cfloop>

		<cfreturn LOCAL.response>
	</cffunction>

	<cffunction name="updateBudget" access="public" returntype="boolean" returnformat="JSON"
		hint="Updates a budget.">
		<cfargument name="BudgetID" type="numeric" required="true">
		<cfargument name="Revenues" type="array" required="true">
		<cfargument name="Expenses" type="array" required="true">
		<cfargument name="PreviousYearBudget" type="numeric" default="0">
		<cfargument name="RequestedFromAirdrie" type="numeric" default="0">

		<cftransaction>
			<cfset updateRevenueItems(ARGUMENTS.BudgetID, ARGUMENTS.Revenues)>
			<cfset updateExpenseItems(ARGUMENTS.BudgetID, ARGUMENTS.Expenses)>
			<cfquery>
				UPDATE 	Budget_tbl
				SET 	PreviousYearBudget = <cfqueryparam value="#ARGUMENTS.PreviousYearBudget#" cfsqltype="cf_sql_float">,
						RequestedFromAirdrie = <cfqueryparam value="#ARGUMENTS.RequestedFromAirdrie#" cfsqltype="cf_sql_float">
				WHERE	BudgetID = <cfqueryparam value="#ARGUMENTS.BudgetID#" cfsqltype="cf_sql_integer">
			</cfquery>
		</cftransaction>

		<cfreturn true>
	</cffunction>	

<!--- REVENUES --->
	<cffunction name="getRevenuesByBudgetID" access="public" returnformat="JSON" returntype="Array"
		hint="Gets an array of revenue line items for a budget">
		<cfargument name="BudgetID" type="numeric" required="true">

		<cfset LOCAL.REVENUES = ArrayNew(1)>

		<cfquery name="LOCAL.qRevenues">
			SELECT 	[SourceID], [PreviousYearBudget], [RevenueAmount]
			FROM 	BudgetRevenue_tbl
			WHERE	BudgetID = <cfqueryparam value="#ARGUMENTS.BudgetID#" cfsqltype="cf_sql_integer">
			ORDER BY isOrder
		</cfquery>

		<cfoutput query="LOCAL.qRevenues">
			<cfset LOCAL.line = StructNew()>
			<cfset LOCAL.line.SOURCEID = LOCAL.qRevenues.SourceID> 
			<cfset LOCAL.line.PREVIOUSYEARBUDGET = LOCAL.qRevenues.PreviousYearBudget> 
			<cfset LOCAL.line.REVENUEAMOUNT = LOCAL.qRevenues.RevenueAmount> 

			<cfset ArrayAppend(LOCAL.REVENUES, LOCAL.line)>
		</cfoutput>

		<cfreturn LOCAL.REVENUES>
	</cffunction>

	<cffunction name="updateRevenueItems" access="public" returntype="boolean" returnformat="JSON"
		hint="Removes existing revenue items and adds the ones passed in.">
		<cfargument name="BudgetID" type="numeric" required="true">
		<cfargument name="Items" type="array" required="true">
		<cfargument name="AccountID" type="numeric" default="#REQUEST.USER.AccountID#">

		<cftransaction>
			<!--- remove existing items --->
			<cfquery>
				DELETE FROM BudgetRevenue_tbl WHERE BudgetID = <cfqueryparam value="#ARGUMENTS.BUDGETID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<!--- Add the new items --->
			<cfloop array="#ARGUMENTS.Items#" index="line">
				<cfquery result="LOCAL.qAddRevenue">
					INSERT INTO BudgetRevenue_tbl 
					(
						BudgetID, SourceID, PreviousYearBudget, RevenueAmount, AccountID
					) VALUES (
						<cfqueryparam value="#ARGUMENTS.BudgetID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#line.SourceID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#line.PreviousYearBudget#" cfsqltype="cf_sql_float">,
						<cfqueryparam value="#line.RevenueAmount#" cfsqltype="cf_sql_float">,
						<cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
					)
				</cfquery>	
			</cfloop>
		</cftransaction>

		<cfreturn true>
	</cffunction>

<!--- EXPENSES --->
	<cffunction name="getExpensesByBudgetID" access="public" returnformat="JSON" returntype="Array"
		hint="Gets an array of expense line items for a budget">
		<cfargument name="BudgetID" type="numeric" required="true">

		<cfset LOCAL.EXPENSES = ArrayNew(1)>

		<cfquery name="LOCAL.qExpenses">
			SELECT 	[SourceID], [PreviousYearBudget], [FundedOther], [FundedAirdrie]
			FROM 	BudgetExpense_tbl
			WHERE	BudgetID = <cfqueryparam value="#ARGUMENTS.BudgetID#" cfsqltype="cf_sql_integer">
			ORDER BY isOrder
		</cfquery>

		<cfoutput query="LOCAL.qExpenses">
			<cfset LOCAL.line = StructNew()>
			<cfset LOCAL.line.SOURCEID = LOCAL.qExpenses.SourceID> 
			<cfset LOCAL.line.PREVYEAR = LOCAL.qExpenses.PreviousYearBudget> 
			<cfset LOCAL.line.FUNDEDOTHER = LOCAL.qExpenses.FundedOther> 
			<cfset LOCAL.line.FUNDEDAIRDRIE = LOCAL.qExpenses.FundedAirdrie> 

			<cfset ArrayAppend(LOCAL.EXPENSES, LOCAL.line)>
		</cfoutput>

		<cfreturn LOCAL.EXPENSES>
	</cffunction>	

	<cffunction name="updateExpenseItems" access="public" returntype="boolean" returnformat="JSON"
		hint="Removes existing expense items and adds the ones passed in.">
		<cfargument name="BudgetID" type="numeric" required="true">
		<cfargument name="Items" type="array" required="true">
		<cfargument name="AccountID" type="numeric" default="#REQUEST.USER.AccountID#">

		<cftransaction>
			<!--- remove existing items --->
			<cfquery>
				DELETE FROM BudgetExpense_tbl WHERE BudgetID = <cfqueryparam value="#ARGUMENTS.BUDGETID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<!--- Add the new items --->
			<cfloop array="#ARGUMENTS.Items#" index="line">
				<cfquery result="LOCAL.qAddExpense">
					INSERT INTO BudgetExpense_tbl 
					(
						BudgetID, SourceID, PreviousYearBudget, FundedOther, FundedAirdrie, AccountID
					) VALUES (
						<cfqueryparam value="#ARGUMENTS.BudgetID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#line.SourceID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#line.PreviousYearBudget#" cfsqltype="cf_sql_float">,
						<cfqueryparam value="#line.FundedOther#" cfsqltype="cf_sql_float">,
						<cfqueryparam value="#line.FundedAirdrie#" cfsqltype="cf_sql_float">,
						<cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
					)
				</cfquery>	
			</cfloop>
		</cftransaction>

		<cfreturn true>
	</cffunction>	

</cfcomponent>