*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
105_CamperInsurance_001_SmokeTest
    FlowExecution    ${Flow}    ${TEST NAME}