<cfcomponent displayname="core">

<!--- Return an error message --->
	<cffunction name="getErrorResponse" returntype="Struct" access="public">
		<cfargument name="message" type="string" required="true">
	
		<cfset LOCAL.response = StructNew()>
		<cfset LOCAL.response.SUCCESS = false>
		<cfset LOCAL.response.TYPE = "error">
		<cfset LOCAL.response.MESSAGE = ARGUMENTS.MESSAGE>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- Return a success message --->
	<cffunction name="getSuccessResponse" returntype="Struct" access="public">
		<cfargument name="message" type="string" required="true">
	
		<cfset LOCAL.response = StructNew()>
		<cfset LOCAL.response.SUCCESS = true>
		<cfset LOCAL.response.TYPE = "success">
		<cfset LOCAL.response.MESSAGE = ARGUMENTS.MESSAGE>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- Return an info message --->
	<cffunction name="getInfoResponse" returntype="Struct" access="public">
		<cfargument name="message" type="string" required="true">
	
		<cfset LOCAL.response = StructNew()>
		<cfset LOCAL.response.SUCCESS = true>
		<cfset LOCAL.response.TYPE = "info">
		<cfset LOCAL.response.MESSAGE = ARGUMENTS.MESSAGE>

		<cfreturn LOCAL.response>
	</cffunction>	

</cfcomponent>