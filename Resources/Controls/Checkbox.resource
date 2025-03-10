#Checkbox Handling in Browser Library | Robot Framework
#https://www.youtube.com/watch?v=qDZ4HTvxiHo

*** Settings ***
Library    String
#Library    Browser
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***

*** Keywords ***
CheckboxProcessing
    [Arguments]    ${Container}    ${Modus}    ${Name}    ${Selector}    ${Value}

    ${actualAUT}=    GetVariableValue    AUT
    ${controlResourceName}=    Catenate    SEPARATOR=    C:/Users/matth/PycharmProjects/OnTop/Resources/Controls/Checkbox_    ${actualAUT}    .resource
    Import Resource    ${controlResourceName}

    IF  '${Modus}' == '<GET>'
        CheckboxProcessingGet    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<CHK>'
        CheckboxProcessingChk    ${Name}    ${Selector}    ${Value}
    ELSE IF  '${Modus}' == '<SET>'
        CheckboxProcessingSet    ${Name}    ${Selector}    ${Value}
    ELSE
        Fatal Error    Modus not defined
    END

CheckboxProcessingGet
    [Arguments]    ${Name}    ${Selector}    ${Value}
    Log        ButtonProcessingGet
    ${FirstLetterOfValue}=    Get Substring    ${Value}    0    1
    IF  '${FirstLetterOfValue}' == 'X'
        Checkbox specific get checkbox state    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

CheckboxProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        ButtonProcessingChk
    IF    '${Value}' == '<CHECKED>'
        ${state}=    Checkbox specific get checkbox state    ${Selector}
        IF    ${state}
            Log    Checkbox checked as expected!
        ELSE
            Fail    Checkbox not checked, but expected to be checked!!!
        END
    END

    IF    '${Value}' == '<UNCHECKED>'
        ${state}=    Checkbox specific get checkbox state    ${Selector}
        IF    ${state} != True
            Log    Checkbox not checked as expected!
        ELSE
            Fail    Checkbox checked, but expected to be not checked!!!
        END
    END

CheckboxProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}

    IF    '${Value}' == '<CHECK>'
        ${state}=    Checkbox specific get checkbox state    ${Selector}
        IF    ${state}
            Log    Checkbox already checked!
        ELSE
            Checkbox specific check    ${Selector}
        END
        RETURN
    END

    IF    '${Value}' == '<UNCHECK>'
        ${state}=    Checkbox specific get checkbox state    ${Selector}
        IF    ${state} != True
            Log    Checkbox already unchecked!
        ELSE
            Checkbox specific uncheck    ${Selector}
        END
        RETURN
    END

    IF    '${Value}' == '<CLICK>'
        ${state}=    Get Checkbox State    ${Selector}
        IF    ${state}
            Checkbox specific uncheck    ${Selector}
        ELSE
            Checkbox specific check    ${Selector}
        END
        RETURN
    END