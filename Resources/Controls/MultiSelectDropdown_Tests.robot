*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Controls/MultiSelectDropdown.resource

*** Keywords ***

*** Test Cases ***
Get_MultiSelectDropdown_normalLogging
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    Take Screenshot
    Scroll To Element    id=training_ids
    Take Screenshot
    MultiSelectDropdownProcessing    <GET>    msdTeilnahmeerinnerungTrainings    id=training_ids    X
    MultiSelectDropdownProcessing    <SET>    msdTeilnahmeerinnerungTrainings    id=training_ids    <SELECT>Aktiventraining (Donnerstag, 19:00 Uhr)
    MultiSelectDropdownProcessing    <GET>    msdTeilnahmeerinnerungTrainings    id=training_ids    X