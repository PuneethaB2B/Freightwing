page 50147 "Posted MAWB Invoices"
{
    Caption = 'Posted MAWB Invoices';
    CardPageID = "Posted MAWB Invoice";
    DataCaptionFields = "Document Type";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            Posted = FILTER(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(fw)
            {
                field("No."; Rec."No.")
                {
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(f; Links)
            {
                Visible = false;
            }
            systempart(f1; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PageID: Integer;
                    begin
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Quote:
                                PageID := PAGE::"Sales Quote";
                            Rec."Document Type"::Order:
                                PageID := PAGE::"Sales Order";
                            Rec."Document Type"::Invoice:
                                PageID := PAGE::"Sales Invoice";
                            Rec."Document Type"::"Return Order":
                                PageID := PAGE::"Sales Return Order";
                            Rec."Document Type"::"Credit Memo":
                                PageID := PAGE::"Sales Credit Memo";
                            Rec."Document Type"::"Blanket Order":
                                PageID := PAGE::"Blanket Sales Order";
                        END;

                        PageID := GetPageId(PageID);

                        IF PageID <> 0 THEN
                            PAGE.RUN(PageID, Rec);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 209;
            }
        }
    }

    local procedure GetPageId(PageId: Integer): Integer
    var
        MiniPagesMapping: Record 1305;
    begin
        IF MiniPagesMapping.READPERMISSION THEN
            IF MiniPagesMapping.GET(PageId) THEN
                EXIT(MiniPagesMapping."Substitute Page ID");

        EXIT(PageId);
    end;
}

