*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/Link.resource

*** Test Cases ***
Set_ClickPasswortReset
    Set Up Browser
    LinkProcessing    dlgLogin    <SET>    lnkPasswortVergessen    text=Passwort vergessen    X