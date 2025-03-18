*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
102_VehicleInsuranceAutomobile_001_SmokeTest
    FlowExecution    ${Flow}    ${TEST NAME}