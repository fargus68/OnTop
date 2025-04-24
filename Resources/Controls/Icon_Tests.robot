*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Icon.resource

*** Test Cases ***
Chromium_Set_ClickIconAbmelden
    Setup AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful    
    IconProcessing    dlgMain    <SET>    icoAbmelden    xpath=//*[@class='bx bx-power-off mr-5']    X

Pixel9Pro_API35_Set_ClickIconAbmelden
    Setup AUT Pixel9Pro_API35
    DialogExecution    dlgLogin    001_Login_001_Successful
    BuiltIn.Sleep    3s
    IconProcessing    dlgMain    <SET>    icoAbmelden    xpath=//android.view.View[@resource-id='navbar-collapse'][2]/android.widget.ListView/android.view.View[3]/android.view.View/android.widget.TextView    X
    
Pixel9Pro_API35_Set_ClickIconAbmelden_direct
    #Setup AUT Pixel9Pro_API35
    #DialogExecution    dlgLogin    001_Login_001_Successful
    Setup AUT Pixel9Pro_API35 NoWaitForLoginScreen
    IconProcessing    dlgMain    <SET>    icoAbmelden    xpath=(//android.view.View[@resource-id="navbar-collapse"])[2]/android.widget.ListView/android.view.View[3]/android.view.View/android.widget.TextView    X    