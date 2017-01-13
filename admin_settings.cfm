<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<cfinvoke component="#APPLICATION.cfcpath#settings" method="getSettings" returnvariable="REQUEST.Settings">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div class="form-group">
				<h1>Settings</h1>
				<p class="setting" data-column="MAXCHARACTERLENGTH">
					<label for="max_character_length">Maximum Character Length</label><br />
					<input type="number" id="max_character_length" class="input-half" value="<cfoutput>#XMLFormat(REQUEST.Settings.MAXCHARACTERLENGTH)#</cfoutput>" />
				</p>
				<p class="setting" data-column="SUPPORTNUMBER">
					<label for="support_number">Support Number</label><br />
					<input type="text" id="support_number" class="input-half" value="<cfoutput>#XMLFormat(REQUEST.Settings.SUPPORTNUMBER)#</cfoutput>" />
				</p>
				<p class="setting" data-column="ADMINEMAIL">
					<label for="admin_email">Admin Email (receives system notifications)</label><br />
					<input type="text" id="admin_email" class="input-half" value="<cfoutput>#XMLFormat(REQUEST.Settings.ADMINEMAIL)#</cfoutput>" />
				</p>
				<p class="setting" data-column="ISENABLEDAPPLICATIONS">
					<label for="is_enabled_applications">
						<input type="checkbox" id="is_enabled_applications" value="1" <cfoutput>#IIF(EncodeForHTMLAttribute(REQUEST.Settings.ISENABLEDAPPLICATIONS) IS 1, DE('checked="checked"'), DE(''))#</cfoutput>" /> Applications Enabled
					</label>
				</p>
				<p class="setting" data-column="ISENABLEDLETTEROFINTENT">
					<label for="is_enabled_letter_of_intent">
						<input type="checkbox" id="is_enabled_letter_of_intent" value="1" <cfoutput>#IIF(EncodeForHTMLAttribute(REQUEST.Settings.ISENABLEDLETTEROFINTENT), DE('checked="checked"'), DE(''))#</cfoutput>" /> Letter of Intent Enabled 
					</label>
				</p>
			</div>

			<div class="form_buttons clearfix">
				<button type="button" class="save btn btn-primary pull-left"><i class="fa fa-save"></i> Save</button> 
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">