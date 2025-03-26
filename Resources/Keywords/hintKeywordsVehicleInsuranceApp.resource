*** Settings ***
Library    String
Library    Browser
Library    BuiltIn
Library    mandatoryFieldHelperVehicleInsuranceApp.py

*** Variables ***

*** Keywords ***
hintKeywordsProcessing
    [Arguments]    ${Selector}    ${Value}
    Log    ${Selector}
    Log    ${Value}

    #it is necessary that field has focus
    Browser.Focus    ${Selector}

    BuiltIn.Sleep    3s

    Browser.Take Screenshot

    ${xpathHint}=    catenate    SEPARATOR=    ${Selector}    /parent::*/span
    Log    ${xpathHint}
    ${hintCount}=    Get Element Count    ${xpathHint}

    IF    ${hintCount} == 0
        Set local Variable    ${Actual}    <NOHINT>
    ELSE
        ${hintText}=    Browser.Get Text    ${xpathHint}
        IF    '${hintText}' == ""
            Set local Variable    ${Actual}    <NOHINT>
        ELSE
            Set local Variable    ${Actual}    <HINT ${hintText}>
        END
    END
    Log    ${Actual}
    
    #Fail    zu Testzwecken

    Set Local Variable    ${keywordProcessed}    ${False}
    IF    '${Value}' == '<NOHINT>'
        IF    '${Value}' == '${Actual}'
            Log    SUCCESS: no hint found!
        ELSE
            Fail    ERROR: hint found => ${Actual}
        END
        Set Local Variable    ${keywordProcessed}    ${True}
    ELSE
        IF    '${Value}' == '${Actual}'
            Log    SUCCESS: expected hint found!
        ELSE
            Fail    ERROR: expected hint '${Value}' not found => ${Actual} found!
        END
        Set Local Variable    ${keywordProcessed}    ${True}
    END
    
    RETURN    ${keywordProcessed}