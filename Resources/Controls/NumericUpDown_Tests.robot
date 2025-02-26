*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/NumericUpDown.resource

*** Keywords ***

*** Test Cases ***
NumericUpDown_Test_AllModus
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    Take Screenshot
    Scroll To Element    id=reminder_games_hours
    Take Screenshot    
    NumericUpDownProcessing    dlgProfil_pagProfil    <GET>    nudSpielerinnerungStunden    id=reminder_games_hours    X
    NumericUpDownProcessing    dlgProfil_pagProfil    <SET>    nudSpielerinnerungStunden    id=reminder_games_hours    42
    NumericUpDownProcessing    dlgProfil_pagProfil    <GET>    nudSpielerinnerungStunden    id=reminder_games_hours    X
    Take Screenshot
    NumericUpDownProcessing    dlgProfil_pagProfil    <CHK>    nudSpielerinnerungStunden    id=reminder_games_hours    42