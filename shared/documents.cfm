<script src="assets/js/page/document.js"></script>

<cfinvoke component="#APPLICATION.cfcpath#document" method="getRequiredDocumentTypesByAgencyID" returnvariable="DOCUMENTTYPES" />
<cfinvoke component="#APPLICATION.cfcpath#document" method="getDocumentsByAgencyID" returnvariable="DOCUMENTS" />

<cfoutput>
	<cfif REQUEST.AGENCY.hasDocuments>
		<p id="has_documents" class="strong">You have uploaded all required documents.</p>
	<cfelse>
		<p id="has_documents" class="strong">Please upload the following documents:</p>
	</cfif>
	<ul id="document_type_display">
		<cfloop array="#DOCUMENTTYPES#" index="dt">
			<cfif dt.REQUIRED>
				<li id="ID_#dt.ID#" class="#iif(dt.HASDOCUMENT, DE('hidden'), DE(''))# required-document-type"><cfoutput>#dt.TYPE#</cfoutput></li>	
			</cfif>
		</cfloop>
	</ul>
</cfoutput>

<div id="document_upload_select">
	<form enctype="multipart/form-data" action="shared\document_upload.cfm" method="post" id="upload_document_form" >
		<p><input class="upload-document" name="upload_document" type="file" /></p>
	</form>
</div>

<h4>Current Documents</h4>
<p>Please remember to select the document type if applicable.</p>
<div id="current_documents">
	<cfif ArrayLen(DOCUMENTS) GT 0>
		<cfoutput>
			<cfloop array="#DOCUMENTS#" index="d">
				<div class="document" data-id="#d.ID#">
					<a href="javascript:;" class="remove-document inline" title="Remove this document."><i class="fa fa-times-circle"></i></a>
					<select class="document-type inline">
						<cfloop array="#DOCUMENTTYPES#" index="dt">
							<option value="#dt.ID#" #iif(d.DocumentTypeID IS dt.ID, DE('selected'), DE(''))#>#dt.TYPE#</option>
						</cfloop>
					</select>					
					<a href="#APPLICATION.documentpath#/#d.filename#" class="inline" target="_blank">#d.FILENAME#</a>					
				</div>	
			</cfloop>
		</cfoutput>
	<cfelse>
		<p id="no_documents">You do not currently have any documents uploaded.</p>
	</cfif>
	<input type="hidden" id="agency_has_documents" value="<cfoutput>#REQUEST.AGENCY.HASDOCUMENTS#</cfoutput>" class="required-hidden" data-validate="1" data-error="<strong>Error!</strong> Please make sure you have uploaded all of the required documents." />
</div>

<!--- TEMPLATES --->
	<!--- Upload Progress Template --->
	<div class="progress template">
		<div class="filename"></div>
		<div class="display_progress">
			<div class="bar"></div>
			<div class="percent">0%</div>
		</div>
	</div>
<cfoutput>
	<div class="document template">
		<a href="javascript:;" class="remove-document inline" title="Remove this document."><i class="fa fa-times-circle"></i></a>
		<select class="document-type inline">
			<cfloop array="#DOCUMENTTYPES#" index="dt">
				<option value="#dt.ID#" #iif(dt.TYPE IS "Other", DE('selected'), DE(''))#>#dt.TYPE#</option>
			</cfloop>
		</select>		
		<a href="#APPLICATION.documentpath#/" class="document-filename inline" target="_blank"></a>					
	</div>
</cfoutput>
