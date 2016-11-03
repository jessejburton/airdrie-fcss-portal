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
            <cfset StructDelete(SESSION, "LOGGEDIN")>
        </cfif>        

        <!--- Check if this is an ajax call or not --->
        <cfset REQUEST.isAjax = false>        
        <cfset LOCAL.headers = getHttpRequestData().headers /> 
        <cfset REQUEST.isAjax = structKeyExists(LOCAL.headers, "X-Requested-With") AND (LOCAL.headers["X-Requested-With"] EQ "XMLHttpRequest")>
        <cfif REQUEST.isAjax>
            <cfcontent type="application/json">
        </cfif> 

        <cfset REQUEST.NEWAGENCY = false>
        <cfif isDefined('SESSION.loggedin')>
            <!--- TODO - check to see if the session is still valid --->
            <cfset REQUEST.NEWAGENCY = SESSION.NEWAGENCY>
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
        <cflog file="#This.Name#" type="error" text="Message is: #except.message#">
        <!--- Throw validation errors to ColdFusion for handling. --->
        <cfif Find("coldfusion.filter.FormValidationException",
                         Arguments.Except.StackTrace)>
            <cfthrow object="#except#">
        <cfelse>
            <!--- You can replace this cfoutput tag with application-specific 
                    error-handling code. --->
            <cfoutput>
            	<p>An error has occurred. The system administrator has been notified.</p>                
            </cfoutput>
        </cfif>

		<cfsavecontent variable="errordetails">
        	<cfoutput>
            	<p>Error from - #CGI.SCRIPT_NAME#</p>
                <p>Details - #except#</p>
                <cfif isDefined('except.cause.detail')>
                	<p>More Details - #except.cause.detail#</p>
                </cfif>
                <cfdump var="#except#">
                <cfdump var="#FORM#">
                <cfdump var="#CGI#">
                <cfif isDefined('SESSION')>
	                <cfdump var="#SESSION#">
                </cfif>
                <cfdump var="#REQUEST#">
            </cfoutput>
        </cfsavecontent>
        <cfoutput>#errordetails#</cfoutput>
        <!---<cfmail to="#APPLICATION.adminemail#" from="no-reply@airdrie.ca" type="html" subject="Error from #application.title#">
        	<cfoutput>#errordetails#</cfoutput>
        </cfmail>--->
    </cffunction>
    	
</cfcomponent>