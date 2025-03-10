*** Settings ***
Library    String
Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
MultiLineTextboxProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/MultiLineTextbox_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}
    
    IF  '${Modus}' == '<GET>'
        MultiLineTextboxProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        MultiLineTextboxProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        MultiLineTextboxProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

MultiLineTextboxProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        MultiLineTextboxProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        ${MultiLineTextboxContent}=    MultiLineTextbox specific get text    ${Selector}
        IF    '${MultiLineTextboxContent}' == ''
            Log    MultiLineTextbox content = <EMPTY>
        ELSE
            Log    MultiLineTextbox content = '${MultiLineTextboxContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    MultiLineTextboxProcessingGet
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

MultiLineTextboxProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        MultiLineTextboxProcessingChk

MultiLineTextboxProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        MultiLineTextboxProcessingSet
    #Type Text    ${Selector}    ${Value}    0.01    False
    MultiLineTextbox specific set text    ${Selector}    ${Value}
