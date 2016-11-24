<cfcomponent displayname="Testing" extends="core">
	<cffunction name="setAgency" returnformat="JSON" returntype="Struct" access="remote">
		<cfargument name="Name" type="string" default="">
		<cfargument name="Vision" type="string" default="">
		<cfargument name="Mission" type="string" default="">
		<cfargument name="Phone" type="string" default="">
		<cfargument name="Email" type="string" default="">
		<cfargument name="Fax" type="string" default="">
		<cfargument name="Website" type="string" default="">
		<cfargument name="Address" type="string" default="">
		<cfargument name="MailingAddress" type="string" default="">
		<cfargument name="PrimaryContactNameFirst" type="string" default="">
		<cfargument name="PrimaryContactNameLast" type="string" default="">
		<cfargument name="PrimaryContactPhone" type="string" default="">
		<cfargument name="PrimaryContactEmail" type="string" default="">

		<cfset LOCAL.Agency.AgencyID = 1>
		<cfset LOCAL.Agency.Name = ARGUMENTS.Name>
		<cfset LOCAL.Agency.Vision = ARGUMENTS.Vision>
		<cfset LOCAL.Agency.Mission = ARGUMENTS.Mission>
		<cfset LOCAL.Agency.Phone = ARGUMENTS.Phone>
		<cfset LOCAL.Agency.Email = ARGUMENTS.Email>
		<cfset LOCAL.Agency.Fax = ARGUMENTS.Fax>
		<cfset LOCAL.Agency.Website = ARGUMENTS.Website>
		<cfset LOCAL.Agency.Address = ARGUMENTS.Address>
		<cfset LOCAL.Agency.MailingAddress = ARGUMENTS.MailingAddress>

		<cfset LOCAL.Agency.PrimaryContact = StructNew()>
		<cfset LOCAL.Agency.PrimaryContact.NameFirst = ARGUMENTS.PrimaryContactNameFirst>
		<cfset LOCAL.Agency.PrimaryContact.NameLast = ARGUMENTS.PrimaryContactNameLast>
		<cfset LOCAL.Agency.PrimaryContact.Phone = ARGUMENTS.PrimaryContactPhone>
		<cfset LOCAL.Agency.PrimaryContact.Email = ARGUMENTS.PrimaryContactEmail>

		<cfset SESSION.Agency = LOCAL.Agency>
		<cfreturn SESSION.Agency>
	</cffunction>	

	<cffunction name="saveAgencyInformation" returnformat="JSON" returntype="Struct" access="remote">
		<cfargument name="Name" type="string" default="">
		<cfargument name="Vision" type="string" default="">
		<cfargument name="Mission" type="string" default="">

		<cfset SESSION.Agency.Name = ARGUMENTS.Name>
		<cfset SESSION.Agency.Vision = ARGUMENTS.Vision>
		<cfset SESSION.Agency.Mission = ARGUMENTS.Mission>

		<cfreturn getSuccessResponse("Agency information has been updated.")>
	</cffunction>	

	<cffunction name="saveAgencyContact" returnformat="JSON" returntype="Struct" access="remote">
		<cfargument name="Phone" type="string" default="">
		<cfargument name="Email" type="string" default="">
		<cfargument name="Fax" type="string" default="">
		<cfargument name="Website" type="string" default="">
		<cfargument name="Address" type="string" default="">
		<cfargument name="MailingAddress" type="string" default="">
		<cfargument name="PrimaryContactNameFirst" type="string" default="">
		<cfargument name="PrimaryContactNameLast" type="string" default="">
		<cfargument name="PrimaryContactPhone" type="string" default="">
		<cfargument name="PrimaryContactEmail" type="string" default="">

		<cfset SESSION.Agency.Phone = ARGUMENTS.Phone>
		<cfset SESSION.Agency.Email = ARGUMENTS.Email>
		<cfset SESSION.Agency.Fax = ARGUMENTS.Fax>
		<cfset SESSION.Agency.Website = ARGUMENTS.Website>
		<cfset SESSION.Agency.Address = ARGUMENTS.Address>
		<cfset SESSION.Agency.MailingAddress = ARGUMENTS.MailingAddress>

		<cfset SESSION.Agency.PrimaryContact = StructNew()>
		<cfset SESSION.Agency.PrimaryContact.NameFirst = ARGUMENTS.PrimaryContactNameFirst>
		<cfset SESSION.Agency.PrimaryContact.NameLast = ARGUMENTS.PrimaryContactNameLast>
		<cfset SESSION.Agency.PrimaryContact.Phone = ARGUMENTS.PrimaryContactPhone>
		<cfset SESSION.Agency.PrimaryContact.Email = ARGUMENTS.PrimaryContactEmail>

		<cfreturn getSuccessResponse("Agency contact information has been updated.")>
	</cffunction>

	<cffunction name="allocateFunds" returnformat="JSON" returntype="boolean" access="remote">
		<cfset SESSION.Applications[1].Allocated = 5000>
		<cfreturn true>
	</cffunction>

	<cffunction name="midYear" returnformat="JSON" returntype="boolean" access="remote">
		<cfset SESSION.Applications[1].MidYear = true>
		<cfreturn true>
	</cffunction>

	<cffunction name="endYear" returnformat="JSON" returntype="boolean" access="remote">
		<cfset SESSION.Applications[1].EndYear = true>
		<cfreturn true>
	</cffunction>
</cfcomponent>