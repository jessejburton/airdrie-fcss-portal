<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<div class="panels clearfix">
				<ul class="panel_nav_top clearfix">
					<li><a href="javascript:;" class="active" data-show="step1">step 1</a></li>
					<li><a href="javascript:;" data-show="step2">step 2</a></li>
					<li><a href="javascript:;" data-show="step3">step 3</a></li>
					<li><a href="javascript:;" data-show="step4">step 4</a></li>
					<li><a href="javascript:;" data-show="step5">step 5</a></li>
					<li><a href="javascript:;" data-show="step6">step 6</a></li>
					<li><a href="javascript:;" data-show="step7">step 7</a></li>
					<li><a href="javascript:;" data-show="step8">step 8</a></li>
					<li><a href="javascript:;" data-show="step9">step 9</a></li>	
				</ul>				

				<form id="panel_display" class="panel_form">
				<!--- STEP 1 START --->
					<div id="step1" class="panel active">
						<h1 class="form-group-heading">Project Details</h1>
						<div class="autoreply autoreply-success">
							Your application was successfully submitted!	
						</div>
						<div class="autoreply autoreply-error">
							Please make sure to
							<ul>
								<li>Fill out the field.</li>
								<li>Must be a number.</li>
								<li>Select at least one.</li>
							</ul>	
						</div>
						<div class="autoreply autoreply-warning">
							The system will be down for maintenance tomorrow.	
						</div>
						
						<p>
							<label for="project_name">Project Name</label><br />
							<input type="text" id="project_name" placeholder="Please enter the name of your project" />
						</p>
						<p>
							<label for="project_description">Project Description</label><br ?>
							<textarea id="project_name" placeholder="Please enter a description for your project" class="textarea-large autoreply-input-error"></textarea>
						</p>
					</div>
				<!--- STEP 1 END --->

				<!--- STEP 2 START --->
					<div id="step2" class="panel">
						<h1>Step 2</h1>
						<p class="checkbox-group autoreply-input-error">
							<span class="label">Check All That Apply</span><br />
							<label class="checkbox" for="checkbox1"><input type="checkbox" id="checkbox1" /> Option 1</label>
							<label class="checkbox" for="checkbox2"><input type="checkbox" id="checkbox2" /> Option 2</label>
							<label class="checkbox" for="checkbox3"><input type="checkbox" id="checkbox3" /> Option 3</label>
							<label class="checkbox" for="checkbox4"><input type="checkbox" id="checkbox4" /> Option 4</label>
						</p>
						<p class="radio-group">
							<span class="label">Select One</span><br />
							<label class="radio" for="radio1"><input type="radio" id="radio1" name="radio" /> Option 1</label>
							<label class="radio" for="radio2"><input type="radio" id="radio2" name="radio" /> Option 2</label>
							<label class="radio" for="radio3"><input type="radio" id="radio3" name="radio" /> Option 3</label>
							<label class="radio" for="radio4"><input type="radio" id="radio4" name="radio" /> Option 4</label>
						</p>
					</div>
				<!--- STEP 2 END --->

				<!--- STEP 3 START --->
					<div id="step3" class="panel">
						<h1>Step 3</h1>
						<p>
							<label for="selectbox">Select something</label><br />
							<select id="selectbox">
								<option value="">--- Select an option ---</option>
								<option value="1">Option 1</option>
								<option value="2">Option 2</option>
								<option value="3">Option 3</option>
								<option value="4">Option 4</option>
							</select>
						</p>
						<hr />
						<p>
							<label for="selectbox">Select another something</label><br />
							<select id="selectbox" class="autoreply-input-error">
								<option value="">--- Select an option ---</option>
								<option value="1">Option 1</option>
								<option value="2">Option 2</option>
								<option value="3">Option 3</option>
								<option value="4">Option 4</option>
							</select>
						</p>
					</div>
				<!--- STEP 3 END --->

				<!--- STEP 4 START --->
					<div id="step4" class="panel">
						<h1>Step 4</h1>
					</div>
				<!--- STEP 4 END --->

				<!--- STEP 5 START --->
					<div id="step5" class="panel">
						<h1>Step 5</h1>
					</div>
				<!--- STEP 5 END --->

				<!--- STEP 6 START --->
					<div id="step6" class="panel">
						<h1>Step 6</h1>
					</div>
				<!--- STEP 6 END --->

				<!--- STEP 7 START --->
					<div id="step7" class="panel">
						<h1>Step 7</h1>
					</div>
				<!--- STEP 7 END --->

				<!--- STEP 8 START --->
					<div id="step8" class="panel">
						<h1>Step 8</h1>
					</div>
				<!--- STEP 8 END --->

				<!--- STEP 9 START --->
					<div id="ste9p9" class="panel">
						<h1>Step 9</h1>
					</div>
				<!--- STEP 9 END --->

					<div class="panel_nav_bottom clearfix">
						<button type="button" class="btn btn-navigation pull-left" disabled>Previous</button>
						<button type="button" class="btn btn-navigation pull-right">Next</button> 
					</div>									
				</form>
			</div>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">