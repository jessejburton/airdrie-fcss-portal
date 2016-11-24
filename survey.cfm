<!--- THIS PAGE REQUIRES A SURVEY ID TO BE PASSED IN THROUGH THE URL --->
<cfif NOT isDefined('URL.SurveyID') OR NOT isNumeric(URL.SurveyID)>
	<cflocation url="index.cfm" addtoken="false">
<cfelse>
	<!--- Get the approrpriate survey data --->
	<cfinvoke component="#APPLICATION.cfcpath#webservices" method="getSurveyByID" SurveyID="#URLEncodedFormat(URL.SurveyID)#" returnvariable="response" />
	<cfset REQUEST.SURVEY = response.DATA>
</cfif>

<cfinclude template="shared/header.cfm">

<!--- Survey Style Sheet --->
<link href="assets/css/survey.css" rel="stylesheet" type="text/css" />

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<h1><cfoutput>#XMLFormat(REQUEST.SURVEY.Name)#</cfoutput></h1>
			<p><cfoutput>#XMLFormat(REQUEST.SURVEY.Description)#</cfoutput></p>

			<cfif isDefined('URL.SurveyComplete')>
				<div class="autoreply autoreply-success autoreply-visible">
					<p><strong>Success!</strong> Survey data has been collected for this participant, you can begin collecting another survey now.</p>
				</div>
			</cfif>

			<p><a href="surveys.cfm" class="link"><i class="fa fa-arrow-circle-o-left"></i> Back to Surveys</a></p>

			<form id="survey">
				<div class="accordion clearfix">			
<!--- PARTICIPANT INFORMATION --->
					<h3>Participant Details</h3>
					<div class="form-group">
						<p>
							<label for="client_id">Client ID</label><br />
							<input type="text" class="input-half" id="client_id" disabled value="12345" />
						</p>
						<p>
							<label for="participant_name">Name</label><br />
							<input type="text" class="input-half" id="participant_name" placeholder="Enter the participants name." />
						</p>
						<p>
							<label for="gender">Gender</label><br />
							<select id="gender" class="input-half">
								<option value="" hidden>--- Select ---</option>
								<option value="1">Male</option>
								<option value="2">Female</option>
							</select>
						</p>
						<p>
							<label for="age">Age</label><br />
							<select id="age" class="input-half">
								<option value="" hidden>--- Select ---</option>
								<option value="1">0-4</option>
								<option value="2">5-9</option>
								<option value="3">10-14</option>
								<option value="4">15-19</option>
								<option value="5">20-24</option>
								<option value="6">25-29</option>
								<option value="3">30-34</option>
								<option value="4">35-39</option>
								<option value="5">40-44</option>
								<option value="6">45-49</option>
								<option value="5">50-54</option>
								<option value="6">55-59</option>
								<option value="3">60-64</option>
								<option value="4">65-69</option>
								<option value="5">70-74</option>
								<option value="6">75+</option>
							</select>
						</p>					
						<p>
							<label for="numpeople">Number of People in Family</label><br />
							<select id="numpeople" class="input-half">
								<option value="" hidden>--- Select ---</option>
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
									<option value="1">Airdrie</option>
									<option value="2">Rocky View County & Area</option>
									<option value="3">Calgary</option>
									<option value="4">Another Province/Country</option>
									<option value="Other">Other (specify)</option>
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
									<option value="1">English</option>
									<option value="2">French</option>
									<option value="3">German</option>
									<option value="4">Spanish</option>
									<option value="5">Punjabi</option>
									<option value="6">Tagalog (Pilipino)</option>
									<option value="7">Vietnamese</option>
									<option value="Other">Other (specify)</option>
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
								<option value="" hidden>--- Select ---</option>
								<option value="1">Under $39,999</option>
								<option value="2">$40,000-$79,000</option>
								<option value="3">$80,000-$119,000</option>
								<option value="4">$120,000-$159,999</option>
								<option value="5">$160,000-$199,000</option>
								<option value="6">$200,000+</option>
								<option value="6">I don't want to say</option>
							</select>
						</p>
					</div>

<!--- SURVEY QUESTIONS --->
					<h3>Survey</h3>
					<div class="form-group">
					<!--- TODO - ADD A PLACE HERE FOR SPECIAL INSTRUCTIONS MAYBE? --->
						<cfoutput>
							<cfloop array="#REQUEST.SURVEY.Questions#" index="question"> 
								<div class="radio-group">
									<span class="label question">#question.QUESTION#</span><br />
									<div class="pre radio-column">
									<span>Pre Survey</span>
										<cfloop array="#question.ANSWERS#" index="answer">
											<label class="radio" for="pre_#question.QuestionID#_#answer.AnswerID#">
											<input type="radio" id="pre_#question.QuestionID#_#answer.AnswerID#" name="pre_question_#question.QuestionID#" value="#answer.AnswerID#" /> #answer.Answer#</label>
										</cfloop>
									</div>							
									<div class="post radio-column">
										<span>Post Survey</span>
										<cfloop array="#question.ANSWERS#" index="answer">
											<label class="radio" for="post_#question.QuestionID#_#answer.AnswerID#">
											<input type="radio" id="post_#question.QuestionID#_#answer.AnswerID#" name="post_question_#question.QuestionID#" value="#answer.AnswerID#" /> #answer.Answer#</label>
										</cfloop>
									</div>
								</div>
							</cfloop>
						</cfoutput>

						<div class="form_buttons clearfix">
							<button type="button" class="btn btn-primary pull-right" id="complete_survey_btn">Complete Survey</button> 
						</div>																									
					</div>								
				</form>
			</div>

			<!--- CITATION INFORMATION --->
			<em class="centered smaller-text spaced"><cfoutput>#REQUEST.SURVEY.Citation#</cfoutput></em>

		</div>
	</section>	

<cfinclude template="shared/footer.cfm">