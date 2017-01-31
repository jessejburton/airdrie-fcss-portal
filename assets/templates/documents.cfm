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

		<cfinvoke component="#APPLICATION.cfcpath#document" method="getDocumentsByAgencyID" AgencyID="#qGetAgencyID.AgencyID#" returnvariable="Documents" />

		<h1>Documents</h1>

		<ul>
			<cfoutput>
				<cfloop array="#Documents#" index="document">
					<li><strong>#XMLFormat(document.DOCUMENTTYPE)#</strong> <i class="small-text">(#XMLFormat(document.FILENAME)#)</i></li>
				</cfloop>
			</cfoutput>
		</ul>
	</cfif>
</cfif>