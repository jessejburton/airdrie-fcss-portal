<cfif APPLICATION.environment IS "development">
	<cfif NOT isDefined('url.reset')>
		<p><a href="reset.cfm?reset=true">Click here</a> to reset the database</p>
	<cfelse>
		<cfquery>
			TRUNCATE TABLE Account_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE Program_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE Agency_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE BoardMembers_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE Documents_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE Budget_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE BudgetExpense_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE BudgetRevenue_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE BudgetStaff_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE ProgramStatus_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE SurveyClient_tbl
		</cfquery>
		<cfquery>
			TRUNCATE TABLE SurveyResponse_tbl
		</cfquery>

		<p>All data has been cleared</p>
	</cfif>	
<cfelse>
	<p>You can not reset the data on a production system.</p>
</cfif>	