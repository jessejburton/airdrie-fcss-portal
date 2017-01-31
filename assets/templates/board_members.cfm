<cfif StructKeyExists(FORM, "ProgramID")>
	<cfset ATTRIBUTES.ProgramID = FORM.ProgramID>
</cfif>

<!--- Get the Agency ID for the specific program --->
<cfif StructKeyExists(ATTRIBUTES, "ProgramID")>
	<!--- Check Permission --->
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkProgramAccessByAccountID" programID="#ATTRIBUTES.ProgramID#" returnvariable="userHasAccess" />
	
	<cfif userHasAccess>
		<cfquery name="qGetAgencyID">
			SELECT AgencyID FROM Program_vw
			WHERE 	ProgramID = <cfqueryparam value="#ATTRIBUTES.ProgramID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfinvoke component="#APPLICATION.cfcpath#board" method="GetBoardMembersByAgencyID" AgencyID="#qGetAgencyID.AgencyID#" returnvariable="Board" />

		<h1>Board Members</h1>

		<ul>
			<cfoutput>
				<cfloop array="#Board#" index="member">
					<li><strong>#XMLFormat(member.NAME)#</strong> <i>~ #XMLFormat(member.TITLE)#</i></li>
				</cfloop>
			</cfoutput>
		</ul>
	</cfif>
</cfif>