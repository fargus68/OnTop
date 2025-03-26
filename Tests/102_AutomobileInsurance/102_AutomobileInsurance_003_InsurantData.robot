*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
102_AutomobileInsurance_003_InsurantData_001_MandatoryFields
    FlowExecution    ${Flow}    ${TEST NAME}

102_AutomobileInsurance_003_InsurantData_002_FieldHintsAndErrors
    FlowExecution    ${Flow}    ${TEST NAME}