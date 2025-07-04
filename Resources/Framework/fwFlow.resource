*** Settings ***
Library    ExcelLibrary
Library    String
Library    ScreenCapLibrary
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwProcess.resource

*** Variables ***
${FlowDir}    Data\\Flows\\
${RowCount}    -1
${FlowRecordFound}
${ActualConfig}    Config1

*** Keywords ***
FlowExecution
    [Arguments]    ${Flow}    ${FlowRecord}
    #ToDo minimize pycharm
    #Start Video Recording     alias=None    name="recording"    fps=None    size_percentage=1    embed=True    embed_width='800px'    monitor=1

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
    
    #Stop Video Recording    alias=None    save_to_disk=true
    
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
    
    Teardown SUT

#ToDo: sollte in Konfigurationsdaten ausgelagert werden
Setup SUT
    ${BaseStateChromium}=    GetVariableValue    BaseStateChromium
    IF    $BaseStateChromium == 'Started'
        ${AUT}=    GetVariableValue    AUT
        IF    $AUT == 'VIA_Chromium'
            Set Up Browser    url=https://sampleapp.tricentis.com/101/    viewport={'width': 1600, 'height': 900}
            #ToDo: auch nur ein Workaround
            SetVariableValue    AUT    Chromium
        ELSE
            Set Up Browser
        END
    END
    ${BaseStatePixel9Pro_API35}=    GetVariableValue    BaseStatePixel9Pro_API35
    IF    $BaseStatePixel9Pro_API35 == 'Started'
        Set Up Pixel9Pro_API35
    END

Teardown SUT
    ${BaseStateChromium}=    GetVariableValue    BaseStateChromium
    ${AUT}=    GetVariableValue    AUT
    IF    $AUT == 'Chromium'
        Tear down browser
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