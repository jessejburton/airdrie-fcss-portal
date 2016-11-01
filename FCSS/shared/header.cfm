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
	<link href="assets/css/style.css?v=1.0" rel="stylesheet" type="text/css" />

	<meta name="viewport" content="width=500">

</head>
<body>

<cfif NOT isDefined('REQUEST.loggedin') AND 1 IS 1>
<link href="assets/css/login.css?v=1.0" rel="stylesheet" type="text/css" />

	<section id="header">Airdrie FCSS Portal</section>

	<div id="login_form_container">
		<cfinclude template="login.cfm">
	</div>

	<cfinclude template="footer.cfm">
	<cfabort>
<cfelse>
	<cfinclude template="navigation.cfm">
</cfif>