*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
Textbox specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    Browser.Get Text    ${Selector}
    RETURN    ${TextboxContent}

Textbox specific set text
    [Arguments]    ${Selector}    ${Value}
    Browser.Clear Text    ${Selector}
    Browser.Type Text    ${Selector}    ${Value}    0.01    False