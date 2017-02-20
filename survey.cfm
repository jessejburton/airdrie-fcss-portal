<!--- THIS PAGE REQUIRES A SURVEY ID TO BE PASSED IN THROUGH THE URL --->
<cfif NOT isDefined('URL.SurveyID') OR NOT isNumeric(URL.SurveyID)>
	<cflocation url="index.cfm" addtoken="false">
<cfelse>
	<!--- Check Permission for program --->
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkProgramAccessByAccountID" programID="#URL.ProgramID#" returnvariable="programpermission" />
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkSurveyAccessByProgramID" surveyID="#URL.SurveyID#" programID="#URL.ProgramID#" returnvariable="surveypermission" />
	<cfif NOT programpermission OR NOT surveypermission>
		<cflocation url="index.cfm" addtoken="false">
	</cfif>

	<!--- Get the approrpriate survey data --->
	<cfinvoke component="#APPLICATION.cfcpath#webservices" method="getSurveyByID" csrf="#COOKIE.CSRF#" SurveyID="#URL.SurveyID#" returnvariable="response" />
	<cfset REQUEST.SURVEY = response.DATA>
</cfif>

<!--- Get lookup values (TODO - It might be a good idea to switch these to lookup tables but because I am not sure if they are going to be changing the questions I wanted to wait until I get more information before putting in the time) They do not appear to be clear as to what they want specifically for surveys as it seems to change. I did ask Jessie if it is ok to assume that for now at least all questions will be answered 1 - 5 --->
<cfset GENDER = ArrayNew(1)>
	<cfset ArrayAppend(GENDER, "Male")>
	<cfset ArrayAppend(GENDER, "Female")>
<cfset AGE = ArrayNew(1)>
	<cfset ArrayAppend(AGE, "0-4")>
	<cfset ArrayAppend(AGE, "5-9")>
	<cfset ArrayAppend(AGE, "10-14")>
	<cfset ArrayAppend(AGE, "15-19")>
	<cfset ArrayAppend(AGE, "20-24")>
	<cfset ArrayAppend(AGE, "25-29")>
	<cfset ArrayAppend(AGE, "30-34")>
	<cfset ArrayAppend(AGE, "35-39")>
	<cfset ArrayAppend(AGE, "40-44")>
	<cfset ArrayAppend(AGE, "45-49")>
	<cfset ArrayAppend(AGE, "50-54")>
	<cfset ArrayAppend(AGE, "55-59")>
	<cfset ArrayAppend(AGE, "60-64")>
	<cfset ArrayAppend(AGE, "65-69")>
	<cfset ArrayAppend(AGE, "70-74")>
	<cfset ArrayAppend(AGE, "75+")>
<cfset RESIDENCE = ArrayNew(1)>
	<cfset ArrayAppend(RESIDENCE, "Airdrie")>
	<cfset ArrayAppend(RESIDENCE, "Rocky View & County Area")>
	<cfset ArrayAppend(RESIDENCE, "Another Province/Country")>
	<cfset ArrayAppend(RESIDENCE, "Other (specify)")>
<cfset LANGUAGE = ArrayNew(1)>
	<cfset ArrayAppend(LANGUAGE, "English")>
	<cfset ArrayAppend(LANGUAGE, "German")>
	<cfset ArrayAppend(LANGUAGE, "Spanish")>
	<cfset ArrayAppend(LANGUAGE, "Punjabi")>
	<cfset ArrayAppend(LANGUAGE, "Tagalog (Pilipino)")>
	<cfset ArrayAppend(LANGUAGE, "Vietnamese")>
	<cfset ArrayAppend(LANGUAGE, "Other (specify)")>
<cfset INCOME = ArrayNew(1)>
	<cfset ArrayAppend(INCOME, "Under $39,999")>
	<cfset ArrayAppend(INCOME, "$40,000 - $79,999")>
	<cfset ArrayAppend(INCOME, "$80,000 - $119,999")>
	<cfset ArrayAppend(INCOME, "$120,000 - $159,999")>
	<cfset ArrayAppend(INCOME, "$160,000 - $199,999")>
	<cfset ArrayAppend(INCOME, "$200,000 +")>
	<cfset ArrayAppend(INCOME, "I don't want to say")>

<cfinclude template="shared/header.cfm">

<!--- Survey Style Sheet --->
<link href="assets/css/survey.css" rel="stylesheet" type="text/css" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1><cfoutput>#EncodeForHTML(REQUEST.SURVEY.Name)#</cfoutput></h1>
			<p><cfoutput>#EncodeForHTML(REQUEST.SURVEY.Description)#</cfoutput></p>

			<p><a href="outcome_measures.cfm?ProgramID=<cfoutput>#URLEncodedFormat(URL.ProgramID)#</cfoutput>" class="link"><i class="fa fa-arrow-circle-o-left"></i> Back to Surveys</a></p>

			<form id="survey">
			<!--- HIDDEN FIELDS --->
				<cfoutput>
					<input type="hidden" id="SurveyID" value="#EncodeForHTML(URL.SurveyID)#" />
					<input type="hidden" id="ProgramID" value="#EncodeForHTML(URL.ProgramID)#" />
					<input type="hidden" id="client_id" value="" />
				</cfoutput>

				<div class="accordion clearfix">	
