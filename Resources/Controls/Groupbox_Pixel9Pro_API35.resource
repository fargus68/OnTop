*** Settings ***
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
Group specific get text
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${GroupContent}=    Set Variable    ${element.text}
    RETURN    ${GroupContent}