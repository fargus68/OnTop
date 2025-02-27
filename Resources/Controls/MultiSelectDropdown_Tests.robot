*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/MultiSelectDropdown.resource

*** Keywords ***

*** Test Cases ***
Chromium_Get_MultiSelectDropdown_normalLogging
    Setup AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    Take Screenshot
    Scroll To Element    id=training_ids
    Take Screenshot
    MultiSelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    id=training_ids    X
    MultiSelectDropdownProcessing    dlgProfil_pagProfil    <SET>    msdTeilnahmeerinnerungTrainings    id=training_ids    <SELECT>Aktiventraining (Donnerstag, 19:00 Uhr)
    MultiSelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    id=training_ids    X

Pixel9Pro_API35_Get_MultiSelectDropdown_normalLogging
    Setup AUT Pixel9Pro_API35
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    Sleep    1s
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    #Take Screenshot
    #Scroll To Element    id=training_ids
    #Take Screenshot
    Capture Page Screenshot
    Scroll Element Into View    //android.widget.ListView[@resource-id="select2-training_ids-container"]
    Capture Page Screenshot
    
    ${xpath}=    Convert To String    //android.widget.ListView[@resource-id="select2-training_ids-container"]
    MultiSelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    ${xpath}    X
    MultiSelectDropdownProcessing    dlgProfil_pagProfil    <SET>    msdTeilnahmeerinnerungTrainings    ${xpath}    <SELECT>Aktiventraining (Donnerstag, 19:00 Uhr)
    MultiSelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    ${xpath}    X