<!--- TODO 
	Need to check to make sure the current program has access to the survey selected --->

<cfcomponent displayname="Survey" extends="Core">
	<cffunction name="GetSurveyByID" returntype="struct" returnformat="JSON" access="public">
		<cfargument name="SurveyID" type="numeric" required="true">

		<cfset LOCAL.response = StructNew()>

<!--- GET THE SURVEY DETAILS --->
		<cfquery name="LOCAL.qSurvey">
			SELECT	Name, Description, Citation
			FROM Survey_tbl
			WHERE SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			AND isActive = 1
			Order by isOrder
		</cfquery>

		<cfset LOCAL.response.SurveyID = ARGUMENTS.SurveyID>
		<cfset LOCAL.response.Name = LOCAL.qSurvey.Name>
		<cfset LOCAL.response.Description = LOCAL.qSurvey.Description>
		<cfset LOCAL.response.Citation = LOCAL.qSurvey.Citation>
		<cfset LOCAL.response.Questions = getQuestionsBySurveyID(ARGUMENTS.SurveyID)>

		<cfreturn LOCAL.response>
	</cffunction>

	<cffunction name="getQuestionsBySurveyID" returntype="array" returnformat="JSON" access="public">
		<cfargument name="SurveyID" type="numeric" required="true">

		<cfset LOCAL.response = ArrayNew(1)>

<!--- GET THE QUESTIONS FOR A SPECIFIC SURVEY --->
		<cfquery name="LOCAL.qQuestions">
			SELECT QuestionID, Question, isOrder
			FROM SurveyQuestion_tbl
			WHERE SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			AND	  isActive = 1
			ORDER BY isOrder
		</cfquery>
		
		<cfloop query="LOCAL.qQuestions">	
			<cfset LOCAL.Question = StructNew()>
				<cfset LOCAL.Question.Question = LOCAL.qQuestions.Question>
				<cfset LOCAL.Question.QuestionID = LOCAL.qQuestions.QuestionID>
				<cfset LOCAL.Question.isOrder = LOCAL.qQuestions.isOrder>

<!--- HANDLE GETTING THE ANSWERS WITH THE QUESTION --->		
				<cfquery name="LOCAL.qAnswers">
					SELECT	AnswerID, Answer, isOrder, isActive
					FROM	SurveyAnswer_tbl
					WHERE QuestionID = <cfqueryparam value="#LOCAL.qQuestions.QuestionID#" cfsqltype="cf_sql_integer">
					ORDER BY isOrder
				</cfquery>

				<cfset LOCAL.Question.ANSWERS = ArrayNew(1)>
				<cfloop query="LOCAL.qAnswers">
					<cfset LOCAL.Answer = StructNew()>
					<cfset LOCAL.Answer.Answer = LOCAL.qAnswers.Answer>
					<cfset LOCAL.Answer.AnswerID = LOCAL.qAnswers.Answer>
					<cfset ArrayAppend(LOCAL.Question.ANSWERS, LOCAL.Answer)>
				</cfloop>

			<cfset ArrayAppend(LOCAL.response, LOCAL.Question)>
		</cfloop>	

		<cfreturn LOCAL.response>
	</cffunction>
</cfcomponent>