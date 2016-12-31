<cfset ARGS = StructNew()>
<cfset ARGS.Name = "My new survey">
<cfset ARGS.Description = "test desc">
<cfset ARGS.Citation = "Citation">
<cfset ARGS.IndicatorID = 1>
<cfset ARGS.questions = ["Question 1", "Question2", "Question 3"]>
	<cfset ARGS.questions = ArrayToList(ARGS.questions)>
<cfset ARGS.csrf = cookie.csrf>

<cfinvoke component="#APPLICATION.cfcpath#webservices" method="saveSurvey" argumentcollection="#ARGS#" returnvariable="output" />
<cfdump var="#output#">
<cfabort>


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