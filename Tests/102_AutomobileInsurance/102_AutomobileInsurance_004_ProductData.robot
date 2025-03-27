*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
102_AutomobileInsurance_004_ProductData_001_MandatoryFields
    FlowExecution    ${Flow}    ${TEST NAME}

102_AutomobileInsurance_004_ProductData_002_FieldHintsAndErrors
    FlowExecution    ${Flow}    ${TEST NAME}