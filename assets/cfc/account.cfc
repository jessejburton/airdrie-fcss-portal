<cfcomponent displayname="Account" extends="core">
	<cffunction name="getAccountByID" returnformat="JSON" returntype="Struct" access="public"
		hint="Returns an account.">
		<cfargument name="AccountID" type="string" required="true">

		<cfquery name="LOCAL.qAccount">
			SELECT	AccountID, Name, Email, AgencyID, GUID
			FROM 	Account_tbl a
			WHERE	AccountID = <cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfset LOCAL.ACCOUNT = StructNew()>
		<cfset LOCAL.ACCOUNT.ACCOUNTID = ARGUMENTS.AccountID>
		<cfset LOCAL.ACCOUNT.NAME = LOCAL.qAccount.Name>
		<cfset LOCAL.ACCOUNT.EMAIL = LOCAL.qAccount.Email>
		<cfset LOCAL.ACCOUNT.AGENCYID = LOCAL.qAccount.AgencyID>
		<cfset LOCAL.ACCOUNT.GUID = LOCAL.qAccount.GUID>

		<cfreturn LOCAL.ACCOUNT>
	</cffunction>		

	<cffunction name="getAccountsByAgencyID" returnformat="JSON" returntype="Array" access="public"
		hint="Returns an array of accounts for a specific agency.">
		<cfargument name="AgencyID" type="string" required="true">

		<cfquery name="LOCAL.qAccounts">
			SELECT	AccountID, Name, Email, isActive
			FROM 	Account_tbl
			WHERE	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			ORDER BY Name ASC, isActive DESC
		</cfquery>

		<cfset LOCAL.ACCOUNTS = ArrayNew(1)>

		<cfloop query="LOCAL.qAccounts">
			<cfset LOCAL.account = StructNew()>
			<cfset LOCAL.account.ACCOUNTID = LOCAL.qAccounts.AccountID>
			<cfset LOCAL.account.NAME = LOCAL.qAccounts.Name>
			<cfset LOCAL.account.EMAIL = LOCAL.qAccounts.Email>
			<cfset LOCAL.account.ISACTIVE = LOCAL.qAccounts.isActive>

			<cfset ArrayAppend(LOCAL.ACCOUNTS, LOCAL.account)>
		</cfloop>

		<cfreturn LOCAL.ACCOUNTS>
	</cffunction>			

<!--- VERIFY ACCOUNT --->
	<cffunction name="verifyAccount" returntype="boolean" returnformat="JSON" access="public"
		hint="Verify's an account, updates the users password and logs them in if successful.">
		<cfargument name="GUID" type="string" required="true">
		<cfargument name="EmailHash" type="string" required="true">
		<cfargument name="PlainPW" type="string" required="true">

		<cfquery name="LOCAL.qAccountCheck">
			SELECT	AccountID, Email, DateVerified
			FROM 	Account_tbl
			WHERE	GUID = <cfqueryparam value="#ARGUMENTS.GUID#" cfsqltype="varchar">
			AND 	isActive = 1
		</cfquery>

		<!--- Check if the emails match --->
		<cfif TRIM(hashString(LOCAL.qAccountCheck.Email)) IS TRIM(ARGUMENTS.EmailHash)>
			<!--- Update the Verification Date if this is a new account and always update 
				the GUID so that the verify/reset link is no longer valid. --->
			<cfquery>
				UPDATE 	Account_tbl
				SET 	GUID = <cfqueryparam value="#CreateUUID()#" cfsqltype="cf_sql_varchar">
						<cfif LEN(LOCAL.qAccountCheck.DateVerified) IS 0>
							,DateVerified = getDate()
						</cfif>
				WHERE	AccountID = <cfqueryparam value="#LOCAL.qAccountCheck.AccountID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<!--- Set the users password --->
			<cfset updateAccountPassword(LOCAL.qAccountCheck.AccountID, ARGUMENTS.PlainPW)>
			<cfinvoke component="#APPLICATION.cfcpath#webservices" method="loginAccount" email="#LOCAL.qAccountCheck.Email#" plainpw="#ARGUMENTS.PlainPW#" />
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>	

