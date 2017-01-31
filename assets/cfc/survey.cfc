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
					SELECT	AnswerID, Answer, isOrder, isActive, isDefault
					FROM	SurveyAnswer_tbl
					WHERE QuestionID = <cfqueryparam value="#LOCAL.qQuestions.QuestionID#" cfsqltype="cf_sql_integer">
					ORDER BY isOrder, isDefault
				</cfquery>

				<cfset LOCAL.Question.ANSWERS = ArrayNew(1)>
				<cfloop query="LOCAL.qAnswers">
					<cfset LOCAL.Answer = StructNew()>
					<cfset LOCAL.Answer.Answer = LOCAL.qAnswers.Answer>
					<cfset LOCAL.Answer.AnswerID = LOCAL.qAnswers.AnswerID>
					<cfset LOCAL.Answer.isDefault = LOCAL.qAnswers.isDefault>
					<cfset ArrayAppend(LOCAL.Question.ANSWERS, LOCAL.Answer)>
				</cfloop>

			<cfset ArrayAppend(LOCAL.response, LOCAL.Question)>
		</cfloop>	

		<cfreturn LOCAL.response>
	</cffunction>

<!--- Check if a client exists or not --->
	<cffunction name="checkSurveyClientNameExists" access="public" returntype="boolean" returnformat="JSON"
		hint="Checks to see if a name is already used for a specific client by program and survey ID's. If you pass a clientID that isn't 0 it will disregard the client with that ID for checking to update the record.">
		<cfargument name="ProgramID" type="numeric" required="true">
		<cfargument name="SurveyID" type="numeric" required="true">
		<cfargument name="Name" type="string" required="true">
		<cfargument name="ClientID" type="numeric" default="0">

		<cfquery name="LOCAL.qCheck">
			SELECT 	ClientID
			FROM	SurveyClient_tbl
			WHERE	ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">
			AND 	SurveyID = <cfqueryparam value="#ARGUMENTS.SurveyID#" cfsqltype="cf_sql_integer">
			AND 	Name = <cfqueryparam value="#ARGUMENTS.Name#" cfsqltype="cf_sql_varchar">
			<cfif ARGUMENTS.ClientID NEQ 0>
				AND ClientID <> <cfqueryparam value="#ARGUMENTS.ClientID#" cfsqltype="cf_sql_integer">
			</cfif>
		</cfquery>

		<cfreturn LOCAL.qCheck.recordcount IS 1>
	</cffunction>	

	<cffunction name="getAllSurveys" access="public" returntype="query" returnformat="JSON"
	    hint="Gets a query of all active surveys and their ID's">

	    <cfquery name="LOCAL.qSurveys">
	    	SELECT 	SurveyID, Name
	    	FROM	Survey_tbl
	    	WHERE 	isActive = 1
	    </cfquery>
	    
	    <cfreturn LOCAL.qSurveys>
	</cffunction>	

	<cffunction name="getAreas" access="public" returntype="query" returnformat="JSON"
		hint="Get a list of the availbale Areas.">

		<cfquery name="LOCAL.qAreas">
			SELECT 	Area, AreaID, Color
			FROM	Area_tbl
			WHERE	isActive = 1
		</cfquery>

		<cfreturn LOCAL.qAreas>
	</cffunction>	

	<cffunction name="getOutcomes" access="public" returntype="query" returnformat="JSON"
		hint="Get a list of the availbale outcomes.">

		<cfquery name="LOCAL.qOutcomes">
			SELECT 	Outcome, OutcomeID 
			FROM	Outcome_tbl
			WHERE	isActive = 1
		</cfquery>

		<cfreturn LOCAL.qOutcomes>
	</cffunction>

	<cffunction name="getIndicators" access="public" returntype="query" returnformat="JSON"
		hint="Get a list of the availbale indicators.">

		<cfquery name="LOCAL.qIndicators">
			SELECT 	Indicator, IndicatorID 
			FROM	Indicator_tbl
			WHERE	isActive = 1
		</cfquery>

		<cfreturn LOCAL.qIndicators>
	</cffunction>

	<cffunction name="getFullIndicators" access="public" returntype="struct" returnformat="JSON"
	    hint="Gets a query of all available indicators">

	    <cfset LOCAL.response = StructNew()>

	    <!--- Areas --->
	    <cfset LOCAL.qAreas = getAreas()>
	    <cfset LOCAL.response.AREAS = ArrayNew(1)>
	   	<cfoutput query="LOCAL.qAreas">
	   		<cfset LOCAL.area = StructNew()>
	   		<cfset LOCAL.area.AREAID = LOCAL.qAreas.AreaID> 
	   		<cfset LOCAL.area.AREA = LOCAL.qAreas.Area> 
	   		<cfset LOCAL.area.COLOR = LOCAL.qAreas.Color>
	   		<cfset LOCAL.area.OUTCOMES = ArrayNew(1)>

		   	<!--- Outcomes --->
			<cfquery name="LOCAL.qOutcomes">
				SELECT 	Outcome, OutcomeID 
				FROM	Outcome_tbl
				WHERE	isActive = 1
				AND 	AreaID = <cfqueryparam value="#LOCAL.qAreas.AreaID#" cfsqltype="cf_sql_integer">
			</cfquery>
		   	<cfloop query="LOCAL.qOutcomes">
		   		<cfset LOCAL.outcome = StructNew()>
		   		<cfset LOCAL.outcome.OUTCOMEID = LOCAL.qOutcomes.OutcomeID> 
		   		<cfset LOCAL.outcome.OUTCOME = LOCAL.qOutcomes.Outcome> 
		   		<cfset LOCAL.outcome.INDICATORS = ArrayNew(1)>

		   		<!--- Indicators --->
			    <cfquery name="LOCAL.qIndicators">
			    	SELECT 	IndicatorID, Indicator
			    	FROM 	Indicator_tbl 
			    	WHERE 	isActive = 1
			    	AND 	OutcomeID = <cfqueryparam value="#LOCAL.qOutcomes.OutcomeID#" cfsqltype="cf_sql_integer">
			    	ORDER BY Indicator
			    </cfquery>

				<cfloop query="LOCAL.qIndicators">
			    	<cfset LOCAL.indicator = StructNew()>
			    	<cfset LOCAL.indicator.INDICATORID = LOCAL.qIndicators.IndicatorID> 
			    	<cfset LOCAL.indicator.INDICATOR = LOCAL.qIndicators.Indicator>
			    	<cfset ArrayAppend(LOCAL.outcome.INDICATORS, LOCAL.indicator)>
			    </cfloop>

		   		<cfset ArrayAppend(LOCAL.area.OUTCOMES, LOCAL.outcome)>
		   	</cfloop>	

	   		<cfset ArrayAppend(LOCAL.response.AREAS, LOCAL.area)>
	   	</cfoutput>	    

	    <cfreturn LOCAL.response>
	</cffunction>

	<cffunction name="getSurveysByProgramID" access="public" returntype="struct" returnformat="JSON"
			hint="Gets all of the surveys available for an application.">
		<cfargument name="ProgramID" type="numeric" required="true">

		<cfquery name="LOCAL.qSurveys">
			SELECT	SurveyID, Name, Description, Citation
			FROM 	Survey_tbl
			WHERE isActive = 1
			AND IndicatorID IN (SELECT IndicatorID FROM ProgramIndicator_tbl WHERE ProgramID = <cfqueryparam value="#ARGUMENTS.ProgramID#" cfsqltype="cf_sql_integer">)
		</cfquery>

		<cfset LOCAL.response = getSuccessResponse("")>

		<cfset LOCAL.response.DATA = ArrayNew(1)>
		<cfoutput query="LOCAL.qSurveys">
			<cfset LOCAL.Survey = StructNew()>
			<cfset LOCAL.Survey.ID = LOCAL.qSurveys.SurveyID>
			<cfset LOCAL.Survey.Name = LOCAL.qSurveys.Name>
			<cfset LOCAL.Survey.Description = LOCAL.qSurveys.Description>
			<cfset LOCAL.Survey.Citation = LOCAL.qSurveys.Citation>

			<cfset ArrayAppend(LOCAL.response.DATA, LOCAL.Survey)>
		</cfoutput>

		<cfreturn LOCAL.response>
	</cffunction>		
</cfcomponent>