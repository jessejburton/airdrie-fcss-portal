<cfcomponent displayname="Template" extends="core">
	<cffunction name="getTemplates" returnformat="JSON" returntype="Array" access="public"
		hint="Returns a list of saved templates.">

		<cfquery name="LOCAL.qTemplates">
			SELECT	TemplateID, Name, Template
			FROM	Template_tbl
			WHERE isActive = 1
		</cfquery>

		<cfset LOCAL.response = ArrayNew(1)>

		<cfoutput query="LOCAL.qTemplates">
			<cfset LOCAL.Template = StructNew()>
			<cfset LOCAL.Template.TemplateID = LOCAL.qTemplates.TemplateID>
			<cfset LOCAL.Template.Name = LOCAL.qTemplates.Name>
			<cfset LOCAL.Template.Template = LOCAL.qTemplates.Template>

			<cfset ArrayAppend(LOCAL.response, LOCAL.Template)>
		</cfoutput>

		<cfreturn LOCAL.response>

	</cffunction>
</cfcomponent>