<cfset dir = "#APPLICATION.documentfullpath#">
<cffile action="upload" destination="#dir#" filefield="upload_document" nameconflict="makeunique">

<cfinvoke component="#APPLICATION.cfcpath#document" method="getRequiredDocumentTypesByAgencyID" returnvariable="DOCUMENTTYPES" />

<cfset valid = "jpg,png,pdf,doc,docx,xls,xlsx,txt">

<!--- Check for executables --->
<cfif ListFindNoCase(valid, FILE.ServerFileExt) EQ 0>
	<cffile action="delete" file="#dir#\#FILE.ServerFile#" />
	<!--- Originally I had just use #valid# to display the types in this message but it looks strange without spaces and if you add spaces in to the list then the ListFindNoCase doesn't work properly --->
	<cfinvoke component="#APPLICATION.cfcpath#core" method="getErrorResponse" message="Document must be one of the following types: jpg, png, pdf, doc, docx, xls, xlsx, txt" returnvariable="response" />
	<cfoutput>#serializeJSON(response)#</cfoutput>
<cfelse>
	<cfinvoke component="#APPLICATION.cfcpath#document" method="addDocument" FileName="#FILE.ServerFile#" returnvariable="document" />
	<cfoutput>#serializeJSON(document)#</cfoutput>
</cfif>