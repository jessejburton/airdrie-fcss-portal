<div class="clearfix" id="verify">
	<div id="verify_form_container" style="max-width: 400px; margin: 0 auto;">
		<form id="verify_form" name="verify_form">
			<h1>Almost Done!</h1>
			<p>All that is left to verify your account is to set your password. Please enter the password you would like to use to log in to the system.</p>
			<div class="form-group" id="password_verify_group">
				<p>
					<label for="password">Password</label><br />
					<input type="password" placeholder="password" id="password" name="password" />
				</p>

				<p>
					<label for="verify_password">Verify Password</label><br />
					<input type="password" placeholder="verify password" id="verify_password" name="verify_password" />
				</p>

				<input type="hidden" id="guid" value="<cfoutput>#XMLFormat(URL.accountverify)#</cfoutput>" />
				<input type="hidden" id="emailhash" value="<cfoutput>#XMLFormat(URL.email)#</cfoutput>" />
				<input type="button" id="verify_submit" name="verify_submit" value="Set Password" class="btn btn-primary btn-lg btn-block" />
			</div>
		</form>

		<div class="centered spaced small-text">
			<p><a href="javascript:;" id="register_btn" class="spaced underlined login">Register Your Agency</a></p>
		</div>
	</div>	
</div>