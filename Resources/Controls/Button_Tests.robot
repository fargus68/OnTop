*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Button.resource

*** Test Cases ***
Chromium_Set_ClickButtonEinloggen
    Setup AUT Chromium
    ButtonProcessing    dlgLogin    <SET>    butEinloggen    text=Einloggen    X

Pixel9Pro_API35_Set_ClickButtonEinloggen
    Setup AUT Pixel9Pro_API35
    ButtonProcessing    dlgLogin    <SET>    butEinloggen    xpath=//android.widget.Button[@text="Einloggen"]    X

VIA_Chromium_Chk_Enabled
    Setup AUT Chromium VehicleInsuranceDemoApp
    ButtonProcessing    dlgVehicleInsuranceMain    <CHK>    butSearchSupport    id=search_button    <ENABLED>

