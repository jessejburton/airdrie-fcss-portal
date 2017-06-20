<!DOCTYPE html>
<html>
<head>
	<title>FCSS Portal</title>

	<link href="https://fonts.googleapis.com/css?family=Open+Sans|Open+Sans+Condensed:300" rel="stylesheet" type="text/css" />
	<link href="assets/css/style.css?v=<cfoutput>#REQUEST.CacheGUID#</cfoutput>" rel="stylesheet" type="text/css" />
	<link href="assets/libs/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css" />

	<meta name="viewport" content="width=500">

	<!--- Libraries --->
	<script src="assets/libs/jquery-3.1.1.min.js" type="text/javascript"></script>
	<script src="assets/libs/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<script src="assets/libs/jquery.form.min.js" type="text/javascript"></script>
	<script src="assets/libs/jquery.form.min.js" type="text/javascript"></script>
	<script src="https://use.fontawesome.com/40939fccf0.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script src="assets/libs/jquery.cookie.js" type="text/javascript"></script>
	<!--- Scripts --->
	<script src="assets/js/common.js?v=<cfoutput>#REQUEST.CacheGUID#</cfoutput>" type="text/javascript"></script>
	<script src="assets/js/form.js?v=<cfoutput>#REQUEST.CacheGUID#</cfoutput>" type="text/javascript"></script>

	<!--- Create Javascript variables from settings --->
	<script>
		var <cfoutput>#toScript(REQUEST.SETTINGS.MaxCharacterLength, "MaxCharacterLength")#</cfoutput>
	</script>
		
	<!--- Include any page specific javascript --->
 	<cfset pagename = ReplaceNoCase(ListLast(cgi.script_name,"/"), ".cfm", "")>
 	<cfif FileExists(ExpandPath("assets/js/page/#pagename#.js"))>
 		<script src="assets/js/page/<cfoutput>#pagename#</cfoutput>.js?v=<cfoutput>#REQUEST.CacheGUID#</cfoutput>" type="text/javascript"></script>
 	</cfif>

</head>
<body>

<cfif NOT StructKeyExists(REQUEST, "loggedin")>
	<link href="assets/css/login.css?v=<cfoutput>#REQUEST.CacheGUID#</cfoutput>" rel="stylesheet" type="text/css" />
	<script src="assets/js/page/login.js?v=<cfoutput>#REQUEST.CacheGUID#</cfoutput>" type="text/javascript"></script>

<!--- HEADER --->
	<section id="header" class="clearfix">
		<div class="pull-left">			
			<a href="index.cfm" id="header_logo_text">Airdrie FCSS Portal</a>
		</div>
	</section>

	<section id="main_content">
		<cfif isDefined('url.accountverify')>
			<script src="assets/js/page/verify.js?v=<cfoutput>#REQUEST.CacheGUID#</cfoutput>" type="text/javascript"></script>
			<cfinclude template="verify.cfm">
		<cfelse>
			<cfinclude template="login.cfm">
		</cfif>
	</section>

	<cfinclude template="footer.cfm">
	<cfabort>
<cfelse>
	<cfinclude template="navigation.cfm">
</cfif>