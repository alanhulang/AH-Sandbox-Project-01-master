/// <summary>
/// TableExtension G/L Account_Ext (ID 50350) extends Record G/L Account.
/// </summary>
tableextension 50350 "G/L Account_Ext" extends "G/L Account"
{
    Caption = 'G/L Account_Ext';
    Fields
    {
        field(50001; "CN Name"; Text[150])
        {
            // Set links to the "Reward ID" from the Reward table.
            // TableRelation = Reward."Reward ID";
            // Set whether to validate a table relationship.
            // ValidateTableRelation = true;
            // "OnValidate" trigger executes when data is entered in a field.
            // trigger OnValidate();
            // begin

            // // If the "Reward ID" changed and the new record is blocked, an error is thrown. 
            //     if (Rec."Reward ID" <> xRec."Reward ID") and
            //         (Rec.Blocked <> Blocked::" ") then
            //     begin
            //         Error('Cannot update the rewards status of a blocked customer.')
            //     end;
            // end;
        }
    }
}