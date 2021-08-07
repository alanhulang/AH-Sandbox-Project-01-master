table 50350 "API Setup"
{
    Caption = 'API Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "API Code"; Code[20])
        {
            Caption = 'API Code';
            DataClassification = ToBeClassified;
        }
        field(2; "API Url"; Text[250])
        {
            Caption = 'API Url';
            DataClassification = ToBeClassified;
        }
        field(3; "API User ID"; Code[50])
        {
            Caption = 'API User ID';
            DataClassification = ToBeClassified;
        }
        field(4; "API User Pwd"; Text[100])
        {
            Caption = 'API User Pwd';
            DataClassification = ToBeClassified;
        }
        field(5; "API User Key"; Text[250])
        {
            Caption = 'API Key';
            DataClassification = ToBeClassified;
        }
        field(6; "API User Secret"; Text[250])
        {
            Caption = 'API Secret';
            DataClassification = ToBeClassified;
        }
        field(7; "API User Token"; Text[250])
        {
            Caption = 'API Token';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "API Code")
        {
            Clustered = true;
        }
    }

}
