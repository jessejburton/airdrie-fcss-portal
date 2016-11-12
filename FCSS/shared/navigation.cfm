<!--- HEADER --->
	<section id="header" class="clearfix">
		<div class="pull-left">			
			<a href="index.cfm" id="header_logo_text">Airdrie FCSS Portal</a>
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
				<cfif isDefined('SESSION.Agency')>				   	
				   	<li><a href="programs.cfm"><i class="fa fa-check-circle"></i> Programs </a></li>
				   	<li><a href="agency_details.cfm"><i class="fa fa-user"></i> Agency Details </a></li>
				</cfif>
					<li class="logout-link"><a href="index.cfm?logout"><i class="fa fa-sign-out"></i> Logout</a></li>	
					<li class="logout-link"><a href="javascript:;" onclick="showResources();"><i class="fa fa-question"></i> Resources</a></li>	
			</ul>
		</div>