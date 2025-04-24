*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Password.resource

*** Keywords ***

*** Test Cases ***
Chromium_Password_Test_AllModus
    Setup AUT Chromium
    PasswordProcessing    dlgLogin    <GET>    pwdPassword    id=password    X
    PasswordProcessing    dlgLogin    <SET>    pwdPassword    id=password    <GETPASSWORD>
    PasswordProcessing    dlgLogin    <SET>    pwdPassword    id=password    <SHOWPASSWORD>
    Browser.Take Screenshot

Pixel9Pro_API35_Password_Test_AllModus
    Setup AUT Pixel9Pro_API35
    #    xpath=//*[@hint='PASSWORT:'] only works with empty passwort; otherwise it contains addionally the password itself (???)
    #    the textbox control in opposite works as expected, the hint doesn't contain the content
    #PasswordProcessing    dlgLogin    <GET>    pwdPassword    xpath=//*[@hint='PASSWORT:']    X
    #PasswordProcessing    dlgLogin    <SET>    pwdPassword    xpath=//*[@hint='PASSWORT:']    <GETPASSWORD>
    #PasswordProcessing    dlgLogin    <SET>    pwdPassword    xpath=//*[@hint='PASSWORT:']    <SHOWPASSWORD>
    #24.04.2025: now with resource-id attribute
    PasswordProcessing    dlgLogin    <GET>    pwdPassword    xpath=//*[@resource-id='password']    X
    PasswordProcessing    dlgLogin    <SET>    pwdPassword    xpath=//*[@resource-id='password']    <GETPASSWORD>
    PasswordProcessing    dlgLogin    <SET>    pwdPassword    xpath=//*[@resource-id='password']    <SHOWPASSWORD>
    ScreenCapLibrary.Take Screenshot

