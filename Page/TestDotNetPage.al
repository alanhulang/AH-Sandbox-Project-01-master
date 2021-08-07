page 50353 "Test DotNet in AL"
{
    PageType = NavigatePage;
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
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

                trigger PingResult(t: Text)
                begin
                    Message(t);
                end;

                trigger Test1Result(t1: Text)
                begin
                    Message(t1);
                end;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(TestAction1)
            {
                Caption = 'Ping';
                InFooterBar = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Ready then
                        CurrPage.TestDemo.Ping()
                    else
                        Message('Dotnet still loading....');
                end;
            }
            action(TestAction2)
            {
                Caption = 'Test from My dll';
                InFooterBar = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Ready then
                        CurrPage.TestDemo.Test1()
                    else
                        Message('Dotnet still loading....');
                end;
            }
        }
    }
    var
        Ready: Boolean;
}