<cfcomponent displayname="Web Services" extends="Core">

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
				<cfreturn getSuccessResponse("<strong>Thank You!</strong> your account has now been verified. You can now <a href='#APPLICATION.URL#'>visit</a> the portal.")>
			<cfelse>
				<cfreturn getErrorResponse("<strong>Sorry!</strong> the information provided did not match our records for verification. If you feel that this is a mistake please contact #REQUEST.SETTINGS.SupportNumber#. We appologise for any inconveniences.")>
			</cfif>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

	<!--- Add a new Account --->
	<cffunction name="addAccount" access="remote" returntype="struct" returnformat="JSON"
		hint="Adds a new login account to an Agency">
		<cfargument name="Name" required="true" type="string">
		<cfargument name="Email" required="true" type="string">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfinvoke component="#APPLICATION.cfcpath#account" method="Insert" accountname="#ARGUMENTS.Name#" accountemail="#ARGUMENTS.Email#" AgencyID="#REQUEST.USER.AGENCYID#" returnvariable="LOCAL.account" />

			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Account has been created. An email will be sent to the address provided for the user to setup their account.")>
			<cfset LOCAL.response.DATA = LOCAL.account>
			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction> 

	<!--- Update an Account --->
	<cffunction name="updateAccount" access="remote" returntype="struct" returnformat="JSON"
		hint="Adds a new login account to an Agency">
		<cfargument name="AccountID" required="true" type="numeric">
		<cfargument name="Name" required="true" type="string">
		<cfargument name="Email" required="true" type="string">
		<cfargument name="isActive" required="true" type="boolean">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfinvoke component="#APPLICATION.cfcpath#account" method="Update" accountID="#ARGUMENTS.AccountID#" accountname="#ARGUMENTS.Name#" accountemail="#ARGUMENTS.Email#" isActive="#ARGUMENTS.isActive#" returnvariable="LOCAL.account">

			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> This account has been updated.")>
			<cfset LOCAL.response.DATA = LOCAL.account>
			<cfreturn LOCAL.response>
		<cfelse>
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
					<cfreturn getSuccessResponse("Account logged in successfully")>
				<cfelse>
					<!--- Update the number of attempts --->
					<cfquery>
						UPDATE 	Account_tbl 
						SET 	NumAttempts = NumAttempts + 1 
						WHERE 	AccountID = <cfqueryparam value="#LOCAL.qCheckAccount.AccountID#" cfsqltype="cf_sql_integer">
					</cfquery>

					<cfreturn getErrorResponse("Invalid email or password. Please try again.")>
				</cfif>
			<cfelse>				
				<cfreturn getErrorResponse("Invalid email or password. Please try again.")>
			</cfif>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>			
	</cffunction>

<!--- CHECK ACCOUNT PASSWORD --->
	<cffunction name="checkPassword" returntype="struct" returnformat="JSON" access="remote"
		hint="Used for when a user needs to re-enter their password. Checks based on currently logged in user">
		<cfargument name="pword" type="string" required="true">
		<cfargument name="spword" type="string" required="false">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfquery name="LOCAL.qCheckAccount">
				SELECT 	AccountID, Password, GUID
				FROM	Account_tbl
				WHERE	Email = <cfqueryparam value="#REQUEST.USER.Email#" cfsqltype="cf_sql_varchar">
				AND 	isActive = 1
				AND 	DateVerified IS NOT NULL
			</cfquery>

			<!--- Validate the password --->
			<cfif LOCAL.qCheckAccount.recordcount IS 1 AND validatePassword(ARGUMENTS.PlainPW, LOCAL.qCheckAccount.Password)>
				<cfreturn getSuccessResponse("")>
			<cfelse>
				<cfreturn getErrorResponse("Password is incorrect.")>
			</cfif>
		<cfelse>
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
				WHERE	Email = <cfqueryparam value="#ARGUMENTS.AccountEmail#" cfsqltype="cf_sql_varchar">
			</cfquery>

			<!--- Only send the email if the email is valid, but return success either way so as not to spill the beans about if the email is valid or not --->
			<cfif LOCAL.qGUID.recordcount IS 1>
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
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

