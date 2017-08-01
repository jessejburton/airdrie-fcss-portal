<!--- 	
	TODO - Future Enhancement
	Add the ability to control whether or not the package includes the header and footer 
--->

<!--- Check permissions if program ID is passed in through the URL (means single program id and may not be admin) --->
<!--- This will ALWAYS just serve the package that is named "Program" TODO - restrict the ability to remove or rename this package --->
<cfif StructKeyExists(URL, "ProgramID")>
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkProgramAccessByAccountID" programID="#URL.ProgramID#" returnvariable="userHasAccess" />
<cfelse>
	<!--- Must be an admin account --->
	<cfinvoke component="#APPLICATION.cfcpath#core" method="isAdminAccount" returnvariable="userHasAccess" />
</cfif>

<cfif userHasAccess>
	<cfset output = ArrayNew(1)>

	<cfif StructKeyExists(URL, "ProgramID")>
	<!--- If Program ID is passed in, make sure the user has access and then just display all details for that program --->
		<cfif StructKeyExists(URL, "PackageName")>
			<cfquery name="qPackage">
				SELECT 	PackageID 
				FROM 	Package_tbl 
				WHERE 	PackageName = <cfqueryparam value="#URL.PackageName#" cfsqltype="cf_sql_varchar" />
			</cfquery>
			<cfinvoke component="#APPLICATION.cfcpath#package" method="getPackageContent" ProgramID="#URL.ProgramID#" PackageID="#qPackage.PackageID#" returnvariable="DATA" />
			<cfset PackageName = URL.PackageName>
		<cfelse>
			<cfinvoke component="#APPLICATION.cfcpath#package" method="getPackageContent" ProgramID="#URL.ProgramID#" returnvariable="DATA" />
			<cfset PackageName = "Program">
		</cfif>

		<cfset ArrayAppend(output, DATA)>
	<cfelse>
	<!--- Otherwise use the form data that is passed in to decide which package and what programs / agencies to include --->
		<cfinvoke component="#APPLICATION.cfcpath#package" method="getPackageNameByPackageID" PackageID="#FORM.PackageID#" returnvariable="PackageName" />

		<cfoutput>
			<cfloop list="#FORM.Programs#" index="programID">
				<cfinvoke component="#APPLICATION.cfcpath#package" method="getPackageContent" ProgramID="#programID#" PackageID="#FORM.PackageID#" returnvariable="DATA" />
				<cfset ArrayAppend(output, DATA)>
			</cfloop>
		</cfoutput>
	</cfif>

	<!--- Serve the PDF --->
	<cfheader name="Content-disposition" value="inline;filename=fcss_package.pdf">
	<cfcontent type="application/pdf">

	<cfdocument format="pdf" encryption="none" marginTop="1">
		<cfloop array="#output#" index="data">
			<cfdocumentsection>
				<cfdocumentitem type="header"> 
					<cfoutput>			
						<div style="float: left; padding-top: 15px;"><img src="assets/images/coalogo.png" style="height: 30px; padding: 5px;" alt="City of Airdrie Logo"></div>
						<div style="float: right; line-height: 70px;">#APPLICATION.Name# - #PackageName#</div>
					</cfoutput>
				</cfdocumentitem> 
				<cfoutput>#data#</cfoutput>
				<cfdocumentitem type="footer"> 
					<cfoutput>
						#cfdocument.currentpagenumber# of #cfdocument.totalpagecount#
					</cfoutput>
				</cfdocumentitem> 
			</cfdocumentsection>
		</cfloop>
	</cfdocument>	
<cfelse>
	<p>You do not have permission to access this information.</p>
</cfif>