*** Settings ***
Library    ExcelLibrary
Library    String
Library    Collections

*** Variables ***
${VariablesDir}    Data\\Variables\\
&{variableStorage}

*** Keywords ***
InitializeVariableStorage
    &{variableStorage}    Create Dictionary

ReadVariablesFromFile
    [Arguments]    ${VariablesFile}    ${Config}
    Log    ${Config}
    ${FullVariablesFilePath}=    catenate    SEPARATOR=    ${VariablesDir}    ${VariablesFile}    .xlsx
    Log    ${FullVariablesFilePath}

    Open Excel Document	filename=${FullVariablesFilePath}	doc_id=actualVariablesFile
    #${sheets}=	Get List Sheet Names
    #${Sheet}=    Get Sheet

    ${FirstRow}=    Read Excel Row    0    0
    ${ColumnCount}=    Get Length    ${FirstRow}
    ${FirstColumn}=    Read Excel Column    0    0
    ${RowCount}=    Get Length    ${FirstColumn}

    FOR    ${row_index}     IN RANGE     2    ${RowCount} + 1
        ${theVariable}    Read Excel Cell    ${row_index}    1
        Log    ${theVariable}
        FOR    ${col_index}    IN RANGE    2    ${ColumnCount} + 1
           Log    ${col_index}
           ${theHeader}    Read Excel Cell    1    ${col_index}
           Log    ${theHeader}
            IF    $theHeader == $Config
               ${theValue}    Read Excel Cell    ${row_index}    ${col_index}
               Log    ${theValue}
               #Set Global Variable    ${theVariable}    ${theValue}
               #VAR    ${${theVariable}}    ${theValue}    scope=GLOBAL
               #Set To Dictionary   ${variableStorage}    ${${theVariable}}    ${theValue}
               #Set To Dictionary    &{variableStorage}    $${theVariable}    ${theValue}
               SetVariableValue    ${theVariable}    ${theValue}
               Exit For Loop
           END
        END
    END

    Close Current Excel Document
    #Close All Excel Documents

ReportVariables
    #${variables} =	Get Variables
    Log Many    &{variableStorage}
    
SetVariableValue
    [Arguments]    ${theVariable}    ${theValue}
    Set To Dictionary   ${variableStorage}    $${theVariable}    ${theValue}

GetVariableValue
    [Arguments]    ${theVariable}
    #Get From Dictionary    ${variableStorage}    ${${theVariable}}
    ${value}=    Evaluate    $variableStorage.get("$${theVariable}", "NULL")
    
GetValueWithResolvedVariables
    [Arguments]    ${ValueWithVariables}
    ${Value}=    ${ValueWithVariables}    
    RETURN    ${Value}