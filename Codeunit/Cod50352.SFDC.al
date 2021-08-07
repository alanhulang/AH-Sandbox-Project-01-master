codeunit 50352 SFDC
{
    local procedure MyProcedure()
    var
        clientID: Text;
        clientSecret: Text;
        environment: Text;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
    begin
        request.Method('Post');
    end;


    [TryFunction]
    procedure CallWebService()
    var
        Setup: Record "API Setup";
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        QueryString: Text;
        XMLtxt: Text;
        txtOut: Text;
        XMLOut: XmlDocument;
        APICode: Code[20];
    begin

        APICode := 'SFDC';
        if not Setup.Get(APICode) then
            Error('%1 setup is needed, please enter URL and UserID', Setup."API Code");
        //XMLin.WriteTo(XMLtxt);
        TypeHelper.UrlEncode(XMLtxt);
        QueryString := Setup."API Url";//'?API=' + Setup."API Url" + '&XML=' + XMLtxt
        if Setup."API User Key" <> '' then QueryString += '&client_id=' + Setup."API User Key";
        if Setup."API User Secret" <> '' then QueryString += '&client_secret=' + Setup."API User Secret";
        if Setup."API User ID" <> '' then QueryString += '&username=' + Setup."API User ID";
        if Setup."API User Pwd" <> '' then QueryString += '&password=' + Setup."API User Pwd";
        Request.Method := 'POST';
        //Request.GetHeaders(Headers);
        //Headers.Add('Content-Type', 'application/json');
        Request.SetRequestUri(QueryString);
        if Client.Send(Request, Response) then begin
            if Response.HttpStatusCode = 200 then begin
                Response.Content().ReadAs(txtOut);
                if XmlDocument.ReadFrom(txtOut, XMLOut) then begin
                    MESSAGE(FORMAT(XMLOut));
                end;// else
                    //Error('Expected XML format from %1, got this instead: %2', Setup."API Code", txtOut);

            end;// else
                // Error('%1 web service call failed (status code %2)', Setup."API Code", Response.HttpStatusCode());
        end else
            error('Cannot contact %1, connection error!', Setup."API Code");
    end;


}
