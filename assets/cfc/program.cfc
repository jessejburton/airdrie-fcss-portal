<cfcomponent displayname="Program" extends="core"
	hint="Functions relating to a program (from application to closeout)">

	<cffunction name="saveProgram" access="public" returntype="Struct" returnformat="JSON">
		<cfargument name="ProgramID" type="numeric" required="false">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AGENCYID#">
		<cfargument name="AccountID" type="numeric" default="#REQUEST.USER.ACCOUNTID#">
		<cfargument name="ProgramName" type="string" required="true">
		<cfargument name="ProgramStatement" type="string" default="">
		<cfargument name="TargetAudience" type="string" default="">
		<cfargument name="MostlyAirdrie" type="boolean" required="false">
		<cfargument name="PrimaryContactName" type="string" default="">
		<cfargument name="PrimaryPhone" type="string" default="">
		<cfargument name="PrimaryEmail" type="string" default="">
		<cfargument name="ProgramAddress" type="string" default="">
		<cfargument name="ProgramMailingAddress" type="string" default="">
		<cfargument name="Need" type="string" default="">
		<cfargument name="Goal" type="string" default="">
		<cfargument name="Strategies" type="string" default="">
		<cfargument name="Rationale" type="string" default="">
		<cfargument name="Footnotes" type="string" default="">
		<cfargument name="PreventionFocus" type="string" default="">
		<cfargument name="Alignment" type="string" default="">
		<cfargument name="MissionFit" type="string" default="">
		<cfargument name="ConsideredPartnerships" type="string" default="">
		<cfargument name="EstimatedFromAirdrie" type="numeric" default="0">
		<cfargument name="EstimatedFromOther" type="numeric" default="0">
		<cfargument name="ShortTermGoals" type="string" default="">
		<cfargument name="MidTermGoals" type="string" default="">
		<cfargument name="LongTermGoals" type="string" default="">

		<cfif NOT isNumeric(ARGUMENTS.EstimatedFromAirdrie)>
			<cfset ARGUMENTS.EstimatedFromAirdrie = 0>
		</cfif>
		<cfif NOT isNumeric(ARGUMENTS.EstimatedFromOther)>
			<cfset ARGUMENTS.EstimatedFromOther = 0>
		</cfif>

		<!--- New Program, create a record for it --->
		<cfif NOT isDefined('ARGUMENTS.ProgramID')>	
			<cfquery result="LOCAL.qProgram">
				INSERT INTO Program_tbl
				(
					ProgramName, AgencyID, AccountID
				) VALUES (
					<cfqueryparam value="#ARGUMENTS.ProgramName#" cfsqltype="varchar">,					
					<cfqueryparam value="#ARGUMENTS.AGENCYID#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#ARGUMENTS.ACCOUNTID#" cfsqltype="cf_sql_integer">
				)
			</cfquery>

			<cfset ARGUMENTS.ProgramID = LOCAL.qProgram.GeneratedKey>

			<!--- Add the Status Record --->
			<cfquery>
				INSERT INTO ProgramStatus_tbl
				( 
					ProgramID, StatusID, AccountID 
				) Values (
					<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
					(SELECT StatusID FROM Status_tbl WHERE Status = 'LOI - Saved'),
					<cfqueryparam value="#REQUEST.USER.ACCOUNTID#" cfsqltype="cf_sql_integer">
				)
			</cfquery>
		</cfif>

		<!--- Now update the rest of the data --->
		<cfquery name="LOCAL.qProgramUpdate">
			UPDATE Program_tbl
			SET 	ProgramName = <cfqueryparam value="#ARGUMENTS.ProgramName#" cfsqltype="cf_sql_varchar">
					,ProgramStatement = <cfqueryparam value="#ARGUMENTS.ProgramStatement#" cfsqltype="cf_sql_varchar">
					,TargetAudience = <cfqueryparam value="#ARGUMENTS.TargetAudience#" cfsqltype="cf_sql_varchar">
					<cfif isDefined('ARGUMENTS.MostlyAirdrie')>
						,MostlyAirdrie = <cfqueryparam value="#ARGUMENTS.MostlyAirdrie#" cfsqltype="cf_sql_bit">
					</cfif>
					,PrimaryContactName = <cfqueryparam value="#ARGUMENTS.PrimaryContactName#" cfsqltype="cf_sql_varchar">
					,PrimaryPhone = <cfqueryparam value="#ARGUMENTS.PrimaryPhone#" cfsqltype="cf_sql_varchar">
					,PrimaryEmail = <cfqueryparam value="#ARGUMENTS.PrimaryEmail#" cfsqltype="cf_sql_varchar">
					,ProgramAddress = <cfqueryparam value="#ARGUMENTS.ProgramAddress#" cfsqltype="cf_sql_varchar">
					,ProgramMailingAddress = <cfqueryparam value="#ARGUMENTS.ProgramMailingAddress#" cfsqltype="cf_sql_varchar">
					,Need = <cfqueryparam value="#ARGUMENTS.Need#" cfsqltype="cf_sql_varchar">
					,Goal = <cfqueryparam value="#ARGUMENTS.Goal#" cfsqltype="cf_sql_varchar">
					,Strategies = <cfqueryparam value="#ARGUMENTS.Strategies#" cfsqltype="cf_sql_varchar">
					,Rationale = <cfqueryparam value="#ARGUMENTS.Rationale#" cfsqltype="cf_sql_varchar">
					,Footnotes = <cfqueryparam value="#ARGUMENTS.Footnotes#" cfsqltype="cf_sql_varchar">
					,PreventionFocus = <cfqueryparam value="#ARGUMENTS.PreventionFocus#" cfsqltype="cf_sql_varchar">
					,Alignment = <cfqueryparam value="#ARGUMENTS.Alignment#" cfsqltype="cf_sql_varchar">
					,MissionFit = <cfqueryparam value="#ARGUMENTS.MissionFit#" cfsqltype="cf_sql_varchar">
					,ConsideredPartnerships = <cfqueryparam value="#ARGUMENTS.ConsideredPartnerships#" cfsqltype="cf_sql_varchar">
					,EstimatedFromAirdrie = <cfqueryparam value="#ARGUMENTS.EstimatedFromAirdrie#" cfsqltype="cf_sql_float">
					,EstimatedFromOther = <cfqueryparam value="#ARGUMENTS.EstimatedFromOther#" cfsqltype="cf_sql_float">
					,ShortTermGoals = <cfqueryparam value="#ARGUMENTS.ShortTermGoals#" cfsqltype="cf_sql_varchar">
					,MidTermGoals = <cfqueryparam value="#ARGUMENTS.MidTermGoals#" cfsqltype="cf_sql_varchar">
					,LongTermGoals = <cfqueryparam value="#ARGUMENTS.LongTermGoals#" cfsqltype="cf_sql_varchar">
					,AccountID = <cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
					,DateUpdated = getDate()
			WHERE ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn ARGUMENTS>
	</cffunction>

	<cffunction name="getProgramByID" access="public" returntype="struct" returnformat="JSON"
		hint="Gets the details of an application by ID">
		<cfargument name="ProgramID" type="numeric" required="true">

		<!--- Get the program data but make sure the user has access to it --->
		<cfquery name="LOCAL.qProgram">
			SELECT 	*
			FROM 	Program_vw
			WHERE	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
			AND 	AgencyID = <cfqueryparam value="#REQUEST.AGENCY.AGENCYID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfset LOCAL.PROGRAM = StructNew()>

		<cfloop list="#LOCAL.qProgram.columnList#" index="col">
			<cfset LOCAL.PROGRAM[col] = LOCAL.qProgram[col][1]>
		</cfloop>

		<!--- Get a list of status's this application has had --->
		<cfquery name="LOCAL.qProgramStatus">
			SELECT 	s.Status
			FROM 	ProgramStatus_tbl ps
			INNER JOIN Status_tbl s ON ps.StatusID = s.StatusID
			WHERE 	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
			ORDER BY DateAdded DESC
		</cfquery>
		
		<cfset LOCAL.PROGRAM.StatusList = ValueList(LOCAL.qProgramStatus.Status)>
		<cfset LOCAL.PROGRAM.FormattedDateUpdated = DateFormat(LOCAL.qProgram.DateUpdated, "DD/MM/YYYY") & ' @ ' & TimeFormat(LOCAL.qProgram.DateUpdated, "hh:mm:ss")>

		<cfreturn LOCAL.PROGRAM>
	</cffunction>

