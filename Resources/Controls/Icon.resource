*** Settings ***
Library    String
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
IconProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceName}=    Catenate    SEPARATOR=    Resources/Controls/Icon_    ${actualAUT}    .resource
    Import Resource    ${controlResourceName}

    IF  '${Modus}' == '<GET>'
        IconProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        IconProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        IconProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

IconProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        IconProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        #${IconContent}=    Get Text    ${Selector}
        ${IconContent}=    Icon specific get text    ${Selector}
        IF    '${IconContent}' == ''
            Log    Icon content = <EMPTY>
        ELSE
            Log    Icon content = '${IconContent}'
        END
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

IconProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        IconProcessingChk

IconProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        ButtonProcessingSet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Icon specific click    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Set-modus is X or a variable name
    END