<!--- WEB FUNCTIONS RELATED TO PACKAGES --->
	<cffunction name="savePackage" access="remote" returnformat="JSON" returntype="Struct"
		hint="Saves a package to be used for export.">
		<cfargument name="PackageID" type="numeric" required="false" hint="Only passed in if saving an existing package">
		<cfargument name="PackageName" type="string" required="true" hint="The name to reference the package by">
		<cfargument name="PackageContent" type="string" required="true" hint="An array of package content items">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>	
			<cfset LOCAL.PackageContent = DeSerializeJSON(ARGUMENTS.PackageContent)>

			<!--- Make sure the name isn't in use --->
			<cfquery name="LOCAL.qCheck">
				SELECT 	PackageID
				FROM 	Package_tbl
				WHERE 	PackageName = <cfqueryparam value="#ARGUMENTS.PackageName#" cfsqltype="cf_sql_varchar">
				<cfif isDefined('ARGUMENTS.PackageID')>		<!--- This will allow this check to handle both saving and updating --->
					AND 	PackageID <> <cfqueryparam value="#ARGUMENTS.PackageID#" cfsqltype="cf_sql_integer">
				</cfif>
			</cfquery>

			<cfif LOCAL.qCheck.recordcount NEQ 0>
				<cfreturn getErrorResponse("A package with this name already exists, please choose a different name")>
			</cfif>

			<cftransaction>
			<!--- Name is ok, so now either update the package or save a new one --->
			<cfif isDefined('ARGUMENTS.PackageID')> 										<!--- Saving an existing package --->
				<cfset LOCAL.PackageID = ARGUMENTS.PackageID>
				<!--- Update the program name --->
				<cfquery>
					UPDATE 	Package_tbl
					SET 	PackageName = <cfqueryparam value="#ARGUMENTS.PackageName#" cfsqltype="cf_sql_varchar">
					WHERE 	PackageID = <cfqueryparam value="#LOCAL.PackageID#" cfsqltype="cf_sql_integer">
				</cfquery>
			<cfelse>																		<!--- Adding a new package --->
				<!--- Add the new package and get the ID --->
				<cfquery result="LOCAL.qNewPackage">
					INSERT 	INTO Package_tbl
					( PackageName ) VALUES ( <cfqueryparam value="#ARGUMENTS.PackageName#" cfsqltype="cf_sql_varchar"> )
				</cfquery>

				<cfset LOCAL.PackageID = LOCAL.qNewPackage.GeneratedKey>
			</cfif>

			<!--- Handle the package contents --->
			<!--- Remove the existing records so that we can just look through and add the new ones --->
			<cfquery>
				DELETE 	FROM PackageData_tbl 
				WHERE 	PackageID = <cfqueryparam value="#LOCAL.PackageID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfset LOCAL.curOrder = 0>
			<cfloop array="#LOCAL.PackageContent#" index="LOCAL.content">
				<cfset LOCAL.content = DeSerializeJSON(LOCAL.content)>
				<cfquery>
					INSERT INTO PackageData_tbl
					(
						PackageID, TableView, SectionTitle, ColumnName, TemplateFile, isSectionHeading, isOrder
					) VALUES (
						<cfqueryparam value="#LOCAL.PackageID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#LOCAL.content.TableView#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#LOCAL.content.SectionTitle#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#LOCAL.content.ColumnName#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#LOCAL.content.TemplateFile#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#LOCAL.content.isSectionHeading#" cfsqltype="cf_sql_bit">,
						<cfqueryparam value="#LOCAL.curOrder#" cfsqltype="cf_sql_integer">
					)
				</cfquery>

				<cfset LOCAL.curOrder ++>
			</cfloop>			
					
			</cftransaction>

			<cfset LOCAL.response = getSuccessResponse("The package <strong>#ARGUMENTS.PackageName#</strong> has been saved and is now ready for use.")>
			<cfset LOCAL.response.PackageID = LOCAL.PackageID>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

	<cffunction name="getPackageByID" access="remote" returnformat="JSON" returntype="Struct"
		hint="Get a package to edit by its ID.">
		<cfargument name="PackageID" type="numeric" required="false" hint="Only passed in if saving an existing package">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfquery name="LOCAL.qPackageContents">
				SELECT 	p.PackageName, TableView, SectionTitle, ColumnName, TemplateFile, isSectionHeading, isOrder
				FROM 	PackageData_tbl pd
				INNER JOIN Package_tbl p ON pd.PackageID = p.PackageID
				WHERE 	pd.PackageID = <cfqueryparam value="#ARGUMENTS.PackageID#" cfsqltype="cf_sql_integer">
				ORDER BY isOrder
			</cfquery>

			<cfset LOCAL.response = getSuccessResponse("")>
			<cfset LOCAL.response.DATA = StructNew()>
			<cfset LOCAL.response.DATA.PackageName = LOCAL.qPackageContents.PackageName>
			<cfset LOCAL.response.DATA.PackageContents = ArrayNew(1)>

			<cfoutput query="LOCAL.qPackageContents">
				<cfset LOCAL.elm = StructNew()>
				<cfset LOCAL.elm.TableView = LOCAL.qPackageContents.TableView>
				<cfset LOCAL.elm.SectionTitle = LOCAL.qPackageContents.SectionTitle>
				<cfset LOCAL.elm.ColumnName = LOCAL.qPackageContents.ColumnName>
				<cfset LOCAL.elm.TemplateFile = LOCAL.qPackageContents.TemplateFile>
				<cfset LOCAL.elm.isSectionHeading = LOCAL.qPackageContents.isSectionHeading>
				<cfset LOCAL.elm.isOrder = LOCAL.qPackageContents.isOrder>

				<cfset ArrayAppend(LOCAL.response.DATA.PackageContents, LOCAL.elm)>
			</cfoutput>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