<!--- UPDATE AN ACCOUNT PASSWORD --->
	<cffunction name="updateAccountPassword" returntype="boolean" returnformat="JSON" access="public"
		hint="Sets the password for an account using BCrypt encryption.">
		<cfargument name="AccountID" type="numeric" required="true">
		<cfargument name="PlainPW" type="string" required="true">

		<cfquery>
			UPDATE 	Account_tbl
			SET 	Password = <cfqueryparam value="#hashPassword(ARGUMENTS.PlainPW)#" cfsqltype="varchar">
			WHERE 	AccountID = <cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn true>
	</cffunction>

	<cffunction name="Insert" returntype="struct" returnformat="JSON" access="public"
		hint="Creates a new account and sends an email to verify it.">
		<cfargument name="AccountName" type="string" required="true">
		<cfargument name="AccountEmail" type="string" required="true">
		<cfargument name="AgencyID" type="numeric" required="true">

		<cfset LOCAL.GUID = CreateUUID()>
		<cfinvoke component="agency" method="GetAgencyByID" AgencyID="#ARGUMENTS.AgencyID#" returnvariable="LOCAL.Agency" />

		<!--- Ensure this email doesn't exist --->
		<cfquery name="LOCAL.qCheck">
			SELECT	AccountID 
			FROM 	Account_tbl
			WHERE	Email = <cfqueryparam value="#ARGUMENTS.AccountEmail#" cfsqltype="cf_sql_varchar">
			AND 	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfif LOCAL.qCheck.recordcount GT 0>
			<cfthrow message="<strong>Sorry!</strong> an account with this email address already exists.">
		<cfelse>
			<cfquery result="LOCAL.qAccount">
				INSERT INTO Account_tbl
				(
					AgencyID, Name, Email, GUID
				) VALUES (
					<cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#ARGUMENTS.AccountName#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#ARGUMENTS.AccountEmail#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#LOCAL.GUID#" cfsqltype="cf_sql_varchar">
				)
			</cfquery>

			<cfset LOCAL.Account = StructNew()>
			<cfset LOCAL.Account.AccountID = LOCAL.qAccount.GeneratedKey>
			<cfset LOCAL.Account.Name = ARGUMENTS.AccountName>
			<cfset LOCAL.Account.Email = ARGUMENTS.AccountEmail>

			<!--- Now send the verification email --->
			<cfmail to="#ARGUMENTS.AccountEmail#"
					from="#APPLICATION.fromemail#"
					type="html"
					subject="#APPLICATION.Name# - Account Verification">

				<h1>Thank You for Registering!</h1>
				
				<p>You are receiving this email as a verification process for registering <strong>#LOCAL.Agency.Name#</strong> as a new agency with the #APPLICATION.Name#.</p>
				<p>In order to complete the registration and activate your account please <a href="#APPLICATION.url#?accountverify=#LOCAL.GUID#&email=#hashString(ARGUMENTS.AccountEmail)#">click here</a>.</p>
				<p>If you did not register, please disregard this email.</p>
				<!--- TODO - get verification email text from Jessie --->
			</cfmail>

			<cfreturn LOCAL.Account>
		</cfif>
	</cffunction>

	<cffunction name="Update" returntype="struct" returnformat="JSON" access="public"
		hint="Updates an existing account.">
		<cfargument name="AccountID" type="numeric" required="true">
		<cfargument name="AccountName" type="string" required="true">
		<cfargument name="AccountEmail" type="string" required="true">
		<cfargument name="isActive" type="boolean" required="true">

		<!--- Ensure this email doesn't exist --->
		<cfquery name="LOCAL.qCheck">
			SELECT	AccountID 
			FROM 	Account_tbl
			WHERE	(Email = <cfqueryparam value="#ARGUMENTS.AccountEmail#" cfsqltype="cf_sql_varchar">
			OR 		(Name = <cfqueryparam value="#ARGUMENTS.AccountName#" cfsqltype="cf_sql_varchar">
					AND AgencyID = <cfqueryparam value="#REQUEST.AGENCY.AgencyID#" cfsqltype="cf_sql_integer">))
			AND AccountID <> <cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfif LOCAL.qCheck.recordcount GT 0>
			<cfthrow message="<strong>Sorry!</strong> an account with this name or email address already exists.">
		<cfelse>
			<cfquery result="LOCAL.qAccount">
				UPDATE Account_tbl
				SET
					Name = <cfqueryparam value="#ARGUMENTS.AccountName#" cfsqltype="cf_sql_varchar">,
					Email = <cfqueryparam value="#ARGUMENTS.AccountEmail#" cfsqltype="cf_sql_varchar">,
					DateUpdated = getDate(),
					isActive = <cfqueryparam value="#ARGUMENTS.isActive#" cfsqltype="cf_sql_bit">
					<cfif NOT ARGUMENTS.isActive>
						,GUID = <cfqueryparam value="#CreateUUID()#" cfsqltype="varchar"> <!--- Update the GUID so any active sessions are killed. --->
					</cfif>
				WHERE AccountID = <cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfset LOCAL.Account = StructNew()>
			<cfset LOCAL.Account.AccountID = ARGUMENTS.AccountID>
			<cfset LOCAL.Account.Name = ARGUMENTS.AccountName>
			<cfset LOCAL.Account.Email = ARGUMENTS.AccountEmail>

			<cfreturn LOCAL.Account>
		</cfif>
	</cffunction>	
</cfcomponent>