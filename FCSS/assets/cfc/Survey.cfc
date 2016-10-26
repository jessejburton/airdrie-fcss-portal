<cfcomponent displayname="Survey" extends="Core">
	<cffunction name="Get" returntype="struct" returnformat="JSON">
		<cfargument name="SurveyID" type="numeric" required="yes">

		<cfset LOCAL.Survey = StructNew()>
		<cfset LOCAL.Survey.SurveyID = 1>
		<cfset LOCAL.Survey.SurveyName = "Test Survey">
	</cffunction>
</cfcomponent>