<cfcomponent displayname="Security" extends="Core">
	<cffunction name="checkLogin" returntype="struct" returnformat="JSON">
		<cfargument name="SurveyID" type="numeric" required="true">

		<cfset LOCAL.Survey = StructNew()>
		<cfset LOCAL.Survey.SurveyID = 1>
		<cfset LOCAL.Survey.SurveyName = "Test Survey">
	</cffunction>

	<cffunction name="hashPassword" returntype="string" returnformat="JSON">
		<cfargument name="unHashedPassword" type="string" required="true">

		
	</cffunction>
</cfcomponent>