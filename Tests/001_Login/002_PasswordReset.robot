*** Settings ***
Test Tags       MobileReady
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floLogin

*** Test Cases ***
002_PasswordReset_001_Successful
    FlowExecution    ${Flow}    ${TEST NAME}

002_PasswordReset_002_BackToLogin
    FlowExecution    ${Flow}    ${TEST NAME}