<!--- WEB FUNCTIONS RELATED TO RESOURCES --->
	<cffunction name="addResource" access="remote" returnformat="JSON" returntype="Struct"
		hint="Adds a resource link">
		<cfargument name="Title" type="string" required="true">
		<cfargument name="URL" type="string" required="true">
		<cfargument name="ResourceType" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<!--- TODO - Nice to have, ability to add documents --->

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- Make sure this is an internal account --->
			<cfif isDefined('REQUEST.Agency.ADMIN') AND REQUEST.Agency.ADMIN IS true>	
				<cfquery result="LOCAL.qResource">
					INSERT INTO Resource_tbl 
					(
						Title, URL, ResourceType, AccountID, isOrder
					) VALUES (
						<cfqueryparam value="#ARGUMENTS.Title#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.URL#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.ResourceType#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#REQUEST.USER.AccountID#" cfsqltype="cf_sql_integer">,
						isNull((SELECT MAX(isOrder) + 1 FROM Resource_tbl WHERE ResourceType = <cfqueryparam value="#ARGUMENTS.ResourceType#" cfsqltype="cf_sql_varchar">), 0)
					)
				</cfquery>

				<cfset LOCAL.response = getSuccessResponse("Resource has been added.")>
				<cfset LOCAL.response.DATA = StructNew()>
					<cfset LOCAL.response.DATA.RESOURCEID = LOCAL.qResource.GeneratedKey>
					<cfset LOCAL.response.DATA.TITLE = ARGUMENTS.Title>
					<cfset LOCAL.response.DATA.URL = ARGUMENTS.URL>
					<cfset LOCAL.response.DATA.RESOURCETYPE = ARGUMENTS.ResourceType>
				<cfreturn LOCAL.response>
			</cfif>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="removeResource" access="remote" returnformat="JSON" returntype="Struct"
		hint="Removes a resource link">
		<cfargument name="ResourceID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- Make sure this is an internal account --->
			<cfif isDefined('REQUEST.Agency.ADMIN') AND REQUEST.Agency.ADMIN IS true>	
				<cfquery>
					DELETE FROM Resource_tbl 
					WHERE ResourceID = <cfqueryparam value="#ARGUMENTS.ResourceID#" cfsqltype="cf_sql_integer">
				</cfquery>
			</cfif>

			<cfreturn getSuccessResponse("Resource has been removed.")>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
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
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- TODO - make this a cftransaction --->
			<cfinvoke component="#APPLICATION.cfcpath#agency" method="insert" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.Agency" />
			<cfinvoke component="#APPLICATION.cfcpath#account" method="insert" AgencyID="#LOCAL.Agency.AgencyID#" AccountName="#ARGUMENTS.AccountName#" AccountEmail="#ARGUMENTS.AccountEmail#" returnvariable="LOCAL.Account" />

			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Your agency has now been registered. Please check your e-mail to verify your account and receive your login information. <br /><br /><span><i class='fa fa-question-circle'></i> Having difficulties? Contact City of Airdrie Social Planning at 403.948.8800 or social.planning@airdrie.ca.</span>")>
			<cfset LOCAL.response.DATA = LOCAL.Agency>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<!--- Update an existing new Agency --->
	<cffunction name="updateAgency" access="remote" returnformat="JSON" returntype="Struct"
		hint="Update an existing Agency.">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
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
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="getAgencyByID" access="remote" returnformat="JSON" returntype="Struct"
		hint="Get the details about an agency by its ID.">
		<cfargument name="AgencyID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfinvoke component="#APPLICATION.cfcpath#agency" method="getAgencyByID" agencyID="#ARGUMENTS.AgencyID#" returnvariable="LOCAL.Agency" />

			<cfset LOCAL.response = getSuccessResponse("Agency details retrieved.")>
			<cfset LOCAL.response.DATA = LOCAL.Agency>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

