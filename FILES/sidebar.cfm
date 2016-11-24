<!DOCTYPE html>
<html>
<head>
	<title></title>

	<style>
		body {
			    color: #444;
		    font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen-Sans,Ubuntu,Cantarell,"Helvetica Neue",sans-serif;
		    font-size: 13px;
		    line-height: 1.4em;
		}
		div { 
			display: block;
		}
		#wrapper {
			height: auto;
		    min-height: 100%;
		    width: 100%;
		    position: relative;
		}
		#adminmenuback {
		    position: fixed;
		    top: 0;
		    bottom: -120px;
		    z-index: 1;
		}
		#adminmenuwrap {
			position: fixed;
			float: left;
    		z-index: 9990;
		}
		#adminmenu, #adminmenuback, #adminmenuwrap {
		    width: 160px;
		    background-color: #23282d;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<div id="adminmenuback"></div>
		<div id="adminmenuwrap">
			<ul id="adminmenu">
				<li><a href="javascript:;">Menu Item 1</a></li>
				<li><a href="javascript:;">Menu Item 2</a></li>
				<li><a href="javascript:;">Menu Item 3</a></li>
				<li><a href="javascript:;">Menu Item 4</a></li>
			</ul>
		</div>
	</div>
</body>
</html>