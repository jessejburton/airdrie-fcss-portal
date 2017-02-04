<cfcomponent displayname="Dashboard" extends="Core">
<!--- Number of Programs by Agency --->
	<cffunction name="getNumProgramsByAgencyID" returnformat="JSON" returntype="Numeric"
		hint="Gets the number of active programs for a specific agency.">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#" 
			hint="Not passing in an ID just returns the current active users Agency Info">

		<cfquery name="LOCAL.qPrograms">
			SELECT	COUNT(ProgramID) AS theCount
			FROM 	Program_tbl
			WHERE 	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			AND		YEAR(DateAdded) = YEAR(getDate())
			AND 	isActive = 1
		</cfquery>

		<cfreturn LOCAL.qPrograms.theCount>
	</cffunction>

<!--- Number of Programs Total --->
	<cffunction name="getNumProgramsTotal" returnformat="JSON" returntype="Numeric"
		hint="Gets the number of total active programs.">

		<cfquery name="LOCAL.qPrograms">
			SELECT	COUNT(ProgramID) AS theCount
			FROM 	Program_tbl
			WHERE 	YEAR(DateAdded) = YEAR(getDate())
			AND 	isActive = 1
		</cfquery>

		<cfreturn LOCAL.qPrograms.theCount>
	</cffunction>

<!--- Number of Approved Programs by Agency --->
	<cffunction name="getNumApprovedProgramsByAgencyID" returnformat="JSON" returntype="Numeric"
		hint="Gets the number of active programs for a specific agency.">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#" 
			hint="Not passing in an ID just returns the current active users Agency Info">

		<cfquery name="LOCAL.qPrograms">
			SELECT	COUNT(ProgramID) AS theCount
			FROM 	Program_tbl
			WHERE 	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			AND		YEAR(DateAdded) = YEAR(getDate())
			AND 	isActive = 1
			AND 	ProgramID IN (SELECT ProgramID FROM ProgramStatus_tbl WHERE StatusID IN (SELECT StatusID FROM Status_tbl WHERE Status = 'APPLICATION - Approved'))
		</cfquery>

		<cfreturn LOCAL.qPrograms.theCount>
	</cffunction>

<!--- Number of Approved Programs Total --->
	<cffunction name="getNumApprovedProgramsTotal" returnformat="JSON" returntype="Numeric"
		hint="Gets the number of total active programs.">

		<cfquery name="LOCAL.qPrograms">
			SELECT	COUNT(ProgramID) AS theCount
			FROM 	Program_tbl
			WHERE 	YEAR(DateAdded) = YEAR(getDate())
			AND 	isActive = 1
			AND 	ProgramID IN (SELECT ProgramID FROM ProgramStatus_tbl WHERE StatusID IN (SELECT StatusID FROM Status_tbl WHERE Status = 'APPLICATION - Approved'))
		</cfquery>

		<cfreturn LOCAL.qPrograms.theCount>
	</cffunction>

<!--- Number of Surveys Completed for an Agency --->		
	<cffunction name="getNumClientSurveysByAgencyID" returnformat="JSON" returntype="Numeric"
		hint="Gets the number of clients surveys completed for a specific agency.">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#" 
			hint="Not passing in an ID just returns the current active users Agency Info">

		<cfquery name="LOCAL.qPrograms">
			SELECT	DISTINCT ClientID
			FROM 	SurveyClient_vw
			WHERE 	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			AND		YEAR(DateAdded) = YEAR(getDate())
		</cfquery>

		<cfreturn LOCAL.qPrograms.recordcount>
	</cffunction>

<!--- Number of Surveys Completed Total --->		
	<cffunction name="getNumClientSurveysTotal" returnformat="JSON" returntype="Numeric"
		hint="Gets the number of clients surveys completed total.">

		<cfquery name="LOCAL.qPrograms">
			SELECT	DISTINCT ClientID
			FROM 	SurveyClient_vw
			WHERE 	YEAR(DateAdded) = YEAR(getDate())
		</cfquery>

		<cfreturn LOCAL.qPrograms.recordcount>
	</cffunction>

<!--- Number of Clients by Agency --->
	<cffunction name="getNumClientsByAgencyID" returnformat="JSON" returntype="numeric"
		hint="The number of clients for a specific agency">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#" 
			hint="Not passing in an ID just returns the current active users Agency Info">

		<cfquery name="LOCAL.qClients">
			SELECT DISTINCT ClientID
			FROM	SurveyClient_vw
			WHERE 	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			AND		YEAR(DateAdded) = YEAR(getDate())
		</cfquery>

		<cfreturn LOCAL.qClients.recordcount>
	</cffunction>

<!--- Number of Agencies --->
	<cffunction name="getNumAgencies" returnformat="JSON" returntype="numeric"
		hint="The number of active agencies">

		<cfquery name="LOCAL.qAgencies">
			SELECT DISTINCT AgencyID
			FROM	Agency_tbl
			WHERE 	isActive = 1
		</cfquery>

		<cfreturn LOCAL.qAgencies.recordcount>
	</cffunction>
</cfcomponent>