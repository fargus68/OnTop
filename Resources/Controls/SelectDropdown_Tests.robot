*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/SelectDropdown.resource

*** Keywords ***

*** Test Cases ***
Chromium_Get_SelectDropdown_normalLogging
    #ToDo: mal schauen ob irgendwo so ein select-Element vorhanden ist im TT-Planer
    Setup AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    Take Screenshot
    Scroll To Element    id=training_ids
    Take Screenshot
    SelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    id=training_ids    X
    SelectDropdownProcessing    dlgProfil_pagProfil    <SET>    msdTeilnahmeerinnerungTrainings    id=training_ids    <SELECT>Aktiventraining (Donnerstag, 19:00 Uhr)
    SelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    id=training_ids    X

Pixel9Pro_API35_Get_SelectDropdown_normalLogging
    #ToDo: mal schauen ob irgendwo so ein select-Element vorhanden ist im TT-Planer
    Setup AUT Pixel9Pro_API35
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    Sleep    1s
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    ${xpath}=    Convert To String    //android.widget.ListView[@resource-id="select2-training_ids-container"]
    SelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    ${xpath}    X
    SelectDropdownProcessing    dlgProfil_pagProfil    <SET>    msdTeilnahmeerinnerungTrainings    ${xpath}    <SELECT>Aktiventraining (Donnerstag, 19:00 Uhr)
    SelectDropdownProcessing    dlgProfil_pagProfil    <GET>    msdTeilnahmeerinnerungTrainings    ${xpath}    X
    
Via_Chromium_Get_SelectDropdown_normalLogging
    Setup AUT Chromium VehicleInsuranceDemoApp
    DialogExecution    dlgVehicleInsuranceMain    Click Automobile link
    SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <SET>    selMake    id=make    Audi
    SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <SET>    selNumberOfSeats    id=numberofseats    5
    SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <SET>    selFuelType    id=fuel    Benzin-Fail

Via_Chromium_Chk_SelectDropdown_mandatoryFields
    Setup AUT Chromium VehicleInsuranceDemoApp
    DialogExecution    dlgVehicleInsuranceMain    Click Automobile link
    SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <CHK>    selMake    //*[@id='make']    <MissingMandatoryField>
    SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <SET>    selMake    //*[@id='make']    Audi
    SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <CHK>    selMake    //*[@id='make']    <FilledMandatoryField>
    #SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <CHK>    txtLicensePlateNumber    id=licenseplatenumber    <NoMandatoryField>
    SelectDropdownProcessing    dlgAutomobileInsurance_pagVehicleData    <CHK>    txtLicensePlateNumber    //*[@id='licenseplatenumber']    <NoMandatoryField>
