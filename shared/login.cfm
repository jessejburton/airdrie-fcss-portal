<!--- MAIN CONTENT --->
<div class="clearfix" id="login">
	<div id="login_form_container">
		<form id="login_form" name="login_form">
			<h1>Login</h1>
			<div id="login_form_group">
				<p>
					<label for="login_email">Email</label><br />
					<input type="text" placeholder="enter your email address" id="login_email" name="login_email" />
				</p>

				<p>	
					<label for="login_password">Password</label><br />
					<input type="password" placeholder="enter your password" id="login_password" name="login_password" /><br />
					<a href="javascript:;" id="forgot_btn" class="underlined small-text">Forgot Your Password?</a>
				</p>

				<input type="submit" id="login_submit" name="login_submit" value="Log In" class="btn btn-primary btn-lg btn-block" />
				<div id="timeleft" class="hidden centered small-text">retry in <span>3</span> seconds</div>
			</div>
		</form>

		<div class="centered spaced small-text">
			<p class="spaced">Don't have an account? <a href="javascript:;" id="register_btn" class="underlined login">Register Your Agency</a></p>
		</div>
	</div>	

	<div class="splash">
		<cfinclude template="splash.cfm">
	</div>
</div>

<!--- REGISTRATION --->
<div class="clearfix wrapper" id="register">
	<h1>Register your Agency</h1>

	<form id="register_form">
		<div class="accordion clearfix">
		<!--- AGENCY INFORMATION --->
			<h3 class="open">Agency Information</h3>
			<div class="form-group seen">
				<p>
					<label for="agency_name">Agency Name</label><br />
					<input type="text" id="agency_name" placeholder="Please enter the name of your agency." class="required" />
				</p>
				<p>
					<label for="agency_mission">Mission</label><br />						
					<textarea id="agency_mission" placeholder="Please enter the mission for your agency" class="textarea-large required"></textarea>						
				</p>
				<p>
					<label for="agency_vision">Vision</label><br />						
					<textarea id="agency_vision" placeholder="Please enter the vision for your agency" class="textarea-large required"></textarea>						
				</p>		
				
				<div class="form_buttons clearfix">
					<button type="button" class="btn btn-primary pull-right nav next">Next</button> 
				</div>			
			</div>

		<!--- CONTACT INFORMATION --->
			<h3>Contact Information</h3>
			<div class="form-group">
				<p>
					<label for="agency_phone">Agency Phone Number</label><br />
					<input type="text" id="agency_phone" class="input-half required" placeholder="Please enter the phone number of your agency." />
				</p>
				<p>
					<label for="agency_fax">Agency Fax Number</label><br />
					<input type="text" id="agency_fax" class="input-half" placeholder="Please enter the fax number of your agency." />
				</p>
				<p>
					<label for="agency_email">Agency Email</label><br />
					<input type="text" id="agency_email" class="input-half required" placeholder="Please enter the primary email of your agency." />
				</p>
				<p>
					<label for="agency_address">Agency Address</label><br />
					<textarea data-maxlength="1000" id="agency_address" placeholder="Please enter your agencies physical address. Please include the postal code." class="input-half required"></textarea>
				</p>
				<p>
					<label for="agency_mailing">Agency Mailing Address</label><br />
					<span class="label-sub">if different from your physical address</span><br />	
					<textarea data-maxlength="1000" id="agency_mailing" placeholder="Please enter your agencies mailing address. Please include the postal code." class="input-half"></textarea>
				</p>
				<p>
					<label for="agency_website">Website</label><br />
					<input type="text" id="agency_website" class="input-half" placeholder="Please enter your agencies website." />
				</p>

				<div class="form_buttons clearfix">
					<button type="button" class="btn btn-primary pull-left nav prev">Prev</button> 
					<button type="button" class="btn btn-primary pull-right nav next">Next</button> 
				</div>	
			</div>

<!--- USER ACCOUNT INFORMATION --->
			<h3>Your Account Information</h3>
			<div class="form-group">
				<p>This information will be used to verify your e-mail address and to log you in to the system after registration.</p>

				<p>
					<label for="account_name">Your Name</label><br />
					<input type="text" id="account_name" class="input-half required" placeholder="Please enter your name." />
				</p>
				<p>
					<label for="account_email">Your Email</label><br />
					<input type="text" id="account_email" class="input-half required" placeholder="Please enter the email of the primary contact person." />
				</p>

				<div class="form_buttons clearfix">
					<button type="button" id="register_agency_submit" class="btn btn-primary pull-right">Register your Agency</button>
				</div>	
			</div>								
		</div>
	</form>
</div>