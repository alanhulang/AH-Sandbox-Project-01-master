/// <summary>
/// Page Intger Page (ID 50351).
/// </summary>
page 50351 "Intger Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Integer;
    SourceTableView = where(Number = const(1));//(Number = filter(-5 .. 5));
    layout
    {
        area(Content)
        {
            repeater("rpt")
            {

                field("Version"; callapi.ResponseFromSF('version'))
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
            }
        }
    }
    local procedure GetValue(i: Integer): Text
    begin
        if dict.ContainsKey(i) then
            exit(Dict.Get(i));
    end;

    /// <summary>
    /// OnOpenPage
    /// </summary>
    trigger OnOpenPage()
    begin
        Dict.Add(-1, 'Dominic');
        Dict.Add(2, 'Ricky');
        Dict.Add(3, 'Doris');
        Dict.Add(4, 'Mango');
        Dict.Add(5, 'Alan');
        Dict.Add(6, 'Nicklaus');
    end;

    trigger OnAfterGetRecord()

    begin
        jTokenTxt := '';
        // UserName := '';
        // if dict.ContainsKey(rec.Number) then
        //     UserName := (Dict.Get(rec.Number))
        // else
        //     UserName := 'can not find the user for key ' + format(rec.Number);
        //jArray := callapi.ResponseFromSF('version');
        //jArray.Get(0, jToken);
        //jTokenTxt := jToken.AsValue().AsText();

    end;

    var
        Dict: Dictionary of [Integer, Text];
        UserName: Text;
        callapi: Codeunit 50351;
        jArray: JsonArray;
        jToken: JsonToken;
        jTokenTxt: Text;
}