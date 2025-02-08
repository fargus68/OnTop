*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwDialog.resource

*** Variables ***
${ProcessDir}    Data\\Processes\\
${RowCount}    -1
${ProcessRecordFound}

*** Keywords ***
ProcessExecution
    [Arguments]    ${Process}    ${ProcessRecord}
    InitializeProcessExecution    ${Process}    ${ProcessRecord}
    Set Test Variable  ${ProcessRecordFound}  ${False}

    FOR    ${row_index}     IN RANGE     2    ${ProcessRowCount} + 1
        ${theProcessRecord}    Read Excel Cell    ${row_index}    1
        Log    ${theProcessRecord}
        IF    $ProcessRecord == $theProcessRecord
            Set Test Variable  ${ProcessRecordFound}  ${True}
            ProcessRowProcessing    ${row_index}    #${ProcessColumnCount}
            Exit For Loop
        END
    END

    Should Be True    ${ProcessRecordFound}    Fatal Error: Process record not found!
    Close Current Excel Document
    
InitializeProcessExecution
    [Arguments]    ${Process}    ${ProcessRecord}
    ${FullProcessFilePath}=    catenate    SEPARATOR=    ${ProcessDir}    ${Process}    .xlsx
    #Log    ${FullFlowFilePath}

    Open Excel Document	filename=${FullProcessFilePath}    doc_id=actualProcess
    #${sheets}=	Get List Sheet Names
    #${Sheet}=    Get Sheet

    #${tmpProcessFirstRow}=    Read Excel Row    0    0
    #Set Test Variable    ${ProcessFirstRow}    ${tmpProcessFirstRow}
    ${ProcessFirstRow}=    Read Excel Row    0    0
    ${tmpProcessColumnCount}=    Get Length    ${ProcessFirstRow}
    Set Test Variable    ${ProcessColumnCount}    ${tmpProcessColumnCount}
    #${tmpProcessFirstColumn}=    Read Excel Column    0    0
    #Set Test Variable    ${ProcessFirstColumn}    ${tmpProcessFirstColumn}=
    ${ProcessFirstColumn}=    Read Excel Column    0    0
    ${tmpProcessRowCount}=    Get Length    ${ProcessFirstColumn}
    Set Test Variable    ${ProcessRowCount}    ${tmpProcessRowCount}

    #ReportProcessContent    ${Sheet}
    #Set Test Variable  ${ProcessRecordFound}  ${False}

ProcessRowProcessing
    [Arguments]    ${row_index}    #${ProcessColumnCount}
    #Log    ${row_index}
    ${theProcessRow}    Read Excel Row    ${row_index}    #0    1
    #Get Length    ${theProcessRow}
    #Log    ${theProcessRow}
    #Log    Record found!
    #Set Test Variable  ${ProcessRecordFound}  ${True}
    
    FOR    ${col_index}    IN RANGE    2    ${ProcessColumnCount} + 1
       #Log    ${col_index}
       ${theDialogHeader}    Read Excel Cell    1    ${col_index}
       ${theDialogValue}    Read Excel Cell    ${row_index}    ${col_index}
       #Log    ${theProcessRow}[${col_index}]
       
       #IF    $theDialogValue <> None
       IF    ${{$theDialogValue is not None}}
           IF    $theDialogHeader == "Variables"
               ReadVariablesFromFile    ${theDialogValue}    Config2
           ELSE
               DialogExecution    ${theDialogHeader}    ${theDialogValue}
           END
           
           Switch Current Excel Document    actualProcess
       ELSE
           Log    No dialog value found!
       END                   
    END