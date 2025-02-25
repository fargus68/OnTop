*** Settings ***
Library    ExcelLibrary
Library    String
Library    Collections
Library    ../../Libraries/Keywords.py

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
    Log    ${theVariable}
    #Get From Dictionary    ${variableStorage}    ${${theVariable}}
    ${Value}=    Evaluate    $variableStorage.get("$${theVariable}", "NULL")
    RETURN    ${Value}
    
GetValueWithResolvedVariables
    [Arguments]    ${ValueWithVariables}
    Log    ${ValueWithVariables}
    Set Local Variable    ${Value}    ${ValueWithVariables}
    Set Local Variable    ${KeywordVarIdentifier}    VAR

    Set Local Variable    ${activeSearchProcess}    ${True}

    WHILE    ${activeSearchProcess}
        ${VarExists}=    check_keyword_existence    ${Value}    ${KeywordVarIdentifier}
        IF    ${VarExists}
            ${FullKeywordToReplace}=    get_full_keyword_substring    ${Value}    ${KeywordVarIdentifier}
            ${tmpKeywordValueVar}=    get_keyword_value    ${Value}    ${KeywordVarIdentifier}
            Log    ${tmpKeywordValueVar}
            #Set Local Variable    ${Variable}    ${tmpKeywordValueVar}
            #${tmpValueOfVar}=    GetVariableValue    ${Variable}
            ${tmpValueOfVar}=    GetVariableValue    ${tmpKeywordValueVar}
            ${Value}=    Replace String    ${Value}    ${FullKeywordToReplace}    ${tmpValueOfVar}
        ELSE
            Set Local Variable    ${activeSearchProcess}    ${False}
            #BREAK
        END
    END
    RETURN    ${Value}  
