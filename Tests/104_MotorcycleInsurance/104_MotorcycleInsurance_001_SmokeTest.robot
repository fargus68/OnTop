*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
104_MotorcycleInsurance_001_SmokeTest
    FlowExecution    ${Flow}    ${TEST NAME}