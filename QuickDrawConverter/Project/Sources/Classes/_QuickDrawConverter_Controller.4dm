property stdOut : 4D:C1709.Blob
property stdErr : Text

Class extends _CLI_Controller

Class constructor($CLI : cs:C1710._CLI)
	
	Super:C1705($CLI)
	
	This:C1470.clear()
	
Function clear() : cs:C1710._QuickDrawConverter_Controller
	
	This:C1470.stdOut:=4D:C1709.Blob.new()
	This:C1470.stdErr:=""
	
	return This:C1470
	
Function onData($worker : 4D:C1709.SystemWorker; $params : Object)
	
	var $stdOut : Blob
	COPY BLOB:C558(This:C1470.stdOut; $stdOut; 0; 0; This:C1470.stdOut.size)
	COPY BLOB:C558($params.data; $stdOut; 0; BLOB size:C605($stdOut); $params.data.size)
	
	This:C1470.stdOut:=$stdOut
	
Function onDataError($worker : 4D:C1709.SystemWorker; $params : Object)
	
	This:C1470.stdErr+=$params.data
	
Function onResponse($worker : 4D:C1709.SystemWorker; $params : Object)
	
Function onError($worker : 4D:C1709.SystemWorker; $params : Object)
	
Function onTerminate($worker : 4D:C1709.SystemWorker; $params : Object)
	