<!--- Returns a blank program for when starting a new LOI --->
	<cffunction name="getBlankProgram" access="public" returntype="struct" returnformat="JSON"
		hint="Returns a blank program for when starting a new LOI">

		<!--- Get the program data but make sure the user has access to it --->
		<cfquery name="LOCAL.qProgram">
			SELECT Name
			FROM sys.columns
			WHERE object_id = OBJECT_ID('Program_vw')
		</cfquery>

		<cfset LOCAL.PROGRAM = StructNew()>

		<cfloop list="#ValueList(LOCAL.qProgram.Name)#" index="col">
			<cfset LOCAL.PROGRAM[col] = "">
		</cfloop>
		
		<cfset LOCAL.PROGRAM.FormattedDateUpdated = DateFormat(now(), "DD/MM/YYYY") & ' @ ' & TimeFormat(now(), "hh:mm:ss")>
		<cfset LOCAL.PROGRAM.StatusList = "">

		<!--- Update the non varchar values --->
		<cfset PROGRAM.isMostlyAirdrie = 0>
		<cfset PROGRAM.EstimatedFromAirdrie = 0>
		<cfset PROGRAM.EstimatedFromOther = 0>

		<cfreturn LOCAL.PROGRAM>
	</cffunction>	

<!--- Get Program Details for a specific Agency --->
	<cffunction name="getProgramsByAgencyID" access="public" returntype="array" returnformat="JSON"
		hint="Returns the program details from a specific agency.">
		<cfargument name="AgencyID" type="numeric" required="true">
		<cfargument name="Active" type="boolean" default="true">
		<cfargument name="Year" type="numeric" default="#YEAR(NOW())#">

		<!--- Get the program data but make sure the user has access to it --->
		<cfquery name="LOCAL.qPrograms">
			SELECT 	ProgramID, ProgramName, Status
			FROM 	Program_vw
			WHERE	AgencyID = <cfqueryparam value="#REQUEST.AGENCY.AGENCYID#" cfsqltype="cf_sql_integer">
			AND 	Year(DateAdded) = <cfqueryparam value="#ARGUMENTS.Year#" cfsqltype="cf_sql_integer">
			<cfif ARGUMENTS.Active>
				AND 	isActive = 1
			</cfif>
		</cfquery>

		<cfset LOCAL.PROGRAMS = ArrayNew(1)>
		<cfoutput query="LOCAL.qPrograms">
			<cfset program = StructNew()>
			<cfset program.ProgramID = LOCAL.qPrograms.ProgramID>
			<cfset program.ProgramName = LOCAL.qPrograms.ProgramName>
			<cfset program.CurrentStatus = LOCAL.qPrograms.Status>

			<cfquery name="LOCAL.qProgramStatus">
				SELECT 	s.Status
				FROM 	ProgramStatus_tbl ps
				INNER JOIN Status_tbl s ON ps.StatusID = s.StatusID
				WHERE 	ProgramID = <cfqueryparam value="#LOCAL.qPrograms.ProgramID#" cfsqltype="cf_sql_integer">
				ORDER BY DateAdded DESC
			</cfquery>
			<cfset program.StatusList = ValueList(LOCAL.qProgramStatus.Status)>

			<cfset ArrayAppend(LOCAL.PROGRAMS, program)>
		</cfoutput>

		<cfreturn LOCAL.PROGRAMS>
	</cffunction>	