<!--- WEB FUNCTIONS RELATED TO SURVEYS --->
	<cffunction name="saveSurvey" access="remote" returntype="struct" returnformat="JSON"
			hint="Saves survey data">
		<cfargument name="SurveyID" type="numeric" required="false">
		<cfargument name="Name" type="string" required="true">
		<cfargument name="Description" type="string" default="">
		<cfargument name="Citation" type="string" default="">
		<cfargument name="IndicatorID" type="numeric" required="true">
		<cfargument name="Questions" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfset LOCAL.Questions = DeserializeJSON(ARGUMENTS.Questions)>

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf AND isAdminAccount()>
		<!--- Check to make sure the name is ok --->
			<cfquery name="LOCAL.qCheck">
				SELECT 	Name
				FROM 	Survey_tbl
				<cfif isDefined('ARGUMENTS.SurveyID')>
					WHERE SurveyID <> <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer"> 
				</cfif>
			</cfquery>

			<!--- Handle the surveys --->
			<cfif isDefined('ARGUMENTS.SurveyID') AND ARGUMENTS.SurveyID NEQ 0>	
				<!--- Update Survey details --->
				<cfquery>
					UPDATE Survey_tbl 
					SET 	Name = <cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="cf_sql_varchar">,
							Description = <cfqueryparam value="#ARGUMENTS.Description#" cfsqltype="cf_sql_varchar">,
							Citation = <cfqueryparam value="#ARGUMENTS.Citation#" cfsqltype="cf_sql_varchar">,
							IndicatorID = <cfqueryparam value="#ARGUMENTS.IndicatorID#" cfsqltype="cf_sql_integer">
					WHERE 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfset LOCAL.SurveyID = ARGUMENTS.SurveyID>
			<cfelse>
				<!--- Add the new survey --->
				<cfquery result="LOCAL.qSurvey">
					INSERT INTO Survey_tbl
					(
						Name, Description, Citation, IndicatorID
					) VALUES (
						<cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.Description#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.Citation#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.IndicatorID#" cfsqltype="cf_sql_integer">
					)
				</cfquery>

				<cfset LOCAL.SurveyID = LOCAL.qSurvey.GeneratedKey>
			</cfif>

			<!--- Now handle the questions --->
			<cftransaction>				
				<cfset LOCAL.curOrder = 0>
				<cfset LOCAL.questionIDs = "">  <!--- Use this to know if we need to delete any questions --->

				<cfloop array="#LOCAL.Questions#" index="LOCAL.question">
					<cfset LOCAL.question = DeserializeJSON(LOCAL.question)>

					<cfif StructKeyExists(LOCAL.question, "QuestionID")>
						<cfquery>
							UPDATE SurveyQuestion_tbl
							SET  Question = <cfqueryparam value="#LOCAL.question.Question#" cfsqltype="cf_sql_varchar">,
								 isOrder = <cfqueryparam value="#LOCAL.curOrder#" cfsqltype="cf_sql_integer">
							WHERE QuestionID = <cfqueryparam value="#LOCAL.question.QuestionID#" cfsqltype="cf_sql_integer">
						</cfquery>

						<cfset LOCAL.questionIDs = ListAppend(LOCAL.questionIDs, LOCAL.question.QuestionID)>
					<cfelse> 
						<cfquery result="LOCAL.qQuestion">
							INSERT INTO SurveyQuestion_tbl
							(
								Question, SurveyID, isOrder
							) VALUES (
								<cfqueryparam value="#LOCAL.question.Question#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#LOCAL.SurveyID#" cfsqltype="cf_sql_integer">,
								<cfqueryparam value="#LOCAL.curOrder#" cfsqltype="cf_sql_integer">
							)
						</cfquery>

						<!--- Add the answers for this question --->
						<cfset addAnswersToQuestion(LOCAL.qQuestion.GeneratedKey)>	
						<cfset LOCAL.questionIDs = ListAppend(LOCAL.questionIDs, LOCAL.qQuestion.GeneratedKey)>					
					</cfif>

					<cfset LOCAL.curOrder ++>
				</cfloop>

				<!--- Clear up any questions that were removed --->
				<cfquery>
					UPDATE SurveyQuestion_tbl 
					SET isActive = 0
					WHERE SurveyID = <cfqueryparam value="#LOCAL.SurveyID#" cfsqltype="cf_sql_integer">
					AND QuestionID NOT IN (<cfqueryparam value="#LOCAL.QuestionIDs#" cfsqltype="cf_sql_integer" list="true">)
				</cfquery>
			</cftransaction>

			<cfreturn getSuccessResponse("Survey has been saved.")>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="saveProgramIndicators" access="remote" returntype="Struct" returnformat="JSON"
		hint="Saves the selected indicators for a program.">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="Indicators" type="string" required="true">
		<cfargument name="csrf" type="string" required="true">

		<!--- First check permissions --->
		<cfif ARGUMENTS.csrf EQ COOKIE.csrf AND checkProgramAccessByAccountID(ARGUMENTS.ProgramID)>
			<cftransaction>
				<!--- Remove existing Indicators --->
				<cfquery>
					DELETE FROM ProgramIndicator_tbl
					WHERE ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfloop list="#ARGUMENTS.Indicators#" index="LOCAL.i">
					<cfquery>
						INSERT INTO ProgramIndicator_tbl
						( ProgramID, IndicatorID ) VALUES
						(
							<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#LOCAL.i#" cfsqltype="cf_sql_integer">
						)
					</cfquery>
				</cfloop>
			</cftransaction>

			<cfreturn getSuccessResponse("Indicators have been saved.")>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="addAnswersToQuestion" access="private" returntype="boolean" returnformat="JSON"
			hint="Adds the questions 1 - 5 to the survey">
		<!--- 	At the time that the system was created they only wanted all questions to be 1-5 answers and so the database is set
				up to accommodate for having different answers but we just add the defaults for now, I can see them eventually wanting to 
				add different responses and question types --->
		<cfargument name="QuestionID" type="numeric" required="true">
		
		<cfoutput>
			<cftransaction>
				<cfquery>
					DELETE FROM SurveyAnswer_tbl WHERE QuestionID = <cfqueryparam value="#ARGUMENTS.QuestionID#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfset LOCAL.curOrder = 0>
				<cfloop list="1 - low,2,3,4,5 - high,No Response" index="a">
					<cfquery>
						INSERT INTO SurveyAnswer_tbl
						(
							Answer, QuestionID, isOrder, isDefault
						) VALUES (
							<cfqueryparam value="#a#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#ARGUMENTS.QuestionID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#LOCAL.curOrder#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#a IS 'No Response'#" cfsqltype="cf_sql_bit">
						)
					</cfquery>

					<cfset LOCAL.curOrder ++>
				</cfloop>		
			</cftransaction>		
		</cfoutput>

		<cfreturn true>
	</cffunction>

	<cffunction name="getSurvey" access="remote" returntype="struct" returnformat="JSON" 
		hint="get a survey for editing">
		<cfargument name="SurveyID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf AND isAdminAccount()>
			<cfquery name="LOCAL.qSurvey">
				SELECT 	Name, Description, IndicatorID, Citation 
				FROM 	Survey_tbl
				WHERE 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfset LOCAL.DATA = StructNew()>
			<cfset LOCAL.DATA.Name = LOCAL.qSurvey.Name> 
			<cfset LOCAL.DATA.Description = LOCAL.qSurvey.Description>
			<cfset LOCAL.DATA.IndicatorID = LOCAL.qSurvey.IndicatorID>
			<cfset LOCAL.DATA.Citation = LOCAL.qSurvey.Citation>

			<!--- Questions --->
			<cfquery name="LOCAL.qQuestions">
				SELECT 	QuestionID, Question 
				FROM 	SurveyQuestion_tbl 
				WHERE 	isActive = 1
				AND 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfset LOCAL.DATA.Questions = ArrayNew(1)>
			<cfoutput query="LOCAL.qQuestions">
				<cfset LOCAL.q = StructNew()>
				<cfset LOCAL.q.Question = LOCAL.qQuestions.Question>
				<cfset LOCAL.q.QuestionID = LOCAL.qQuestions.QuestionID> 

				<cfset ArrayAppend(LOCAL.DATA.Questions, LOCAL.q)>
			</cfoutput>

			<cfset LOCAL.response = getSuccessResponse("Survey Loaded")>
			<cfset LOCAL.response.DATA = LOCAL.DATA>
			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

	<cffunction name="getSurveyByID" access="remote" returntype="struct" returnformat="JSON"
			hint="Gets all of the information about a specific survey including questions and responses.">
		<cfargument name="SurveyID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfinvoke component="survey" method="getSurveyByID" SurveyID="#ARGUMENTS.SurveyID#" returnvariable="LOCAL.SURVEY" />

			<cfset LOCAL.response = getSuccessResponse("")>
			<cfset LOCAL.response.DATA = LOCAL.SURVEY>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="getParticipantSuggestBySurveyID" access="remote" returntype="string" returnformat="JSON"
		hint="Used to find participants that have already started a survey. (primarily to collect post-data)">
		<cfargument name="SurveyID" type="numeric" required="true">
		<cfargument name="Term" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">
		<!--- TODO Need to add additional security to ensure this is protected --->

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfset LOCAL.response = ArrayNew(1)>

			<cfquery name="LOCAL.qClients">
				SELECT 	Name, ClientID, DateAdded
				FROM 	SurveyClient_tbl
				WHERE	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
				AND 	Name LIKE <cfqueryparam value="#ARGUMENTS.Term#%" cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfoutput query="LOCAL.qClients">
				<cfset LOCAL.person = StructNew()>
				<cfset LOCAL.person['label'] = LOCAL.qClients.Name & ' (collected: ' & DateFormat(LOCAL.qClients.DateAdded, "MM/DD/YYYY") & ')' >
				<cfset LOCAL.person['id'] = LOCAL.qClients.ClientID>
				<cfset LOCAL.person['value'] = LOCAL.qClients.Name>

				<cfset ArrayAppend(LOCAL.response, LOCAL.person)>
			</cfoutput>

			<cfreturn serializeJSON(LOCAL.response)>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="savePersonData" access="remote" returntype="struct" returnformat="JSON"
		hint="Saves data about a client when conducting a survey. If new client (no ID is passed in) it creates them. The client is returned as the DATA attrivute of the response">
		<cfargument name="ClientID" type="numeric" default="0">
		<cfargument name="SurveyID" type="numeric" required="true">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="Name" type="string" required="true">
		<cfargument name="Gender" type="string" required="true">
		<cfargument name="Age" type="string" required="true">
		<cfargument name="NumPeople" type="numeric" required="true">
		<cfargument name="Residence" type="string" required="true">
		<cfargument name="Language" type="string" required="true">
		<cfargument name="Income" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfset ARGUMENTS.AccountID = REQUEST.USER.AccountID>

			<!--- Check if the user exists --->
			<cfinvoke component="#APPLICATION.cfcpath#survey" method="checkSurveyClientNameExists" SurveyID="#ARGUMENTS.SurveyID#" ProgramID="#ARGUMENTS.ProgramID#" Name="#ARGUMENTS.Name#" ClientID="#ARGUMENTS.ClientID#" returnvariable="LOCAL.qCheck" />
			<cfif LOCAL.qCheck IS true>
				<cfreturn getErrorResponse("A client with this name already exists, please select a new name.")>
			</cfif>		

			<!--- If adding a new client --->
			<cfif NOT isDefined('ARGUMENTS.ClientID') OR ARGUMENTS.ClientID IS 0>
				<cfquery result="LOCAL.qClient">
					INSERT INTO SurveyClient_tbl
					(
						ProgramID, SurveyID, Name, Gender, Age, NumPeople, Residence, Language, Income, AccountID
					) VALUES (
						<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.Gender#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.Age#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.NumPeople#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#ARGUMENTS.Residence#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.Language#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#ARGUMENTS.Income#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#REQUEST.USER.AccountID#" cfsqltype="cf_sql_integer">
					)
				</cfquery>

				<cfset ARGUMENTS.CLIENTID = LOCAL.qClient.GeneratedKey>
			<cfelse>
				<!--- You can't update the program or survey id for a client. I was also going to make it so that you can't update the name once the survey has been started but I feel like there may be cases where it would be cleaner if you can update the name. Especially since it is just a UI anyways --->
				<cfquery>
					UPDATE SurveyClient_tbl
					SET
						Name = <cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="cf_sql_varchar">,
						Gender = <cfqueryparam value="#ARGUMENTS.Gender#" cfsqltype="cf_sql_varchar">,
						Age = <cfqueryparam value="#ARGUMENTS.Age#" cfsqltype="cf_sql_varchar">,
						NumPeople = <cfqueryparam value="#ARGUMENTS.NumPeople#" cfsqltype="cf_sql_integer">,
						Residence = <cfqueryparam value="#ARGUMENTS.Residence#" cfsqltype="cf_sql_varchar">,
						Language = <cfqueryparam value="#ARGUMENTS.Language#" cfsqltype="cf_sql_varchar">,
						Income = <cfqueryparam value="#ARGUMENTS.Income#" cfsqltype="cf_sql_varchar">,
						AccountID = <cfqueryparam value="#REQUEST.USER.AccountID#" cfsqltype="cf_sql_integer">
					WHERE ClientID = <cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">
				</cfquery>			
			</cfif>

			<cfset LOCAL.response = getSuccessResponse("Client has been saved.")>
			<cfset LOCAL.response.DATA = ARGUMENTS>
			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="getClientSurveyData" access="remote" returnformat="JSON" returntype="struct" 
		hint="Gets all of the survey data collected be a client">
		<cfargument name="SurveyID" type="numeric" required="true">
		<cfargument name="ClientID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- TODO - check to make sure this account has access to this survey --->
			<!--- Get the Client Data --->
			<cfquery name="LOCAL.qData">
				SELECT 	[Name],[Gender],[Age],[NumPeople],[Residence],[Language],[Income]
				FROM SurveyClient_tbl
				WHERE ClientID = <cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">
				<!--- TODO - Should only the person who collected the data be able to see this? Maybe a setting --->
			</cfquery>

			<cfset LOCAL.person = StructNew()>
			<cfset LOCAL.person.NAME 		= LOCAL.qData.Name>
			<cfset LOCAL.person.GENDER 		= LOCAL.qData.Gender> 
			<cfset LOCAL.person.AGE 		= LOCAL.qData.Age> 
			<cfset LOCAL.person.NUMPEOPLE 	= LOCAL.qData.NumPeople> 
			<cfset LOCAL.person.RESIDENCE 	= LOCAL.qData.Residence> 
			<cfset LOCAL.person.LANGUAGE 	= LOCAL.qData.Language> 
			<cfset LOCAL.person.INCOME 		= LOCAL.qData.Income>

			<!--- Get the Survey data --->
			<cfquery name="LOCAL.qSurveyData">
				SELECT 	PrePost, sr.AnswerID, sa.QuestionID FROM SurveyResponse_tbl sr
				INNER JOIN SurveyAnswer_tbl sa ON sa.AnswerID = sr.AnswerID
				WHERE 	ClientID = <cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">
				AND 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfset LOCAL.response = getSuccessResponse("Client-survey data retrieved.")>
			<cfset LOCAL.response.DATA.PERSON = LOCAL.person>
			
			<cfset LOCAL.response.DATA.PREDATA = StructNew()>
			<cfset LOCAL.response.DATA.POSTDATA = StructNew()>
			<cfoutput query="LOCAL.qSurveyData">
				<cfif LOCAL.qSurveyData.PrePost IS "Pre">
					<cfset LOCAL.response.DATA.PREDATA[LOCAL.qSurveyData.QuestionID] = LOCAL.qSurveyData.AnswerID>
				<cfelse>
					<cfset LOCAL.response.DATA.POSTDATA[LOCAL.qSurveyData.QuestionID] = LOCAL.qSurveyData.AnswerID>
				</cfif>
			</cfoutput>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="saveSurveyData" access="remote" returntype="struct" returnformat="JSON"
		hint="Saves the Pre and Post Survey data.">
		<cfargument name="SurveyID" type="numeric" required="true">
		<cfargument name="ClientID" type="numeric" required="true">
		<cfargument name="PreData" type="string" required="true">
		<cfargument name="PostData" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- check to make sure that this client has access to this survey --->
			<cfquery name="LOCAL.qCheck">
				SELECT 	ClientID, SurveyID
				FROM 	SurveyClient_tbl
				WHERE 	ClientID = <cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">
				AND 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfif LOCAL.qCheck.recordcount IS 0>
				<cfreturn getErrorResponse("This client is not a part of this survey.")>
			</cfif>

			<cftransaction>
				<!--- Clear existing data for this client --->
				<cfquery>
					DELETE 	FROM SurveyResponse_tbl
					WHERE 	ClientID = <cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">
					AND 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfloop list="#ARGUMENTS.PREDATA#" index="p">
					<cfquery>
						INSERT INTO SurveyResponse_tbl
						( 
							ClientID, SurveyID, AnswerID, PrePost 
						) VALUES (
							<cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#p#" cfsqltype="cf_sql_integer">,
							'Pre'
						)
					</cfquery>
				</cfloop>

				<cfloop list="#ARGUMENTS.POSTDATA#" index="p">
					<cfquery>
						INSERT INTO SurveyResponse_tbl
						( 
							ClientID, SurveyID, AnswerID, PrePost 
						) VALUES (
							<cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#p#" cfsqltype="cf_sql_integer">,
							'Post'
						)
					</cfquery>
				</cfloop>
			</cftransaction>

			<cfreturn getSuccessResponse("Survey Data has been collected, you can now collect for a new client.")>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

	<cffunction name="getNextClientID" access="remote" returntype="Struct" returnformat="JSON"
		hint="Gets the next available client ID for a specific program and survey and returns 'Client X' where X is the next available ID number.">
		<cfargument name="ProgramID" type="string" required="true">
		<cfargument name="SurveyID" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfquery name="LOCAL.qNextID">
				SELECT 	MAX(ClientID) + 1 AS ID
				FROM 	SurveyClient_tbl
				WHERE 	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
				AND 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfset LOCAL.response = getSuccessResponse("Client ID retrieved.")>
			<cfset LOCAL.response.DATA = "Client " & LOCAL.qNextID.ID>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
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
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
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
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

