codeunit 50350 "Find the right way"
{
    trigger OnRun()
    begin
        Test();
    end;

    [TryFunction]
    procedure Test()
    var
        customer: Record Customer;
    begin
        customer.SetFilter("Name", 'Ka*');
        customer.SetCurrentKey(Name);
        if customer.FindSet() then
            repeat
            until customer.Next() = 0;
    end;
}