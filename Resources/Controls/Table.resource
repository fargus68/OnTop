*** Settings ***
Library    String
#Library    AppiumLibrary
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource
#Resource    ../Controls/Textbox_Pixel9Pro_API35.resource
Resource    ../../Resources/Keywords/mandatoryFieldKeywordsVehicleInsuranceApp.resource

*** Variables ***

*** Keywords ***
TableProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    Log    ${CURDIR}

    ${actualAUT}=    GetVariableValue    AUT
    #${controlResourceFullPath}=    Catenate    SEPARATOR=    Resources/Controls/Textbox_    ${actualAUT}    .resource
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
    Table specific set text    ${Selector}    ${Value}