<!--- MARK APPLICATION FOR REVIEW --->
	<cffunction name="markApplicationForReview" access="remote" returnformat="JSON" returntype="Struct"
		hint="Marks the application / LOI ready for review. The system handles what status that needs to be set. (NOT SUBMITTED TO AIRDRIE - Internal Agency review process)">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- TODO Account Check --->

			<cfinvoke component="#APPLICATION.cfcpath#program" method="markApplicationForReview" programID="#ARGUMENTS.ProgramID#" returnvariable="LOCAL.marked" />
			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Your information has been saved for review.")>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

<!--- MARK APPLICATION SUBMITTED --->
	<cffunction name="markApplicationSubmitted" access="remote" returnformat="JSON" returntype="Struct"
		hint="Marks the application / LOI Submitted for review by Airdrie. The system handles what status that needs to be set.">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<!--- TODO Account Check --->

			<cfinvoke component="#APPLICATION.cfcpath#program" method="markApplicationSubmitted" programID="#ARGUMENTS.ProgramID#" returnvariable="LOCAL.marked" />
			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Your information has been submitted to the City of Airdrie.")>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

<!--- MARK APPLICATION APPROVED --->
	<cffunction name="markApplicationApproved" access="remote" returnformat="JSON" returntype="Struct"
		hint="Marks the application / LOI as approved and ready for the next step">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfif isAdminAccount()> <!--- Only if this is an admin account --->
				<cfquery name="LOCAL.qProgramStatus">
					SELECT 	s.Status
					FROM 	ProgramStatus_tbl ps
					INNER JOIN Status_tbl s ON ps.StatusID = s.StatusID
					WHERE 	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
					ORDER BY DateAdded DESC
				</cfquery>

				<cfset LOCAL.StatusList = ValueList(LOCAL.qProgramStatus.Status)>

				<cfif ListFindNoCase(LOCAL.StatusList, "LOI - Approved") EQ 0>
					<!--- Approve the LOI --->
					<cfquery>
						INSERT INTO ProgramStatus_tbl
						( 
							ProgramID, StatusID, AccountID 
						) VALUES (
							<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
							(SELECT StatusID FROM Status_tbl WHERE Status = 'LOI - Approved'),
							<cfqueryparam value="#REQUEST.USER.ACCOUNTID#" cfsqltype="cf_sql_varchar">
						)
					</cfquery>
				<cfelseif ListFindNoCase(LOCAL.StatusList, "APPLICATION - Approved") EQ 0>
					<!--- Approve the Application --->
					<cfquery>
						INSERT INTO ProgramStatus_tbl
						( 
							ProgramID, StatusID, AccountID 
						) VALUES (
							<cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">,
							(SELECT StatusID FROM Status_tbl WHERE Status = 'APPLICATION - Approved'),
							<cfqueryparam value="#REQUEST.USER.ACCOUNTID#" cfsqltype="cf_sql_varchar">
						)
					</cfquery>
				</cfif>

				<cfreturn getSuccessResponse("Program status has been updated.")>
			</cfif>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

