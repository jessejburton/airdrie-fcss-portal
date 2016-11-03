<div id="login_form_container">
	<form id="login_form" name="login_form"><form>
		<h1>Login</h1>
		<div id="login_form_group" class="form-group seen">
			<p>
				<label for="login_email">Email</label><br />
				<input type="text" placeholder="enter your email address" id="login_email" name="login_email" class="required" />
			</p>

			<p>	
				<label for="login_password">Password</label><br />
				<input type="password" placeholder="enter your password" id="login_password" name="login_password" class="required" /><br />
			</p>

			<input type="button" id="login_submit" name="login_submit" value="Login" class="btn btn-primary btn-lg btn-block" />
		</div>
	</form>

	<form id="register_form" name="register_form" class="hidden">
		<h1>Register Your Agency</h1>
		<div id="register_form_group" class="form-group seen">
			<p>
				<label for="agency_name">Agency's Name</label><br />
				<input type="text" placeholder="enter the name of your agency" id="agency_name" name="agency_name" class="required" />
			</p>
			<p>
				<label for="your_email">Your Email Address</label><br />
				<input type="text" placeholder="enter the primary email of your agency" id="your_email" name="your_email" class="required" /><br />
				<span class="super-small-text">* This email address will be used for your login. An email will be sent to the address with a link to continue with the registration process.</span>
			</p>

			<input type="button" id="register_submit" name="register_submit" value="Register" class="btn btn-primary btn-lg btn-block" />
		</div>
	</form>

	<div class="centered spaced small-text">
		<p><a href="javascript:;" id="login_register" class="spaced underlined login">Register Your Agency</a></p>
	</div>
</form>