*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/Icon.resource

*** Test Cases ***
Set_ClickIconAbmelden
    Set Up Browser
    IconProcessing    <SET>    icoAbmelden    text=Einloggen    X