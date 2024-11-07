page 50165 ImportManagementRolecenter
{
    PageType = RoleCenter;
    Caption = 'Import Management';
    ApplicationArea = All;

    layout
    {

    }

    actions
    {
        area(Sections)
        {
            group(ImportManagement)
            {
                group("Master Data")
                {
                    Caption = 'Master Data';

                    action(Shippers)
                    {
                        ApplicationArea = All;
                        Caption = 'Shippers';
                        RunObject = Page "Shipper List";

                    }
                    action("Shipping Agents")
                    {
                        Caption = 'Shipping Agents';
                        ApplicationArea = All;
                        RunObject = page "Shipper Agents";
                    }

                    action("Cosignees")
                    {
                        Caption = 'Cosignees';
                        ApplicationArea = All;
                        RunObject = page "Consignee List";
                    }
                    action("Notify Parties")
                    {
                        Caption = 'Notify Parties';
                        ApplicationArea = All;
                        RunObject = page "Notify Party List";
                    }
                    action("Import Activities")
                    {
                        Caption = 'Import Activities';
                        ApplicationArea = All;
                        //RunObject = page "Import Activities";
                    }
                    action("Import Charges Master")
                    {
                        Caption = 'Import Charges Master';
                        ApplicationArea = All;
                        // RunObject = page "Import Charges Master";
                    }
                    action("AirLines")
                    {
                        Caption = 'Airlines';
                        ApplicationArea = All;
                        RunObject = page Airlines;
                    }
                    action("Airports")
                    {
                        Caption = 'Airports';
                        ApplicationArea = All;
                        RunObject = page Airports;
                    }
                    action("Countries")
                    {
                        Caption = 'Countries';
                        ApplicationArea = All;
                        RunObject = page Countries;
                    }
                    action("MAWB By Airlines")
                    {
                        Caption = 'MAWB By Airlines';
                        ApplicationArea = All;
                        RunObject = page "MAWB By Airline";
                    }
                }
                group("Import Process")
                {
                    Caption = 'Import Process';
                    action("Pre Alerts")
                    {
                        Caption = 'Pre Alerts';
                        ApplicationArea = All;
                        RunObject = page "Pre Alerts";
                    }
                    action("Airport Cargo Receipts")
                    {
                        Caption = 'Airport Cargo Receipts';
                        ApplicationArea = All;
                        RunObject = page "Airport Cargo Receipts";
                    }
                    action("FWL Cargo Receipts")
                    {
                        Caption = 'FWL Cargo Receipts';
                        ApplicationArea = All;
                        RunObject = page "FWL Cargo Receipts";
                    }
                    action("Shipment Updates")
                    {
                        Caption = 'Shipment Updates';
                        ApplicationArea = All;
                        RunObject = page "Shipment Updates";
                    }
                }
                group(Invoicing)
                {
                    Caption = 'Invoicing';
                    action("Sales Invoices")
                    {
                        Caption = 'Sales Invoices';
                        ApplicationArea = All;
                        RunObject = page "Sales Invoice List - Import";
                    }
                }
                group(History)
                {
                    Caption = 'History';
                    action("Delivered Imports List")
                    {
                        Caption = 'Delivered Imports List';
                        ApplicationArea = all;
                        RunObject = page "Delivered Imports List";
                    }
                }
            }
            group("Export Mannagement")
            {
                Caption = 'Export Management';
                group(MasterData)
                {
                    Caption = 'Master Data';
                    action(ShippersExp)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Shippers';
                        RunObject = Page "Shipper List";
                    }
                    action(ShippingAgents)
                    {
                        ApplicationArea = ALL;
                        Caption = 'ShippingAgents';
                        RunObject = Page "Shipper Agents";
                    }
                    action("Divisions/Farms")
                    {
                        ApplicationArea = ALL;
                        Caption = 'Divisions/Farms';
                        RunObject = Page "Divisions/Farms";
                    }
                    action(Consignees)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Consignees';
                        RunObject = Page "Consignee List";
                    }
                    action(Items)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Items';
                        RunObject = Page "Item List";
                    }
                    action(NotifyParties)
                    {
                        ApplicationArea = ALL;
                        Caption = 'NotifyParties';
                        RunObject = Page "Notify Party List";
                    }
                    action(CountriesExp)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Countries';
                        RunObject = Page Countries;
                    }
                    action(AirportsExp)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Airports';
                        RunObject = Page Airports;
                    }
                    action(AirlinesExp)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Airlines';
                        RunObject = Page Airlines;
                    }
                    action(ULDTypes)
                    {
                        ApplicationArea = ALL;
                        Caption = 'ULDTypes';
                        RunObject = Page "ULD Types";
                    }
                    action(DefaultMAWBLineCharges)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Default MAWB Line Charges';
                    }

                    action(FreightChargeByAirlines)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Freight Charge By Airlines';
                        RunObject = Page "Freight Charge By Airlines";
                    }
                    action(Charges)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Charges';
                        RunObject = Page "Freight Charges";
                    }
                }
                group(CustomerService)
                {
                    Caption = 'CustomerService';
                    action(WeightAgreementByAirlines)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Weight Agreement By Airlines';
                        RunObject = page "Wt. Agreement By Airlines";

                    }
                    action(WeeklyCustWeightRequirements)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Weekly Customer Weight Requirements';
                        RunObject = page "Wk. Customer Wgt. Requirements";

                    }
                    action(DailyWeightDistributions)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Daily Weight Distributions';
                        RunObject = page "Dl. Weight Distributions";

                    }
                    action(BookingSheets)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Booking Sheets';
                        RunObject = page "Booking Sheets";
                    }
                    action(MAWBByAirlines)
                    {
                        ApplicationArea = ALL;
                        Caption = 'MAWB By Airlines';
                        RunObject = page "MAWB By Airlines";
                    }
                    action(HAWBReceipts)
                    {
                        ApplicationArea = ALL;
                        Caption = 'HAWB Receipts';
                        RunObject = page "HAWB Receipts";
                    }
                }
                group(Operations)
                {
                    Caption = 'Operations';
                    action(GoodsReceipts)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Goods Receipts';
                        RunObject = page "Goods Receipts";
                    }
                    action(LoadingSheets)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Loading Sheets';
                        RunObject = page "Loading Sheets";
                    }
                    action(OffLoadedGatePass)
                    {
                        ApplicationArea = ALL;
                        Caption = 'OffLoaded Gate Pass';
                        RunObject = page "Offloaded Gate Pass";
                    }

                }
                group(Security)
                {
                    Caption = 'Security';
                    action(GatePasses)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Gate Passes';
                        RunObject = page "Gate Passes";
                    }


                }
                group(Documentation)
                {
                    Caption = 'Documentation';
                    action(MasterAirwayBills)
                    {
                        ApplicationArea = ALL;
                        Caption = 'Master Airway Bills';
                        RunObject = page "MAWBs";
                    }
                    action(HouseAirwayBills)
                    {
                        ApplicationArea = ALL;
                        Caption = 'House Airway Bills';
                        RunObject = page "HAWBs";
                    }


                }
                group(InvoicingExp)
                {
                    Caption = 'Invoicing';
                    action("MAWB Invoices")
                    {
                        ApplicationArea = ALL;
                        Caption = 'MAWB Invoices';
                        RunObject = page "MAWB Invoices";
                    }
                    action("Airline Purchase Invoices")
                    {
                        ApplicationArea = ALL;
                        Caption = 'Airline Purchase Invoices';
                        //  RunObject = page "Airline Purchase Invoices";
                    }


                }
                group(HistoryExp)
                {
                    Caption = 'History';
                    group(List)
                    {
                        Caption = 'List';
                        action("posted sales invoice")
                        {
                            ApplicationArea = ALL;
                            Caption = 'posted sales invoice';
                            RunObject = page "Posted Sales Invoices";
                        }
                        action(PostedGoodsReceipts)
                        {
                            ApplicationArea = ALL;
                            Caption = 'Posted Goods Receipts';
                            RunObject = page "Posted Goods Receipts";
                        }
                        action(PostedLoadingSheets)
                        {
                            ApplicationArea = ALL;
                            Caption = 'Posted Loading Sheets';
                            RunObject = page "Posted Loading Sheets";
                        }
                        action(ConvertedIATAPurchLines)
                        {
                            ApplicationArea = ALL;
                            Caption = 'Converted IATA Purchase Lines';
                            RunObject = page "Converted IATA Purchase Lines";
                        }
                    }
                    group(Archive)
                    {
                        Caption = 'Archive';
                        action("Received Booking Sheets")
                        {
                            ApplicationArea = ALL;
                            Caption = 'Received Booking Sheets';
                            RunObject = page "Received Booking Sheets";
                        }
                        action(ArchivedHouseAirwayBills)
                        {
                            ApplicationArea = ALL;
                            Caption = 'Archived House Airway Bills';
                            RunObject = page "Archived HAWBs";
                        }
                        action(ArchivedMasterAirwayBills)
                        {
                            ApplicationArea = ALL;
                            Caption = 'Archived Master Airway Bills';
                            RunObject = page "Archived MAWBs";
                        }
                        action(ReleasedGatePasses)
                        {
                            ApplicationArea = ALL;
                            Caption = 'Released Gate Passes';
                            RunObject = page "Released Gate Passes";
                        }
                    }
                }
                group(Reports)
                {
                    Caption = 'Reports';
                    group("Purchase Analysis")
                    {
                        Caption = 'Purchase Analysis';
                        action("Purchase Analysi Invoices")
                        {
                            ApplicationArea = ALL;
                            Caption = 'Purchase Analysi Invoices';
                            RunObject = report "Purchase Anlitycs.";
                        }
                        action("Purchase Analysis Credit Memo")
                        {
                            ApplicationArea = ALL;
                            Caption = 'Purchase Analysis Credit Memo';
                            RunObject = report "Purchase Anlitycs.CR";
                        }
                    }
                    group("Operation Report")
                    {
                        Caption = 'Operation Report';
                        action("Operational Report")
                        {
                            ApplicationArea = ALL;
                            Caption = 'Operational Report';
                            RunObject = report "Operational Report";
                        }

                    }
                }
                group(Setup)
                {
                    Caption = 'Setup';
                    group("Tasks")
                    {
                        Caption = 'Tasks';
                        action("Import/Export Setup")
                        {
                            ApplicationArea = ALL;
                            Caption = 'Import/Export Setup';
                            RunObject = page "Import/Export Setup";
                        }
                    }
                    group("Administration")
                    {
                        Caption = 'Administration';
                        action("Update MAWB Archives")
                        {
                            ApplicationArea = ALL;
                            Caption = 'Update MAWB Archivest';
                            //  RunObject =page" Update MAWB Archives";
                        }
                        action("User Access to Customer Service")
                        {
                            ApplicationArea = ALL;
                            Caption = 'User Access to Customer Service';
                            RunObject = page "User Access to Cust Service";
                        }

                    }
                }
            }
        }
    }

}

