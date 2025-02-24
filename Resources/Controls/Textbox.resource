*** Settings ***
Library    String
#Library    AppiumLibrary
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource
#Resource    ../Controls/Textbox_Pixel9Pro_API35.resource

*** Variables ***

*** Keywords ***
TextboxProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    Resources/Controls/Textbox_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

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
        ${TextboxContent}=    Textbox specific get text    ${Selector}
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
    Textbox specific set text    ${Selector}    ${Value}