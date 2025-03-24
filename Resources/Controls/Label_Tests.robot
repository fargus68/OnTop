*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Label.resource

*** Keywords ***

*** Test Cases ***
Chromium_Textbox_Tests_AllModus
    Setup AUT Chromium
    LabelProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    LabelProcessing    dlgLogin    <SET>    txtEmail    id=email    matthias@matthias-schmotz.de
    LabelProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    LabelProcessing    dlgLogin    <CHK>    txtEmail    id=email    matthias@matthias-schmotz.de

Pixel9Pro_API35_Textbox_Tests_AllModus
    Setup AUT Pixel9Pro_API35
    LabelProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    LabelProcessing    dlgLogin    <SET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de
    LabelProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    LabelProcessing    dlgLogin    <CHK>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de