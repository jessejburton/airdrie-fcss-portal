<cfif APPLICATION.environment NEQ "development">
	<cflocation url="#APPLICATION.URL#" addtoken="false">
	<cfabort>
</cfif>

<cfquery name="qStatus">
	SELECT	StatusID
	FROM	Status_tbl
	<cfif URL.Type IS "A">
		WHERE	Status IN ('APPLICATION - Approved', 'PROGRAM - Funded')
	<cfelseif URL.Type IS "L">
		WHERE	Status = 'LOI - Approved'
	</cfif>
</cfquery>

<!--- Check Program --->
<cfquery name="qCheck">
	SELECT	StatusID FROM ProgramStatus_tbl 
	WHERE	ProgramID = <cfqueryparam value="#URL.ProgramID#" cfsqltype="cf_sql_integer">
	AND 	StatusID IN (<cfqueryparam value="#ValueList(qStatus.StatusID)#" cfsqltype="cf_sql_integer" list="true">)
</cfquery>

<cfif qCheck.recordcount IS 0>
	<cfoutput query="qStatus">
		<cfquery>
			INSERT INTO ProgramStatus_tbl
			( ProgramID, StatusID, AccountID ) 
			VALUES
			(
				<cfqueryparam value="#URL.ProgramID#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#qStatus.StatusID#" cfsqltype="cf_sql_integer">,
				1
			)
		</cfquery>
	</cfoutput>
</cfif>

<p><cfoutput>#iif(URL.Type IS "A", DE('Application'), DE('Letter of Intent'))#</cfoutput> has been approved!</p>