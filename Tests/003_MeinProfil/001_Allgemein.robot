*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floProfil

*** Test Cases ***
003_Profil_001_Allgemein_CheckingDefaults
    FlowExecution    ${Flow}    ${TEST NAME}

