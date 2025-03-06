*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Checkbox.resource

*** Test Cases ***
Chromium_Get_Checkbox_normalLogging
    SetUp AUT Chromium
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

Pixel9Pro_API35_Get_Checkbox_normalLogging
    SetUp AUT Pixel9Pro_API35
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

Pixel9Pro_API35_Checkbox_Quicktests
    Setup AUT Pixel9Pro_API35 NoWaitForLoginScreen
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <GET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    X
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECKED>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECK>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECK>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CLICK>
    CheckboxProcessing    dlgProfil_pagBenachrichtigungen    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>