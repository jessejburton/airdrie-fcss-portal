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

<!--- Send Error Email --->
	<cffunction name="sendErrorEmail" access="public">
		<cfargument name="error" type="any" required="true">
		<cfargument name="subject" type="string" default="Error message from #APPLICATION.Name# (#APPLICATION.environment#)">

		<cfmail to="#APPLICATION.adminemail#"
				from="#APPLICATION.fromemail#"
				type="html"
				subject="#ARGUMENTS.subject#">
			<cfdump var="#ARGUMENTS#">
		</cfmail>
	</cffunction>	

<!--- Hash a String --->
	<cffunction name="hashString" returntype="string" returnformat="JSON" access="public"
		hint="takes in a string and returns it hashed using SHA-256 encryption.">
		<cfargument name="String" type="string" required="true">

		<cfreturn HASH(ARGUMENTS.String, "SHA-256", "UTF-8")>
	</cffunction>

<!--- Encrypt using BCrypt --->
	<cffunction name="hashPassword" returntype="string" returnformat="JSON" access="public"
		hint="Encrypts a password using BCrypt encryption">
		<cfargument name="plainPW" type="string" required="true" hint="The password to be hashed">

		<!--- Can increase the salt value (currently 12) to increase the complexity of the passwords over time --->
		<cfreturn APPLICATION.BCrypt.hashpw(ARGUMENTS.plainPW, APPLICATION.BCrypt.genSalt(12))>
	</cffunction>

<!--- Encrypt using BCrypt --->
	<cffunction name="validatePassword" returntype="boolean" returnformat="JSON" access="public"
		hint="Validate a password against the BCrypt hash">
		<cfargument name="plainPW" type="string" required="true" hint="The password to be hashed">
		<cfargument name="hashedPW" type="string" required="true" hint="The has to validate against">

		<!--- Can increase the salt value (currently 12) to increase the complexity of the passwords over time --->
		<cfreturn APPLICATION.BCrypt.checkpw(ARGUMENTS.plainPW, ARGUMENTS.hashedPW)>
	</cffunction>
</cfcomponent>