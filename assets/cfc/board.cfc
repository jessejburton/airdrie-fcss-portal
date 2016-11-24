<cfcomponent displayname="Board" extends="Core" hint="Functions relating to an Agency's Board Members">
<!--- GET --->
	<cffunction name="GetBoardMembersByAgencyID" returnformat="JSON" returntype="Array"
		hint="Get all of the board members for an Agency.">
		<cfargument name="AgencyID" type="numeric" required="true">

		<cfquery name="LOCAL.qMembers">
			SELECT	board.BoardMemberID, board.AgencyID, board.Name, board.Title, agency.Name AS Agency
			FROM	BoardMembers_tbl board
			INNER JOIN Agency_tbl agency ON agency.AgencyID = board.AgencyID
			WHERE	board.AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			ORDER BY board.Name
		</cfquery>

		<cfset LOCAL.Members = ArrayNew(1)>
		<cfoutput query="LOCAL.qMembers">
			<cfset LOCAL.Member = StructNew()>
			<cfset LOCAL.Member.ID = LOCAL.qMembers.BoardMemberID>
			<cfset LOCAL.Member.Name = LOCAL.qMembers.Name>
			<cfset LOCAL.Member.Title = LOCAL.qMembers.Title>
			<cfset LOCAL.Member.Agency = StructNew()>
			<cfset LOCAL.Member.Agency.ID = LOCAL.qMembers.AgencyID>
			<cfset LOCAL.Member.Agency.Name = LOCAL.qMembers.Agency>

			<cfset ArrayAppend(LOCAL.Members, LOCAL.Member)>
		</cfoutput>


		<cfreturn LOCAL.Members>
	</cffunction>	

<!--- INSERT --->
	<cffunction name="updateBoardMembers" returnformat="JSON" returntype="Array" access="public"
		hint="Update the board members, replaces existing board members with the passed in array. Assumes any not passed in are no longer needed.">
		<cfargument name="BoardMembers" type="Array" required="true" hint="An array of members, name and title">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.Agency.AgencyID#">

		<cftransaction>
			<cfquery>
				DELETE FROM BoardMembers_tbl
				WHERE AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfloop array="#ARGUMENTS.BoardMembers#" index="LOCAL.Member">
				<cfquery result="LOCAL.qMember">
					INSERT INTO BoardMembers_tbl
					(
						Name, Title, AgencyID, AccountID
					) VALUES (
						<cfqueryparam value="#LOCAL.Member.Name#" cfsqltype="varchar">,
						<cfqueryparam value="#LOCAL.Member.Title#" cfsqltype="varchar">,
						<cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#REQUEST.USER.AccountID#" cfsqltype="cf_sql_integer">
					)
				</cfquery>
			</cfloop>
		</cftransaction>

		<!--- Update the request scope and send the new array back --->
		<cfset REQUEST.AGENCY.BOARDMEMBERS = GetBoardMembersByAgencyID(ARGUMENTS.AgencyID)>
		<cfreturn REQUEST.AGENCY.BOARDMEMBERS>
	</cffunction>

<!--- UPDATE --->
	<cffunction name="Update" returnformat="JSON" returntype="Struct"
		hint="Update a board member">
		<cfargument name="BoardMemberID" type="numeric" required="true">
		<cfargument name="Name" type="string" required="true">
		<cfargument name="Title" type="string" required="true">

		<cfquery result="LOCAL.qMember">
			UPDATE BoardMembers_tbl
			SET Name = <cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="varchar">,
				Title = <cfqueryparam value="#ARGUMENTS.Title#" cfsqltype="varchar">
			WHERE BoardMemberID = <cfqueryparam value="#ARGUMENTS.BoardMemberID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn GetBoardMemberByID(LOCAL.qMember.BoardMemberID)>		
	</cffunction>

<!--- DELETE --->
	<cffunction name="Delete" returnformat="JSON" returntype="Boolean"
		hint="Delete a board member">
		<cfargument name="BoardMemberID" type="numeric" required="true">

		<cfquery result="LOCAL.qMember">
			DELETE FROM BoardMembers_tbl
			WHERE BoardMemberID = <cfqueryparam value="#ARGUMENTS.BoardMemberID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn true>
	</cffunction>

</cfcomponent>