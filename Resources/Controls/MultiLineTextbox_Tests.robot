*** Settings ***
Library    Browser    auto_closing_level=keep
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Controls/MultiLineTextbox.resource

*** Keywords ***

*** Test Cases ***
MultiLineTextbox_AllModus
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Abwesenheiten
    DialogExecution    dlgProfil    Abwesenheit anlegen Page Abwesenheiten
    MultiLineTextboxProcessing    popAbwesenheitAnlegen    <GET>    mltComment    id=comment    X
    MultiLineTextboxProcessing    popAbwesenheitAnlegen    <CHK>    mltComment    id=comment    <EMPTY>
    MultiLineTextboxProcessing    popAbwesenheitAnlegen    <SET>    mltComment    id=comment    Nur ein Test!
    MultiLineTextboxProcessing    popAbwesenheitAnlegen    <GET>    mltComment    id=comment    X
    Take Screenshot
    
