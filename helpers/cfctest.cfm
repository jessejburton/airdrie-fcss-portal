<cftry>
	<cfset output = "test">
	<cffile action="write" file="#ExpandPath('error.html')#" nameconflict="overwrite" output="#output#" />
	<cfcatch>
		<cfdump var="#CFCATCH#">
	</cfcatch>
</cftry>


<cfabort>
<cfset component = "agency">
<cfset method = "GetAgencyByID">
<cfset args = StructNew()>
	<cfset args.ID = 1>


<cfinvoke component="#APPLICATION.cfcpath##component#" method="#method#" argumentcollection="#args#" returnvariable="response" />
<cfdump var="#response#">