*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Table.resource

*** Keywords ***

*** Test Cases ***
Chromium_Textbox_Tests_AllModus
    Setup AUT Chromium
    TableProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    TableProcessing    dlgLogin    <SET>    txtEmail    id=email    matthias@matthias-schmotz.de
    TableProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    TableProcessing    dlgLogin    <CHK>    txtEmail    id=email    matthias@matthias-schmotz.de

Pixel9Pro_API35_Textbox_Tests_AllModus
    Setup AUT Pixel9Pro_API35
    TableProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    TableProcessing    dlgLogin    <SET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de
    TableProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    TableProcessing    dlgLogin    <CHK>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de