*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
102_VehicleInsuranceAutomobile_002_VehicleData
    FlowExecution    ${Flow}    ${TEST NAME}