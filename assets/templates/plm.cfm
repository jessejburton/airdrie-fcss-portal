<cfif StructKeyExists(ATTRIBUTES, "ProgramID")>
	<h1>Program Logic Model</h1>

	<cfquery name="qPLM">
		SELECT 	Filename, DocumentID
		FROM 	Document_tbl
		WHERE 	DocumentTypeID = (SELECT DocumentTypeID FROM DocumentType_tbl WHERE DocumentType = 'Program Logic Model')
		AND 	ProgramID = <cfqueryparam value="#ATTRIBUTES.ProgramID#" cfsqltype="cf_sql_integer">
	</cfquery>	

	<cfif qPLM.recordcount IS 0>
		<p>No Program Logic Model submitted</p>
	<cfelse>
		<cfoutput>
			<a href="#APPLICATION.documentpath#/#EncodeForHTMLAttribute(qPLM.Filename)#" target="_blank">#EncodeForHtml(qPLM.Filename)#</a>	
		</cfoutput>
	</cfif>
</cfif>