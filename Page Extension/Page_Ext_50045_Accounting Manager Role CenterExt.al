pageextension 50045 AccountingManagerRoleCenterExt extends "Accounting Manager Role Center"
{
    layout
    {
        moveafter(Control106; Control1902476008)
    }
    actions
    {
        modify("Sales Orders")
        {
            Visible = false;
        }
    }
}