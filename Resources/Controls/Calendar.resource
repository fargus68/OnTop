*** Settings ***
Library    String
#Library    Browser
Library    ../../Libraries/dateRelatedKeywords.py
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Keywords/mandatoryFieldKeywordsVehicleInsuranceApp.resource

*** Variables ***

*** Keywords ***
CalendarProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceName}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Calendar_    ${actualAUT}    .resource
    Import Resource    ${controlResourceName}

    IF  '${Modus}' == '<GET>'
        CalendarProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        CalendarProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        CalendarProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

CalendarProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        CalendarProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${CalendarContent}=    Calendar specific get text    ${Selector}
        IF    '${CalendarContent}' == ''
            Log    Calendar content = <EMPTY>
        ELSE
            Log    Calendar content = '${CalendarContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    CalendarProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

CalendarProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        CalendarProcessingChk
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == '<'
        ${ends_with}=    Evaluate    '${Value}'.endswith('MandatoryField>')
        Run Keyword If    ${ends_with}    mandatoryFieldKeywordsProcessing    ${Selector}    ${Value}
        ${contains}=    Evaluate    'HINT' in '${Value}'
        Run Keyword If    ${contains}    hintKeywordsProcessing    ${Selector}    ${Value}

        #${containsToday}=    Evaluate    '<TODAY' in '${Value}'
        #Run Keyword If    ${containsToday}    today_keywords_processing    ${Selector}    ${Value}

    ELSE
        Fail    Normal check not implemented yet!
    END

CalendarProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        CalendarProcessingSet

    ${containsToday}=    Evaluate    "<TODAY" in "${Value}"
    IF    ${containsToday}
        ${Value}=    today_keywords_processing    ${Value}
    END
    Calendar specific set text    ${Selector}    ${Value}
    