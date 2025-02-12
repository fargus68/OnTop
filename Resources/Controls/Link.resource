*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
LinkProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    IF  '${Modus}' == '<GET>'
        LinkProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        LinkProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        LinkProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

LinkProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        LinkProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${LinkContent}=    Get Text    ${Selector}
        IF    '${LinkContent}' == ''
            Log    Link content = <EMPTY>
        ELSE
            Log    Link content = '${TextboxContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

LinkProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        LinkProcessingChk

LinkProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        LinkProcessingSet

    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Click    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Set-modus is X or a variable name
    END