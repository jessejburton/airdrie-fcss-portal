<cfinclude template="shared/header.cfm">

<cfset showForm = true>

<!--- Make sure there is a program selected and that it has been approved --->
<cfif StructKeyExists(URL, 'ID')>
	<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramByID" programID="#URL.ID#" returnvariable="PROGRAM" />
<cfelse>
	<cflocation url="index.cfm" addtoken="false">
</cfif>
<cfif ListFindNoCase(PROGRAM.StatusList, 'LOI - Approved') IS 0>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1>Mid-Year Report</h1>

<!--- Decide whether or not to show the form --->
<cfif ListFindNoCase(PROGRAM.StatusList, 'Mid-Year Submitted') IS 1>
	<cfset showForm = false>
	<div class="autoreply autoreply-info autoreply-visible">
		<p><strong>Submitted!</strong> You have already completed and sent in your mid-year report for this program.
	</div>
</cfif>

<!--- BEGIN FORM --->	
		<cfif showForm>
			<form id="mid_year_form">
				<!--- Hidden Form Fields --->
				<input type="hidden" id="program_id" value="<cfoutput>#EncodeForHTML(PROGRAM.ProgramID)#</cfoutput>" />
				<input type="hidden" id="program_status" value="<cfoutput>#EncodeForHTML(PROGRAM.Status)#</cfoutput>" />

				<p>
					<a href="javascript:;" class="save btn btn-primary inline"><i class="fa fa-save"></i> Save</a>
					<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
					<em class="pull-right small-text" id="last_saved">Last Saved: <cfoutput>#EncodeForHTML(PROGRAM.FormattedDateUpdated)#</cfoutput></em>
				</p>
				
			<cfoutput>
				<cfset BUDGETTYPE = "Mid-Year Budget">				
				
				<div class="accordion clearfix">					
					<h3>Mid Year Questions</h3>
					<div class="form-group seen">
						<p>
							<label for="midyearvalue">Enter a Value</label><br />
							<input type="text" id="midyearvalue" placeholder="Please enter a value" class="required value" 
								value="#EncodeForHTML(PROGRAM.MidYearValue)#" />
						</p>
					</div>

					<h3>Mid Year Financials</h3>
					<div class="form-group">
						<cfinclude template="shared/budget.cfm">

						<div class="form_buttons clearfix">
							<button type="button" id="application_review" class="btn btn-primary pull-right">Review</button> 
						</div>
					</div>											

				<!--- REVIEW --->
					<h3 class="ui-state-disabled">Review and Submit</h3>
					<div>
						<div id="application_review_display">	
							<h2>Mid Year Budget Summary</h2>
							<div class="budget-summary"></div>								
						</div>
						
						<div class="form-buttons clearfix"> 
							<button type="button" id="application_submit_to_airdrie" class="btn btn-primary pull-right submit-button">Send to City of Airdrie</button>
							<button type="button" id="application_save_for_review" class="btn btn-secondary pull-right submit-button">Save for Agency Review</button>  
							<a href="javascript:;" class="pull-right small-text link inline" style="margin-top: 15px;"><i class="fa fa-file-pdf-o"></i> Printable Version</a>
						</div>
					</div>	
				</div>
			</cfoutput>				

			<p>
				<a href="javascript:;" class="save btn btn-primary inline"><i class="fa fa-save"></i> Save</a>
				<a href="programs.cfm" class="link inline"><i class="fa fa-chevron-circle-left"></i> Back to Programs</a>
				<em class="pull-right small-text" id="last_saved">Last Saved: <cfoutput>#EncodeForHTML(PROGRAM.FormattedDateUpdated)#</cfoutput></em>
			</p>
		</cfif>
<!--- END FORM --->
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">