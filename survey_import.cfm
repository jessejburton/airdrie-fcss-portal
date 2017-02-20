<cfset dir = "#APPLICATION.importfullpath#">
<cffile action="upload" destination="#dir#" filefield="import_file_select" nameconflict="makeunique">

<cfset valid = "xls,xlsx">

<!--- Check for executables --->
<cfif ListFindNoCase(valid, FILE.ServerFileExt) EQ 0>
    <cffile action="delete" file="#dir#\#FILE.ServerFile#" />
    <!--- Originally I had just use #valid# to display the types in this message but it looks strange without spaces and if you add spaces in to the list then the ListFindNoCase doesn't work properly --->
    <cfinvoke component="#APPLICATION.cfcpath#core" method="getErrorResponse" message="Import files must be one of the following types: xls, xlsx" returnvariable="response" />
    <cfoutput>#serializeJSON(response)#</cfoutput>
<cfelse>
    <cfspreadsheet action="read" src="#dir#\#FILE.ServerFile#" query="qImport" headerrow="1" excludeHeaderRow="1">
    <cfset SURVEYID = FORM.IMPORT_SURVEY_ID>

    <cfoutput query="qImport">
        <cftry>
            <!--- Find out if the Client exists --->
            <cfquery name="qClient">
                SELECT  ClientID 
                FROM    SurveyClient_tbl 
                WHERE   LTRIM(RTRIM(Name)) = <cfqueryparam value='#TRIM(qImport["Name"][CurrentRow])#' cfsqltype="cf_sql_varchar">
                AND     SurveyID = <cfqueryparam value="#SURVEYID#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfif qClient.recordcount IS 1>
                <cfset ClientID = qClient.ClientID>
            <cfelse>
                <cfquery>
                    INSERT INTO SurveyClient_tbl
                    (
                        Name, 
                        Age, 
                        Gender,
                        NumPeople, 
                        Residence,
                        Language,
                        Income,
                        ProgramID,
                        SurveyID,
                        AccountID,
                        isImported
                    ) VALUES (
                        <cfqueryparam value="#qImport["Name"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#qImport["Age"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#qImport["Gender"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#qImport["People in Family"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#qImport["Residence"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#qImport["Language"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#qImport["Income"][CurrentRow]#" cfsqltype="cf_sql_varchar">,                        
                        <cfqueryparam value="#FORM.import_program_id#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#SURVEYID#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#REQUEST.User.AccountID#" cfsqltype="cf_sql_integer">,
                        1
                    )
                </cfquery>
            </cfif>
        <cfcatch>
            <!--- TODO - Write to logs and create output file --->
            <cfdump var="#CFCATCH#">
            <cfabort>
        </cfcatch>
        </cftry>
    </cfoutput> 

</cfif>