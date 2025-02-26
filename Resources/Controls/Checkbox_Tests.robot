*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Checkbox.resource

*** Test Cases ***
Get_Checkbox_normalLogging
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <GET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    X
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECKED>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECK>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECK>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CLICK>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
