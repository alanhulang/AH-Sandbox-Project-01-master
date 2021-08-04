/// <summary>
/// Codeunit call sf (ID 50351).
/// </summary>
codeunit 50351 "call sf"
{

    /// <summary>
    /// callSF.
    /// </summary>
    /// <param name="jsonMember">Text.</param>
    /// <returns>Return value of type Text begin.</returns>
    procedure ResponseFromSF(jsonMember: Text): Text
    var
        client: HttpClient;
        request: HttpRequestMessage;
        reponse: HttpResponseMessage;
        jobject: JsonObject;
        responseTxt: Text;
        jArray: JsonArray;
        i: Integer;
        jtoken: JsonToken;
    begin
        if client.Get('https://ap12.lightning.force.com/services/data', reponse) then begin
            if reponse.IsSuccessStatusCode() then begin
                reponse.Content().ReadAs(responseTxt);
                if not jArray.ReadFrom(responseTxt) then
                    Error('Invalid response, expected an JSON array as root object');
                for i := 0 to jArray.Count - 1 do begin
                    jArray.Get(i, jtoken);
                    jobject := jtoken.AsObject();
                    if GetJsonToken(jobject, 'label').AsValue().AsText() = 'Summer ' + '''' + '18' then
                        exit(GetJsonToken(jobject, 'url').AsValue().AsText());
                end;
            end;
            exit('');
        end;
    end;

    /// <summary>
    /// SelectJsonToken.
    /// </summary>
    /// <param name="jsonObj">JsonObject.</param>
    /// <param name="tokenKey">Text.</param>
    /// <returns>Return variable JToken of type JsonToken.</returns>
    local procedure GetJsonToken(jsonObj: JsonObject; tokenKey: Text) JToken: JsonToken
    begin
        if not jsonObj.Get(tokenKey, JToken) then
            Error('Could not find a token with key %1', tokenKey);
    end;

    /// <summary>
    /// SelectJsonToken.
    /// </summary>
    /// <param name="jsonObj">JsonObject.</param>
    /// <param name="Path">Text.</param>
    /// <returns>Return variable JToken of type JsonToken.</returns>
    local procedure SelectJsonToken(jsonObj: JsonObject; Path: Text) JToken: JsonToken
    begin
        if jsonObj.SelectToken(Path, JToken) then
            Error('Could not find a token with Path %1', Path);

    end;
}
