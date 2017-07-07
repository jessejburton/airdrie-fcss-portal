<cfinclude template="shared/header.cfm">

<cfset dir = "#APPLICATION.importfullpath#">
<cffile action="upload" destination="#dir#" filefield="import_file_select" nameconflict="makeunique">

<cfset valid = "xls,xlsx">

<!--- MAIN CONTENT --->
    <section id="main_content">
        <div class="wrapper clearfix">

<!--- Get lookup values --->
<cfset LOOKUPS = StructNew()>
<cfinvoke component="#APPLICATION.cfcpath#core" method="getLookupValuesByType" Type="Gender" returnvariable="LOOKUPS.GENDER" />
<cfinvoke component="#APPLICATION.cfcpath#core" method="getLookupValuesByType" Type="Age" returnvariable="LOOKUPS.AGE" />
<cfinvoke component="#APPLICATION.cfcpath#core" method="getLookupValuesByType" Type="Residence" returnvariable="LOOKUPS.RESIDENCE" />
<cfinvoke component="#APPLICATION.cfcpath#core" method="getLookupValuesByType" Type="Language" returnvariable="LOOKUPS.LANGUAGE" />
<cfinvoke component="#APPLICATION.cfcpath#core" method="getLookupValuesByType" Type="Income" returnvariable="LOOKUPS.INCOME" />  

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

    <cfset NewClients = 0>
    <cfset SurveysCollected = 0>
    <cfset Errors = 0>

    <!--- Get the survey data --->
    <cfinvoke component="#APPLICATION.cfcpath#webservices" method="getSurveyByID" csrf="#COOKIE.CSRF#" SurveyID="#SURVEYID#" returnvariable="response" />
    <cfset REQUEST.SURVEY = response.DATA>

    <cfoutput query="qImport">
        <cftry>
            <!--- VALIDATE LOOKUP VALUES --->
            <cfset validationCheck = "">
            <cfif ListFindNoCase("Pre,Post", TRIM(qImport["Pre/Post"][CurrentRow])) IS 0>
                <cfset validationCheck = "Invalid value from PrePost">
            </cfif>
            <cfif ArrayFindNoCase(LOOKUPS.GENDER, TRIM(qImport["Gender"][CurrentRow])) IS 0 AND LEN(validationCheck) IS 0>
                <cfset validationCheck = "Invalid gender specified">
            </cfif>
            <cfif ArrayFindNoCase(LOOKUPS.AGE, TRIM(qImport["Age"][CurrentRow])) IS 0 AND LEN(validationCheck) IS 0>
                <cfset validationCheck = "Invalid age specified">
            </cfif>
            <cfif ArrayFindNoCase(LOOKUPS.RESIDENCE, TRIM(qImport["Residence"][CurrentRow])) IS 0 AND LEN(validationCheck) IS 0>
                <cfset validationCheck = "Invalid residence specified">
            </cfif>
            <cfif ArrayFindNoCase(LOOKUPS.LANGUAGE, TRIM(qImport["Language"][CurrentRow])) IS 0 AND LEN(validationCheck) IS 0>
                <cfset validationCheck = "Invalid language specified">
            </cfif>
            <cfif ArrayFindNoCase(LOOKUPS.INCOME, TRIM(qImport["Income"][CurrentRow])) IS 0 AND LEN(validationCheck) IS 0>
                <cfset validationCheck = "Invalid income specified">
            </cfif>

            <cfif LEN(validationCheck) IS 0>            
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

                    <cfset NewClients ++>
                    <cfset ClientID = qClient.GeneratedKey>
                    <cfset c = StructNew()>
                    <cfset c.NAME = qImport["Name"][CurrentRow]>
                    <cfset c.MESSAGE = "added">
                    <cfset ArrayAppend(CLIENTS, c)>

                <!--- Now handle the responses --->
                <!--- Check if the client has completed this survey yet or not --->
                    <cfquery name="qCheck">
                        SELECT  ClientID FROM SurveyResponse_tbl
                        WHERE   ClientID = <cfqueryparam value="#ClientID#" cfsqltype="cf_sql_integer">
                        AND     PrePost = <cfqueryparam value="#qImport["Pre/Post"][CurrentRow]#" cfsqltype="cf_sql_varchar">  
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
                                    <cfqueryparam value="#qImport["Pre/Post"][CurrentRow]#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#ClientID#" cfsqltype="cf_sql_integer">
                                )
                            </cfquery>

                            <cfset i++>
                        </cfloop>
                        <cfif NOT StructKeyExists(SURVEYDATA, qImport["Name"][CurrentRow])>
                            <cfset SURVEYDATA[qImport["Name"][CurrentRow]] = StructNew()>
                        </cfif>

                        <cfif qImport["Pre/Post"][CurrentRow] IS "Pre">
                            <cfset SURVEYDATA[qImport["Name"][CurrentRow]].Pre = true>
                        <cfelseif qImport["Pre/Post"][CurrentRow] IS "Post">
                            <cfset SURVEYDATA[qImport["Name"][CurrentRow]].Post = true>
                        </cfif>

                        <cfset SurveysCollected ++>
                    <cfelse>
                        <cfset ex = StructNew()>
                        <cfset ex.NAME = "">
                        <cfset ex.MESSAGE = "#qImport["Pre/Post"][CurrentRow]# data for #qImport["Name"][CurrentRow]# has already been collected.">
                        <cfset ArrayAppend(EXCEPTIONS, ex)>
                    </cfif>
                </cfif>
            <cfelse>
                <cfset Errors ++>
                <cfset ex = StructNew()>
                <cfset ex.NAME = qImport["Name"][CurrentRow]>
                <cfset ex.MESSAGE = validationCheck>
                <cfset ArrayAppend(EXCEPTIONS, ex)>
            </cfif>
        <cfcatch>
            <cfset Errors ++>
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

    <cfoutput>
        <div class="autoreply autoreply-success autoreply-visible">
            <p><strong>Import Complete!</strong> Your import included <strong>#NewClients#</strong> new clients, <strong>#SurveysCollected#</strong> survey's collected and had <strong>#Errors#</strong> errors. <a href="<cfoutput>#APPLICATION.home#assets/documents/imports/#filename#.htm</cfoutput>" target="_blank">View Results</a><br /><br /><a href="outcome_measures.cfm?ProgramID=#FORM.import_program_id#"><<< Back to Outcome Measures</a></p>
        </div>
    </cfoutput>
</cfif>

</div></section>

<cfinclude template="shared/footer.cfm">