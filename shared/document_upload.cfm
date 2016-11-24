<cfset dir = "#ExpandPath('../' & APPLICATION.documentpath)#">
<cffile action="upload" destination="#dir#" filefield="upload_document" nameconflict="makeunique">

<cfinvoke component="#APPLICATION.cfcpath#document" method="getRequiredDocumentTypesByAgencyID" returnvariable="DOCUMENTTYPES" />

<!--- Check for executables --->
<cfif FindNoCase(".zip", FILE.ServerFile) NEQ 0
	OR FindNoCase(".exe", FILE.ServerFile) NEQ 0
	OR FindNoCase(".bat", FILE.ServerFile) NEQ 0>
	<cffile action="delete" file="#dir#\#FILE.ServerFile#" />
	<div class="document"><i class="fa fa-close"></i> Invalid File Type</div>
<cfelse>
	<cfinvoke component="#APPLICATION.cfcpath#document" method="addDocument" FileName="#FILE.ServerFile#" returnvariable="document" />
	<cfoutput>#serializeJSON(document)#</cfoutput>
</cfif>