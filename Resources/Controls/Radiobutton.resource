#Checkbox Handling in Browser Library | Robot Framework
#https://www.youtube.com/watch?v=qDZ4HTvxiHo

*** Settings ***
Library    String
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
RadiobuttonProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceName}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Radiobutton_    ${actualAUT}    .resource
    Import Resource    ${controlResourceName}

    IF  '${Modus}' == '<GET>'
        RadiobuttonProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        RadiobuttonProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        RadiobuttonProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

RadiobuttonProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        RadiobuttonProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Radiobutton specific get checkbox state    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

RadiobuttonProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        RadiobuttonProcessingChk
    IF    '${Value}' == '<CHECKED>'
        ${state}=    Radiobutton specific get checkbox state    ${Selector}
        IF    ${state}
            Log    Radiobutton checked as expected!
        ELSE
            Fail    Radiobutton not checked, but expected to be checked!!!
        END
    END

    IF    '${Value}' == '<UNCHECKED>'
        ${state}=    Radiobutton specific get checkbox state    ${Selector}
        IF    ${state} != True
            Log    Radiobutton not checked as expected!
        ELSE
            Fail    Radiobutton checked, but expected to be not checked!!!
        END
    END

RadiobuttonProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}

    IF    '${Value}' == '<CHECK>'
        ${state}=    Radiobutton specific get checkbox state    ${Selector}
        IF    ${state}
            Log    Checkbox already checked!
        ELSE
            Radiobutton specific click    ${Selector}
        END
        RETURN
    END

    IF    '${Value}' == '<CLICK>'
        ${state}=    Radiobutton specific get checkbox state    ${Selector}
        Radiobutton specific click    ${Selector}
        RETURN
    END