<!--- Get All Program Details --->
	<cffunction name="getAllPrograms" access="public" returntype="array" returnformat="JSON"
		hint="Returns an array of program objects by year (defaults to current year). Ones that require attention show up first.">
		<cfargument name="Year" type="numeric" default="#YEAR(NOW())#">

		<!--- Get the program data but make sure the user has access to it --->
		<cfquery name="LOCAL.qPrograms">
			SELECT 	ProgramID, ProgramName, ProgramStatement, PrimaryContactName, PrimaryPhone, PrimaryEmail, ProgramAddress, ProgramMailingAddress, Status, a.Name
			FROM 	Program_vw p 
			INNER JOIN Agency_tbl a on p.AgencyID = a.AgencyID
			WHERE	Year(p.DateAdded) = <cfqueryparam value="#ARGUMENTS.Year#" cfsqltype="cf_sql_integer">
			ORDER BY p.AgencyID, p.ProgramName
		</cfquery>

		<cfset LOCAL.PROGRAMS = ArrayNew(1)>
		<cfoutput query="LOCAL.qPrograms">
			<cfset LOCAL.program = StructNew()>
			<cfset LOCAL.program.ProgramID = LOCAL.qPrograms.ProgramID>
			<cfset LOCAL.program.ProgramName = LOCAL.qPrograms.ProgramName>
			<cfset LOCAL.program.ProgramStatement = LOCAL.qPrograms.ProgramStatement>
			<cfset LOCAL.program.PrimaryContactName = LOCAL.qPrograms.PrimaryContactName>
			<cfset LOCAL.program.PrimaryPhone = LOCAL.qPrograms.PrimaryPhone>
			<cfset LOCAL.program.PrimaryEmail = LOCAL.qPrograms.PrimaryEmail>
			<cfset LOCAL.program.ProgramAddress = LOCAL.qPrograms.ProgramAddress>
			<cfset LOCAL.program.ProgramMailingAddress = LOCAL.qPrograms.ProgramMailingAddress>
			<cfset LOCAL.program.Agency = LOCAL.qPrograms.Name>
			<cfset LOCAL.program.CurrentStatus = LOCAL.qPrograms.Status>			

			<cfquery name="LOCAL.qProgramStatus">
				SELECT 	s.Status, ps.DateAdded, ps.AccountID, a.Name
				FROM 	ProgramStatus_tbl ps
				INNER JOIN Status_tbl s ON ps.StatusID = s.StatusID
				INNER JOIN Account_tbl a ON a.AccountID = ps.AccountID
				WHERE 	ProgramID = <cfqueryparam value="#LOCAL.qPrograms.ProgramID#" cfsqltype="cf_sql_integer">
				ORDER BY DateAdded DESC
			</cfquery>
			<cfset LOCAL.program.StatusList = ArrayNew(1)>

			<cfloop query="LOCAL.qProgramStatus">
				<cfset LOCAL.status = StructNew()>
				<cfset LOCAL.status.Status = LOCAL.qProgramStatus.Status>
				<cfset LOCAL.status.DateAdded = LOCAL.qProgramStatus.DateAdded> 
				<cfset LOCAL.status.AccountID = LOCAL.qProgramStatus.AccountID> 
				<cfset LOCAL.status.Name = LOCAL.qProgramStatus.Name>

				<cfset ArrayAppend(LOCAL.program.StatusList, LOCAL.status)>
			</cfloop>

			<cfset ArrayAppend(LOCAL.PROGRAMS, LOCAL.program)>
		</cfoutput>

		<cfreturn LOCAL.PROGRAMS>
	</cffunction>	

