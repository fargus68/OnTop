*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/Button.resource

*** Test Cases ***
Set_ClickButtonEinloggen
    Set Up Browser
    ButtonProcessing    dlgLogin    <SET>    butEinloggen    text=Einloggen    X