*** Settings ***
Test Tags       MobileReady
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floProfil
${RECORDING}    True

*** Test Cases ***
003_Profil_003_Abwesenheiten_Normalfall_Anlage
    FlowExecution    ${Flow}    ${TEST NAME}

