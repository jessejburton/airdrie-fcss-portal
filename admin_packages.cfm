<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<!--- GET THE CURRENT PACKAGES --->
<cfinvoke component="#APPLICATION.cfcpath#package" method="getPackages" returnvariable="qPackages" />
<!--- GET THE CURRENT PROGRAMS --->
<cfinvoke component="#APPLICATION.cfcpath#program" method="getAllPrograms" returnvariable="aPrograms" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Packages</h1>

			<form id="package_export_form" target="_blank" action="admin_create_package.cfm" method="post">
				<p>
					<select id="package_select" name="packageID">
						<option value="0">--- Please select a package ---</option>
						<cfoutput query="qPackages">
							<option value="#EncodeForHTMLAttribute(qPackages.PackageID)#">#XMLFormat(qPackages.PackageName)#</option>
						</cfoutput>
					</select>
				</p>

				<div id="programs">
					<p>
						<label for="programs">Choose which programs to include:</label><br />
						<label for="select_all_programs" class="small-text blue"><input type="checkbox" id="select_all_programs" /> select/deselect all</label>
					</p>
					<div id="program_list">
						<cfoutput>
							<cfloop array="#aPrograms#" index="p">
								<label for="program_#EncodeForHTMLAttribute(p.ProgramID)#"><input type="checkbox" name="programs" id="program_#EncodeForHTMLAttribute(p.ProgramID)#" value="#EncodeForHTMLAttribute(p.ProgramID)#" /> #XMLFormat(p.ProgramName)#</label><br />	
							</cfloop>
						</cfoutput>
					</div>
				</div>

				<div class="form-buttons clearfix">
					<p><button type="submit" id="export_package" class="btn btn-primary"><i class="fa fa-file-o"></i> Export Package</button></p>
				</div>	
			</form>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">