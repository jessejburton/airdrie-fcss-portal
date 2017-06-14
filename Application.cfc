<cfcomponent displayname="Application" output="true">
    <cfset timeout = CreateTimeSpan(0,0,30,0)>

	<!--- Setup the Application --->
	<cfinclude template="this.ini">
    
    <!--- Function for the start of the application --->    
    <cffunction name="onApplicationStart" returnType="void" output="false">
		<cfinclude template="application.ini">
        
        <!--- THIS CODE CAN BE USED TO WORK ON A SYSTEM WITHOUT THE BCRYPT LIBRARY 
        <cftry>
            <cfset APPLICATION.BCRYPT = createObject("java", "sorg.mindrot.jbcrypt.BCrypt")>
        <cfcatch>
        <cfset APPLICATION.BCRYPT = createObject("component", "#APPLICATION.cfcpath#BCryptAlt")>
        </cfcatch>
        </cftry>--->

	</cffunction>
        
	<!--- Function for every request --->
	<cffunction name="onRequestStart" access="public" returntype="void">
	    <cfargument	name="targetpage" type="string" required="yes" />
        
        <!--- If they log out, kill the session vars and cookies --->
        <cfif isDefined('URL.init')>
            <cfset onApplicationStart()> 
        </cfif> 

        <!--- If they log out, kill the session vars and cookies --->
        <cflock scope="Session" type="readonly" timeout="10">
    		<cfif isDefined('URL.logout')>    
                <cfif StructKeyExists(SESSION, "ACCOUNTID")>
                    <cfinvoke component="#APPLICATION.cfcpath#core" method="writeLog" Details="Logout for account ID: #SESSION.AccountID#" />
                    <cfset StructDelete(SESSION, "LOGGEDIN")>
                    <cfset StructDelete(SESSION, "ACCOUNTID")>
                    <cflocation url="#application.home#" addtoken="false" />
                <cfelse>
                    <cflocation url="#application.home#" addtoken="false" />
                </cfif>                
            </cfif> 
        </cflock>     

        <!--- Cross Site Request Forgery --->
        <cfif NOT structKeyExists(COOKIE, 'csrf')>
            <cfcookie name="csrf" value='#HASH(CREATEUUID(), "sha-256", "utf-8")#' secure="false" httpOnly="false">
        </cfif>  

        <!--- Check if this is an ajax call or not --->
        <cfset REQUEST.isAjax = false>        
        <cfset LOCAL.headers = getHttpRequestData().headers /> 
        <cfset REQUEST.isAjax = structKeyExists(LOCAL.headers, "X-Requested-With") AND (LOCAL.headers["X-Requested-With"] EQ "XMLHttpRequest")>
        <cfif REQUEST.isAjax>
            <cfcontent type="application/json">
        </cfif> 

        <cflock scope="Session" type="readonly" timeout="10">
            <cfif StructKeyExists(SESSION, "ACCOUNTID")>
                <cfset REQUEST.LOGGEDIN = true>
                <cfinvoke component="#APPLICATION.cfcpath#account" method="getAccountByID" accountID="#SESSION.AccountID#" returnvariable="REQUEST.USER" />
                <cfinvoke component="#APPLICATION.cfcpath#agency" method="getAgencyByID" agencyID="#REQUEST.USER.AGENCYID#" returnvariable="REQUEST.AGENCY" />
                <cfif SESSION.GUID NEQ REQUEST.USER.GUID>
                    <cflocation url="index.cfm?logout" addtoken="false"> <!--- This user account has been disabled --->
                </cfif>
            </cfif>
        </cflock>

        <cfif APPLICATION.environment IS "development">
            <cfset REQUEST.CacheGUID = CreateUUID()>
        <cfelse>
            <cfset REQUEST.CacheGUID = APPLICATION.version>
        </cfif>

        <cfset REQUEST.SETTINGS = getSettings()>
	</cffunction>    
    
	
	<!--- Function for the start of a session --->
	<cffunction name="onSessionStart" returntype="void">
    	<cfset SESSION.IPAddress = CGI.REMOTE_ADDR>
	</cffunction>
	
	<!--- Function for the end of a session --->
	<cffunction name="onSessionEnd" returntype="void">
		<cfargument name = "SessionScope" required="yes" />
    	<cfargument name = "ApplicationScope" required="yes" />
	</cffunction>
	
	<!--- Function for the end of a request --->
	<cffunction name="onRequestEnd" access="public" returntype="void">

	</cffunction>   
    
    <!--- Function for any errors that occur --->
    <cffunction name="onError" access="public" returntype="void">
        <cfargument name="Except" required=true/>
        <cfargument type="String" name = "EventName" required=true/>
        <!--- Log all errors in an application-specific log file. --->
        <cflog file="#APPLICATION.ApplicationName#" type="error" text="Message: #except#">
        
        <!--- Throw validation errors to ColdFusion for handling. --->
        <cfif Find("coldfusion.filter.FormValidationException",
            Arguments.Except.StackTrace)>
            <cfthrow object="#ARGUMENTS.Except#">
        <cfelse>
            <cfoutput>
                <cfif APPLICATION.environment IS "production" OR (isDefined('REQUEST.isAjax') AND REQUEST.isAjax)>                    
                    <cfinvoke component="#APPLICATION.cfcpath#core" error="#EXCEPT#" session="#SESSION#" request="#REQUEST#" form="#FORM#" method="sendErrorEmail" />
                <cfelseif APPLICATION.environment IS "development" OR APPLICATION.environment IS "testing">
                    <cfdump var="#EXCEPT#">
                    <cfdump var="#REQUEST#">
                    <cfdump var="#FORM#">
                    <cfdump var="#SESSION#">
                </cfif>
            </cfoutput>
        </cfif>
        
        <cfinvoke component="#APPLICATION.cfcpath#core" method="getErrorResponse" message="An error has occurred. The system administrator has been notified. Please try again later." returnvariable="LOCAL.response">

        <cfif APPLICATION.environment IS "development">
            <cfset LOCAL.response.MESSAGE = EXCEPT.MESSAGE & ' ' & EXCEPT.DETAIL>
            <cfset LOCAL.response.DETAIL = EXCEPT.DETAIL>
        </cfif>
        
        <cfif IsDefined('REQUEST.isAJAX') AND REQUEST.isAjax>
            <cfoutput>#SERIALIZEJSON(LOCAL.response)#</cfoutput>
        <cfelse>
            <cfoutput>#LOCAL.response.MESSAGE#</cfoutput>
        </cfif>
    </cffunction>

    <cffunction name="getSettings" access="private" returntype="struct" returnformat="JSON">
        <cfquery name="LOCAL.qSettings">
            SELECT  *
            FROM    Settings_tbl
        </cfquery>

        <cfset LOCAL.SETTINGS = StructNew()>
        <cfloop list="#LOCAL.qSettings.columnList#" index="col">
            <cfset LOCAL.SETTINGS[col] = LOCAL.qSettings[col][1]>
        </cfloop>

        <cfreturn LOCAL.SETTINGS>
    </cffunction>
    	
</cfcomponent>