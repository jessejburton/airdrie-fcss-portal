<!--- THIS PAGE REQUIRES A SURVEY ID TO BE PASSED IN THROUGH THE URL --->
<cfif NOT isDefined('REQUEST.Loggedin') OR NOT isDefined('URL.SurveyID') OR NOT isNumeric(URL.SurveyID)>
	<cflocation url="index.cfm" addtoken="false">
<cfelse>
	<!--- Check Permission for program --->
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkProgramAccessByAccountID" programID="#URL.ProgramID#" returnvariable="programpermission" />
	<cfinvoke component="#APPLICATION.cfcpath#core" method="checkSurveyAccessByProgramID" surveyID="#URL.SurveyID#" programID="#URL.ProgramID#" returnvariable="surveypermission" />
	<cfif NOT programpermission OR NOT surveypermission>
		<cflocation url="index.cfm" addtoken="false">
	</cfif>

	<!--- Get the approrpriate survey data --->
	<cfinvoke component="#APPLICATION.cfcpath#webservices" method="getSurveyByID" csrf="#COOKIE.CSRF#" SurveyID="#URL.SurveyID#" returnvariable="response" />
	<cfset REQUEST.SURVEY = response.DATA>
</cfif>

<cfscript>
    // Create New Spreadsheet
    SpreadsheetObj = spreadsheetNew("Survey");
 
// Get Workbook object
    workbook = SpreadsheetObj.getWorkBook();
 
// Get sheet by name where you liek to add list validation
    sheet = workbook.getSheet("Survey");
 
    //Create object of required class
    dvconstraint = createObject("java","org.apache.poi.hssf.usermodel.DVConstraint");
    cellRangeList = createObject("java","org.apache.poi.ss.util.CellRangeAddressList");
    dataValidation = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataValidation");
 
 	columns = "Name, Gender, Age, People in Family, Residence, Language, Income";
 	for (i=1; i LTE ArrayLen(REQUEST.SURVEY.QUESTIONS); i=i+1) {
 		columns = ListAppend(columns, ReplaceNoCase(REQUEST.SURVEY.QUESTIONS[i].Question, ",", "", "all"));
	}
	columns = ListAppend(columns, "Pre/Post");

    SpreadsheetAddRow(SpreadsheetObj,columns,1,1); 

    // Gender
    gender = cellRangeList.init(1, 100, 1, 1); //First 100 rows in column
    dvConstraint = dvconstraint.createExplicitListConstraint(["Male", "Female"]); //set contraint value
    dataValidation = dataValidation.init(gender, dvConstraint); //apply validation on address list
    sheet.addValidationData(dataValidation); //Add validation to sheet.

    /* Age
    age = cellRangeList.init(2, 100, 1, 1);//First 100 rows in column
    ageConstraint = ageconstraint.createExplicitListConstraint(["0-4","5-9","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65-69","70-74","75+";
]); //set contraint value
    dataValidation = dataValidation.init(age, dvConstraint); //apply validation on address list
    sheet.addValidationData(dataValidation);//Add validation to sheet.  */


// Write spreadsheet object
    spreadsheetwrite(SpreadsheetObj,"#expandpath('./downloadsheet.xls')#",true);
</cfscript>