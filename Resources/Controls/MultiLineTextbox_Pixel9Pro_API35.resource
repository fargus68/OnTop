*** Settings ***
Library    String
#Library    AppiumLibrary
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
MultiLineTextbox specific get text
    [Arguments]    ${Selector}
    #${TextboxContent}=    AppiumLibrary.Get Text    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${TextboxContent}=    Set Variable    ${element.text}
    RETURN    ${TextboxContent}

MultiLineTextbox specific set text
    [Arguments]    ${Selector}    ${Value}
    #AppiumLibrary.Input Text    ${Selector}    ${Value}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.clear()
    Evaluate    $element.send_keys($Value)