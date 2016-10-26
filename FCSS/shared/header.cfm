<!DOCTYPE html>
<html>
<head>
	<title>FCSS Portal</title>

	<script src="assets/libs/jquery-3.1.1.min.js" type="text/javascript"></script>
	<script src="assets/js/common.js" type="text/javascript"></script>
	<script src="https://use.fontawesome.com/40939fccf0.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

	<!--- Include any page specific javascript --->
 	<cfset pagename = ReplaceNoCase(ListLast(cgi.script_name,"/"), ".cfm", "")>
 	<cfif FileExists(ExpandPath("assets/js/page/#pagename#.js"))>
 		<script src="assets/js/page/<cfoutput>#pagename#</cfoutput>.js" type="text/javascript"></script>
 	</cfif>

	<link href="https://fonts.googleapis.com/css?family=Open+Sans|Open+Sans+Condensed:300" rel="stylesheet" type="text/css" />
	<link href="assets/css/style.css" rel="stylesheet" type="text/css" />

</head>
<body>

<cfif NOT isDefined('REQUEST.loggedin') AND 1 IS 0>
	<cfinclude template="login.cfm">
	<cfinclude template="footer.cfm">
	<cfabort>
<cfelse>
	<cfinclude template="navigation.cfm">
</cfif>