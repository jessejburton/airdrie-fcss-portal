<!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<cfinvoke component="#APPLICATION.cfcpath#settings" method="getSettings" returnvariable="REQUEST.Settings">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<!--- FORM IS SUBMITTED --->
			<cfif isDefined('FORM.Fieldnames')>
				<cfquery result="result" name="query">
					#FORM.sql#
				</cfquery>

				<cfdump var="#query#">
				<cfdump var="#result#">
			</cfif>

			<div class="form-group">
				<h1><i class="fa fa-cogs"></i> Reset Table Data</h1>
				<form id="reset" name="reset" action="admin_reset.cfm" method="post">
					<textarea name="sql" class="form-control"></textarea>
					<input type="submit" class="save btn btn-danger pull-left" value="Run Command" />
				</form>
			</div>

		</div>
	</section>	

<cfinclude template="shared/footer.cfm">