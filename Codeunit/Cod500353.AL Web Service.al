codeunit 50353 "AL Web Service"
{
    local procedure CallWebService(APICode: Code[20]; API: Text; XMLin: XmlDocument): XmlDocument
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
    begin
        if not Setup.Get(APICode) then
            Error('%1 setup is needed, please enter URL and UserID', Setup."API Code");
        XMLin.WriteTo(XMLtxt);
        TypeHelper.UrlEncode(XMLtxt);
        QueryString := '?API=' + API + '&XML=' + XMLtxt;
        Request.Method := 'GET';
        Request.GetHeaders(Headers);
        Headers.Add('User-Agent', 'Dynamics 365 Business Central');
        Request.SetRequestUri(Setup."API Url" + QueryString);
        if Client.Send(Request, Response) then begin
            if Response.HttpStatusCode = 200 then begin
                Response.Content().ReadAs(txtOut);
                if XmlDocument.ReadFrom(txtOut, XMLOut) then begin
                    exit(XMLOut);
                end else
                    Error('Expected XML format from %1, got this instead: %2', Setup."API Code", txtOut);

            end else
                Error('%1 web service call failed (status code %2)', Setup."API Code", Response.HttpStatusCode());
        end else
            error('Cannot contact %1, connection error!', Setup."API Code");
    end;
}