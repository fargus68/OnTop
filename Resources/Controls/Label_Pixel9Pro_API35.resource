*** Settings ***
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
Label specific get text
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${LabelContent}=    Set Variable    ${element.text}
    RETURN    ${LabelContent}