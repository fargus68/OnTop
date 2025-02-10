*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
PageProcessing
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}

    IF  '${Modus}' == '<GET>'
        PageProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        PageProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        PageProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

PageProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        PageProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${PageContent}=    Get Text    ${Selector}
        IF    '${PageContent}' == ''
            Log    Page content = <EMPTY>
        ELSE
            Log    Page content = '${PageContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

PageProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        PageProcessingChk

PageProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        PageProcessingSet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Click    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        IF    '${Value}' == '<SELECT>'
            Click    ${Selector}
        END
    ELSE
        Fatal Error    Value of Set-modus is X or a variable name
    END