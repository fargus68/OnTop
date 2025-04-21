*** Settings ***
Library    String
#Library    AppiumLibrary
#Library    Browser
Library    ../../Libraries/Keywords.py
Library    ../../Libraries/RecordReader.py
Resource    ../../Resources/Framework/fwVariables.resource
#Resource    ../Controls/Textbox_Pixel9Pro_API35.resource
Resource    ../../Resources/Keywords/mandatoryFieldKeywordsVehicleInsuranceApp.resource

*** Variables ***
${TableDir}    Data\\Tables\\

*** Keywords ***
TableProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    Log    ${CURDIR}

    Set Test Variable    ${theContainer}    ${Container}    
    Set Test Variable    ${theTable}    ${Name}
    Set Test Variable    ${theModus}    ${Modus}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Table_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

    IF  '${Modus}' == '<GET>'
        TableProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        TableProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        TableProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

TableProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        TableProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${TableContent}=    Table specific get text    ${Selector}
        IF    '${TableContent}' == ''
            Log    Table content = <EMPTY>
        ELSE
            Log    Table content = '${TableContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    TableProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

TableProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        TableProcessingChk
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == '<'
        ${ends_with}=    Evaluate    '${Value}'.endswith('MandatoryField>')
        Run Keyword If    ${ends_with}    mandatoryFieldKeywordsProcessing    ${Selector}    ${Value}
        ${contains}=    Evaluate    'HINT' in '${Value}'
        Run Keyword If    ${contains}    hintKeywordsProcessing    ${Selector}    ${Value}
    ELSE
        #Fail    Keyword not defined
        Log    ToDo: normal check for Table not implemented yet
    END

TableProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        TableProcessingSet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == '<'
        ${contains}=    Evaluate    'DELETE' in '${Value}'
        Run Keyword If    ${contains}    deleteKeywordProcessing    ${Selector}    ${Value}
    ELSE
        Table specific set text    ${Selector}    ${Value}
    END

deleteKeywordProcessing    
    [Arguments]    ${Selector}    ${Value}
    ${tableRecordToDelete}=    get_keyword_value    ${Value}    DELETE
    ${TableFile}=    catenate    SEPARATOR=    ${TableDir}    ${theContainer}    _    ${theTable}        .xlsx
    ${AUT}=    GetVariableValue    AUT
    ${AllData}=    Read Technical Records From Excel    ${TableFile}    ${tableRecordToDelete}    ${AUT}    False
    #Log Many    ${AllData}
    Table specific delete keyword processing    ${Selector}    ${Value}    ${AllData}