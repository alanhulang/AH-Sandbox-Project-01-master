/// <summary>
/// Page Intger Page (ID 50351).
/// </summary>
page 50351 "Intger Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Integer;
    SourceTableView = where(Number = filter(1 ..));//(Number = filter(-5 .. 5));
    layout
    {
        area(Content)
        {
            repeater("rpt")
            {

                field("ID"; id)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
                field("Name"; name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field("Contact No. (NAV)"; contactNo)
                {
                    Caption = 'Contact No.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area("Processing")
        {
            action("Test SFDC")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // SFDCManagement.GetAccountFromSFDC('Bauerfeind AG', jObj);
                    // jObj.SelectToken('records', jToken);
                    // jArray := jtoken.AsArray();
                    // objCount := jArray.Count;
                    // Rec.SetRange(Number, 1, objCount);
                    SFDCManagement.GetAccountFromSFDCwXML(xmlDoc);
                    if xmlDoc.SelectNodes('//QueryResult/records', xmlNotes) then
                        objCount := xmlNotes.Count;
                    Rec.SetRange(Number, 1, objCount);
                end;
            }
        }
    }

    /// <summary>
    /// OnOpenPage
    /// </summary>
    trigger OnOpenPage()
    begin
        rec.SETRANGE(Number, 0);
    end;

    trigger OnAfterGetRecord()
    var
        l_index: Integer;
        l_xmlNode: XmlNode;
        l_xmlOpt: XmlWriteOptions;
    begin
        if objCount > 0 then begin
            Id := '';
            Name := '';
            contactNo := '';
            if xmlNotes.Get(rec.Number - 1, xmlNodeTmp) then begin
                if xmlNodeTmp.SelectSingleNode('Id', l_xmlNode) then
                    if l_xmlNode.IsXmlElement then Id := l_xmlNode.AsXmlElement.InnerText;
                if xmlNodeTmp.SelectSingleNode('Name', l_xmlNode) then
                    if l_xmlNode.IsXmlElement then Name := l_xmlNode.AsXmlElement.InnerText;
                if xmlNodeTmp.SelectSingleNode('Contact_No_NAV__c', l_xmlNode) then
                    if l_xmlNode.IsXmlElement then contactNo := l_xmlNode.AsXmlElement.InnerText;
            end
        end;
        // if jArray.Count > 0 then begin
        //     Clear(jtoken);
        //     jArray.Get(Rec.Number - 1, jtoken);
        //     jObj := jtoken.AsObject();

        //     jObj.Get('Id', jtoken);
        //     id := jtoken.AsValue().AsText();

        //     jObj.Get('Name', jtoken);
        //     name := jtoken.AsValue().AsText();

        //     jObj.Get('Contact_No_NAV__c', jtoken);
        //     if not jtoken.AsValue().IsNull then
        //         contactNo := jtoken.AsValue().AsText();
        // end;

    end;

    var
        SFDCManagement: Codeunit SFDC;
        jObj: JsonObject;
        jToken: JsonToken;
        tokenKey: Text;
        jArray: JsonArray;
        tokenValue: Text;
        xmlDoc: XmlDocument;
        xmlNotes: XmlNodeList;
        xmlNodeTmp: XmlNode;
        i: Integer;
        id: Text;
        name: Text;
        contactNo: Text;
        dict: Dictionary of [Text, Text];

        objCount: Integer;
}