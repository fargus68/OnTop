*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floCommon

*** Test Cases ***
101_Common_001_CheckDefaults
    FlowExecution    ${Flow}    ${TEST NAME}