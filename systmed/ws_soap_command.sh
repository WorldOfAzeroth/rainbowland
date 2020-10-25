curl --user user:password --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction: " --data '
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" xmlns:xsd="http://www.w3.org/1999/XMLSchema" xmlns:ns1="urn:TC">
    <SOAP-ENV:Header>
    </SOAP-ENV:Header>
    <SOAP-ENV:Body>
         <ns1:executeCommand>
	     <command>server info</command>
	 </ns1:executeCommand>
    </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
' -X POST http://127.0.0.1:7878/urn:TC

