<cfcomponent displayname="Document" extends="core">
	<cffunction name="getDocumentByID" returntype="Struct" returnformat="JSON" access="public"
		hint="Returns a document object by ID">
		<cfargument name="DocumentID" type="numeric" required="true">

		<cfquery name="LOCAL.qDocument">
			SELECT 	DocumentID, FileName, d.DocumentTypeID, dt.DocumentType, AgencyID
			FROM 	Document_tbl d
			INNER JOIN DocumentType_tbl dt ON d.DocumentTypeID = dt.DocumentTypeID 
			WHERE	DocumentID = <cfqueryparam value="#ARGUMENTS.DocumentID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfset LOCAL.response = StructNew()>
		<cfset LOCAL.response.DocumentID = ARGUMENTS.DocumentID>
		<cfset LOCAL.response.Filename = LOCAL.qDocument.Filename>
		<cfset LOCAL.response.DocumentTypeID = LOCAL.qDocument.DocumentTypeID> 
		<cfset LOCAL.response.DocumentType = LOCAL.qDocument.DocumentType>
		<cfset LOCAL.response.AgencyID = LOCAL.qDocument.AgencyID>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- Get a list of the required document types and if the agency has them or not --->
	<cffunction name="getRequiredDocumentTypesByAgencyID" returnformat="JSON" returntype="Array" access="public">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#">

		<cfquery name="LOCAL.qDocumentTypes">
			SELECT DocumentTypeID, DocumentType, isRequired,
				CAST((SELECT COUNT(DocumentID) FROM Document_tbl WHERE AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
					AND DocumentTypeID = dt.DocumentTypeID) AS bit) AS AgencyHasDocument
			FROM DocumentType_tbl dt
			ORDER BY isOrder
		</cfquery>

		<cfset LOCAL.response = ArrayNew(1)>

		<cfloop query="LOCAL.qDocumentTypes">
			<cfset LOCAL.documenttype = StructNew()>
			<cfset LOCAL.documenttype.TYPE = LOCAL.qDocumentTypes.DocumentType>
			<cfset LOCAL.documenttype.ID = LOCAL.qDocumentTypes.DocumentTypeID> 
			<cfset LOCAL.documenttype.REQUIRED = LOCAL.qDocumentTypes.isRequired>
			<cfset LOCAL.documenttype.HASDOCUMENT = LOCAL.qDocumentTypes.AgencyHasDocument>

			<cfset ArrayAppend(LOCAL.response, LOCAL.documenttype)>
		</cfloop>

		<cfreturn LOCAL.response>
	</cffunction>	

<!--- Get all of the documents associated with an agency --->
	<cffunction name="getDocumentsByAgencyID" returnformat="JSON" returntype="Array" access="public">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#">

		<cfquery name="LOCAL.qDocuments">
			SELECT 	DocumentID, Filename, d.DocumentTypeID, dt.DocumentType 
			FROM	Document_tbl d 
			INNER JOIN DocumentType_tbl dt ON d.DocumentTypeID = dt.DocumentTypeID
			WHERE	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			ORDER BY dt.isOrder, DateAdded DESC
		</cfquery>

		<cfset LOCAL.response = ArrayNew(1)>

		<cfloop query="LOCAL.qDocuments">
			<cfset LOCAL.document = StructNew()>
			<cfset LOCAL.document.ID = LOCAL.qDocuments.DocumentID>
			<cfset LOCAL.document.FILENAME = LOCAL.qDocuments.Filename>
			<cfset LOCAL.document.DOCUMENTTYPE = LOCAL.qDocuments.DocumentType>
			<cfset LOCAL.document.DOCUMENTTYPEID = LOCAL.qDocuments.DocumentTypeID>

			<cfset ArrayAppend(LOCAL.response, LOCAL.document)>
		</cfloop>

		<cfreturn LOCAL.response>
	</cffunction>

<!--- Add a document to an agency --->
	<cffunction name="addDocument" returntype="Struct" returnFormat="JSON" access="public"
		hint="Adds a document to an agency, sets the default type to Other">
		<cfargument name="FileName" type="string" required="true">
		<cfargument name="AccountID" type="numeric" default="#REQUEST.USER.AccountID#">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#">

		<cfquery result="LOCAL.qDocument">
			INSERT INTO Document_tbl
			( FileName, DocumentTypeID, AccountID, AgencyID )
			VALUES 
			(
				<cfqueryparam value="#ARGUMENTS.FileName#" cfsqltype="cf_sql_varchar">,
				(SELECT DocumentTypeID FROM DocumentType_tbl WHERE DocumentType = 'Other'),
				<cfqueryparam value="#ARGUMENTS.AccountID#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			)
		</cfquery>

		<cfreturn getDocumentByID(LOCAL.qDocument.GeneratedKey)>
	</cffunction>	

<!--- Remove a document from an agency --->
	<cffunction name="removeDocument" returntype="boolean" returnFormat="JSON" access="public"
		hint="Removes a document from an agency">
		<cfargument name="DocumentID" type="numeric" required="true">
		<cfargument name="AccountID" type="numeric" default="#REQUEST.USER.AccountID#">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#">

		<cfset LOCAL.document = getDocumentByID(ARGUMENTS.DocumentID)>

		<cfif LOCAL.document.AgencyID IS ARGUMENTS.AgencyID>
			<cfif FileExists(APPLICATION.documentfullpath & LOCAL.document.FILENAME)>
				<cffile action="delete" file="#APPLICATION.documentfullpath & LOCAL.document.FILENAME#" />
			</cfif>

			<cfquery>
				DELETE FROM Document_tbl WHERE DocumentID = <cfqueryparam value="#ARGUMENTS.DocumentID#" cfsqltype="cf_sql_integer"> 
			</cfquery>
		<cfelse>
			<cfthrow message="You do not have permission to remove this document.">
			<cfreturn false>
		</cfif>

		<cfreturn true>
	</cffunction>	

<!--- Update a documents type --->
	<cffunction name="setDocumentTypeByDocumentID" access="public" returnformat="JSON" returntype="struct"
		hint="Update the type of document to label it as a specific required document">
		<cfargument name="DocumentID" type="numeric" required="true">
		<cfargument name="DocumentTypeID" type="numeric" required="true">
		<cfargument name="AccountID" type="numeric" default="#REQUEST.USER.AccountID#">
		<cfargument name="AgencyID" type="numeric" default="#REQUEST.AGENCY.AgencyID#">

			<!--- First, remove this type from any other documents just in case. --->
			<cfquery>
				UPDATE 	Document_tbl
				SET 	DocumentTypeID = (SELECT DocumentTypeID FROM DocumentType_tbl WHERE DocumentType = 'Other')
				WHERE	DocumentTypeID = <cfqueryparam value="#ARGUMENTS.DocumentTypeID#" cfsqltype="cf_sql_integer">
				AND 	AgencyID = <cfqueryparam value="#ARGUMENTS.AgencyID#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfquery>
				UPDATE Document_tbl
				SET 	DocumentTypeID = <cfqueryparam value="#ARGUMENTS.DocumentTypeID#" cfsqltype="cf_sql_integer">
				WHERE	DocumentID = <cfqueryparam value="#ARGUMENTS.DocumentID#" cfsqltype="cf_sql_integer">
			</cfquery>

		<cfreturn getDocumentByID(ARGUMENTS.DocumentID)>
	</cffunction>	
</cfcomponent>