//%attributes = {"invisible":true}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	//execute in a worker to process callbacks
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	$files:=Folder:C1567("/DATA/pict/").files(fk ignore invisible:K87:22)
	
	var $QuickDrawConverter : cs:C1710.QuickDrawConverter
	$QuickDrawConverter:=cs:C1710.QuickDrawConverter.new()
	
/*
file can be file, BLOB
*/
	
	$options:=[]
	For each ($file; $files.slice(0; 1))
		$output:=Folder:C1567(fk desktop folder:K87:19).folder("pdf").file($file.name+".pdf")
		$options.push({file: $file; output: $output})
		$options.push({file: $file.getContent()})
	End for each 
	
	$results:=$QuickDrawConverter.convert($options; Formula:C1597(onResponse))
	
End if 