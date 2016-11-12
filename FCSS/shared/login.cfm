<!--- MAIN CONTENT --->
<div class="clearfix" id="login">
	<div id="login_form_container">
		<form id="login_form" name="login_form">
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

				<input type="submit" id="login_submit" name="login_submit" value="Login" class="btn btn-primary btn-lg btn-block" />
			</div>
		</form>

		<div class="centered spaced small-text">
			<p><a href="javascript:;" id="register_btn" class="spaced underlined login">Register Your Agency</a></p>
		</div>
	</div>	

	<div class="splash">
		<h1>Family & Community Support Services</h1>
		<img src="assets/images/splash_page.jpg" class="splash-page-image" />		
		<p>Family and Community Support Services (FCSS) is a partnership between the province, municipalities and Metis Settlements, developing locally driven preventive social initiatives to enhance the well-being of individuals, families and communities.</p>

		<p>The premise behind FCSS is that by investing in programs that strengthen individuals, families and the community before problems occur, we can equip them with knowledge, skills and proactive behaviours that contribute to their overall well-being.</p>
		<p>Airdrie FCSS funds locally-focused preventive social programs that contributes to individual, family and community well-being.</p>
		<h2> Family and Community Support Services Program may offer the following services in the community:</h2>
		<ol>
			<li><strong>Services that promote the social development of children and their families, including:</strong>
				<ul>
					<li>Parent-child development activities</li>
					<li>Temporary or occasional parent relief services</li>
					<li>Support services for young school age children</li>
				</ul>
			</li>
			<li><strong>Services that enrich and strengthen family life by developing skills in people to function more effectively within their own environment, including:</strong>
				<ul>
					<li>Parenting and family life education and development programs</li>
					<li>Individual, family and group counselling services that are educational and not treatment oriented</li>
					<li>Youth development services</li>
				</ul>
			</li>
			<li><strong>Services that enhance the quality of life of the retired and semi-retired, including:</strong>
				<ul>
					<li>Home support services</li>
					<li>Education and information services</li>
					<li>Outreach and coordination self-help socialization activities</li>
				</ul>
			</li>
			<li><strong>Services designed to promote, encourage and support volunteer work in the community, including:</strong>
				<ul>
					<li>Recruitment, training and placement services</li>
					<li>Resources to support volunteers</li>
					<li>Coordination of volunteer services</li>
				</ul>
			</li>
			<li><strong>Services designed to inform the public of available services, including:</strong>
				<ul>
					<li>Information and referral services</li>
					<li>Community information directories</li>
					<li>Newcomer services and inter-agency coordination</li>
				</ul>
			</li>
		</ol>
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

<!--- BOARD DETAILS --->
			<h3>Board Members</h3>
			<div class="form-group">
				<div id="board_list">
					<div class="two-cols board-member">
						<p><input type="text" name="board_name" class="inline required" placeholder="Board member's name" /></p>
						<p><input type="text" name="board_title" class="inline required" placeholder="Board member's title" /></p>
					</div>
					<div class="two-cols board-member">
						<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
						<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
					</div>
					<div class="two-cols board-member">
						<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
						<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
					</div>
					<div class="two-cols board-member">
						<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
						<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
					</div>
					<div class="two-cols board-member">
						<p><input type="text" name="board_name" class="inline" placeholder="Board member's name" /></p>
						<p><input type="text" name="board_title" class="inline" placeholder="Board member's title" /></p>
					</div>
				</div>
				<p><a href="javascript:;" class="add-board"><i class="fa fa-plus"></i> add another</a></p>

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
					<input type="text" id="account_name" class="input-half" placeholder="Please enter your name." />
				</p>
				<p>
					<label for="account_email">Your Email</label><br />
					<input type="text" id="account_email" class="input-half" placeholder="Please enter the email of the primary contact person." />
				</p>

				<div class="form_buttons clearfix">
					<button type="button" class="nav next btn btn-primary pull-right" id="register_agency_btn">Register</button> 
				</div>	
			</div>								
		</div>
	</form>
</div>