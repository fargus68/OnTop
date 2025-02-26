*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Textbox.resource

*** Keywords ***

*** Test Cases ***
Chromium_Textbox_Tests_AllModus
    Setup AUT Chromium
    TextboxProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    TextboxProcessing    dlgLogin    <SET>    txtEmail    id=email    matthias@matthias-schmotz.de
    TextboxProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    TextboxProcessing    dlgLogin    <CHK>    txtEmail    id=email    matthias@matthias-schmotz.de

Pixel9Pro_API35_Textbox_Tests_AllModus
    Setup AUT Pixel9Pro_API35
    TextboxProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    TextboxProcessing    dlgLogin    <SET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de
    TextboxProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    TextboxProcessing    dlgLogin    <CHK>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de