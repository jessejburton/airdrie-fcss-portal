<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<!--- Hidden Data --->
<input type="hidden" id="document_path" value="<cfoutput>#XMLFormat(APPLICATION.documentpath)#</cfoutput>">

<!--- Get Agency Data --->
<cfinvoke component="#APPLICATION.cfcpath#agency" method="GetAgencyList" returnvariable="aAgencies" />
<!--- AgencyID, Address, DateAdded, Email, Fax, isActive, MailingAddress, Mission, Vision, Name, Phone, Website --->

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Agencies</h1>

			<p>
				<label for="agency_select">Select an Agency:</label><br />
				<select id="agency_select" class="input-half">
					<option value="0" class="hidden">--- Please select an agency ---</option>
					<cfoutput>
						<cfloop array="#aAgencies#" index="agency">
							<option value="#agency.AgencyID#">#agency.Name#</option>
						</cfloop>
					</cfoutput>
				</select>
			</p>

			<div id="agency_display" class="hidden">
				<h1 class="agency_name"></h1>
				<h4>Mission</h4>
				<p class="agency_mission"></p>
				<h4>Vision</h4>
				<p class="agency_vision"></p>
				<h4>Address</h4>
				<p class="agency_address"></p>
				<h4>Mailing Address</h4>
				<p class="agency_mailingaddress"></p>
				<h4>Phone</h4>
				<p class="agency_phone"></p>
				<h4>Email</h4>
				<p class="agency_email"></p>
				<h4>Fax</h4>
				<p class="agency_fax"></p>
				<h4>Website</h4>
				<p><a target="_blank" class="agency_website link"></a></p>
				<hr />
				<h4>Board Members</h4>
				<ul class="boardmembers"></ul>
				<h4>Documents</h4>
				<ul class="agency_documents"></ul>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">