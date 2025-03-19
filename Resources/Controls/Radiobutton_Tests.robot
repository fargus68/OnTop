*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Radiobutton.resource

*** Test Cases ***
Chromium_Get_Checkbox_normalLogging
    #ToDo: mal schauen ob irgendwo so ein radiobutton-Element vorhanden ist im TT-Planer
    SetUp AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <GET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    X
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECKED>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CLICK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>

Pixel9Pro_API35_Get_Checkbox_normalLogging
    #ToDo: mal schauen ob irgendwo so ein radiobutton-Element vorhanden ist im TT-Planer
    SetUp AUT Pixel9Pro_API35
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <GET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    X
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECKED>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CLICK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>

Pixel9Pro_API35_Checkbox_Quicktests
    Setup AUT Pixel9Pro_API35 NoWaitForLoginScreen
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <GET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    X
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECKED>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CLICK>
    RadiobuttonProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>

Via_Chromium_Set_CheckRadiobutton
    Setup AUT Chromium VehicleInsuranceDemoApp
    DialogExecution    dlgVehicleInsuranceMain    Click Automobile link
    DialogExecution    dlgAutomobileInsurance    Button Next from Page VehicleData
    RadiobuttonProcessing    dlgAutomobileInsurance_pagInsurantData    <SET>    radMale    text="Male"    <CHECK>
    RadiobuttonProcessing    dlgAutomobileInsurance_pagInsurantData    <SET>    radMale    id=gendermale    <CHECK>
    RadiobuttonProcessing    dlgAutomobileInsurance_pagInsurantData    <GET>    radMale    id=gendermale    X
    RadiobuttonProcessing    dlgAutomobileInsurance_pagInsurantData    <CHK>    radMale    id=gendermale    <CHECKED>