pageextension 50352 GLAccountListExt extends "G/L Account List"
{
    layout
    {
        addafter(Name)
        {
            field("CN Name"; Rec."CN Name")
            {
                Caption = 'CNName';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}