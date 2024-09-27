page 50016 "Import/Export Setup"
{
    PageType = Card;
    SourceTable = 50010;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Consignee Nos."; Rec."Consignee Nos.")
                {
                }
                field("Notify Party Nos."; Rec."Notify Party Nos.")
                {
                }
                field("Daily Analysis Nos."; Rec."Daily Analysis Nos.")
                {
                }
                field("Weekly Analysis Nos."; Rec."Weekly Analysis Nos.")
                {
                }
                field("Booking Sheet Nos."; Rec."Booking Sheet Nos.")
                {
                }
                field("Good Receipt Nos."; Rec."Good Receipt Nos.")
                {
                }
                field("Loading Sheet Nos."; Rec."Loading Sheet Nos.")
                {
                }
                field("Gate Pass Nos."; Rec."Gate Pass Nos.")
                {
                }
                field("Offload Nos."; Rec."Offload Nos.")
                {
                }
                field("Pre Alert Nos."; Rec."Pre Alert Nos.")
                {
                }
            }
            group("Posting Setup")
            {
                Caption = 'Posting Setup';
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                }
                field("Sales Journal Template"; Rec."Sales Journal Template")
                {
                }
                field("Sales Journal Batch"; Rec."Sales Journal Batch")
                {
                }
                field("Default Vendor Code"; Rec."Default Vendor Code")
                {
                }
                field("Default Vendor Name"; Rec."Default Vendor Name")
                {
                }
                field("Invoicing Currency Code"; Rec."Invoicing Currency Code")
                {
                    Caption = 'Invoicing Currency Code';
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Agent's IATA Code"; Rec."Agent's IATA Code")
                {
                }
                field("Carrier Agent Code"; Rec."Carrier Agent Code")
                {
                }
                field("IATA Purchase Acc.TP"; Rec."IATA Purchase Acc.TP")
                {
                }
                field("IATA Purchase Acc.Group"; Rec."IATA Purchase Acc.Group")
                {
                }
                field("Group Purchase A/C Code"; Rec."Group Purchase A/C Code")
                {
                }
                field("Third Party Purchase A/C Code"; Rec."Third Party Purchase A/C Code")
                {
                }
                field("Default IATA Vendor"; Rec."Default IATA Vendor")
                {
                }
                field("CutOff Time"; Rec."CutOff Time")
                {
                }
            }
            group(Rounding)
            {
                Caption = 'Rounding';
                field("Weight Rounding Type"; Rec."Weight Rounding Type")
                {
                }
                field("Weight Rounding Precision"; Rec."Weight Rounding Precision")
                {
                }
                field("Division Factor"; Rec."Division Factor")
                {
                }
                field("ETR PIN."; Rec."ETR PIN.")
                {
                }
                field("KRA Pin"; Rec."KRA Pin")
                {
                }
            }
        }
    }

    actions
    {
    }
}

