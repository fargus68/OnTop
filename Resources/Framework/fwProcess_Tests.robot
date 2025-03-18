*** Settings ***
Resource    ../../Resources/Framework/fwProcess.resource

*** Variables ***
${Process}    proLogin

*** Test Cases ***
001_Login_RecordNotFound
    ProcessExecution    ${Process}    Process does not exist