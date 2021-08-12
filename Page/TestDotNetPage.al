page 50353 "Test DotNet in AL"
{
    PageType = NavigatePage;
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            // usercontrol(TestDemo; DotNetTest)
            // {
            //     ApplicationArea = all;
            //     trigger ControlReady()
            //     begin
            //         Ready := true;
            //     end;

            //     trigger Result(d: Integer)
            //     begin
            //         Message('The result is %1', d);
            //     end;

            //     trigger SFDCTokenResult(t: Text)
            //     begin
            //         Message(t);
            //     end;
            // }
        }
    }
    actions
    {
        area(Processing)
        {
            action(TestAction2)
            {
                Caption = 'Test Connect to SFDC';
                InFooterBar = true;
                ApplicationArea = All;
                // trigger OnAction()
                // begin
                //     if Ready then
                //         CurrPage.TestDemo.GetSFDCToken()
                //     else
                //         Message('Dotnet still loading....');
                // end;
            }

        }
    }

    var
        Ready: Boolean;
}