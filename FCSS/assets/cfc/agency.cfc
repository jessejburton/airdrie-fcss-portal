<cfcomponent displayname="Agency" extends="Core">
<!--- GET --->
	<cffunction name="Get" returnformat="JSON" returntype="Struct">
		<cfargument name="AgencyID" type="numeric" required="yes">

		<cfset LOCAL.Agency = StructNew()>

		<cfquery name="LOCAL.qAgency">
			SELECT	Name, Vision, Mission, Phone, Email, Fax, Website, Address, MailingAddress, isApproved
			FROM	Agency_tbl
			WHERE	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="integer"> 
		</cfquery>

		<cfset LOCAL.Agency.AgencyID = ARGUMENTS.AgencyID>
		<cfset LOCAL.Agency.Name = LOCAL.qAgency.Name>
		<cfset LOCAL.Agency.Vision = LOCAL.qAgency.Vision>
		<cfset LOCAL.Agency.Mission = LOCAL.qAgency.Mission>
		<cfset LOCAL.Agency.Phone = LOCAL.qAgency.Phone>
		<cfset LOCAL.Agency.Email = LOCAL.qAgency.Email>
		<cfset LOCAL.Agency.Fax = LOCAL.qAgency.Fax>
		<cfset LOCAL.Agency.Website = LOCAL.qAgency.Website>
		<cfset LOCAL.Agency.Address = LOCAL.qAgency.Address>
		<cfset LOCAL.Agency.MailingAddress = LOCAL.qAgency.MailingAddress>
		<cfset LOCAL.Agency.isApproved = LOCAL.qAgency.isApproved>

		<cfreturn LOCAL.Agency>
	</cffunction>	

<!--- INSERT --->
	<cffunction name="Add" returnformat="JSON" returntype="Struct">
		<cfargument name="Name" type="string" required="yes">
		<cfargument name="Vision" type="string" default="">
		<cfargument name="Mission" type="string" default="">
		<cfargument name="Phone" type="string" default="">
		<cfargument name="Email" type="string" default="">
		<cfargument name="Fax" type="string" default="">
		<cfargument name="Website" type="string" default="">
		<cfargument name="Address" type="string" default="">
		<cfargument name="MailingAddress" type="string" default="">

		<cfset LOCAL.Agency = ARGUMENTS>

		<cfquery result="qAgency">
			INSERT INTO Agency_tbl
			(
				Name, Vision, Mission, Phone, Email, Fax, Website, Address, MailingAddress
			) VALUES (
				<cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.Vision#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.Mission#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.Phone#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.Email#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.Fax#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.Website#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.Address#" cfsqltype="varchar" />,
				<cfqueryparam value="#ARGUMENTS.MailingAddress#" cfsqltype="varchar" />
			)
		</cfquery>

		<cfset LOCAL.Agency.AgencyID = qAgency.GeneratedKey>

		<cfreturn LOCAL.Agency>
	</cffunction>

<!--- UPDATE --->
	<cffunction name="Update" returnformat="JSON" returntype="Struct">
		<cfargument name="AgencyID" type="numeric" required="yes">
		<cfargument name="Name" type="string" required="yes">
		<cfargument name="Vision" type="string" default="">
		<cfargument name="Mission" type="string" default="">
		<cfargument name="Phone" type="string" default="">
		<cfargument name="Email" type="string" default="">
		<cfargument name="Fax" type="string" default="">
		<cfargument name="Website" type="string" default="">
		<cfargument name="Address" type="string" default="">
		<cfargument name="MailingAddress" type="string" default="">

		<cfset LOCAL.Agency = ARGUMENTS>

		<cfquery result="qAgency">
			UPDATE Agency_tbl
				SET Name = <cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="varchar" />,
					Vision = <cfqueryparam value="#ARGUMENTS.Vision#" cfsqltype="varchar" />,
					Mission = <cfqueryparam value="#ARGUMENTS.Mission#" cfsqltype="varchar" />,
					Phone = <cfqueryparam value="#ARGUMENTS.Phone#" cfsqltype="varchar" />,
					Email = <cfqueryparam value="#ARGUMENTS.Email#" cfsqltype="varchar" />,
					Fax = <cfqueryparam value="#ARGUMENTS.Fax#" cfsqltype="varchar" />,
					Website = <cfqueryparam value="#ARGUMENTS.Website#" cfsqltype="varchar" />,
					Address = <cfqueryparam value="#ARGUMENTS.Address#" cfsqltype="varchar" />,
					MailingAddress = <cfqueryparam value="#ARGUMENTS.MailingAddress#" cfsqltype="varchar" />
			WHERE	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="integer">
		</cfquery>

		<cfreturn LOCAL.Agency>
	</cffunction>

<!--- DELETE --->
	<cffunction name="Delete" returntype="JSON" returntype="Struct">
		<cfargument name="AgencyID" type="numeric" required="yes">

		<cfset LOCAL.Agency = Get(ARGUMENTS.AgencyID)>

		<cfquery result="qAgency">
			UPDATE Agency_tbl
		</cfquery>
	</cffunction>
</cfcomponent>