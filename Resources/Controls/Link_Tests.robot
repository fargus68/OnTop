*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Link.resource

*** Test Cases ***
Browser_Set_ClickPasswortReset
    Set Up Browser
    InitializeVariableStorage
    SetVariableValue    AUT    Chromium
    LinkProcessing    dlgLogin    <SET>    lnkPasswortVergessen    text=Passwort vergessen    X