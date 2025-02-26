*** Settings ***
#Library    Browser    auto_closing_level=keep
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Calendar.resource

*** Keywords ***

*** Test Cases ***
Chromium_Calendar_AllModus
    Setup AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Abwesenheiten
    DialogExecution    dlgProfil    Abwesenheit anlegen Page Abwesenheiten
    CalendarProcessing    popAbwesenheitAnlegen    <GET>    calVon    id=from_date    X
    CalendarProcessing    popAbwesenheitAnlegen    <CHK>    calVon    id=from_date    <EMPTY>
    CalendarProcessing    popAbwesenheitAnlegen    <SET>    calVon    id=from_date    31.12.2025
    CalendarProcessing    popAbwesenheitAnlegen    <GET>    calVon    id=from_date    X
    Take Screenshot

Pixel9Pro_API35_Calendar_AllModus
    Setup AUT Pixel9Pro_API35
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Abwesenheiten
    DialogExecution    dlgProfil    Abwesenheit anlegen Page Abwesenheiten
    CalendarProcessing    popAbwesenheitAnlegen    <GET>    calVon    //android.widget.Spinner[@hint='VON:']    X
    CalendarProcessing    popAbwesenheitAnlegen    <CHK>    calVon    //android.widget.Spinner[@hint='VON:']    <EMPTY>
    CalendarProcessing    popAbwesenheitAnlegen    <SET>    calVon    //android.widget.Spinner[@hint='VON:']    31.12.2025
    CalendarProcessing    popAbwesenheitAnlegen    <GET>    calVon    //android.widget.Spinner[@hint='VON:']    X
    Take Screenshot