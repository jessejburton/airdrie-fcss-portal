<cfcomponent displayname="Settings" extends="Core" hint="Functions relating to the core application settings">
	<cffunction name="getSettings" access="public" returntype="struct" returnformat="JSON"
		hint="Returns an array with all of the settings names and values">

		<cfquery name="LOCAL.qSettings">
			SELECT	[MaxCharacterLength],[isEnabledLetterOfIntent],[isEnabledApplications],[SupportNumber],[AdminEmail],[SuperPassword]
			FROM	Settings_tbl
		</cfquery>

		<cfset LOCAL.response = StructNew()>
		<cfoutput>
			<cfloop list="#LOCAL.qSettings.ColumnList#" index="LOCAL.column">
				<cfset LOCAL.response[LOCAL.column] = LOCAL.qSettings[LOCAL.column]>
			</cfloop>
		</cfoutput>

		<cfreturn LOCAL.response>
	</cffunction>

</cfcomponent>