<!--- MARK PROGRAM FUNDED --->
	<cffunction name="markProgramFunded" access="remote" returnformat="JSON" returntype="Struct"
		hint="Marks the program funded and sets the FundsAllocated field in the program table">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="Amount" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf AND isAdminAccount()>
			<cfinvoke component="#APPLICATION.cfcpath#program" method="markProgramFunded" programID="#ARGUMENTS.ProgramID#" Amount="#ARGUMENTS.Amount#" returnvariable="LOCAL.marked" />
			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> This program has been marked as funded.")>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

<!--- WEB FUNCTIONS RELATED TO BOARD MEMBERS --->
	<cffunction name="updateBoardMembers" access="remote" returnformat="JSON" returntype="struct"
		hint="Removes and inserts the board members passed in through an array.">
		<cfargument name="BoardMembers" type="string" required="true">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AGENCYID#">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfset ARGUMENTS.BoardMembers = DeSerializeJSON(ARGUMENTS.BoardMembers)>

			<cfinvoke component="#APPLICATION.cfcpath#board" method="updateBoardMembers" argumentcollection="#ARGUMENTS#"  returnvariable="LOCAL.BoardMembers" />

			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Board members saved.")>
			<cfset LOCAL.response.DATA = LOCAL.BoardMembers>
			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>

