*** Settings ***
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${Flow}    floVehicleInsurance

*** Test Cases ***
103_TruckInsurance_002_VehicleData_001_MandatoryFields
    FlowExecution    ${Flow}    ${TEST NAME}

103_TruckInsurance_002_VehicleData_002_FieldHintsAndErrors
    FlowExecution    ${Flow}    ${TEST NAME}