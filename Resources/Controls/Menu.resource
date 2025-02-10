*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
MenuProcessing
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}

    IF  '${Modus}' == '<GET>'
        MenuProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        MenuProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        MenuProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

MenuProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        ButtonProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${ButtonContent}=    Get Text    ${Selector}
        IF    '${ButtonContent}' == ''
            Log    Button content = <EMPTY>
        ELSE
            Log    Button content = '${ButtonContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

MenuProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        ButtonProcessingChk

MenuProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        ButtonProcessingSet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Click    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Set-modus is X or a variable name
    END