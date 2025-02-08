*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
TextboxProcessing
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}

    IF  '${Modus}' == '<GET>'
        TextboxProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        TextboxProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        TextboxProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

TextboxProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        TextboxProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${TextboxContent}=    Get Text    ${Selector}
        IF    '${TextboxContent}' == ''
            Log    Textbox content = <EMPTY>
        ELSE
            Log    Textbox content = '${TextboxContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    TextboxProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

TextboxProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        TextboxProcessingChk

TextboxProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        TextboxProcessingSet
    Type Text    ${Selector}    ${Value}    0.1    False
    
    