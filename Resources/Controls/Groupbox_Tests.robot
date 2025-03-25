*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Checkbox.resource
Resource    ../../Resources/Controls/Groupbox.resource

*** Keywords ***

*** Test Cases ***
Chromium_Textbox_Tests_AllModus
    Setup AUT Chromium
    GroupboxProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    GroupboxProcessing    dlgLogin    <SET>    txtEmail    id=email    matthias@matthias-schmotz.de
    GroupboxProcessing    dlgLogin    <GET>    txtEmail    id=email    X
    GroupboxProcessing    dlgLogin    <CHK>    txtEmail    id=email    matthias@matthias-schmotz.de

Pixel9Pro_API35_Textbox_Tests_AllModus
    Setup AUT Pixel9Pro_API35
    GroupboxProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    GroupboxProcessing    dlgLogin    <SET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de
    GroupboxProcessing    dlgLogin    <GET>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    X
    GroupboxProcessing    dlgLogin    <CHK>    txtEmail    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de

Via_Chromium_Chk_Groupbox_mandatoryFields
    Setup AUT Chromium VehicleInsuranceDemoApp
    DialogExecution    dlgVehicleInsuranceMain    Click Automobile link
    DialogExecution    dlgAutomobileInsurance    Goto insurant page
    GroupboxProcessing    dlgAutomobileInsurance_pagInsurantData    <CHK>    grpGender    //label[text()="Gender"]/parent::*/*[@class="group"]    <NoMandatoryField>
    GroupboxProcessing    dlgAutomobileInsurance_pagInsurantData    <CHK>    grpHobbies    //label[text()="Hobbies"]/parent::*/*[@class="group"]    <MissingMandatoryField>
    CheckboxProcessing    dlgAutomobileInsurance_pagInsurantData    <SET>    chkHobbyOther    xpath=//*[@name='Hobbies' and @value='Other']/parent::*    <CHECK>
    GroupboxProcessing    dlgAutomobileInsurance_pagInsurantData    <CHK>    grpHobbies    //label[text()="Hobbies"]/parent::*/*[@class="group"]    <FilledMandatoryField>
