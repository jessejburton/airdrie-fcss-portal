<cfcomponent displayname="Agency" extends="Core">
<!--- GET --->
	<cffunction name="GetAgencyByID" returnformat="JSON" returntype="Struct">
		<cfargument name="AgencyID" type="numeric" required="yes">		

		<cfif AgencyID GT 0>
			<cfquery name="LOCAL.qAgency">
				SELECT	Name, Vision, Mission, Phone, Email, Fax, Website, Address, MailingAddress, hasDocuments, Programs
				FROM	Agency_vw a
				WHERE	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="integer"> 
			</cfquery>

			<cfset LOCAL.Agency = StructNew()>
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
			<cfset LOCAL.Agency.Programs = LOCAL.qAgency.Programs>
			<cfset LOCAL.Agency.isNew = LOCAL.qAgency.Programs IS 0>
			<cfset LOCAL.Agency.hasDocuments = LOCAL.qAgency.hasDocuments>
			<cfinvoke component="board" method="GetBoardMembersByAgencyID" AgencyID="#ARGUMENTS.AgencyID#" returnvariable="LOCAL.Agency.BOARDMEMBERS" />
			<cfinvoke component="document" method="getDocumentsByAgencyID" AgencyID="#ARGUMENTS.AgencyID#" returnvariable="LOCAL.Agency.DOCUMENTS" />
		<cfelse>
			<cfset LOCAL.Agency = StructNew()>
			<cfset LOCAL.Agency.ADMIN = true>
			<cfset LOCAL.Agency.isNew = false>
		</cfif>

		<cfreturn LOCAL.Agency>
	</cffunction>	

<!--- INSERT --->
	<cffunction name="Insert" returnformat="JSON" returntype="Struct">
		<cfargument name="Name" type="string" required="yes">
		<cfargument name="Vision" type="string" default="">
		<cfargument name="Mission" type="string" default="">
		<cfargument name="Phone" type="string" default="">
		<cfargument name="Email" type="string" default="">
		<cfargument name="Fax" type="string" default="">
		<cfargument name="Website" type="string" default="">
		<cfargument name="Address" type="string" default="">
		<cfargument name="MailingAddress" type="string" default="">
		<cfargument name="AccountEmail" type="string" required="false" hint="Used to check to see if an email account is already registered with another agency.">

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
	<cffunction name="Delete" returnformat="JSON" returntype="Boolean">
		<cfargument name="AgencyID" type="numeric" required="yes">

		<cfquery>
			UPDATE Agency_tbl
			SET isActive = 0
			WHERE	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn true>
	</cffunction>

<!--- Get Agency Details --->
	<cffunction name="GetAgencyDetails" returnformat="JSON" returntype="Array"
		hint="Returns an array of Agency objects with details.">		

		<cfquery name="LOCAL.qAgencies">
			SELECT	AgencyID, Address, DateAdded, Email, Fax, isActive, MailingAddress, Mission, Vision, Name, Phone, Website
			FROM	Agency_tbl
		</cfquery>

		<cfset LOCAL.response = ArrayNew(1)>

		<cfoutput query="LOCAL.qAgencies">
			<cfset LOCAL.Agency = StructNew()>
			<cfset LOCAL.Agency.AgencyID = LOCAL.qAgencies.AgencyID>
			<cfset LOCAL.Agency.Address = LOCAL.qAgencies.Address>
			<cfset LOCAL.Agency.DateAdded = LOCAL.qAgencies.DateAdded>
			<cfset LOCAL.Agency.Email = LOCAL.qAgencies.Email>
			<cfset LOCAL.Agency.Fax = LOCAL.qAgencies.Fax>
			<cfset LOCAL.Agency.isActive = LOCAL.qAgencies.isActive>
			<cfset LOCAL.Agency.MailingAddress = LOCAL.qAgencies.MailingAddress>
			<cfset LOCAL.Agency.Mission = LOCAL.qAgencies.Mission>
			<cfset LOCAL.Agency.Vision = LOCAL.qAgencies.Vision>
			<cfset LOCAL.Agency.Name = LOCAL.qAgencies.Name>
			<cfset LOCAL.Agency.Phone = LOCAL.qAgencies.Phone>
			<cfset LOCAL.Agency.Website = LOCAL.qAgencies.Website>
			<cfinvoke component="board" method="GetBoardMembersByAgencyID" AgencyID="#LOCAL.qAgencies.AgencyID#" returnvariable="LOCAL.Agency.BoardMembers" />

			<cfset ArrayAppend(LOCAL.response, LOCAL.Agency)>
		</cfoutput>

		<cfreturn LOCAL.response>
	</cffunction>	

<!--- Get a list of the agencies --->
	<cffunction name="GetAgencyList" returnformat="JSON" returntype="Array"
		hint="Returns an array of Agency objects with just ID, Name and isActive. Used for dropdown selects">		

		<cfquery name="LOCAL.qAgencies">
			SELECT	AgencyID, Name, isActive
			FROM	Agency_tbl
		</cfquery>

		<cfset LOCAL.response = ArrayNew(1)>

		<cfoutput query="LOCAL.qAgencies">
			<cfset LOCAL.Agency = StructNew()>
			<cfset LOCAL.Agency.AgencyID = LOCAL.qAgencies.AgencyID>
			<cfset LOCAL.Agency.Name = LOCAL.qAgencies.Name>
			<cfset LOCAL.Agency.isActive = LOCAL.qAgencies.isActive>

			<cfset ArrayAppend(LOCAL.response, LOCAL.Agency)>
		</cfoutput>

		<cfreturn LOCAL.response>
	</cffunction>	
</cfcomponent>