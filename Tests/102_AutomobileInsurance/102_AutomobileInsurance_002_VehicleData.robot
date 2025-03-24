*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
102_AutomobileInsurance_002_VehicleData_001_MandatoryFields
    FlowExecution    ${Flow}    ${TEST NAME}