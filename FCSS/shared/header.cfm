<!DOCTYPE html>
<html>
<head>
	<title>FCSS Portal</title>

	<script src="assets/libs/jquery-3.1.1.min.js" type="text/javascript"></script>
	<script src="assets/libs/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<script src="assets/js/common.js" type="text/javascript"></script>
	<script src="assets/js/form.js" type="text/javascript"></script>
	<script src="https://use.fontawesome.com/40939fccf0.js"></script>
	<!--<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>-->

	<!--- Include any page specific javascript --->
 	<cfset pagename = ReplaceNoCase(ListLast(cgi.script_name,"/"), ".cfm", "")>
 	<cfif FileExists(ExpandPath("assets/js/page/#pagename#.js"))>
 		<script src="assets/js/page/<cfoutput>#pagename#</cfoutput>.js" type="text/javascript"></script>
 	</cfif>

	<link href="https://fonts.googleapis.com/css?family=Open+Sans|Open+Sans+Condensed:300" rel="stylesheet" type="text/css" />
	<link href="assets/css/style.css?v=1.7" rel="stylesheet" type="text/css" />
	<link href="assets/libs/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css" />

	<meta name="viewport" content="width=500">

</head>
<body>

<cfif NOT isDefined('REQUEST.loggedin')>
	<link href="assets/css/login.css?v=1.1" rel="stylesheet" type="text/css" />
	<script src="assets/js/page/login.js" type="text/javascript"></script>

	<section id="header">Airdrie FCSS Portal</section>

	<section id="main_content">
		<cfinclude template="login.cfm">
	</section>

	<cfinclude template="footer.cfm">
	<cfabort>
<cfelse>
	<cfinclude template="navigation.cfm">
</cfif>