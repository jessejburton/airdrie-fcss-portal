<cfcomponent displayname="content" hint="Handle content for the portal">
	<cffunction name="getContent" access="public" returntype="void" output="true"
		hint="Display content based on the content type passed in.">
		<cfargument name="ContentType" type="string" required="true">

		<cfquery name="LOCAL.qContent">
			SELECT	Content
			FROM 	Content_tbl
			WHERE 	ContentType = <cfqueryparam value="#ARGUMENTS.ContentType#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfoutput>#LOCAL.qContent.Content#</cfoutput>
	</cffunction>
</cfcomponent>