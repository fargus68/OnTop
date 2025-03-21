*** Settings ***
Library    String
Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
ButtonProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceName}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Button_    ${actualAUT}    .resource
    Import Resource    ${controlResourceName}

    IF  '${Modus}' == '<GET>'
        ButtonProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        ButtonProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        ButtonProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

ButtonProcessingGet
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

ButtonProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    IF    '${Value}' == '<ENABLED>'
        #Get Attribute Names    ${Selector}
        Button specific get attribute names    ${Selector}
    END
        
ButtonProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        ButtonProcessingSet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Button specific click    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Set-modus is X or a variable name
    END