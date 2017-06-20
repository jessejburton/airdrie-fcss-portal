<cfcomponent displayname="Package" extends="Core" hint="Functions relating to package creation and generation">
	<cffunction name="getPackageContent" access="public" returntype="string" returnformat="JSON"
		hint="Returns the content for a package">
		<cfargument name="PackageID" type="numeric" required="false">
		<cfargument name="ProgramID" type="numeric" required="true">

		<cfif isAdminAccount() OR checkProgramAccessByAccountID(ARGUMENTS.ProgramID)>
			<cfif NOT isDefined('ARGUMENTS.PackageID')>
				<cfquery name="LOCAL.qPackageID">
					SELECT PackageID FROM Package_tbl 
					WHERE PackageName = 'Program'
				</cfquery>

				<cfset ARGUMENTS.PackageID = LOCAL.qPackageID.PackageID>
			</cfif>

			<cfquery name="LOCAL.qPackage">
				SELECT	[TableView], [SectionTitle], [ColumnName], [TemplateFile], [isSectionHeading], [isOrder]
				FROM	PackageData_tbl
				WHERE 	PackageID = <cfqueryparam value="#ARGUMENTS.PackageID#" cfsqltype="cf_sql_integer">
				ORDER BY isOrder
			</cfquery>

			<!--- Loop through the page data query to display content --->
			<!--- TODO - Future Enhancement, performance, update this so that the query can pull more than one column at a time if needed. It will get a bit complex as you need to cycle through it and figure out the ordering, not even sure if it is possible. --->
			<cfsavecontent variable="LOCAL.response">
				<style type="text/css" media="screen">@import "<cfoutput>#APPLICATION.home#</cfoutput>assets/css/print.css";</style>

				<cfoutput query="LOCAL.qPackage">
					<div class="document-section">
						<!--- If there is a template file include it --->
						<cfif LEN(LOCAL.qPackage.TemplateFile) GT 0>
							<cfmodule template="#application.templatepath##LOCAL.qPackage.TemplateFile#" ProgramID="#ARGUMENTS.ProgramID#">
						<cfelse>
							<cfquery name="LOCAL.qContent">
								SELECT [#LOCAL.qPackage.ColumnName#] AS data FROM #LOCAL.qPackage.TableView#
								<cfif LOCAL.qPackage.TableView IS "Agency_VW">
									<!--- Need to get by Agency ID --->
									WHERE AgencyID = (SELECT AgencyID FROM Program_tbl WHERE ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">)
								<cfelse>
									WHERE ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
								</cfif>
							</cfquery>
							
							<cfif LEN(TRIM(LOCAL.qContent.data)) GT 0> 	<!--- Only display if it has content --->
								<cfif LOCAL.qPackage.isSectionHeading>
									<h1 class="section-heading">#LOCAL.qContent.data#</h1>
								<cfelse>
									<h1>#LOCAL.qPackage.SectionTitle#</h1>
									<p>#LOCAL.qContent.data#</p>
								</cfif>
							</cfif>
						</cfif>
					</div>
				</cfoutput>
			</cfsavecontent>

			<cfreturn LOCAL.response>
		</cfif>
	</cffunction>

	<cffunction name="getPackageNameByPackageID" access="public" returntype="string" returnformat="JSON"
		hint="Returns the name of a package by ID">
		<cfargument name="PackageID" type="numeric" required="true">

		<cfquery name="LOCAL.qPackage">
			SELECT 	PackageName FROM Package_tbl
			WHERE 	PackageID = <cfqueryparam value="#ARGUMENTS.PackageID#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn LOCAL.qPackage.PackageName>
	</cffunction>

	<cffunction name="getPackages" access="public" returntype="query" returnformat="JSON"
		hint="Returns a query of saved packages">

		<cfquery name="LOCAL.qPackages">
			SELECT 	PackageID, PackageName 
			FROM 	Package_tbl
			WHERE 	isActive = 1
		</cfquery>

		<cfreturn LOCAL.qPackages>
	</cffunction>	

	<cffunction name="getPackageElements" access="public" returntype="Array" returnformat="JSON"
		hint="Gets an array containing all of the package elements organized heirarchichally.">

		<cfset LOCAL.elementArray = ArrayNew(1)>

		<cfquery name="LOCAL.qPackageElements">
			SELECT 	ElementID, Description
			FROM 	PackageBuilder_tbl
			WHERE ParentID IS NULL
			ORDER BY isOrder
		</cfquery>

		<cfoutput query="LOCAL.qPackageElements">
			<cfset LOCAL.element = StructNew()>
			<cfset LOCAL.element.ID = LOCAL.qPackageElements.ElementID>
			<cfset LOCAL.element.Description = LOCAL.qPackageElements.Description>
			

			<cfset ArrayAppend(LOCAL.elementArray, LOCAL.element)>
		</cfoutput>			

		<cfreturn LOCAL.elementArray>
	</cffunction>

	<cffunction name="getPackageElementChildren" access="private" returntype="Array" returnformat="JSON"
		hint="Gets all of the child elements for a specific package">
		<cfargument name="ParentID" type="numeric" required="true">

		<cfset LOCAL.elementArray = ArrayNew(1)>

		<cfquery name="LOCAL.qPackageElementChildren">
			SELECT 	ElementID, Description
			FROM 	PackageBuilder_tbl
			WHERE 	ParentID = <cfqueryparam value="#ARGUMENTS.ParentID#" cfsqltype="cf_sql_integer">
			ORDER BY isOrder
		</cfquery>

		<cfoutput query="LOCAL.qPackageElementChildren">
			<cfset LOCAL.element = StructNew()>
			<cfset LOCAL.element.ID = LOCAL.qPackageElementChildren.ElementID>
			<cfset LOCAL.element.Description = LOCAL.qPackageElementChildren.Description>

			<cfset ArrayAppend(LOCAL.elementArray, LOCAL.element)>
		</cfoutput>

		<cfreturn LOCAL.elementArray>
	</cffunction>

</cfcomponent>
