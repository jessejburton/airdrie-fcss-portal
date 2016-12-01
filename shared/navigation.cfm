<!--- HEADER --->
	<section id="header" class="clearfix">
		<div class="pull-left">			
			<a href="index.cfm" id="header_logo_text">Airdrie FCSS Portal</a>
		</div>

		<div class="pull-right">
			<strong>Welcome</strong> 
			<cfif isDefined('REQUEST.USER.Name')>
				<cfoutput>#XMLFormat(REQUEST.USER.Name)#</cfoutput>
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
				<li><a href="index.cfm"><i class="fa fa-users"></i> Dashboard</a></li>
			<!--- Admin or Agency --->
			<cfif isDefined('REQUEST.Agency.ADMIN') AND REQUEST.Agency.ADMIN IS true>	
				<li><a href="admin_programs.cfm"><i class="fa fa-circle"></i> Programs</a></li>
				<li><a href="agencies.cfm"><i class="fa fa-group"></i> Agencies</a></li>	
				<li><a href="packages.cfm"><i class="fa fa-sticky-note-o"></i> Packages</a></li>			
				<li><a href="package_builder.cfm"><i class="fa fa-pencil-square-o"></i> Package Builder</a></li>
				<li><a href="settings.cfm"><i class="fa fa-cogs"></i> Settings</a></li>
			<cfelse>
			   	<li><a href="programs.cfm"><i class="fa fa-check-circle"></i> Programs </a></li>
			   	<li><a href="agency_details.cfm"><i class="fa fa-group"></i> Agency Details </a></li>
			</cfif>
				<li class="logout-link"><a href="index.cfm?logout"><i class="fa fa-sign-out"></i> Logout</a></li>	
				<li class="logout-link"><a href="javascript:;" onclick="showResources();"><i class="fa fa-question-circle"></i> Resources</a></li>	
			</ul>
		</div>