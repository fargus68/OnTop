*** Settings ***
Library    String
Library    Browser
Library    ../../Libraries/mandatoryFieldHelperVehicleInsuranceApp.py

*** Variables ***
${NoMandatoryField}    <NoMandatoryField>
${MissingMandatoryField}    <MissingMandatoryField>
${FilledMandatoryField}    <FilledMandatoryField>

*** Keywords ***
mandatoryFieldKeywordsProcessing
    [Arguments]    ${Selector}    ${Value}
    Log    ${Selector}
    Log    ${Value}
    #${icoCount}=    Convert To Number    0

    ${xpathIcoMandatoryFieldNotDisplayed}=    catenate    SEPARATOR=    ${Selector}    /parent::*/*[@class='icon' and @style='display: none;']
    Log    ${xpathIcoMandatoryFieldNotDisplayed}
    ${icoNotDisplayedCount}=    Get Element Count    ${xpathIcoMandatoryFieldNotDisplayed}

    IF    ${icoNotDisplayedCount} == 1
        Set local Variable    ${Actual}    ${NoMandatoryField}
    ELSE
        ${xpathIcoMandatoryField}=    catenate    SEPARATOR=    ${Selector}    /parent::*/*[@class='icon']
        Log    ${xpathIcoMandatoryField}
        ${icoCount}=    Get Element Count    ${xpathIcoMandatoryField}
        Log    ${icoCount}
    
        Set local Variable    ${Actual}    ${NoMandatoryField}
        IF    ${icoCount} == 1
            Browser.Take Screenshot    filename=actualIcon    selector=${xpathIcoMandatoryField}
            #simple_image_compare_Icons    C:\Users\matth\PycharmProjects\OnTop\browser\screenshot\actualIcon.png
            ${rc}=    simple_image_compare_Icons    output\\browser\\screenshot\\actualIcon.png
            Set local Variable    ${Actual}    ${rc}
        END
    END
    Log    ${Actual}
    
    #Fail    zu Testzwecken

    Set Local Variable    ${keywordProcessed}    ${False}
    IF    '${Value}' == '${NoMandatoryField}'
        IF    '${Value}' == '${Actual}'
            Log    SUCCESS: no icon found!
        ELSE
            Fail    ERROR: icon found => ${Actual}
        END
        Set Local Variable    ${keywordProcessed}    ${True}
    ELSE IF    '${Value}' == '<MissingMandatoryField>'
        IF    '${Value}' == '${Actual}'
            Log    SUCCESS: icon MissingMandatoryField found!
        ELSE
            Fail    ERROR: ${Actual}
        END
        Set Local Variable    ${keywordProcessed}    ${True}
    ELSE IF    '${Value}' == '<FilledMandatoryField>'
        IF    '${Value}' == '${Actual}'
            Log    SUCCESS: icon FilledMandatoryField found!
        ELSE
            Fail    ERROR: ${Actual}
        END
        Set Local Variable    ${keywordProcessed}    ${True}
    ELSE
        Log    No mandatory field keyword found!
    END
    
    RETURN    ${keywordProcessed}