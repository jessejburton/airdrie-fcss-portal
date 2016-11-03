<cfcomponent displayname="Security" extends="Core">

	<cffunction name="checkLogin" returntype="struct" returnformat="JSON" access="remote">
		<cfargument name="email" type="string" required="true">
		<cfargument name="password" type="string" required="true">

		<!--- Log User In --->
		<cfset SESSION.USER = StructNew()>
		<cfset SESSION.USER.EMAIL = ARGUMENTS.email>
		<cfset SESSION.NEWAGENCY = true>
		<cfset SESSION.LOGGEDIN = true>

		<cfreturn getSuccessResponse("Success")>
	</cffunction>

	<cffunction name="hashPassword" returntype="string" returnformat="JSON">
		<cfargument name="unHashedPassword" type="string" required="true">

		
	</cffunction>
</cfcomponent>