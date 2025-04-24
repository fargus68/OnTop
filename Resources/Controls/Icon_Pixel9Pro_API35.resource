*** Settings ***
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
Icon specific get text
    #ToDo not tested yet
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${IconContent}=    Set Variable    ${element.text}
    RETURN    ${IconContent}

Icon specific click
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.click()