*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsuranceAutomobile

*** Test Cases ***
102_VehicleInsuranceAutomobile_001_VehicleData
    FlowExecution    ${Flow}    ${TEST NAME}