<cfinclude template="shared/header.cfm">

<!--- MAIN CONTENT --->
	<section id="main_content">
		<div class="wrapper clearfix">
			<form>
			<!--- STEP 1 START --->
				<div id="section1" class="form-group">
					<h1 class="form-group-heading">Section 1 Heading</h1>
					<span class="subtext form-group-heading">This is what section heading subtext will look like.</span>

<!--- AUTO REPLIES --->
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
						<label for="text_input">Text Input</label><br />
						<input type="text" id="text_input" placeholder="Please enter some text" />
					</p>
					<p class="group-error">
						<label for="long_description">Long Description</label><br />
						<span class="subtext">This is what input subtext will look like.</span>
						<span class="error-details">
							This is where you will be told what you need to do to fix this error.
						</span>
						<textarea id="long_description" placeholder="Please enter a long description" class="textarea-large"></textarea>
						
					</p>
					
				</div>

				<div id="section2" class="form-group">
					<h1 class="form-group-heading">Section 2 Heading</h1>
					<span class="subtext">This is what section heading subtext will look like.</span>

					<p class="checkbox-group group-error">
						<span class="label">Check All That Apply</span><br />
						<span class="subtext">Checkbox group subtext</span>
						<span class="error-details">
							This is where you will be told what you need to do to fix this error.
						</span>
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
				<div id="section3" class="form-group">
					<h1 class="form-group-heading">Section 3 Heading</h1>

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
					<p class="group-error">
						<label for="selectbox">Select another something</label><br />
						<span class="subtext">This is what input subtext will look like.</span>
						<span class="error-details">
							This is where you will be told what you need to do to fix this error.
						</span>
						<select id="selectbox" >
							<option value="">--- Select an option ---</option>
							<option value="1">Option 1</option>
							<option value="2">Option 2</option>
							<option value="3">Option 3</option>
							<option value="4">Option 4</option>
						</select>						
					</p>
				</div>

				<div class="form_buttons clearfix">
					<button type="button" class="btn btn-navigation pull-left" disabled>Previous</button>
					<button type="button" class="btn btn-navigation pull-right">Next</button> 
				</div>									
			</form>
		</div>
	</section>	

<cfinclude template="shared/footer.cfm">