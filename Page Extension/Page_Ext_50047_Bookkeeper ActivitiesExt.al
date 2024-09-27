pageextension 50047 BookkeeperActivitiesExt extends "Bookkeeper Activities"
{
    layout
    {
        addbefore("Purchase Documents Due Today")
        {
            field("Daily Wt. Dist"; Rec."Daily Wt. Dist")
            {
                ApplicationArea = all;
                DrillDownPageID = "Dl. Weight Distributions";
            }
        }
    }

}