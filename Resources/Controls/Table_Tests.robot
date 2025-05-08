*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Table.resource

*** Keywords ***

*** Test Cases ***
Chromium_Table_Tests_AllModus
    Setup AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    DialogExecution    dlgProfil    Auswahl Page Abwesenheiten
    TableProcessing    dlgProfil_pagAbwesenheiten    <SET>    tabAbwesenheiten    xpath=//table    <DELETE Abwesenheit Sylvester>

Pixel9Pro_API35_Textbox_Tests_AllModus
    Setup AUT Pixel9Pro_API35
    TableProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    TableProcessing    dlgLogin    <SET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de
    TableProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    TableProcessing    dlgLogin    <CHK>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de