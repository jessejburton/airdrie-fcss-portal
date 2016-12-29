<cfcomponent displayname="Resources" extends="core">
	<cffunction name="getResources" access="public" returnformat="JSON" returntype="Struct"
		hint="Returns a structure with two arrays, one for internal and one for external resources"> 
		<cfargument name="Internal" type="boolean" required="true">

		<cfset LOCAL.response = StructNew()>

		<cfquery name="LOCAL.qResources">
			SELECT 	[ResourceID], [ResourceType], [Title], [URL], [DocumentID], [DateAdded], [AccountID]
			FROM 	Resource_tbl
			<cfif NOT ARGUMENTS.Internal>
				WHERE	ResourceType = 'A' -- Agency only
			</cfif>
			ORDER BY [isOrder]
		</cfquery>

		<cfset LOCAL.response.AGENCY 	= ArrayNew(1)>
		<cfset LOCAL.response.INTERNAL 	= ArrayNew(1)>

		<cfoutput query="LOCAL.qResources">
			<cfset LOCAL.resource = StructNew()>
			<cfset LOCAL.resource.ResourceID = LOCAL.qResources.ResourceID>
			<cfset LOCAL.resource.Title = LOCAL.qResources.Title>
			<cfset LOCAL.resource.URL = LOCAL.qResources.URL>
			<cfset LOCAL.resource.DocumentID = LOCAL.qResources.DocumentID>

			<cfif LOCAL.qResources.ResourceType IS "A">
				<cfset ArrayAppend(LOCAL.response.AGENCY, LOCAL.resource)>
			<cfelseif LOCAL.qResources.ResourceType IS "I">
				<cfset ArrayAppend(LOCAL.response.INTERNAL, LOCAL.resource)>
			</cfif>
		</cfoutput>

		<cfreturn LOCAL.response>
	</cffunction>

</cfcomponent> 