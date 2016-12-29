<cfinvoke component="#APPLICATION.cfcpath#resources" method="getResources" internal="#isDefined('REQUEST.Agency.ADMIN') AND REQUEST.Agency.ADMIN IS true#" returnvariable="RESOURCES" />

<cfif isDefined('REQUEST.Agency.ADMIN') AND REQUEST.Agency.ADMIN IS true>	
	<h1>Agency Resources</h1>

	<ul id="agency_resource_list">
		<cfoutput>
			<cfloop array="#RESOURCES.AGENCY#" index="r">
				<li class="resource-link" data-id="#r.ResourceID#"><a href="#r.URL#" target="#iif(LEFT(r.URL, 4) IS "http", DE('_blank'), DE('_self'))#">#r.Title#</a> <i class="fa fa-close remove-resource" title="Remove this resource link."></i></li>
			</cfloop>
		</cfoutput>
	</ul>

	<a href="javascript:;" class="link show-next"><i class="fa fa-plus-circle"></i> Add Resource</a>
	<form id="agency_resource_form" class="padded-sides hidden">
		<h4>Add Resource</h4>
		<p>
			<label for-="agency_resource_title">Title</label><br />
			<input type="text" id="agency_resource_title" class="resource-title input-half" placeholder="Title" /><br /><br />
			<label for-="agency_resource_url">URL</label><br />
			<input type="text" id="agency_resource_url" class="resource-url input-half" placeholder="URL" />			
		<!--- TODO - implement adding documents 
			<br /><br />OR<br /><br />

			<label for="agency_resource_document">Document</label><br />
			<input type="file" id="agency_resource_document" /> --->
		</p> 
		<p>
			<input type="hidden" class="resource-type" value="A" />
			<button type="button" class="btn btn-primary add-resource"><i class="fa fa-plus-circle"></i> Add Resource</button>
		</p>
	</form>

	<hr />

	<h1>Internal Resources</h1>

	<ul id="internal_resource_list">
		<cfoutput>
			<cfloop array="#RESOURCES.INTERNAL#" index="r">
				<li class="resource-link" data-id="#r.ResourceID#"><a href="#r.URL#" target="#iif(LEFT(r.URL, 4) IS "http", DE('_blank'), DE('_self'))#">#r.Title#</a> <i class="fa fa-close remove-resource" title="Remove this resource link."></i></li>
			</cfloop>
		</cfoutput>
	</ul>

	<a href="javascript:;" class="link show-next"><i class="fa fa-plus-circle"></i> Add Resource</a>
	<form id="internal_resource_form" class="padded-sides hidden">
		<h4>Add Resource</h4>
		<p>
			<label for-="agency_resource_title">Title</label><br />
			<input type="text" id="agency_resource_title" class="resource-title input-half" placeholder="Title" /><br /><br />
			<label for-="agency_resource_url">URL</label><br />
			<input type="text" id="agency_resource_url" class="resource-url input-half" placeholder="URL" />			
		<!--- TODO - implement adding documents 
			<br /><br />OR<br /><br />

			<label for="agency_resource_document">Document</label><br />
			<input type="file" id="agency_resource_document" /> --->
		</p> 
		<p>
			<input type="hidden" class="resource-type" value="I" />
			<button type="button" class="btn btn-primary add-resource"><i class="fa fa-plus-circle"></i> Add Resource</button>
		</p>
	</form>	
<cfelse>
	<h1>Agency Resources</h1>

	<ul>
		<cfoutput>
			<cfloop array="#RESOURCES.AGENCY#" index="r">
				<li><a href="#r.URL#" target="#iif(LEFT(r.URL, 4) IS "http", DE('_blank'), DE('_self'))#">#r.Title#</a></li>
			</cfloop>
		</cfoutput>
	</ul>	
</cfif>

<ul class="hidden">
	<li class="resource-link template"><a href="javascript:;">LINK</a> <i class="fa fa-close remove-resource" title="Remove this resource link."></i></li>
</ul>