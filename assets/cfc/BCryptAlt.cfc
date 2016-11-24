<cfcomponent displayname="BCrypt Alternative" hint="Used when the BCrypt Library is unavailable">
	<cfset this.SALT = "FCSSPortal2016">

	<cffunction name="hashpw" access="public" returntype="string" returnformat="JSON"
		hint="Returns a hash of the password">
		<cfargument name="plainpw" type="string" required="true">
		<cfargument name="salt" type="string" required="true">

		<cfset LOCAL.hashedPW = ARGUMENTS.salt & ARGUMENTS.plainpw>

		<cfreturn HASH(LOCAL.hashedPW, "SHA-256", "UTF-8")>
	</cffunction>

	<cffunction name="genSalt" access="public" returntype="string" returnformat="JSON"
		hint="Returns the salt">
		<cfargument name="strength" type="numeric" required="true">

		<!--- Not using the strength in the alternative --->
		<cfreturn this.SALT>
	</cffunction>	

	<cffunction name="checkpw" access="public" returntype="boolean" returnformat="JSON"
		hint="Checks to see if the passwords match">
		<cfargument name="plainpw" type="string" required="true">
		<cfargument name="hashedpw" type="string" required="true">

		<cfreturn ARGUMENTS.hashedpw IS hashpw(plainpw, genSalt(12))>
	</cffunction>
</cfcomponent>