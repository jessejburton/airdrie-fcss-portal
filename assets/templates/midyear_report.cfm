<cfif StructKeyExists(ATTRIBUTES, "ProgramID")>
	<cfquery name="qGetAgencyID">
		SELECT AgencyID FROM Program_vw
		WHERE 	ProgramID = <cfqueryparam value="#ATTRIBUTES.ProgramID#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfinvoke component="#APPLICATION.cfcpath#agency" method="GetAgencyByID" AgencyID="#qGetAgencyID.AgencyID#" returnvariable="Agency" />
	<cfinvoke component="#APPLICATION.cfcpath#program" method="getProgramByID" ProgramID="#ATTRIBUTES.ProgramID#" returnvariable="PROGRAM" />

	<h1>Mid-Year Report</h1>

	<cfoutput>
		<h1 class="section-heading">#Agency.Name#</h1>
		<h1 class="section-heading">#PROGRAM.ProgramName#</h1>
	</cfoutput>

	<h1>Sustainability</h1>
	<cfoutput>
		<cfif LEN(PROGRAM.isOnlyFunder) GT 0>
			<p><strong>Is Airdrie FCSS the only funder for this program?</strong><br />#EncodeForHTML(YesNoFormat(PROGRAM.isOnlyFunder))#</p>
			<cfif PROGRAM.isOnlyFunder>
				<p>
					<strong>How do you intend to sustain your program in the longer-term? Will you be seeking other sources of funding?</strong>
					<br />#EncodeForHTML(PROGRAM.sustainFunding)#
				</p>
			</cfif>
		</cfif>
	</cfoutput>

	<h1>Surplus</h1>
	<cfoutput>
		<cfif LEN(PROGRAM.isSurplus) GT 0>
			<p><strong>Do you anticipate a surplus at the end of the year?</strong><br />#EncodeForHTML(YesNoFormat(PROGRAM.isSurplus))#</p>
			<cfif PROGRAM.isSurplus>
				<p><em>Please notify Social Planning by September 1, 2017. All surplus funds must be returned to Airdrie FCSS.</em></p>
			</cfif>
		</cfif>
		<cfif LEN(PROGRAM.isDeficit) GT 0>
			<p><strong>Do you anticipate a deficit at the end of the year?</strong><br />#EncodeForHTML(YesNoFormat(PROGRAM.isDeficit))#</p>
			<cfif PROGRAM.isDeficit>
				<p><strong>Please describe how you will manage this deficit.</strong><br />#EncodeForHTML(PROGRAM.howDeal)#</p>
			</cfif>
		</cfif>
	</cfoutput>

	<cfmodule template="midyear_budget_summary.cfm" programID="#ATTRIBUTES.ProgramID#">	

	<h1>Program Activities Progress</h1>
	<cfoutput>
		<p><strong>What program activities have taken place (completed or currently underway)?</strong><br />#EncodeForHTML(PROGRAM.programActivities)#</p>
		<p><strong>What activities scheduled to begin by June 30, 2017 have NOT yet started?</strong><br />#EncodeForHTML(PROGRAM.notYetStarted)#</p>
		<p><strong>Have you run into any challenges implementing your program?</strong><br />#EncodeForHTML(PROGRAM.programChallenges)#</p>
		<p><strong>Do you require any assistance from Airdrie FCSS to help you report on program activities?</strong><br />#EncodeForHTML(PROGRAM.requireReportAssistance)#</p>
	</cfoutput>

	<h1>Program Evaluation Plan</h1>
	<cfoutput>
		<p><strong>What evaluation activities have you implemented to measure the impact of your program?</strong><br />#EncodeForHTML(PROGRAM.evaluationActivities)#</p>
		<p><strong>If you have NOT yet undertaken any of the above activities, please explain.</strong><br />#EncodeForHTML(PROGRAM.noActivities)#</p>
		<p><strong>Have you run into any challenges implementing program evaluation activities?</strong><br />#EncodeForHTML(PROGRAM.evaluationChallenges)#</p>
		<p><strong>Do you require any assistance from Airdrie FCSS Researcher to help you implement program evaluation activities or to report your data?</strong><br />#EncodeForHTML(PROGRAM.requireResearchAssistance)#</p>
	</cfoutput>

	<cfmodule template="plm.cfm" programID="#ATTRIBUTES.ProgramID#">

	<h1>Agreements</h1>
	<p>
		<input type="checkbox" checked="checked" id="auth1" readonly="readonly" />
		I have the authority to submit this report on behalf of my non-profit organization, and I confirm that the information contained herein is true and correct to the best of my knowledge, information, and belief.
	</p>
	<p>
		<input type="checkbox" checked="checked" id="auth2" readonly="readonly" />
		I acknowledge and understand that the information contained herein will be made public.
	</p>	
</cfif>