*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floLogin

*** Test Cases ***
001_Login_001_Successful
    FlowExecution    ${Flow}    ${TEST NAME}

001_Login_002_LoginWithoutEmailAndPassword
    FlowExecution    ${Flow}    ${TEST NAME}