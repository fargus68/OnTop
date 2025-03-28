*** Settings ***
Test Tags       MobileReady
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floProfil

*** Test Cases ***
003_Profil_002_Profil_Datenaenderung
    FlowExecution    ${Flow}    ${TEST NAME}