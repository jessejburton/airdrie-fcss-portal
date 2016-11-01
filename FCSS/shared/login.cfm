<form id="login_form" name="login_form"><form>
	<h1 class="form-group-heading">Login</h1>
<!---	<p>	
		<label for="simulate">Simulate Login For: </label><br />
		<select id="simulate" name="simulate">
			<option value="Agency">Test Agency</option>
			<option value="Staff">City Staff (Social Planning)</option>
			<option value="CSAB">CSAB Board Member</option>
		</select>
	</p>

	<hr />--->

	<p>
		<label for="login_username">Username</label><br />
		<input type="text" placeholder="username" id="login_username" name="login_username" />
	</p>

	<p>	
		<label for="login_username">Password</label><br />
		<input type="password" placeholder="password" id="login_password" name="login_password" /><br />
	</p>

	<input type="button" id="login_submit" name="login_submit" value="Login" class="btn btn-primary btn-lg btn-block" />
</form>

<form id="register_form" name="register_form" class="hidden">
	<h1>Register Your Agency</h1>

	<p>
		<label for="agency_name">Agency's Name</label><br />
		<input type="text" placeholder="agency" id="agency_name" name="agency_name" />
	</p>
	<p>
		<label for="agency_name">Agency's Primary Email</label><br />
		<input type="text" placeholder="email" id="agency_email" name="agency_email" />
	</p>

	<input type="button" id="register_submit" name="register_submit" value="Register" class="btn btn-secondary btn-lg btn-block" />

	<p class="register_text">
		An email will be sent to the address above to help you continue with the registration process.
	</p>
</form>

<div class="centered spaced">
	<p><a href="javascript:;" id="login_register" class="spaced underlined login">Register Your Agency</a></p>

	<p class="spaced smaller-text">
		<a href="javascript:;" class="underlined faded">Privacy (FOIP)</a><br />
		<a href="javascript:;" class="underlined faded">Terms of Service</a>
	</p>

	<p>
		<img src="assets/images/coalogo.svg" class="coa_logo_small" />
	</p>
</div>