<cfinclude template="shared/header.cfm">

<cfset dir = "#APPLICATION.importfullpath#">
<cffile action="upload" destination="#dir#" filefield="import_file_select" nameconflict="makeunique">

<cfset valid = "xls,xlsx">

<!--- MAIN CONTENT --->
    <section id="main_content">
        <div class="wrapper clearfix">

<!--- Check for executables --->
<cfif ListFindNoCase(valid, FILE.ServerFileExt) EQ 0>
    <cffile action="delete" file="#dir#\#FILE.ServerFile#" />
    <p>Import files must be one of the following types: xls, xlsx</p>
<cfelse>
    <cfspreadsheet action="read" src="#dir#\#FILE.ServerFile#" query="qImport" headerrow="1" excludeHeaderRow="1" />
    <cfset SURVEYID = FORM.IMPORT_SURVEY_ID>
    <cfset CLIENTS = ArrayNew(1)>
    <cfset SURVEYDATA = StructNew()>
    <cfset EXCEPTIONS = ArrayNew(1)>

    <!--- Get the survey data --->
    <cfinvoke component="#APPLICATION.cfcpath#webservices" method="getSurveyByID" csrf="#COOKIE.CSRF#" SurveyID="#SURVEYID#" returnvariable="response" />
    <cfset REQUEST.SURVEY = response.DATA>

    <cfoutput query="qImport">
        <cftry>
            <!--- Find out if the Client exists --->
            <cfquery name="qClient">
                SELECT  ClientID, Name 
                FROM    SurveyClient_tbl 
                WHERE   LTRIM(RTRIM(Name)) = <cfqueryparam value='#TRIM(qImport["Name"][CurrentRow])#' cfsqltype="cf_sql_varchar">
                AND     SurveyID = <cfqueryparam value="#SURVEYID#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfif qClient.recordcount IS 1>
                <cfset ClientID = qClient.ClientID>
                <cfset c = StructNew()>
                <cfset c.NAME = qClient.Name>
                <cfset c.MESSAGE = "already exists">
                <cfset ArrayAppend(CLIENTS, c)>
            <cfelse>
                <cfquery result="qClient">
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

                <cfset ClientID = qClient.GeneratedKey>
                <cfset c = StructNew()>
                <cfset c.NAME = qImport["Name"][CurrentRow]>
                <cfset c.MESSAGE = "added">
                <cfset ArrayAppend(CLIENTS, c)>
            </cfif>

            <!--- Now handle the responses --->
            <!--- Check if the client has completed this survey yet or not --->
            <cfquery name="qCheck">
                SELECT  ClientID FROM SurveyResponse_tbl
                WHERE   ClientID = <cfqueryparam value="#ClientID#" cfsqltype="cf_sql_integer">
                AND     PrePost = <cfqueryparam value="#qImport["PrePost"][CurrentRow]#" cfsqltype="cf_sql_varchar">  
            </cfquery>

            <cfif qCheck.recordcount IS 0>
                <cfset i = 1>
                <cfloop array="#REQUEST.SURVEY.QUESTIONS#" index="q">
                    <cfset question = "Q#i#">
                    <!--- Get the Answer Response --->
                    <cfquery name="qAnswer">
                        SELECT  AnswerID FROM SurveyAnswer_tbl
                        WHERE   QuestionID = <cfqueryparam value="#q.QUESTIONID#" cfsqltype="cf_sql_integer">  
                        AND     LEFT(Answer, 1) = <cfqueryparam value="#TRIM(qImport[question][CurrentRow])#" cfsqltype="cf_sql_varchar">
                    </cfquery>
                    <!--- Insert the records --->
                    <cfquery>
                        INSERT INTO SurveyResponse_tbl 
                        (
                            AnswerID, SurveyID, PrePost, ClientID
                        ) VALUES (
                            <cfqueryparam value="#qAnswer.AnswerID#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#REQUEST.SURVEY.SURVEYID#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#qImport["PrePost"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#ClientID#" cfsqltype="cf_sql_integer">
                        )
                    </cfquery>

                    <cfset i++>
                </cfloop>
                <cfif NOT StructKeyExists(SURVEYDATA, qImport["Name"][CurrentRow])>
                    <cfset SURVEYDATA[qImport["Name"][CurrentRow]] = StructNew()>
                </cfif>

                <cfif qImport["PrePost"][CurrentRow] IS "Pre">
                    <cfset SURVEYDATA[qImport["Name"][CurrentRow]].Pre = true>
                <cfelseif qImport["PrePost"][CurrentRow] IS "Post">
                    <cfset SURVEYDATA[qImport["Name"][CurrentRow]].Post = true>
                </cfif>
            <cfelse>
                <cfset ex = StructNew()>
                <cfset ex.NAME = qImport["Name"][CurrentRow]>
                <cfset ex.MESSAGE = "#qImport["PrePost"][CurrentRow]# data for #qImport["Name"][CurrentRow]# has already been collected.">
                <cfset ArrayAppend(EXCEPTIONS, ex)>
            </cfif>
        <cfcatch>
        <cfdump var="#CFCATCH#"><cfabort>
            <cfset ex = StructNew()>
            <cfset ex.NAME = qImport["Name"][CurrentRow]>
            <cfset ex.MESSAGE = CFCATCH.MESSAGE & " " & CFCATCH.DETAIL>
            <cfset ArrayAppend(EXCEPTIONS, ex)>
        </cfcatch>
        </cftry>
    </cfoutput> 

    <!--- Write Output File --->
    <cfset FILEDATA = ""> 
    <cfloop array="#CLIENTS#" index="client">
        <cfset FILEDATA = FILEDATA & "#client.NAME# #client.MESSAGE#<br />">
    </cfloop>
    <cfloop list="#StructKeyList(SURVEYDATA)#" index="data">
        <cfif StructKeyExists(SURVEYDATA[data], "Pre")>
            <cfset FILEDATA = FILEDATA & "Pre data collected for #data#<br />">
        </cfif>
        <cfif StructKeyExists(SURVEYDATA[data], "Post")>
            <cfset FILEDATA = FILEDATA & "Post data collected for #data#<br />">
        </cfif>
    </cfloop>
    <cfloop array="#EXCEPTIONS#" index="exception">
        <cfset FILEDATA = FILEDATA & "#exception.NAME# #exception.MESSAGE#<br />">
    </cfloop>
    
    <cfset filename = "#REQUEST.AGENCY.NAME#_#year(now())#_#month(now())#_#day(now())#_#createUUID()#">
    <cffile action="write" file="#application.importfullpath##filename#.htm" nameconflict="overwrite" output="#FILEDATA#" />

    <p>Import complete. <a href="<cfoutput>#APPLICATION.home#assets/documents/imports/#filename#.htm</cfoutput>" target="_blank">View Results</a></p>
</cfif>

</div></section>

<cfinclude template="shared/footer.cfm">