<!--- PARTICIPANT INFORMATION --->
					<h3>Participant Details</h3>
					<div class="form-group" id="participant">
						<p>
							<label for="participant_name">Name</label><br />
							<input type="text" class="input-half" id="participant_name" placeholder="Enter the participants name." />
							<a class="link smaller-text" id="generate" href="javascript:;">&nbsp; <i class="fa fa-check"></i> Generate Unique ID</a>
							<a class="link smaller-text hidden" id="new" href="javascript:;">&nbsp; <i class="fa fa-plus"></i> New Client</a>
						</p>

						<div class="form_buttons clearfix" id="begin_buttons">
							<button type="button" class="begin next btn btn-primary pull-right">Continue</button> 
						</div>

						<div id="client_data" class="hidden">
							<p>
								<label for="gender">Gender</label><br />
								<select id="gender" class="input-half">
									<option value="">--- Select ---</option>
									<cfoutput>
										<cfloop array="#GENDER#" index="i">
											<option value="#i#">#i#</option>
										</cfloop>
									</cfoutput>
								</select>
							</p>
							<p>
								<label for="age">Age</label><br />
								<select id="age" class="input-half">
									<option value="">--- Select ---</option>
									<cfoutput>
										<cfloop array="#AGE#" index="i">
											<option value="#i#">#i#</option>
										</cfloop>
									</cfoutput>
								</select>
							</p>					
							<p>
								<label for="numpeople">Number of People in Family</label><br />
								<select id="numpeople" class="input-half">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6+</option>
								</select>
							</p>
							<div class="two-cols">
								<p>
									<label for="residence">Residence</label><br />
									<select id="residence" class="specify">
										<cfoutput>
											<cfloop array="#RESIDENCE#" index="i">
												<option value="#i#">#i#</option>
											</cfloop>
										</cfoutput>
									</select>
								</p>
								<p id="residence_other" class="other">
									<label for="residence_specify">Other Residence Specify</label><br />
									<input type="text" id="residence_specify" placeholder="Please specify your residence" />
								</p>
							</div>
							<div class="two-cols">
								<p>
									<label for="language">Language</label><br />
									<select id="language" class="specify">
										<cfoutput>
											<cfloop array="#LANGUAGE#" index="i">
												<option value="#i#">#i#</option>
											</cfloop>
										</cfoutput>
									</select>
								</p>
								<p id="language_other" class="other">
									<label for="language_specify">Other Language Specify</label><br />
									<input type="text" id="language_specify" placeholder="Please specify what language" />
								</p>
							</div>
							<p>
								<label for="income">Income</label><br />
								<select id="income" class="input-half">
									<option value="">--- Select ---</option>
									<cfoutput>
										<cfloop array="#INCOME#" index="i">
											<option value="#i#">#i#</option>
										</cfloop>
									</cfoutput>
								</select>
							</p>

							<div class="form_buttons clearfix">
								<button type="button" class="save-participant next btn btn-primary pull-right"><i class="fa fa-save"></i> Save and Continue</button> 
							</div>							
						</div>
					</div>

<!--- SURVEY QUESTIONS --->
					<h3 id="pre_survey_data" class="ui-state-disabled" style="display: none;">Pre Survey</h3>
					<div class="form-group">
						<cfoutput>
							<cfloop array="#REQUEST.SURVEY.Questions#" index="question"> 
								<div class="radio-group question" data-questionid="#question.QUESTIONID#">
									<span class="label question">#question.QUESTION#</span><br />
									<div class="pre radio-column">
										<cfloop array="#question.ANSWERS#" index="answer">
											<label class="radio" for="pre_#question.QuestionID#_#answer.AnswerID#">
											<input type="radio" class="#iif(answer.isDefault, DE('default'), DE(''))# answer" id="pre_#question.QuestionID#_#answer.AnswerID#" name="pre_question_#question.QuestionID#" value="#answer.AnswerID#" #iif(answer.isDefault, DE('checked'), DE(''))# /> #answer.Answer#</label>
										</cfloop>
									</div>							
								</div>
							</cfloop>
						</cfoutput>

						<div class="form_buttons clearfix">
							<button type="button" class="btn btn-primary pull-right complete-survey"><i class="fa fa-save"></i> Save Survey</button>
							<button type="button" class="btn btn-secondary pull-right post-survey"><i class="fa fa-arrow-right"></i> Post Survey</button> 
						</div>																									
					</div>	

					<h3 id="post_survey_data" class="ui-state-disabled">Post Survey</h3>
					<div class="form-group">
						<cfoutput>
							<cfloop array="#REQUEST.SURVEY.Questions#" index="question"> 
								<div class="radio-group question" data-questionid="#question.QUESTIONID#">
									<span class="label question">#question.QUESTION#</span><br />						
									<div class="post radio-column">
										<cfloop array="#question.ANSWERS#" index="answer">
											<label class="radio" for="post_#question.QuestionID#_#answer.AnswerID#">
											<input type="radio" class="#iif(answer.isDefault, DE('default'), DE(''))# answer" id="post_#question.QuestionID#_#answer.AnswerID#" name="post_question_#question.QuestionID#" value="#answer.AnswerID#" #iif(answer.isDefault, DE('checked'), DE(''))# /> #answer.Answer#</label>
										</cfloop>
									</div>
								</div>
							</cfloop>
						</cfoutput>

						<div class="form_buttons clearfix">
							<button type="button" class="btn btn-primary pull-right complete-survey"><i class="fa fa-save"></i> Save Survey</button> 
						</div>																									
					</div>								
				</form>
			</div>

			<!--- CITATION INFORMATION --->
			<em class="centered smaller-text spaced"><cfoutput>#REQUEST.SURVEY.Citation#</cfoutput></em>

		</div>
	</section>	

<cfinclude template="shared/footer.cfm">