<!--- WEB FUNCTIONS FOR DOCUMENTS --->
	<cffunction name="setDocumentTypeByDocumentID" access="remote" returnformat="JSON" returntype="struct"
		hint="Update the type of document to label it as a specific required document">
		<cfargument name="DocumentID" type="numeric" required="true">
		<cfargument name="DocumentTypeID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
		<!--- Set accountID and AgencyID to defaults even if they are passed in through the web services which restricts creating with accounts or agency's 
			  you don't have permission to, you CAN however do it through coldfusion in the program.cfc --->
			<cfset ARGUMENTS.AccountID = REQUEST.USER.AccountID>
			<cfset ARGUMENTS.AgencyID = REQUEST.AGENCY.AgencyID>

			<cfinvoke component="#APPLICATION.cfcpath#document" method="setDocumentTypeByDocumentID" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.document" />

			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Document type has been updated.")>
			<cfset LOCAL.response.DATA = LOCAL.document>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

	<cffunction name="removeDocument" access="remote" returnformat="JSON" returntype="struct"
		hint="Remove a document from an Agency.">
		<cfargument name="DocumentID" type="numeric" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
		<!--- Set accountID and AgencyID to defaults even if they are passed in through the web services which restricts creating with accounts or agency's 
			  you don't have permission to, you CAN however do it through coldfusion in the program.cfc --->
			<cfset ARGUMENTS.AccountID = REQUEST.USER.AccountID>
			<cfset ARGUMENTS.AgencyID = REQUEST.AGENCY.AgencyID>

			<cfinvoke component="#APPLICATION.cfcpath#document" method="removeDocument" argumentcollection="#ARGUMENTS#" returnvariable="LOCAL.removed" />

			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> This document has been removed.")>
			<cfset LOCAL.response.DATA = LOCAL.removed>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

