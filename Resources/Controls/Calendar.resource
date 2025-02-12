*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
CalendarProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

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
        ${CalendarContent}=    Get Text    ${Selector}
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

CalendarProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        CalendarProcessingSet
    Type Text    ${Selector}    ${Value}    0.01    False
    
    