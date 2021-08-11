codeunit 50352 SFDC
{
    var
        sfdcToken: Text;
        instanceUrl: Text;

    /// <summary>
    /// Get SFDC response txt
    /// </summary>
    /// <param name="receivedFormat">1:json,2:xml</param>
    procedure GetAccountFromSFDC(receivedFormat: Integer): Text
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
        FormatTxt: Text;
    begin
        GenerateSFToken('SFDC');
        ApiEndPoint := '/services/data/v52.0/query/';
        QueryTxt := '?q=SELECT id, name, Contact_No_NAV__c from Account where Name!=null ORDER BY Name asc LIMIT 200';
        QueryTxt := QueryTxt.Replace(' ', '+');
        QueryTxt := instanceUrl + apiEndPoint + QueryTxt;

        request.Method := 'GET';//Set HttpRequest Method

        //Set HttpRequest Headers <<
        request.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Authorization', 'Bearer ' + sfdcToken);
        if receivedFormat = 1 then
            Headers.Add('Accept', 'application/json')
        else
            Headers.Add('Accept', 'application/xml');
        //Set HttpRequest Headers >>

        request.SetRequestUri(QueryTxt);//Set Url

        Client.Send(Request, Response);//Call Interface
        if Response.HttpStatusCode = 200 then begin
            Response.Content().ReadAs(txtOut);
            case receivedFormat of
                1:
                    FormatTxt := 'json';
                2:
                    FormatTxt := 'xml';
            end;
            if not Confirm('response from salesforce as ' + FormatTxt + ' format:\' + txtOut, false) then exit;
            exit(txtOut);
        end;
        exit(txtOut);
    end;

    [TryFunction]
    procedure GenerateSFToken(APICode: Code[20])
    var
        Setup: Record "API Setup";
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        content: HttpContent;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        ContentString: Text;
        txtOut: Text;
        JObj: JsonObject;
        jToken: JsonToken;
    begin
        if not Setup.Get(APICode) then
            Error('%1 setup is needed, please enter URL and UserID', Setup."API Code");
        ContentString := '?grant_type=password';//Setup."API Url";//'?API=' + Setup."API Url" + '&XML=' + XMLtxt
        if Setup."API User Key" <> '' then ContentString += '&client_id=' + Setup."API User Key";
        if Setup."API User Secret" <> '' then ContentString += '&client_secret=' + Setup."API User Secret";
        if Setup."API User ID" <> '' then ContentString += '&username=' + Setup."API User ID";
        if Setup."API User Pwd" <> '' then ContentString += '&password=' + Setup."API User Pwd";

        request.Method := 'POST';//Set HttpRequest Method
        request.GetHeaders(Headers);//Set HttpRequest Headers
        Headers.Clear();
        Headers.Add('Accept', 'application/json');

        request.SetRequestUri(Setup."API Url" + ContentString);//Set Url
        //////////////////////Setup."API Url" = 'https://login.salesforce.com/services/oauth2/token'

        if Client.Send(Request, Response) then begin
            if Response.HttpStatusCode = 200 then begin
                Response.Content().ReadAs(txtOut);
                if JObj.ReadFrom(txtOut) then begin
                    JObj.Get('access_token', jToken);
                    sfdcToken := jToken.AsValue().AsText();
                    JObj.Get('instance_url', jToken);
                    instanceUrl := jToken.AsValue().AsText();
                end else
                    Error('Expected Json format from %1, got this instead: %2', Setup."API Code", txtOut);

            end else
                Error('%1 web service call failed (status code %2)', Setup."API Code", Response.HttpStatusCode());
        end else
            error('Cannot contact %1, connection error!', Setup."API Code");
    end;


}
