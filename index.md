---
layout: default
---

![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm&color=blue)
[![license](https://img.shields.io/github/license/miyako/QuickDrawConverter)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/QuickDrawConverter/total)

# QuickDrawConverter

based on [wiesmann/QuickDrawViewer](https://github.com/wiesmann/QuickDrawViewer)

## Usage

```4d
#DECLARE($params : Object)

If (Count parameters=0)
    
    //execute in a worker to process callbacks
    CALL WORKER(1; Current method name; {})
    
Else 
    
    $files:=Folder("/DATA/pict/").files(fk ignore invisible)
    
    var $QuickDrawConverter : cs.QuickDrawConverter
    $QuickDrawConverter:=cs.QuickDrawConverter.new()
    
    /*
        file can be file, BLOB
    */
    
    $options:=[]
    For each ($file; $files.slice(0; 1))
        $output:=Folder(fk desktop folder).folder("pdf").file($file.name+".pdf")
        $options.push({file: $file; output: $output})
        $options.push({file: $file.getContent()})
    End for each 
    
    $results:=$QuickDrawConverter.convert($options; Formula(onResponse))
    
End if 
```

* onResponse

```4d
#DECLARE($worker : 4D.SystemWorker; $params : Object)

var $pdf : 4D.Blob
$pdf:=$worker.response

TRACE
```
