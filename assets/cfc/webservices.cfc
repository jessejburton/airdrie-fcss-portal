<cfcomponent displayname="Web Services" extends="Core">

<!--- WEB FUNCTIONS RELATED TO ACCOUNTS --->
	<!--- Verify Account --->
	<cffunction name="verifyAccountAndSetPassword" access="remote" returntype="struct" returnformat="JSON"
		hint="Checks to see if the values submitted match an account in the database that is ready for verification.">
		<cfargument name="GUID" type="string" required="true">
		<cfargument name="EmailHash" type="string" required="true">
		<cfargument name="PlainPW" type="string" required="true">

		<cfinvoke component="#APPLICATION.cfcpath#account" method="verifyAccount" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.AccountCheck" />

		<cfif LOCAL.AccountCheck>
			<cfreturn getSuccessResponse("<strong>Thank You!</strong> your account has now been verified. You can now <a href='#APPLICATION.URL#'>visit</a> the portal.")>
		<cfelse>
			<cfreturn getErrorResponse("<strong>Sorry!</strong> the information provided did not match our records for verification. If you feel that this is a mistake please contact #REQUEST.SETTINGS.SupportNumber#. We appologise for any inconveniences.")>
		</cfif>
	</cffunction>	

	<!--- Add a new Account --->
	<cffunction name="addAccount" access="remote" returntype="struct" returnformat="JSON"
		hint="Adds a new login account to an Agency">
		<cfargument name="Name" required="true" type="string">
		<cfargument name="Email" required="true" type="string">

		<cfinvoke component="#APPLICATION.cfcpath#account" method="Insert" accountname="#ARGUMENTS.Name#" accountemail="#ARGUMENTS.Email#" AgencyID="#REQUEST.AGENCY.AGENCYID#" returnvariable="LOCAL.account">

		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Account has been created. An email will be sent to the address provided for the user to setup their account.")>
		<cfset LOCAL.response.DATA = LOCAL.account>
		<cfreturn LOCAL.response>
	</cffunction> 

	<!--- Update an Account --->
	<cffunction name="updateAccount" access="remote" returntype="struct" returnformat="JSON"
		hint="Adds a new login account to an Agency">
		<cfargument name="AccountID" required="true" type="numeric">
		<cfargument name="Name" required="true" type="string">
		<cfargument name="Email" required="true" type="string">
		<cfargument name="isActive" required="true" type="boolean">

		<cfinvoke component="#APPLICATION.cfcpath#account" method="Update" accountID="#ARGUMENTS.AccountID#" accountname="#ARGUMENTS.Name#" accountemail="#ARGUMENTS.Email#" isActive="#ARGUMENTS.isActive#" returnvariable="LOCAL.account">

		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> This account has been updated.")>
		<cfset LOCAL.response.DATA = LOCAL.account>
		<cfreturn LOCAL.response>
	</cffunction> 	

<!--- LOGIN ACCOUNT --->
	<cffunction name="loginAccount" returntype="struct" returnformat="JSON" access="remote"
		hint="Log a user in">
		<cfargument name="Email" type="string" required="true">
		<cfargument name="PlainPW" type="string" required="true">

		<cfquery name="LOCAL.qCheckAccount">
			SELECT 	AccountID, Password, GUID
			FROM	Account_tbl
			WHERE	Email = <cfqueryparam value="#ARGUMENTS.Email#" cfsqltype="varchar">
			AND 	isActive = 1
			AND 	DateVerified IS NOT NULL
		</cfquery>

		<!--- Validate the password --->
		<cfif LOCAL.qCheckAccount.recordcount IS 1 AND validatePassword(ARGUMENTS.PlainPW, LOCAL.qCheckAccount.Password)>
			<cfset SESSION.GUID = LOCAL.qCheckAccount.GUID>
			<cfset SESSION.AccountID = LOCAL.qCheckAccount.AccountID>
			<cfreturn getSuccessResponse("Account logged in successfully")>
		<cfelse>
			<cfreturn getErrorResponse("Invalid email or password. Please try again.")>
		</cfif>
	</cffunction>

	<cffunction name="resetPassword" returntype="struct" returnformat="JSON" access="remote"
		hint="Sends the user an email that they can be used to set their password.">
		<cfargument name="AccountEmail" type="string" required="true">

		<!--- Get the GUID --->
		<cfquery name="LOCAL.qGUID">
			SELECT	GUID 
			FROM 	Account_tbl
			WHERE	Email = <cfqueryparam value="#ARGUMENTS.AccountEmail#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<!--- Only send the email if the email is valid, but return success either way so as not to spill the beans about if the email is valid or not --->
		<cfif LOCAL.qGUID.recordcount IS 1>
			<!--- Now send the verification email --->
			<cfmail to="#ARGUMENTS.AccountEmail#"
					from="#APPLICATION.fromemail#"
					type="html"
					subject="#APPLICATION.Name# - Account Verification">

				<h1>Password Reset Initiated!</h1>
				
				<p>You are receiving this email because someone has requested a password reset on your #APPLICATION.Name# account.</p>
				<p>In order to change your password please <a href="#APPLICATION.url#?accountverify=#LOCAL.qGUID.GUID#&email=#hashString(ARGUMENTS.AccountEmail)#">click here</a>.</p>
				<p>If you did not request this reset, please disregard this email.</p>
			</cfmail>
		</cfif>

		<cfreturn getSuccessResponse("<strong>Success!</strong> Account reset email has been sent to #XMLFormat(ARGUMENTS.AccountEmail)#.")>
	</cffunction>	

