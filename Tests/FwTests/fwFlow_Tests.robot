*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floLogin

*** Test Cases ***
001_Login_RecordNotFound
    FlowExecution    ${Flow}    ${TEST NAME}