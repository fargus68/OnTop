*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/Password.resource

*** Keywords ***

*** Test Cases ***
Password_Test_AllModus
    Set Up Browser
    PasswordProcessing    dlgLogin    <GET>    pwdPassword    id=password    X
    PasswordProcessing    dlgLogin    <SET>    pwdPassword    id=password    <GETPASSWORD>
    PasswordProcessing    dlgLogin    <SET>    pwdPassword    id=password    <SHOWPASSWORD>
    Take Screenshot
