*** Settings ***
Library    String
#Library    AppiumLibrary
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource
#Resource    ../Controls/Textbox_Pixel9Pro_API35.resource
Resource    ../../Resources/Keywords/mandatoryFieldKeywordsVehicleInsuranceApp.resource

*** Variables ***

*** Keywords ***
GroupboxProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    Log    ${CURDIR}

    ${actualAUT}=    GetVariableValue    AUT
    #${controlResourceFullPath}=    Catenate    SEPARATOR=    Resources/Controls/Textbox_    ${actualAUT}    .resource
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Groupbox_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

    IF  '${Modus}' == '<GET>'
        GroupboxProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        GroupboxProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        Fatal Error    Set-modus not available for groupbox element
    ELSE
        Fatal Error    Modus not defined
    END

GroupboxProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        GroupboxProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${GroupboxContent}=    Groupbox specific get text    ${Selector}
        IF    '${GroupboxContent}' == ''
            Log    Groupbox content = <EMPTY>
        ELSE
            Log    Groupbox content = '${GroupboxContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    GroupboxProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

GroupboxProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        GroupboxProcessingChk
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == '<'
        ${ends_with}=    Evaluate    '${Value}'.endswith('MandatoryField>')
        Run Keyword If    ${ends_with}    mandatoryFieldKeywordsProcessing    ${Selector}    ${Value}
        ${contains}=    Evaluate    'HINT' in '${Value}'
        Run Keyword If    ${contains}    hintKeywordsProcessing    ${Selector}    ${Value}
    ELSE
        Fail    Keyword not defined
    END