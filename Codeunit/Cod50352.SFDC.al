codeunit 50352 SFDC
{
    var
        sfdcToken: Text;
        instanceUrl: Text;

    [TryFunction]
    procedure GetAccountFromSFDC(AccName: Text; var jsonObj: JsonObject)
    var
        Setup: Record "API Setup";
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        content: HttpContent;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        QueryTxt: Text;
        XMLtxt: Text;
        txtOut: Text;
        XMLOut: XmlDocument;
        APICode: Code[20];
        dictionaryForUrl: Dictionary of [Text, Text];
        JObj: JsonObject;
        jToken: JsonToken;
        ApiEndPoint: Text;
    begin
        CallWebService('SFDC');
        ApiEndPoint := '/services/data/v52.0/query/';
        QueryTxt := '?q=SELECT id, name, Contact_No_NAV__c from Account ORDER BY Name asc LIMIT 200';
        QueryTxt := QueryTxt.Replace(' ', '+');
        QueryTxt := instanceUrl + apiEndPoint + QueryTxt;
        request.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Authorization', 'Bearer ' + sfdcToken);
        //Headers.Add('Accept', 'application/xml');

        request.SetRequestUri(QueryTxt);
        request.Method := 'GET';

        Client.Send(Request, Response);
        if Response.HttpStatusCode = 200 then begin
            Response.Content().ReadAs(txtOut);
            message(txtOut);
            if JObj.ReadFrom(txtOut) then begin
                jsonObj := JObj;
            end;
        end;
        //end;
    end;

    procedure GetAccountFromSFDCwXML(var xmlObj: XmlDocument)
    var
        Setup: Record "API Setup";
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        content: HttpContent;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        QueryTxt: Text;
        XMLtxt: Text;
        txtOut: Text;
        XMLOut: XmlDocument;
        APICode: Code[20];
        dictionaryForUrl: Dictionary of [Text, Text];
        JObj: JsonObject;
        jToken: JsonToken;
        ApiEndPoint: Text;
    begin
        CallWebService('SFDC');
        ApiEndPoint := '/services/data/v52.0/query/';
        QueryTxt := '?q=SELECT id, name, Contact_No_NAV__c from Account where Name!=null ORDER BY Name asc LIMIT 200';
        QueryTxt := QueryTxt.Replace(' ', '+');
        QueryTxt := instanceUrl + apiEndPoint + QueryTxt;
        request.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Authorization', 'Bearer ' + sfdcToken);
        Headers.Add('Accept', 'application/xml');

        request.SetRequestUri(QueryTxt);
        request.Method := 'GET';

        Client.Send(Request, Response);
        if Response.HttpStatusCode = 200 then begin
            Response.Content().ReadAs(txtOut);
            if XmlDocument.ReadFrom(txtOut, xmlObj) then begin

            end;
        end;
        //end;
    end;

    [TryFunction]
    procedure CallWebService(APICode: Code[20])
    var
        Setup: Record "API Setup";
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        content: HttpContent;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        ContentString: Text;
        XMLtxt: Text;
        txtOut: Text;
        XMLOut: XmlDocument;
        dictionaryForUrl: Dictionary of [Text, Text];
        JObj: JsonObject;
        jToken: JsonToken;
    begin
        if not Setup.Get(APICode) then
            Error('%1 setup is needed, please enter URL and UserID', Setup."API Code");
        //XMLin.WriteTo(XMLtxt);
        TypeHelper.UrlEncode(XMLtxt);
        ContentString := '?grant_type=password';//Setup."API Url";//'?API=' + Setup."API Url" + '&XML=' + XMLtxt
        if Setup."API User Key" <> '' then ContentString += '&client_id=' + Setup."API User Key";
        if Setup."API User Secret" <> '' then ContentString += '&client_secret=' + Setup."API User Secret";
        if Setup."API User ID" <> '' then ContentString += '&username=' + Setup."API User ID";
        if Setup."API User Pwd" <> '' then ContentString += '&password=' + Setup."API User Pwd";
        //content.WriteFrom(ContentString);

        // Retrieve the contentHeaders associated with the content
        content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        request.Content := content;

        request.SetRequestUri(Setup."API Url" + ContentString);
        request.Method := 'POST';

        if Client.Send(Request, Response) then begin
            if Response.HttpStatusCode = 200 then begin
                Response.Content().ReadAs(txtOut);
                if JObj.ReadFrom(txtOut) then begin
                    //XMLOut.SelectNodes()
                    JObj.Get('access_token', jToken);
                    sfdcToken := jToken.AsValue().AsText();
                    JObj.Get('instance_url', jToken);
                    instanceUrl := jToken.AsValue().AsText();
                end else
                    Error('Expected XML format from %1, got this instead: %2', Setup."API Code", txtOut);

            end else
                Error('%1 web service call failed (status code %2)', Setup."API Code", Response.HttpStatusCode());
        end else
            error('Cannot contact %1, connection error!', Setup."API Code");
    end;


}
