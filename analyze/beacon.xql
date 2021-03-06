xquery version "3.1";
declare namespace functx = "http://www.functx.com";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";
import module namespace config="http://www.digital-archiv.at/ns/rundbriefe-app/config" at "../modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/rundbriefe-app/templates" at "../modules/app.xql";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace gefx = "http://gexf.net/data/hello-world.gexf";
declare namespace util = "http://exist-db.org/xquery/util";

declare option exist:serialize "method=text media-type=text encoding=utf-8";

let $root := "https://rundbriefe-app.acdh.oeaw.ac.at/"

let $prefix := 
"#FORMAT: BEACON
#MESSAGE: rundbriefe-app &#10;"

let $nl := "&#10;"
let $items :=  
    for $x in doc($app:personIndex)//tei:person[starts-with(./tei:idno/text(), 'http://d-nb')]
        let $ownId := data($x/@xml:id)
        let $url := $root||'pages/hits.html?searchkey='||$ownId
        let $idno := $x/tei:idno[1]/text()
        let $entry :=$x/tei:idno[1]/text()||'|'||$url
    return $entry
let $beacon := string-join(($prefix, $items), '&#10;')
    return $beacon