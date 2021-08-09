
/// <summary>
/// Page Date Virtual (ID 50350).
/// </summary>
page 50350 "Date Virtual"
{
    PageType = List;
    SourceTable = Date;
    SourceTableView = where("Period Type" = const(Week));
    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Period Type"; Rec."Period Type")
                {
                    Caption = 'Period Type';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Period Start"; Rec."Period Start")
                {
                    Caption = 'Start';
                    ApplicationArea = All;
                }
                field("Period No."; Rec."Period No.")
                {
                    Caption = 'Period No.';
                    ApplicationArea = All;
                }
            }
            usercontrol(TestDemo; DotNetTest)
            {
                ApplicationArea = all;
                trigger ControlReady()
                begin
                    Ready := true;
                end;

                trigger Result(d: Integer)
                begin
                    Message('The result is %1', d);
                end;

                trigger SFDCTokenResult(t: Text)
                begin
                    Message(t);
                end;
            }
        }

    }

    /// <summary>
    /// OnOpenPage
    /// </summary>
    trigger OnOpenPage()
    begin
        Rec.SetRange("Period Start", 20190101D, 20211231D);
    end;

    var
        Ready: Boolean;
        client: HttpClient;
        content: HttpContent;
        dictionaryForUrl: Dictionary of [Text, Text];



}
