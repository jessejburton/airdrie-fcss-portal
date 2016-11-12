<cfcomponent displayname="Application" output="true">
	<cfset timeout = CreateTimeSpan(0,0,30,0)>
	
	<!--- Setup the Application --->
	<cfinclude template="this.ini">
    
    <!--- Function for the start of the application --->    
    <cffunction name="onApplicationStart" returnType="void" output="false">
		<cfinclude template="application.ini">
	</cffunction>
        
	<!--- Function for every request --->
	<cffunction name="onRequestStart" access="public" returntype="void">
	    <cfargument	name="targetpage" type="string" required="yes" />
        
        <!--- If they log out, kill the session vars and cookies --->
        <cfif isDefined('URL.init')>
            <cfset onApplicationStart()>
        </cfif> 

        <!--- If they log out, kill the session vars and cookies --->
		<cfif isDefined('URL.logout')>
        <!--- TESTING --->
            <cfset StructDelete(SESSION, "AGENCY")>
            <cfset StructDelete(SESSION, "APPLICATIONS")>
        <!--- TESTING --->
            <cfset StructDelete(SESSION, "LOGGEDIN")>
        </cfif>        

        <!--- Check if this is an ajax call or not --->
        <cfset REQUEST.isAjax = false>        
        <cfset LOCAL.headers = getHttpRequestData().headers /> 
        <cfset REQUEST.isAjax = structKeyExists(LOCAL.headers, "X-Requested-With") AND (LOCAL.headers["X-Requested-With"] EQ "XMLHttpRequest")>
        <cfif REQUEST.isAjax>
            <cfcontent type="application/json">
        </cfif> 

        <cfif NOT isDefined('SESSION.Agency')>
            <cfset REQUEST.isNewAgency = true>
        </cfif>

        <cfif isDefined('SESSION.loggedin')>
            <cfset REQUEST.loggedin = true>
        </cfif>
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
                <h1>ERROR HAPPENED</h1>
                <cfdump var="#except#">
                <!---<cfinvoke component="debug" method="sendDebugEmail" subject="Error" error="#except#" email="#APPLICATION.adminemail#" />--->
            </cfoutput>
        </cfif>
        
        <cfinvoke component="cfc.core" method="getErrorResponse" message="An error has occurred. The system administrator has been notified. Please try again later." returnvariable="LOCAL.response">
        
        <cfif IsDefined('REQUEST.isAJAX') AND REQUEST.isAjax>
            <cfoutput>#SERIALIZEJSON(LOCAL.response)#</cfoutput>
        <cfelse>
            <cfoutput>#LOCAL.response.MESSAGE#</cfoutput>
        </cfif>
    </cffunction>
    	
</cfcomponent>