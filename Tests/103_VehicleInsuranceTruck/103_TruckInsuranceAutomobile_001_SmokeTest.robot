*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
103_TruckInsuranceAutomobile_001_SmokeTest
    FlowExecution    ${Flow}    ${TEST NAME}