<!--- Get any programs that need to be approved --->
	<cffunction name="getProgramAlerts" access="public" returntype="Array" returnformat="JSON"
		hint="Gets any programs that need to be reviewed for approval">

		<cfset LOCAL.response = ArrayNew(1)>

		<cfquery name="LOCAL.qPrograms">
			SELECT 	ProgramID, ProgramName, Status 
			FROM 	Program_vw
			WHERE 	Status IN ('LOI - Submitted to Airdrie', 'APPLICATION - Submitted to Airdrie')
			ORDER BY DateUpdated DESC
		</cfquery>

		<cfoutput query="LOCAL.qPrograms">
			<cfset LOCAL.program = StructNew()>
			<cfset LOCAL.program.ProgramID = LOCAL.qPrograms.ProgramID> 
			<cfset LOCAL.program.ProgramName = LOCAL.qPrograms.ProgramName>
			<cfset LOCAL.program.Status = LOCAL.qPrograms.Status>

			<cfset ArrayAppend(LOCAL.response, LOCAL.program)>
		</cfoutput>

		<cfreturn LOCAL.response>
	</cffunction>	

<!--- Marks an LOI or Application ready for review (NOT SUBMITTED TO AIRDRIE) --->
	<cffunction name="markApplicationForReview" access="public" returnformat="JSON" returntype="boolean"
		hint="Marks an LOI or Application ready for review (NOT SUBMITTED TO AIRDRIE)">
		<cfargument name="ProgramID" type="numeric" required="true">

			<!--- Get the Status List for the program --->
			<cfquery name="LOCAL.qCheck">
				SELECT 	Status 
				FROM ProgramStatus_tbl ps
				INNER JOIN Status_tbl s ON s.StatusID = ps.StatusID
				WHERE 	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfset LOCAL.StatusList = ValueList(LOCAL.qCheck.Status)>

			<cfif ListFindNoCase(LOCAL.StatusList, "LOI - Saved for Review") IS 0>
				<!--- This is a Letter of Intent --->
				<cfset LOCAL.Status = "LOI - Saved for Review">
			<cfelseif ListFindNoCase(LOCAL.StatusList, "Application - Saved for Review") IS 0 AND ListFindNoCase(LOCAL.StatusList, "LOI - Approved") GT 0>
				<!--- This is an Application --->
				<cfset LOCAL.Status = "Application - Saved for Review">
			<cfelse>
				<!--- This Program has already been saved for review --->
				<cfreturn true>
			</cfif>

			<!--- Insert the Status record --->
			<cfquery>
				INSERT INTO ProgramStatus_tbl
				( ProgramID, StatusID, AccountID )
				VALUES 
				(
					<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
					(SELECT StatusID FROM Status_tbl WHERE Status = <cfqueryparam value="#LOCAL.Status#" cfsqltype="cf_sql_varchar">),
					<cfqueryparam value="#REQUEST.USER.ACCOUNTID#" cfsqltype="cf_sql_integer">
				)
			</cfquery>

		<cfreturn true>
	</cffunction>

