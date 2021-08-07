
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
        client: HttpClient;

}
