*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance
${RECORDING}    True

*** Test Cases ***
103_TruckInsurance_003_InsurantData_001_MandatoryFields
    FlowExecution    ${Flow}    ${TEST NAME}

103_TruckInsurance_003_InsurantData_002_FieldHintsAndErrors
    FlowExecution    ${Flow}    ${TEST NAME}

103_TruckInsurance_003_InsurantData_003_ListContents
    FlowExecution    ${Flow}    ${TEST NAME}
