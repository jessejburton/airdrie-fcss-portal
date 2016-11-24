<cfscript>
    //Create New Spreadsheet
    SpreadsheetObj = spreadsheetNew("Survey");
 
//Get Workbook object
    workbook = SpreadsheetObj.getWorkBook();
 
//Get sheet by name where you liek to add list validation
    sheet = workbook.getSheet("Survey");
 
    //Create object of required class
    dvconstraint = createObject("java","org.apache.poi.hssf.usermodel.DVConstraint");
    cellRangeList = createObject("java","org.apache.poi.ss.util.CellRangeAddressList");
    dataValidation = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataValidation");
 
    SpreadsheetAddRow(SpreadsheetObj,"Name, Age, Income",1,1); 

    //Define cell list rowstart, rowend, column start, column end
    addressList = cellRangeList.init(1, 100, 1, 1);//First 10 rows in first column
    dvConstraint = dvconstraint.createExplicitListConstraint(["0-4", "5-9", "10-14"]); //set contraint value
    dataValidation = dataValidation.init(addressList, dvConstraint); //apply validation on address list
    dataValidation.setSuppressDropDownArrow(false);//Enable/disable dropdown arrow.
    sheet.addValidationData(dataValidation);//Add validation to sheet.
 
//write spreadsheet object
    spreadsheetwrite(SpreadsheetObj,"#expandpath('./downloadsheet.xls')#",true);
</cfscript>