<!--- Submits an LOI or Application to the City of Airdrie --->
	<cffunction name="markApplicationSubmitted" access="public" returnformat="JSON" returntype="boolean"
		hint="Submits an LOI or Application to the City of Airdrie">
		<cfargument name="ProgramID" type="numeric" required="true">

			<!--- Get the Status List for the program --->
			<cfquery name="LOCAL.qCheck">
				SELECT 	Status 
				FROM ProgramStatus_tbl ps
				INNER JOIN Status_tbl s ON s.StatusID = ps.StatusID
				WHERE 	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfset LOCAL.StatusList = ValueList(LOCAL.qCheck.Status)>

			<cfif ListFindNoCase(LOCAL.StatusList, "LOI - Submitted to Airdrie") IS 0>
				<!--- This is a Letter of Intent --->
				<cfset LOCAL.Status = "LOI - Submitted to Airdrie">
				<cfset LOCAL.Type = "Letter of Intent">
			<cfelseif ListFindNoCase(LOCAL.StatusList, "APPLICATION - Submitted to Airdrie") IS 0 AND ListFindNoCase(LOCAL.StatusList, "LOI - Approved") GT 0>
				<!--- This is an Application --->
				<cfset LOCAL.Status = "APPLICATION - Submitted to Airdrie">
				<cfset LOCAL.Type = "Application">
			<cfelse>
				<!--- This Program has already been submitted --->
				<cfreturn true>
			</cfif>

			<!--- Insert the Status record --->
			<cfquery>
				INSERT INTO ProgramStatus_tbl
				( ProgramID, StatusID, AccountID )
				VALUES 
				(
					<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
					(SELECT StatusID FROM Status_tbl WHERE Status = <cfqueryparam value="#LOCAL.Status#" cfsqltype="cf_sql_varchar">),
					<cfqueryparam value="#REQUEST.USER.ACCOUNTID#" cfsqltype="cf_sql_integer">
				)
			</cfquery>

			<!--- TODO - update this to send the email to internal staff, administration email and update the program on the program page--->
			<cfif isDefined('LOCAL.Type') IS true AND APPLICATION.environment IS "development">
				<cfif LOCAL.Type IS "Application">
					<cfset LOCAL.Link = "#APPLICATION.url#helpers/testApprove.cfm?ProgramID=#ARGUMENTS.ProgramID#&Type=A">
				<cfelse>
					<cfset LOCAL.Link = "#APPLICATION.url#helpers/testApprove.cfm?ProgramID=#ARGUMENTS.ProgramID#&Type=L">
				</cfif>

				<cfmail to="#REQUEST.USER.Email#"
						from="#APPLICATION.fromemail#"
						subject="#APPLICATION.NAME# - Test approve submitted #LOCAL.Type#"
						type="html">
					<p>Your submitted #LOCAL.Type# is ready to be <a href="#LOCAL.Link#">approved</a><
				</cfmail>
			</cfif>

		<cfreturn true>
	</cffunction>	
</cfcomponent>