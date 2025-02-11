#Checkbox Handling in Browser Library | Robot Framework
#https://www.youtube.com/watch?v=qDZ4HTvxiHo

*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
CheckboxProcessing
    [Arguments]    ${Modus}    ${Name}    ${Selector}    ${Value}

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
        Get Checkbox State    ${Selector}
    ELSE IF  '${FirstLetterOfValue}' == '<'
        Log    To be defined
    ELSE
        Fatal Error    Value of Get-modus is X or a variable name
    END

CheckboxProcessingChk
    [Arguments]    ${Name}    ${Selector}    ${Value}
    #Log        ButtonProcessingChk
    IF    '${Value}' == '<CHECKED>'
        ${state}=    Get Checkbox State    ${Selector}
        IF    ${state}
            Log    Checkbox checked as expected!
        ELSE
            Fail    Checkbox not checked, but expected to be checked!!!
        END
    END

    IF    '${Value}' == '<UNCHECKED>'
        ${state}=    Get Checkbox State    ${Selector}
        IF    ${state} != True
            Log    Checkbox not checked as expected!
        ELSE
            Fail    Checkbox checked, but expected to be not checked!!!
        END
    END

CheckboxProcessingSet
    [Arguments]    ${Name}    ${Selector}    ${Value}

    IF    '${Value}' == '<CHECK>'
        ${state}=    Get Checkbox State    ${Selector}
        IF    ${state}
            Log    Checkbox already checked!
        ELSE
            Check Checkbox    ${Selector}
        END
        RETURN
    END

    IF    '${Value}' == '<UNCHECK>'
        ${state}=    Get Checkbox State    ${Selector}
        IF    ${state} != True
            Log    Checkbox already unchecked!
        ELSE
            Uncheck Checkbox    ${Selector}
        END
        RETURN
    END

    IF    '${Value}' == '<CLICK>'
        ${state}=    Get Checkbox State    ${Selector}
        IF    ${state}
            Uncheck Checkbox    ${Selector}
        ELSE
            Check Checkbox    ${Selector}
        END
        RETURN
    END