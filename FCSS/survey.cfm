<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div class="panels clearfix">
				<ul class="panel_nav_top clearfix">
					<li class="active"><a href="javascript:;" data-show="participant_panel">Participant Information</a></li>
					<li><a href="javascript:;" data-show="pre_panel">Pre-Survey</a></li>
					<li><a href="javascript:;" data-show="post_panel">Post-Survey</a></li>
				</ul>

				<form id="panel_display">
				<!--- PARTICIPANT INFORMATION --->
					<div id="participant_panel" class="panel active">
						<h1 class="form-group-heading">Participant Details</h1>

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

				<!--- PARTICIPANT INFORMATION --->
					<div id="pre_panel" class="panel">
						<h1 class="form-group-heading">Pre-Survey</h1>

						<p>Please answer all questions from 1 (lowest) - 5 (highest)</p>

						<p class="radio-group">
							<span class="label">Question Number 1</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
						<p class="radio-group">
							<span class="label">Question Number 2</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
						<p class="radio-group">
							<span class="label">Question Number 3</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
						<p class="radio-group">
							<span class="label">Question Number 4</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
					</div>

				<!--- PARTICIPANT INFORMATION --->
					<div id="post_panel" class="panel">
						<h1 class="form-group-heading">Post-Survey</h1>

						<p>Please answer all questions from 1 (lowest) - 5 (highest)</p>

						<p class="radio-group">
							<span class="label">Question Number 1</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
						<p class="radio-group">
							<span class="label">Question Number 2</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
						<p class="radio-group">
							<span class="label">Question Number 3</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
						<p class="radio-group">
							<span class="label">Question Number 4</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 4</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> 5</label>
						</p>
					</div>

					<div class="form_buttons clearfix">
						<button type="button" class="btn btn-navigation pull-left" disabled>Previous</button>
						<button type="button" class="btn btn-navigation pull-right">Next</button> 
					</div>									
				</form>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">