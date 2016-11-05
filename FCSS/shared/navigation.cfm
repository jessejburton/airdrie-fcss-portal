<!--- FOR TESTING PURPOSES --->
<cfif isDefined('URL.hasSeen')>
	<cfset ArrayAppend(REQUEST.SEEN, URL.hasSeen)>
	<cfset ArrayAppend(SESSION.SEEN, URL.hasSeen)>
</cfif>

<!--- FOR TESTING PURPOSES --->


<!--- HEADER --->
	<section id="header" class="clearfix">
		<div class="pull-left">			
			<a href="javascript:;" id="header_logo_text">Airdrie FCSS Portal</a>
		</div>

		<div class="pull-right">
			<strong>Welcome</strong> 
			<cfif isDefined('SESSION.AGENCY.Name')>
				<cfoutput>#XMLFormat(SESSION.AGENCY.Name)#</cfoutput>
			</cfif>
		</div>
	</section>

<!--- Navigation --->
	<section id="page">	
		<div id="navigation_wrapper">
			<div id="navigation_mobile_button">
				<a href="javascript:;" class="menu" data-menu="#navigation"><i class="fa fa-menu"></i> menu</a>
			</div>
			<ul id="navigation">
				<cfif ArrayContains(REQUEST.SEEN, "New Agency Details") IS TRUE>
				   	<li><a href="agency_details.cfm"><i class="fa fa-user"></i> Agency Details </a></li>
				</cfif>
			   	<cfif ArrayContains(REQUEST.SEEN, "New Agency Details") IS TRUE AND ArrayContains(REQUEST.SEEN, "Letter of Intent") IS FALSE>
				   	<li><a href="letter_of_intent.cfm"><i class="fa fa-check-circle"></i> Letter of Intent </a></li>
				</cfif>
		   		<cfif ArrayContains(REQUEST.SEEN, "Letter Of Intent") IS TRUE>
				   	<li><a href="application_form.cfm"><i class="fa fa-check-circle"></i> Application Form</a></li>
				   	<li><a href="agency_survey_select.cfm"><i class="fa fa-check-circle"></i> Surveys</a></li>
				</cfif>
				<li class="logout-link"><a href="index.cfm?logout"><i class="fa fa-sign-out"></i> Logout</a></li>	
			</ul>
		</div>