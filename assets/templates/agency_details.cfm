<cfif StructKeyExists(ATTRIBUTES, "ProgramID")>
	<cfquery name="qGetAgencyID">
		SELECT AgencyID FROM Program_vw
		WHERE 	ProgramID = <cfqueryparam value="#ATTRIBUTES.ProgramID#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfinvoke component="#APPLICATION.cfcpath#agency" method="GetAgencyByID" AgencyID="#qGetAgencyID.AgencyID#" returnvariable="Agency" />
	
	<cfoutput>
		<h1>Agency Details</h1>
		<p>
			<strong>Agency Name</strong><br />
			#Agency.Name#
		</p>
		<p>
			<strong>Mission</strong><br />
			#Agency.Mission#
		</p>
		<p>
			<strong>Vision</strong><br />
			#Agency.Vision#
		</p>

		<h2>Agency Contact Information</h2>
		<p>
			<strong>Address</strong><br />
			#Agency.Address#
		</p>
		<cfif LEN(Agency.MailingAddress) GT 0 AND Agency.MailingAddress NEQ Agency.Address>
			<p>
				<strong>Mailing Address</strong><br />
				#Agency.MailingAddress#
			</p>
		</cfif>
		<p>
			<strong>Phone</strong><br />
			#Agency.Phone#
		</p>
		<p>
			<strong>Email</strong><br />
			<a href="mailto:#Agency.Email#">#Agency.Email#</a>
		</p>
		<cfif LEN(Agency.Fax) GT 0>
			<p>
				<strong>Fax</strong><br />
				#Agency.Fax#
			</p>
		</cfif>
		<cfif LEN(Agency.Website) GT 0>
			<p>
				<strong>Website</strong><br />
				<a href="#Agency.Website#" target="_blank">#Agency.Website#</a>
			</p>
		</cfif>
	</cfoutput>
</cfif>
