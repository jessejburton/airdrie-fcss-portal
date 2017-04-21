<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<!--- Get the available Agencies --->
<cfinvoke component="#APPLICATION.cfcpath#agency" method="getAgencyList" returnvariable="Agencies" />

<!--- Get the available Templates --->
<cfinvoke component="#APPLICATION.cfcpath#template" method="getTemplates" returnvariable="Templates" />

<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1><i class="fa fa-envelope-o"></i> Messaging</h1>
			<div class="clearfix">
				<div class="pull-right">
					<label for="template">Choose a template...</label>
					<select id="template">
						<option value="" data-html="">No Template...</option>
						<cfoutput>
							<cfloop array="#Templates#" index="t">
								<option value="#EncodeForHTMLAttribute(t.TemplateID)#" data-html="#EncodeForHTMLAttribute(t.Template)#">#EncodeForHTML(t.Name)#</option>
							</cfloop>
						</cfoutput>
					</select>
				</div>
			</div>
			<p>
				<input type="text" class="full" id="message_subject" placeholder="Subject..." /><br />
				<textarea id="message_txt" class="tinyMCE" placeholder="Write your message or select a template above..."></textarea>
			</p>
			<hr />
			<h3>Send To:</h3>
			<p>
				<label for="all_agencies"><input type="checkbox" id="all_agencies" /> All Agencies</label>
			</p>
			<p class="normal-labels">
				<cfoutput>
					<cfloop array="#Agencies#" index="a">
						<label for="agency_#a.AgencyID#"><input type="checkbox" id="agency_#a.AgencyID#" name="agencies" value="#a.AgencyID#" /> #a.Name#</label><br />
					</cfloop>
				</cfoutput>
			</p>
			<p class="spaced border-bottom" style="padding-bottom: 25px;">
				<button type="button" id="send_message" class="btn btn-primary"><i class="fa fa-envelope-o"></i> Send Messages</button>
			</p>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">