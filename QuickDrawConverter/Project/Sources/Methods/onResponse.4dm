//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($worker : 4D:C1709.SystemWorker; $params : Object)

var $pdf : 4D:C1709.Blob
$pdf:=$worker.response

TRACE:C157