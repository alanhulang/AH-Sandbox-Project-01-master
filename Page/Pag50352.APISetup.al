
page 50352 "External API Setup"
{

    ApplicationArea = All;
    Caption = 'API Setup';
    PageType = List;
    SourceTable = "API Setup";
    UsageCategory = Lists;

    layout
    {

        area(content)
        {
            repeater(General)
            {
                field("API Code"; Rec."API Code")
                {
                    ToolTip = 'Specifies the value of the API Code field';
                    ApplicationArea = All;
                }
                field("API Url"; Rec."API Url")
                {
                    ToolTip = 'Specifies the value of the API Url field';
                    ApplicationArea = All;
                }
                field("API User ID"; Rec."API User ID")
                {
                    ToolTip = 'Specifies the value of the API User ID field';
                    ApplicationArea = All;
                }

                field("API User Pwd"; Rec."API User Pwd")
                {
                    ToolTip = 'Specifies the value of the API User Pwd field';
                    ApplicationArea = All;
                }
                field("API Key"; Rec."API User Key")
                {
                    ToolTip = 'Specifies the value of the API User Key field';
                    ApplicationArea = All;
                }
                field("API Secret"; Rec."API User Secret")
                {
                    ToolTip = 'Specifies the value of the API User Secret field';
                    ApplicationArea = All;
                }
                field("API Token"; Rec."API User Token")
                {
                    ToolTip = 'Specifies the value of the API User Token field';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field';
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
                    if NOT SFDCManagement.CallWebService() then
                        Message(GetLastErrorText());
                end;
            }
        }
    }
    var
        SFDCManagement: Codeunit SFDC;

}
