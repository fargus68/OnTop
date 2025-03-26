*** Settings ***
Library    Browser
Library    mandatoryFieldKeywordsVehicleInsuranceApp.py
Resource    ../Resources/Utils/Browser_Mgmt.resource
#Resource    ../Resources/Utils/Mobile_Mgmt.resource
Resource    ../Resources/Framework/fwDialog.resource

*** Variables ***

*** Test Cases ***
test_001_chk_NoMandatoryField
    Setup AUT Chromium VehicleInsuranceDemoApp
    DialogExecution    dlgVehicleInsuranceMain    Click Automobile link
    ${keywordValue}=    process_mandatory_field_keyword    id=make    <NoMandatoryField>
    Log    ${keywordValue}