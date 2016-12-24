<cfinclude template="shared/header.cfm">

<!--- GET THE CURRENT PACKAGES --->
<cfinvoke component="#APPLICATION.cfcpath#program" method="getAllPrograms" returnvariable="aPrograms" />
<!--- GET THE CURRENT AGENCIES --->
<cfinvoke component="#APPLICATION.cfcpath#agency" method="GetAgencyList" returnvariable="aAgencies" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Packages</h1>

			<p>
				<select id="package_select">
					<option value="">CSAB Board Package</option>
					<option value="">Council Package</option>
					<option value="">Agency Details</option>
				</select>
			</p>

			<hr />

			<div class="clearfix">
				<div id="programs" class="half-column">
					<p>
						<label for="programs">Choose which programs to include:</label><br />
						<label for="select_all_programs" class="small-text blue"><input type="checkbox" id="select_all_programs" /> select/deselect all</label>
					</p>
					<div>
						<cfoutput>
							<cfloop array="#aPrograms#" index="p">
								<label for="program_#EncodeForHTMLAttribute(p.ProgramID)#"><input type="checkbox" name="programs" id="program_#EncodeForHTMLAttribute(p.ProgramID)#" value="#EncodeForHTMLAttribute(p.ProgramID)#" /> #XMLFormat(p.ProgramName)#</label><br />	
							</cfloop>
						</cfoutput>
					</div>
				</div>

				<div id="agencies" class="half-column">
					<p>
						<label for="agencies">Choose which agencies to include:</label><br />
						<label for="select_all_agencies" class="small-text blue"><input type="checkbox" id="select_all_agencies" /> select/deselect all</label>
					</p>
					<div>
						<cfoutput>
							<cfloop array="#aAgencies#" index="a">
								<label for="agency_#EncodeForHTMLAttribute(a.AgencyID)#"><input type="checkbox" name="agencies" id="agency_#EncodeForHTMLAttribute(a.AgencyID)#" value="#EncodeForHTMLAttribute(a.AgencyID)#" /> #XMLFormat(a.Name)#</label><br />	
							</cfloop>
						</cfoutput>
					</div>
				</div>
			</div>

			<div class="form-buttons clearfix">
				<button type="button" id="export_package" class="btn btn-primary pull-right"><i class="fa fa-file-o"></i> Export Package</button>
			</div>	
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">