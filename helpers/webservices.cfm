<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<form id="function1" name="function1" method="get" action="<cfoutput>#APPLICATION.webservicesURL#</cfoutput>">
				<h1>getQuestionsBySurveyID</h1>
				<input type="hidden" id="method" name="method" value="getQuestionsBySurveyID" />

				<input type="text" id="surveyID" name="surveyID" class="input-half inline" placeholder="Please enter a surveyID" />
				<button type="submit" id="function1_submit" class="inline btn btn-primary" name="function1_submit">Make Call</button>
			</form>
			<cfif isDefined('FORM.function1_submit')>
				<cfdump var="#FORM#">
			</cfif>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">