<!--- WEB FUNCTIONS RELATED TO AGENCY'S --->
	<!--- Add a new Agency --->
	<cffunction name="addAgency" access="remote" returnformat="JSON" returntype="Struct"
		hint="Adds a new Agency.">
		<cfargument name="Name" type="string" required="yes">
		<cfargument name="Vision" type="string" default="">
		<cfargument name="Mission" type="string" default="">
		<cfargument name="Phone" type="string" default="">
		<cfargument name="Email" type="string" default="">
		<cfargument name="Fax" type="string" default="">
		<cfargument name="Website" type="string" default="">
		<cfargument name="Address" type="string" default="">
		<cfargument name="MailingAddress" type="string" default="">
		<cfargument name="AccountName" type="string" required="true">
		<cfargument name="AccountEmail" type="string" required="true">

		<!--- TODO - make this a cftransaction --->
		<cfinvoke component="#APPLICATION.cfcpath#agency" method="insert" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.Agency" />
		<cfinvoke component="#APPLICATION.cfcpath#account" method="insert" AgencyID="#LOCAL.Agency.AgencyID#" AccountName="#ARGUMENTS.AccountName#" AccountEmail="#ARGUMENTS.AccountEmail#" returnvariable="LOCAL.Account" />

		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> your agency has now been registered. Please check your e-mail to verify your account and get login information.")>
		<cfset LOCAL.response.DATA = LOCAL.Agency>

		<cfreturn LOCAL.response>
	</cffunction>

	<!--- Update an existing new Agency --->
	<cffunction name="updateAgency" access="remote" returnformat="JSON" returntype="Struct"
		hint="Update an existing Agency.">

		<cfset ARGUMENTS.AgencyID = REQUEST.AGENCY.AgencyID>

		<!--- Make sure the new Agency Name isn't already taken --->
		<cfquery name="LOCAL.qAgency">
			SELECT	AgencyID
			FROM	Agency_tbl
			WHERE	Name = <cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="varchar">
			AND 	AgencyID <> <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfif LOCAL.qAgency.recordcount GT 0>
			<cfreturn getErrorResponse("<strong>Sorry!</strong> An Agency with that name already exists.")>
		</cfif>
		
		<cfinvoke component="#APPLICATION.cfcpath#agency" method="update" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.Agency" />

		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> your agency has been updated.")>
		<cfset LOCAL.response.DATA = LOCAL.Agency>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- WEB FUNCTIONS RELATED TO SURVEYS --->
	<cffunction name="getSurveysByApplicationID" access="remote" returntype="struct" returnformat="JSON"
			hint="Gets all of the surveys available for an application.">
		<cfargument name="ApplicationID" type="numeric" required="true">

		<cfquery name="LOCAL.qSurveys">
			SELECT	SurveyID, Name, Description, Citation
			FROM Survey_tbl
			WHERE isActive = 1
			ORDER BY isOrder
		</cfquery>

		<cfset LOCAL.response = getSuccessResponse("")>

		<cfset LOCAL.response.DATA = ArrayNew(1)>
		<cfoutput query="LOCAL.qSurveys">
			<cfset LOCAL.Survey = StructNew()>
			<cfset LOCAL.Survey.ID = LOCAL.qSurveys.SurveyID>
			<cfset LOCAL.Survey.Name = LOCAL.qSurveys.Name>
			<cfset LOCAL.Survey.Description = LOCAL.qSurveys.Description>
			<cfset LOCAL.Survey.Citation = LOCAL.qSurveys.Citation>

			<cfset ArrayAppend(LOCAL.response.DATA, LOCAL.Survey)>
		</cfoutput>

		<cfreturn LOCAL.response>
	</cffunction>

	<cffunction name="getSurveyByID" access="remote" returntype="struct" returnformat="JSON"
			hint="Gets all of the information about a specific survey including questions and responses.">
		<cfargument name="SurveyID" type="numeric" required="true">

		<cfinvoke component="survey" method="getSurveyByID" SurveyID="#ARGUMENTS.SurveyID#" returnvariable="LOCAL.SURVEY">

		<cfset LOCAL.response = getSuccessResponse("")>
		<cfset LOCAL.response.DATA = LOCAL.SURVEY>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- WEB FUNCTIONS RELATED TO PROGRAMS --->
	<cffunction name="saveProgram" access="remote" returntype="struct" returnformat="JSON"
		hint="handles creating and saving a program based on the information passed in.">
		<cfargument name="Type" type="string" default="LOI">
		<cfargument name="ProgramID" type="numeric" required="false">
		<cfargument name="ProgramName" type="string" required="true">
		<cfargument name="ProgramStatement" type="string" required="false">
		<cfargument name="TargetAudience" type="string" required="false">
		<cfargument name="MostlyAirdrie" type="boolean" required="false">
		<cfargument name="PrimaryContactName" type="string" required="false">
		<cfargument name="PrimaryPhone" type="string" required="false">
		<cfargument name="PrimaryEmail" type="string" required="false">
		<cfargument name="Address" type="string" required="false">
		<cfargument name="MailingAddress" type="string" required="false">
		<cfargument name="Need" type="string" required="false">
		<cfargument name="Goal" type="string" required="false">
		<cfargument name="Strategies" type="string" required="false">
		<cfargument name="Rationale" type="string" required="false">
		<cfargument name="Footnotes" type="string" required="false">
		<cfargument name="PreventionFocus" type="string" required="false">
		<cfargument name="Alignment" type="string" required="false">
		<cfargument name="MissionFit" type="string" required="false">
		<cfargument name="ConsideredPartnerships" type="string" required="false">
		<cfargument name="EstimatedFromAirdrie" type="numeric" required="false">
		<cfargument name="EstimatedFromOther" type="numeric" required="false">
		<cfargument name="ShortTermGoals" type="string" required="false">
		<cfargument name="MidTermGoals" type="string" required="false">
		<cfargument name="LongTermGoals" type="string" required="false">

	<!--- Set accountID and AgencyID to defaults even if they are passed in through the web services which restricts creating with accounts or agency's 
		  you don't have permission to, you CAN however do it through coldfusion in the program.cfc --->
		<cfset ARGUMENTS.AccountID = REQUEST.USER.AccountID>
		<cfset ARGUMENTS.AgencyID = REQUEST.AGENCY.AgencyID>

		<cftry>	
			<cfinvoke component="#APPLICATION.cfcpath#program" method="saveProgram" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.Program" />

			<cfset LOCAL.response = getSuccessResponse("Program information has been saved.")>
			<cfset LOCAL.response.DATA = LOCAL.Program>

			<cfcatch>
				<cfset LOCAL.response = getErrorResponse(CFCATCH.MESSAGE & ' ' & CFCATCH.DETAIL)>
			</cfcatch>
		</cftry>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- MARK APPLICATION FOR REVIEW --->
	<cffunction name="markApplicationForReview" access="remote" returnformat="JSON" returntype="Struct"
		hint="Marks the application / LOI ready for review. The system handles what status that needs to be set. (NOT SUBMITTED TO AIRDRIE - Internal Agency review process)">
		<cfargument name="ProgramID" type="numeric" required="true">

		<!--- TODO CSRF and Account Check --->

		<cfinvoke component="#APPLICATION.cfcpath#program" method="markApplicationForReview" programID="#ARGUMENTS.ProgramID#" returnvariable="LOCAL.marked" />
		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Your information has been saved for review.")>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- MARK APPLICATION SUBMITTED --->
	<cffunction name="markApplicationSubmitted" access="remote" returnformat="JSON" returntype="Struct"
		hint="Marks the application / LOI Submitted for review by Airdrie. The system handles what status that needs to be set.">
		<cfargument name="ProgramID" type="numeric" required="true">

		<!--- TODO CSRF and Account Check --->

		<cfinvoke component="#APPLICATION.cfcpath#program" method="markApplicationSubmitted" programID="#ARGUMENTS.ProgramID#" returnvariable="LOCAL.marked" />
		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Your information has been submitted to the City of Airdrie.")>

		<cfreturn LOCAL.response>
	</cffunction>	

