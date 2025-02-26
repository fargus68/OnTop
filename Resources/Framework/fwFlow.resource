*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwProcess.resource

*** Variables ***
${FlowDir}    Data\\Flows\\
${RowCount}    -1
${FlowRecordFound}
${ActualConfig}    Config2

*** Keywords ***
FlowExecution
    [Arguments]    ${Flow}    ${FlowRecord}
    Close All Excel Documents
    InitializeFlowExecution    ${Flow}    ${FlowRecord}
    Set Test Variable  ${FlowRecordFound}  ${False}

    FOR    ${row_index}     IN RANGE     2    ${FlowRowCount} + 1
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
    ReportVariables

InitializeFlowExecution
    [Arguments]    ${Flow}    ${FlowRecord}
    ${FullFlowFilePath}=    catenate    SEPARATOR=    ${FlowDir}    ${Flow}    .xlsx
    #Log    ${FullFlowFilePath}

    Open Excel Document	filename=${FullFlowFilePath}	doc_id=actualFlow
    ${sheets}=	Get List Sheet Names
    ${Sheet}=    Get Sheet    
    
    ${FlowFirstRow}=    Read Excel Row    0    0
    ${tmpFlowColumnCount}=    Get Length    ${FlowFirstRow}
    Set Test Variable    ${FlowColumnCount}    ${tmpFlowColumnCount}
    ${FlowFirstColumn}=    Read Excel Column    0    0
    ${tmpFlowRowCount}=    Get Length    ${FlowFirstColumn}
    Set Test Variable    ${FlowRowCount}    ${tmpFlowRowCount}

ProcessFlowProcessing
    [Arguments]    ${row_index}
    ${theFlowRow}    Read Excel Row    ${row_index}    #0    1
    Set Test Variable  ${FlowRecordFound}  ${True}
    
    FOR    ${col_index}    IN RANGE    2    ${FlowColumnCount} + 1
       Log    ${col_index}
       ${theProcessHeader}    Read Excel Cell    1    ${col_index}
       ${theProcessValue}    Read Excel Cell    ${row_index}    ${col_index}
       #Log    ${theRow}[${col_index}] 
       
       IF    ${{$theProcessValue is not None}}
           IF    $theProcessHeader == "Variables"
               ReadVariablesFromFile    ${theProcessValue}    ${ActualConfig}
               ReportVariables
               Setup SUT
           ELSE
               ProcessExecution    ${theProcessHeader}    ${theProcessValue}
           END
           Switch Current Excel Document    actualFlow
       ELSE
          Log    No process value found!
       END
    END

Setup SUT
    ${BaseStateChromium}=    GetVariableValue    BaseStateChromium
    IF    $BaseStateChromium == 'Started'
        Set Up Browser
    END
    ${BaseStatePixel9Pro_API35}=    GetVariableValue    BaseStatePixel9Pro_API35
    IF    $BaseStatePixel9Pro_API35 == 'Started'
        Set Up Pixel9Pro_API35
    END

ReportFlowContent
    [Arguments]    ${Sheet}
    @{ExcelContent}=    Make List From Excel Sheet    ${Sheet}
    ${FirstRow}=    Read Excel Row    0    0
    ${ColumnCount}=    Get Length    ${FirstRow}
    ${LastRowIndex}=    Evaluate    ${ColumnCount} - 1
    FOR    ${row_index}     IN RANGE     0    ${LastRowIndex}
        Log    ${row_index}
        Log Many    @{ExcelContent}[${row_index}]
        VAR    ${row}    @{ExcelContent}[${row_index}]
        Log    ${row}
        Get Length    ${row}
    END
    Log Many    @{ExcelContent}