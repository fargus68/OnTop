*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
101_Common_001_CheckDefaults
    FlowExecution    ${Flow}    ${TEST NAME}