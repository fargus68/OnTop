*** Settings ***
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
Link specific get text
    #ToDo not tested yet
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${LinkContent}=    Set Variable    ${element.text}
    RETURN    ${LinkContent}

Link specific click
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.click()