<!--- WEB FUNCTIONS RELATING TO THE BUDGET --->
	<cffunction name="saveBudget" access="remote" returntype="struct" returnformat="JSON"
		hint="Updates a budget based on the information passed in.">
		<cfargument name="BudgetID" type="numeric" required="true">
		<cfargument name="Revenues" type="string" required="true">
		<cfargument name="Expenses" type="string" required="true">
		<cfargument name="Staff" type="string" required="true">
		<cfargument name="PreviousYearBudget" type="numeric" default="0">
		<cfargument name="RequestedFromAirdrie" type="numeric" default="0">
		<cfargument name="RevenuesExplanation" type="string" required="true">
		<cfargument name="ExpendituresExplanation" type="string" required="true">
		<cfargument name="DistributionTotals" type="string" required="true">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfset LOCAL.ARGS = StructNew()>

			<cfset LOCAL.ARGS.BUDGETID = ARGUMENTS.BudgetID>
			<cfset LOCAL.ARGS.AccountID = REQUEST.USER.AccountID>
			<cfset LOCAL.ARGS.Revenues = deserializeJSON(ARGUMENTS.Revenues)>
			<cfset LOCAL.ARGS.Expenses = deserializeJSON(ARGUMENTS.Expenses)>
			<cfset LOCAL.ARGS.Staff = deserializeJSON(ARGUMENTS.Staff)>
			<cfset LOCAL.ARGS.PreviousYearBudget = ARGUMENTS.PreviousYearBudget>
			<cfset LOCAL.ARGS.RequestedFromAirdrie = ARGUMENTS.RequestedFromAirdrie>
			<cfset LOCAL.ARGS.RevenuesExplanation = ARGUMENTS.RevenuesExplanation>
			<cfset LOCAL.ARGS.ExpendituresExplanation = ARGUMENTS.ExpendituresExplanation>
			<cfset LOCAL.ARGS.DistributionTotals = deserializeJSON(ARGUMENTS.DistributionTotals)>

			<cfinvoke component="#APPLICATION.cfcpath#budget" method="saveBudget" argumentcollection="#LOCAL.ARGS#" returnvariable="LOCAL.budget" />

			<cfif LOCAL.budget IS true>
				<cfset LOCAL.response = getSuccessResponse("Budget has been updated.")>
			<cfelse>
				<cfset LOCAL.response = getErrorResponse("There was a problem saving this budget.")>
			</cfif>
			<cfset LOCAL.response.BUDGETID = ARGUMENTS.BUDGETID>
			<cfset LOCAL.response.SAVED = LOCAL.budget>

			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	

<!--- WEB FUNCTIONS RELATED TO SYSTEM ADMINISTRATION --->
	<cffunction name="saveSettings" access="remote" returntype="Struct" returnformat="JSON"
		hint="Saves the system settings.">
		<cfargument name="MaxCharacterLength" type="numeric" required="false">
		<cfargument name="isEnabledApplications" type="boolean" required="false">
		<cfargument name="isEnabledLetterOfIntent" type="boolean" required="false">
		<cfargument name="SupportNumber" type="string" required="false">
		<cfargument name="AdminEmail" type="string" required="false">
		<cfargument name="SuperPassword" type="string" required="false">
		<cfargument name="csrf" type="string" required="true" hint="Must match a valid CSRF cookie token">

		<cfif ARGUMENTS.csrf EQ COOKIE.csrf>
			<cfif NOT isAdminAccount()>
				<cfreturn getErrorResponse("<strong>Sorry!</strong> This account does not have permission to save the settings.")>
			</cfif>

			<!--- TODO - update the settings to not be optional, doing this different than I initially thought of it so needs some cleanup --->			
			<cfquery>
				UPDATE Settings_tbl
				SET DateUpdated = GetDate(),
					AccountID = <cfqueryparam value="#REQUEST.User.AccountID#" cfsqltype="cf_sql_integer">
					<cfif isDefined('ARGUMENTS.MaxCharacterLength')>
						,MaxCharacterLength = <cfqueryparam value="#ARGUMENTS.MaxCharacterLength#" cfsqltype="cf_sql_integer">
					</cfif>
					<cfif isDefined('ARGUMENTS.isEnabledLetterOfIntent')>
						,isEnabledLetterOfIntent = <cfqueryparam value="#ARGUMENTS.isEnabledLetterOfIntent#" cfsqltype="cf_sql_integer">
					</cfif>
					<cfif isDefined('ARGUMENTS.isEnabledApplications')>
						,isEnabledApplications = <cfqueryparam value="#ARGUMENTS.isEnabledApplications#" cfsqltype="cf_sql_integer">
					</cfif>
					<cfif isDefined('ARGUMENTS.SuperPassword')>
						,SuperPassword = <cfqueryparam value="#ARGUMENTS.SuperPassword#" cfsqltype="cf_sql_varchar">
					</cfif>
					<cfif isDefined('ARGUMENTS.SupportNumber')>
						,SupportNumber = <cfqueryparam value="#ARGUMENTS.SupportNumber#" cfsqltype="cf_sql_varchar">
					</cfif>
					<cfif isDefined('ARGUMENTS.AdminEmail')>
						,AdminEmail = <cfqueryparam value="#ARGUMENTS.AdminEmail#" cfsqltype="cf_sql_varchar">
					</cfif>
			</cfquery>

			<cfset LOCAL.response = getSuccessResponse("<strong>Success!</strong> Settings have been saved.")>
			<cfset LOCAL.response.DATA = ARGUMENTS>
			<cfreturn LOCAL.response>
		<cfelse>
			<cfthrow message="An error has occurred, please try again later." />
		</cfif>
	</cffunction>	
</cfcomponent>