<!--- WEB FUNCTIONS RELATED TO BOARD MEMBERS --->
	<cffunction name="updateBoardMembers" access="remote" returnformat="JSON" returntype="struct"
		hint="Removes and inserts the board members passed in through an array.">
		<cfargument name="BoardMembers" type="string" required="true">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AGENCYID#">

		<cfset ARGUMENTS.BoardMembers = DeSerializeJSON(ARGUMENTS.BoardMembers)>

		<cfinvoke component="#APPLICATION.cfcpath#board" method="updateBoardMembers" argumentcollection="#ARGUMENTS#"  returnvariable="LOCAL.BoardMembers" />

		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Board members saved.")>
		<cfset LOCAL.response.DATA = LOCAL.BoardMembers>
		<cfreturn LOCAL.response>
	</cffunction>

<!--- WEB FUNCTIONS FOR DOCUMENTS --->
	<cffunction name="setDocumentTypeByDocumentID" access="remote" returnformat="JSON" returntype="struct"
		hint="Update the type of document to label it as a specific required document">
		<cfargument name="DocumentID" type="numeric" required="true">
		<cfargument name="DocumentTypeID" type="numeric" required="true">

	<!--- Set accountID and AgencyID to defaults even if they are passed in through the web services which restricts creating with accounts or agency's 
		  you don't have permission to, you CAN however do it through coldfusion in the program.cfc --->
		<cfset ARGUMENTS.AccountID = REQUEST.USER.AccountID>
		<cfset ARGUMENTS.AgencyID = REQUEST.AGENCY.AgencyID>

		<cfinvoke component="#APPLICATION.cfcpath#document" method="setDocumentTypeByDocumentID" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.document" />

		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Document type has been updated.")>
		<cfset LOCAL.response.DATA = LOCAL.document>

		<cfreturn LOCAL.response>
	</cffunction>	

	<cffunction name="removeDocument" access="remote" returnformat="JSON" returntype="struct"
		hint="Remove a document from an Agency.">
		<cfargument name="DocumentID" type="numeric" required="true">

	<!--- Set accountID and AgencyID to defaults even if they are passed in through the web services which restricts creating with accounts or agency's 
		  you don't have permission to, you CAN however do it through coldfusion in the program.cfc --->
		<cfset ARGUMENTS.AccountID = REQUEST.USER.AccountID>
		<cfset ARGUMENTS.AgencyID = REQUEST.AGENCY.AgencyID>

		<cfinvoke component="#APPLICATION.cfcpath#document" method="removeDocument" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.removed" />

		<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> This document has been removed.")>
		<cfset LOCAL.response.DATA = LOCAL.removed>

		<cfreturn LOCAL.response>
	</cffunction>	

<!--- WEB FUNCTIONS RELATING TO THE BUDGET --->
	<cffunction name="saveBudget" access="remote" returntype="struct" returnformat="JSON"
		hint="Updates a budget based on the information passed in.">
		<cfargument name="BudgetID" type="numeric" required="true">
		<cfargument name="Revenues" type="string" required="true">
		<cfargument name="Expenses" type="string" required="true">
		<cfargument name="PreviousYearBudget" type="numeric" default="0">
		<cfargument name="RequestedFromAirdrie" type="numeric" default="0">

		<cfset LOCAL.ARGS = StructNew()>

		<cfset LOCAL.ARGS.AccountID = REQUEST.USER.AccountID>
		<cfset LOCAL.ARGS.Revenues = deserializeJSON(ARGUMENTS.Revenues)>
		<cfset LOCAL.ARGS.Expenses = deserializeJSON(ARGUMENTS.Expenses)>
		<cfset LOCAL.ARGS.PreviousYearBudget = ARGUMENTS.PreviousYearBudget>
		<cfset LOCAL.ARGS.RequestedFromAirdrie = ARGUMENTS.RequestedFromAirdrie>

	</cffunction>	
</cfcomponent>