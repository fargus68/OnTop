*** Settings ***
Library    String
Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
NumericUpDownProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceFullPath}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/NumericUpDown_    ${actualAUT}    .resource
    Import Resource    ${controlResourceFullPath}

    IF  '${Modus}' == '<GET>'
        NumericUpDownProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        NumericUpDownProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        NumericUpDownProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

NumericUpDownProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        NumericUpDownProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        #${NumericUpDownContent}=    Get Text    ${Selector}
        ${NumericUpDownContent}=    NumericUpDown specific get text    ${Selector}
        IF    '${NumericUpDownContent}' == ''
            Log    NumericUpDown content = <EMPTY>
        ELSE
            Log    NumericUpDown content = '${NumericUpDownContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    NumericUpDownProcessingGet (Variable)
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

NumericUpDownProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        NumericUpDownProcessingChk

NumericUpDownProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}    
    Log        NumericUpDownProcessingSet
    #Type Text    ${Selector}    ${Value}    0.1    False
    NumericUpDown specific set text    ${Selector}    ${Value}
    
    