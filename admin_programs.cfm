<cfinclude template="shared/header.cfm">

<!--- Get existing programs --->
<cfinvoke component="#APPLICATION.cfcpath#program" method="getAllPrograms" returnvariable="Programs" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div id="program_alerts">
				<h1><i class="fa fa-exclamation-circle"></i> Alerts</h1>
			</div>

			<h1>Programs</h1>

			<div id="current_programs">
				<cfoutput>
					<cfloop array="#Programs#" index="program">
						<div class="program">
							<cfdump var="#program#">
						</div>
					</cfloop>
				</cfoutput>
			</div>

		</div>
	</section>	

<cfinclude template="shared/footer.cfm">