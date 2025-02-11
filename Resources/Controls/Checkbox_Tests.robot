*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Controls/Checkbox.resource

*** Test Cases ***
Get_Checkbox_normalLogging
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    CheckboxProcessing    <GET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    X
    CheckboxProcessing    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECKED>
    CheckboxProcessing    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECK>
    CheckboxProcessing    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
    CheckboxProcessing    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CHECK>
    CheckboxProcessing    <SET>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <CLICK>
    CheckboxProcessing    <CHK>    chkTeilnahmeTrainingApp    xpath=//*/tr/*[text()='Teilnahme am Training?']/parent::*/td[@data-label = '📱 App']/div/input    <UNCHECKED>
