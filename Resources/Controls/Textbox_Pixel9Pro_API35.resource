*** Settings ***
Library    String
#Library    ../../Libraries/sessionHelperAppium.py    WITH NAME    SessionHelper
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
Textbox specific get text
    [Arguments]    ${Selector}
    #${driver}=    SessionHelper.Get Current Session
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${TextboxContent}=    Set Variable    ${element.text}
    RETURN    ${TextboxContent}

Textbox specific set text
    [Arguments]    ${Selector}    ${Value}
    #${driver}=    SessionHelper.Get Current Session
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.clear()
    Evaluate    $element.send_keys($Value)
