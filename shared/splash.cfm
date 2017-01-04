<!--- TODO - Future Enhancement - put this content in the database with the assumption 
		that at some point they will most likely want to have the ability to edit it. --->
<cfinvoke component="#APPLICATION.cfcpath#content" method="getContent" contentType="Splash Page" />

<!--- This part of the message will be system generated to include the email and phone numbers from the settings page --->
<cfoutput>
	<h2>More Information</h2>
	<p>Questions about applying for FCSS funding? Contact Social Planning at #REQUEST.SETTINGS.SupportNumber# or via email at <a href="mailto:#REQUEST.SETTINGS.AdminEmail#">#REQUEST.SETTINGS.AdminEmail#</a>.</p>
</cfoutput>
