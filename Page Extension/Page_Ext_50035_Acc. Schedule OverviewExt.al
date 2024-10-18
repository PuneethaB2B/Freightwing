pageextension 50035 AccScheduleOverviewExt extends "Acc. Schedule Overview"
{
    layout
    {
        addafter(ColumnValues11)
        {
            field("Dimension 2 Filter"; Rec."Dimension 2 Filter")
            {
                ApplicationArea = all;
            }
        }
    }
}