<cfcomponent displayname="Web Services (unauthenticated services)" extends="Core">

<!--- WEB FUNCTIONS RELATED TO ACCOUNTS --->
	<!--- Verify Account --->
	<cffunction name="verifyAccountAndSetPassword" access="remote" returntype="struct" returnformat="JSON"
		hint="Checks to see if the values submitted match an account in the database that is ready for verification.">
		<cfargument name="GUID" type="string" required="true" hint="The GUID to check against in the database passed from the verification email">
		<cfargument name="EmailHash" type="string" required="true" hint="The has of the email address passed from the verification email">
		<cfargument name="PlainPW" type="string" required="true" hint="The password to be set for the account">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfinvoke component="#APPLICATION.cfcpath#account" method="verifyAccount" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.AccountCheck" />

			<cfif LOCAL.AccountCheck>
				<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Account verified for GUID: #ARGUMENTS.GUID#" />
				<cfreturn getSuccessResponse("<strong>Thank You!</strong> your account has now been verified. You can now <a href='#APPLICATION.URL#'>visit</a> the portal.")>
			<cfelse>
				<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Invalid verification attempt for GUID: #ARGUMENTS.GUID#" />
				<cfreturn getErrorResponse("<strong>Sorry!</strong> the information provided did not match our records for verification. If you feel that this is a mistake please contact #REQUEST.SETTINGS.SupportNumber#. We appologise for any inconveniences.")>
			</cfif>
		<cfelse>
			<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Invalid CSRF Token" />
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

<!--- LOGIN ACCOUNT --->
	<cffunction name="loginAccount" returntype="struct" returnformat="JSON" access="remote"
		hint="Log a user in">
		<cfargument name="Email" type="string" required="true">
		<cfargument name="PlainPW" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfquery name="LOCAL.qCheckAccount">
				SELECT 	AccountID, Password, GUID, NumAttempts
				FROM	Account_tbl
				WHERE	Email = <cfqueryparam value="#ARGUMENTS.Email#" cfsqltype="cf_sql_varchar">
				AND 	isActive = 1
				AND 	DateVerified IS NOT NULL
			</cfquery>

			<!--- Validate the password --->
			<cfif LOCAL.qCheckAccount.recordcount IS 1 AND LOCAL.qCheckAccount.NumAttempts LTE 5>
				<cfif validatePassword(ARGUMENTS.PlainPW, LOCAL.qCheckAccount.Password)>
					<!--- Update the last logged in --->
					<cfquery>
						UPDATE 	Account_tbl 
						SET 	DateLastOn = getDate(),
								NumAttempts = 0
						WHERE 	AccountID = <cfqueryparam value="#LOCAL.qCheckAccount.AccountID#" cfsqltype="cf_sql_integer">
					</cfquery>

					<cfset SESSION.GUID = LOCAL.qCheckAccount.GUID>
					<cfset SESSION.AccountID = LOCAL.qCheckAccount.AccountID>
					<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Login success for email: #ARGUMENTS.EMAIl#" />
					<cfreturn getSuccessResponse("Account logged in successfully")>
				<cfelse>
					<!--- Update the number of attempts --->
					<cfquery>
						UPDATE 	Account_tbl 
						SET 	NumAttempts = NumAttempts + 1 
						WHERE 	AccountID = <cfqueryparam value="#LOCAL.qCheckAccount.AccountID#" cfsqltype="cf_sql_integer">
					</cfquery>

					<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Invalid login attempt" />
					<cfreturn getErrorResponse("Invalid email or password. Please try again.")>
				</cfif>
			<cfelse>	
				<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Invalid login attempt" />
				<cfif LOCAL.qCheckAccount.NumAttempts GT 5>
					<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Account locked for email: #ARGUMENTS.Email#" />
				</cfif>
				<cfreturn getErrorResponse("Invalid email or password. Please try again.")>
			</cfif>
		<cfelse>
			<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Invalid CSRF Token" />
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>			
	</cffunction>

	<cffunction name="resetPassword" returntype="struct" returnformat="JSON" access="remote"
		hint="Sends the user an email that can be used to set their password.">
		<cfargument name="AccountEmail" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- Get the GUID --->
			<cfquery name="LOCAL.qGUID">
				SELECT	GUID 
				FROM 	Account_tbl
				WHERE	Email = <cfqueryparam value="#TRIM(ARGUMENTS.AccountEmail)#" cfsqltype="cf_sql_varchar">
				AND 	isActive = 1
			</cfquery>

			<!--- Only send the email if the email is valid, but return success either way so as not to spill the beans about if the email is valid or not --->
			<cfif LOCAL.qGUID.recordcount IS 1>
				<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Password reset for email: #ARGUMENTS.AccountEmail#" /> <!--- Log the reset --->

				<!--- Now send the verification email --->
				<cfmail to="#ARGUMENTS.AccountEmail#"
						from="#APPLICATION.fromemail#"
						type="html"
						subject="#APPLICATION.Name# - Account Verification">

					<h1>Password Reset</h1>
					
					<p>You recently requested to reset your password on your #APPLICATION.Name# account.</p>
					<div>
						<!--[if mso]>
						<v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="#APPLICATION.url#?accountverify=#LOCAL.qGUID.GUID#&email=#hashString(ARGUMENTS.AccountEmail)#" style="height:40px;v-text-anchor:middle;width:200px;" arcsize="10%" stroke="f" fillcolor="##005596">
						<w:anchorlock/>
						<center style="color:##ffffff;font-family:sans-serif;font-size:16px;font-weight:bold;">
						  Reset Your Password
						</center>
						</v:roundrect>
						<![endif]-->
						<![if !mso]>
						<table cellspacing="0" cellpadding="0"> <tr> 
						<td align="center" width="200" height="40" bgcolor="##005596" style="-webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; color: ##ffffff; display: block;">
							<a href="#APPLICATION.url#?accountverify=#LOCAL.qGUID.GUID#&email=#hashString(ARGUMENTS.AccountEmail)#" style="font-size:16px; font-weight: bold; font-family:sans-serif; text-decoration: none; line-height:40px; width:100%; display:inline-block">
						<span style="color: ##ffffff;">
						  Reset Your Password
						</span>
						</a>
						</td> 
						</tr> </table> 
						<![endif]>
					</div>
					<p>If you did not request this reset, please disregard this email.</p>
				</cfmail>
			</cfif>

			<cfreturn getSuccessResponse("<strong>Success!</strong> Account reset email has been sent to #EncodeForHTML(ARGUMENTS.AccountEmail)#.")>
		<cfelse>
			<cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Invalid login attempt" />
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

</cfcomponent>
