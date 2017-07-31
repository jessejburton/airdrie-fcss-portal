<i class="fa fa-pencil-square-o"></i> <!--- Admin only page --->
<cfinvoke component="#APPLICATION.cfcpath#core" method="adminOnly" />

<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1><i class="fa fa-pencil-square-o"></i> Package Builder</h1>

			<p class="spaced border-bottom" style="padding-bottom: 25px;">
				<button type="button" id="new_package" class="btn btn-secondary"><i class="fa fa-plus"></i> Create New Package</button>
				<button type="button" id="edit_package" class="btn btn-secondary"><i class="fa fa-file-text"></i> Edit an Existing Package</button>
			</p>

			<!--- GET THE CURRENT PACKAGES --->
			<cfinvoke component="#APPLICATION.cfcpath#package" method="getPackages" returnvariable="qPackages" />
			<div class="spaced edit-package hidden">
				<strong>Select a package to edit</strong>
				<p>
					<select id="package_select" name="packageID" class="input-half">
						<option value="">--- Please select a package to edit ---</option>
						<cfoutput query="qPackages">
							<option value="#EncodeForHTMLAttribute(qPackages.PackageID)#">#EncodeForHTML(qPackages.PackageName)#</option>
						</cfoutput>
					</select>
					
				</p>
			</div>

			<div id="package_builder_form" class="hidden">
				<label for="package_name">Package Name:</label>
				<input type="text" id="package_name" placeholder="enter the name to use for this package" />

				<div class="form-buttons clearfix">
					<button type="button" class="save-package btn btn-primary pull-right"><i class="fa fa-save"></i> Save</button>
				</div>			

				<!--- 	TODO - Cleanup
						Could make this have two lists, and the lists have a data-tableview instead of each item needing to have it's own --->

				<!--- 	TODO - Finish
						Create the template pages --->

				<!--- 	
						PACKAGE BUILDER SYNTAX
						If you would like to add more elements just add them to the package_available_elements_list, each li shoud have the
						following data items:

							data-tableview		The name of the table or view to pull the data from (required if template is not used)
							data-column 		The column to pull the data from (required if template is not used)
							data-template		Create a page in the templates folder to display the appropriate data, ProgramID will be passed in

						the span in the list on the left becomes the value in "SectionTitle" in the database and is used for displaying the content.
				--->

				<div class="clearfix">
					<div id="package_available_elements">
						<h1>Package Elements</h1>

						<!---<cfinvoke component="#APPLICATION.cfcpath#package" method="getPackageElements" returnvariable="aPackageElements" />
						<cfdump var="#aPackageElements#">--->

						<ul id="package_available_elements_list">
							<li class="heading">Agency Elements</li>
							<li data-column="Name" data-tableview="Agency_vw"><span>Agency Name</span></li> 
							<li data-column="Mission" data-tableview="Agency_vw"><span>Mission</span></li>
							<li data-column="Vision" data-tableview="Agency_vw"><span>Vision</span></li>
							<li data-column="Phone" data-tableview="Agency_vw"><span>Agency Phone</span></li>
							<li data-column="Email" data-tableview="Agency_vw"><span>Agency Email</span></li>
							<li data-column="Fax" data-tableview="Agency_vw"><span>Agency Fax</span></li>
							<li data-column="Address" data-tableview="Agency_vw"><span>Agency Address</span></li>
							<li data-column="MailingAddress" data-tableview="Agency_vw"><span>Agency Mailing Address</span></li>
							<li data-column="Website" data-tableview="Agency_vw"><span>Agency Website</span></li>
							<li data-template="board_members.cfm"><span>Board Members</span></li>
							<li data-template="agency_details.cfm"><span>Agency Details</span></li> 
												<!--- 	Using data-template will pass the program ID to the specific 															template file (assets/template/) and display accordingly --->
							<li class="heading">Program Elements</li>
							<li data-column="ProgramName" data-tableview="Program_vw"><span>Program Name</span></li>
							<li data-column="ProgramStatement" data-tableview="Program_vw"><span>Statement</span></li>
							<li data-column="TargetAudience" data-tableview="Program_vw"><span>Target Audience</span></li>
							<li data-column="MostlyAirdrie" data-tableview="Program_vw"><span>Mostly Airdrie Residents</span></li>
							<li data-column="PrimaryContactName" data-tableview="Program_vw"><span>Primary Contact</span></li>
							<li data-column="PrimaryPhone" data-tableview="Program_vw"><span>Primary Phone</span></li>
							<li data-column="PrimaryEmail" data-tableview="Program_vw"><span>Primary Email</span></li>
							<li data-column="ProgramAddress" data-tableview="Program_vw"><span>Program Address</span></li>
							<li data-column="ProgramMailingAddress" data-tableview="Program_vw"><span>Program Mailing Address</span></li>
							<li data-column="Need" data-tableview="Program_vw"><span>Need</span></li>
							<li data-column="Goal" data-tableview="Program_vw"><span>Goal</span></li>
							<li data-column="Strategies" data-tableview="Program_vw"><span>Strategies</span></li>
							<li data-column="Rationale" data-tableview="Program_vw"><span>Rationale</span></li>
							<li data-column="Footnotes" data-tableview="Program_vw"><span>Footnotes</span></li>
							<li data-column="PreventionFocus" data-tableview="Program_vw"><span>Prevention Focus</span></li>
							<li data-column="Alignment" data-tableview="Program_vw"><span>Alignment</span></li>
							<li data-column="MissionFit" data-tableview="Program_vw"><span>Fits With Mission?</span></li>
							<li data-column="ConsideredPartnerships" data-tableview="Program_vw"><span>Considered Partnerships?</span></li>
							<li data-column="EstimatedFromAirdrie" data-tableview="Program_vw"><span>Estimated From Airdrie</span></li>
							<li data-column="EstimatedFromOther" data-tableview="Program_vw"><span>Estimated From Other</span></li>
							<li data-template="budget_summary.cfm"><span>Budget Summary</span></li>
							<li data-template="documents.cfm"><span>Documents</span></li>
							<li data-column="ShortTermGoals" data-tableview="Program_vw"><span>Short Term Goals</span></li>
							<li data-column="MidTermGoals" data-tableview="Program_vw"><span>Mid Term Goals</span></li>
							<li data-column="LongTermGoals" data-tableview="Program_vw"><span>Long Term Goals</span></li>
							<li data-column="Status" data-tableview="Program_vw"><span>Current Status</span></li>
							<li data-template="status_list.cfm"><span>Status List</span></li>
								<!--- Mid-Year Details --->
							<li class="heading">Mid Year Details</li>
							<li data-column="isOnlyFunder" data-tableview="Program_vw"><span>Is Airdrie the only funder?</span></li>
							<li data-column="sustainFunding" data-tableview="Program_vw"><span>How will you sustain? Will you need more funds?</span></li>
							<li data-column="isSurplus" data-tableview="Program_vw"><span>Do you anticipate a surplus?</span></li>
							<li data-column="isDeficit" data-tableview="Program_vw"><span>Do you anticipate a deficit?</span></li>
							<li data-column="howDeal" data-tableview="Program_vw"><span>How you will manage this deficit?</span></li>
							<li data-template="midyear_budget_summary.cfm"><span>Mid-Year Budget Summary</span></li>
							<li data-column="programActivities" data-tableview="Program_vw"><span>What program activities have taken place?</span></li>
							<li data-column="notYetStarted" data-tableview="Program_vw"><span>June 30 activities that have NOT yet started</span></li>
							<li data-column="programChallenges" data-tableview="Program_vw"><span>Challenges implementing your program?</span></li>
							<li data-column="requireReportAssistance" data-tableview="Program_vw"><span>Do you require report assistance from Airdrie FCSS?</span></li>
							<li data-column="evaluationActivities" data-tableview="Program_vw"><span>Implemented evaluation activities</span></li>	
							<li data-column="noActivities" data-tableview="Program_vw"><span>Explanation of No Activities</span></li>
							<li data-column="evaluationChallenges" data-tableview="Program_vw"><span>Challenges implementing evaluation activities</span></li>
							<li data-column="requireResearchAssistance" data-tableview="Program_vw"><span>Do you require Airdrie FCSS Researcher assistance?</span></li>				
							<li data-template="plm.cfm"><span>Program Logic Model</span></li>		
						</ul>
					</div>				

					<div id="package_elements">
						<h1>Current Package</h1>					
						<ul id="package_elements_list">
							<li class="heading" id="package_name_display">Give this package a name</li></ul>
						</ul>
						<div class="placeholder">Click on elements to add or remove them from this package, drag to re-order elements in the current package.</div>
					</div>
				</div>

				<div class="form-buttons">
					<button type="button" class="save-package btn btn-primary pull-right"><i class="fa fa-save"></i> Save</button>
				</div>

				<div class="package-options template">
					<div class="section-heading"><label for="section_heading"><input type="checkbox" class="section-heading-checkbox" name="section_heading" /> Section Heading</label></div>
					<div class="remove-package-content package-option"><i class="fa fa-close"></i></div>
				</div>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">