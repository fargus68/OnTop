*** Settings ***
Library    ExcelLibrary
Library    String
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwFlow.resource

*** Variables ***
${TestPlanDir}    Data\\TestPlans\\
${ActualConfig}    Config1

*** Keywords ***
TestPlanExecution
    [Arguments]    ${TestPlan}

    Close All Excel Documents

    #ToDo: not implemented yet
    FOR    ${row_index}     IN RANGE     2    ${TestPlanRowCount} + 1
        ${theFlowRecord}    Read Excel Cell    ${row_index}    1
        Log    ${theFlowRecord}
        IF    $FlowRecord == $theFlowRecord
            Set Test Variable  ${FlowRecordFound}  ${True}
            ProcessFlowProcessing    ${row_index}    #${FlowColumnCount}
            Exit For Loop
        END
    END

    Should Be True    ${FlowRecordFound}    Fatal Error: Flow record not found!
    Close Current Excel Document