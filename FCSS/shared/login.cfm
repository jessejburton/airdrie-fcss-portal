<form id="login_form" name="login_form"><form>
	<p>	
		<label for="simulate">Simulate Login For: </label><br />
		<select id="simulate" name="simulate" class="form-control">
			<option value="Agency">Test Agency</option>
			<option value="Staff">City Staff (Social Planning)</option>
			<option value="CSAB">CSAB Board Member</option>
		</select>
	</p>

	<hr />

	<input type="text" placeholder="username" id="login_username" name="login_username" class="form-control" /><br />
	<input type="password" placeholder="password" id="login_password" name="login_password" class="form-control" /><br />
	<input type="button" id="login_submit" name="login_submit" value="Login" class="btn btn-default btn-lg btn-block" />
</form>

